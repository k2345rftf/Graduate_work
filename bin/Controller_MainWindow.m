classdef Controller_MainWindow < handle
    
    properties
        UI;
        model;
        count_inputs;
        rezult_calc;
    end
    methods
        function obj = Controller_MainWindow()
            global list_info_about_variable;
            global list_models;
            global list_input;
            
            count_input = length(list_input);
            obj.UI = UI_MainWindow(list_input);
            
            
            for i = 1:count_input
                if strcmp(list_input{i}{2},'edit')
                    obj.UI.param.(list_input{i}{1}).setValues(list_input{i}{4});
                else
                    obj.UI.param.(list_input{i}{1}).setValues(list_input{i}{4},list_models);
                end
            end
            obj.UI.param.('r_zad').hide();
            obj.UI.param.('time_hf').hide();
            
            obj.model = Model();
            obj.count_inputs = count_input;
            for i = 1:length(list_info_about_variable)
                if list_info_about_variable{i}{5}
                    list_info_about_variable{i}{4} = 0;
                end
            end
            obj.UI.menu_save_param.Callback = @obj.saveParamExcel;
            obj.UI.menu_choose_param.Callback = @obj.chooseVisibleParam;
            obj.UI.menu_input_aircraft.Callback = @obj.inputAircraft;
            
            obj.UI.param.('choose_model').setCallBack(@obj.changeModel);
            obj.UI.rezult.setCallBack(@obj.calculation);
            obj.UI.update.setCallBack(@obj.update);
            
        end
        
        
        
        function changeModel(obj, src, event)
            global list_info_about_variable;
            global aircraft_params;
            value = obj.UI.param.('choose_model').getValue();
            
            if strcmp(value,'engine_h_2d') || strcmp(value,'engine_h_0_2d') || strcmp(value,'engine_alpha_2d')
                obj.UI.param.('r_zad').hide();
                obj.UI.param.('time_hf').hide();
                bool_value = 0;
                aircraft_params{6}{5} = 0;
                aircraft_params{7}{5} = 0;
            elseif strcmp(value,'engine_h') || strcmp(value,'engine_h_g')
                obj.UI.param.('r_zad').show();
                obj.UI.param.('time_hf').show();
                bool_value = 1;
                aircraft_params{6}{5} = 1;
                aircraft_params{7}{5} = 1;
            end
            if strcmp(value,'engine_h_g')
                aircraft_params{5}{5} = 1;
            else
                aircraft_params{5}{5} = 0;
            end
            for i = 1:length(list_info_about_variable)
                if list_info_about_variable{i}{5}
                    list_info_about_variable{i}{4} = bool_value;
                end
            end
        end
        
        function saveParamExcel(obj, src, event)
            rez = evalin('base', 'rezult_calc');
            Controller_SaveVariabels(rez);
        end
        
        function inputAircraft(obj, src, event)
            Controller_InputAircraft();
        end
        
        function chooseVisibleParam(obj, src, event)
            Controller_ChooseVariables();
            
        end
        
        function update(obj,src, event)
            obj.showRezult();
        end
        
        function calculation(obj, src, event)
            global list_input;
            global aircraft_params;
            input_param = {};
            input_param{end+1} = obj.UI.param.(list_input{1}{1}).input_widget.getValue();
            for i=2:obj.count_inputs
                value = str2num(obj.UI.param.(list_input{i}{1}).input_widget.Text());
                [status, err_msg] = verification_inputs(value, list_input{i}{3}, obj.UI.param.(list_input{i}{1}).isVisible());
                if status
                    msgbox(err_msg);
                    return
                end
               
                input_param{end+1} = value;
            end
            for i = 1:length(aircraft_params)
                value = str2num(aircraft_params{i}{4});
                checker = length(value);
                if ~checker || checker > 1
                    error = ['Поле: ' aircraft_params{i}{3} ' не верно заполнено!!!'];
                    msgbox(error);
                    return
                end
                if aircraft_params{i}{5}
                    input_param{end+1} = aircraft_params{i}{4};
                end
            end
            rezult = obj.model.runExp(input_param{:});
            assignin('base','rezult_calc', rezult);
            
            if ~strcmp(obj.model.errormsg,'')
                disp(obj.model.errormsg)
                disp(obj.model.errorpath)
                return
            end
            obj.showRezult();
            obj.UI.update.show();
            
        end
        
        function showRezult(obj)
            
            global list_info_about_variable;
            
            obj.UI.tab_widget.clearTabs();
            info_output_param = list_info_about_variable;
            header = {};
            TData = {};
            index_vars = [];
            graf_tabs = {};
            Position = [0 0 1 1];
            
            data = evalin('base','rezult_calc');
            
            MainTab = UITableWidget();
            MainTab.setParent(obj.UI.widget);
            MainTab.setPosition(Position);
            count_exp = length(data);
            for i = 1:count_exp
                line = {};
                for j = 1:length(info_output_param)
                    if info_output_param{j}{4}
                        line{end+1} = data{i}.(info_output_param{j}{1})(end);
                        if i == 1
                            header{end+1} = info_output_param{j}{2};
                            index_vars(end+1) = j;
                        end
                    end
                end
                graf_tabs{end+1} = Controller_TabRezultGraf(obj.UI.widget, Position, i);
                td = {};
                TData(end+1,:) = line;
                td(end+1,:) = header(:);
                td(end+1,:) = TData(i,:)';
                graf_tabs{end}.UI.drawGraf(data{i}.('Xg'),data{i}.('Zg'),data{i}.('Yg'),'Xg,m','Zg,m','Yg,m');
                graf_tabs{end}.setData(td');
                graf_tabs{end}.setSettings(header, index_vars);
            end
            MainTab.setData(TData');
            MainTab.setRowName(header);
            obj.UI.tab_widget.addTab(MainTab,'Результаты расчетов');
            for i =1:count_exp
                title = ['Эксперимент №' num2str(i)];
                obj.UI.tab_widget.addTab(graf_tabs{i}.getWidget(),title);
            end
        end
        
    end
    
end


