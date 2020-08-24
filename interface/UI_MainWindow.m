classdef UI_MainWindow < handle

    properties
        widget;
        tab_widget;
        param;
        menu_save_param;
        menu_choose_param;
        menu_input_aircraft;
        rezult;
        update;
    end
    
    methods
        function obj = UI_MainWindow(list_inputs)
            obj.widget = figure;
            obj.widget.Name = 'Расчет балансировочных характеристик ЛА';
            obj.widget.NumberTitle = 'off';
            obj.widget.Units = 'normalized';
            obj.widget.OuterPosition = [0 0.05 1 .95];
            obj.widget.DockControls = 'off';
            obj.widget.WindowStyle = 'normal';
            obj.widget.MenuBar = 'none';
            obj.widget.ToolBar = 'figure';
            left_panel = UIPanel();
            left_panel.setParent(obj.widget);
            left_panel.setPosition([0 0 .75 1]);
            
            menu_save = uimenu(obj.widget);
            menu_save.Label = 'Сохранить параметры...';
            obj.menu_save_param = uimenu(menu_save,'Label','Сохранить параметры в файл excel');
            obj.menu_choose_param = uimenu(obj.widget,'Label','Настроить отображаемые параметры');
            obj.menu_input_aircraft = uimenu(obj.widget,'Label','Ввести параметры экраноплана');
            
            obj.tab_widget = UITabWidget(left_panel,[0 0 1 1]);
            
            right_panel = UIPanel();
            right_panel.setParent(obj.widget);
            right_panel.setPosition([.75 0 .25 1]);
            
            obj.param = struct;
            y_pos = .9;
           
            for i = 1:length(list_inputs)
                y_pos = y_pos - 0.01;
                obj.param.(list_inputs{i}{1}) = UI_Input(list_inputs{i}{2},list_inputs{i}{3});
                obj.param.(list_inputs{i}{1}).setParent(right_panel.widget);
                obj.param.(list_inputs{i}{1}).setPosition([0 y_pos 1 0.1]);
                obj.param.(list_inputs{i}{1}).setValues(list_inputs{i}{4});
                y_pos = y_pos - 0.1;
                
            end
            
            obj.rezult = UIButton();
            obj.rezult.setParent(right_panel.widget)
            obj.rezult.setPosition([0 0 1 .05]);
            obj.rezult.setText('Рассчитать');
            
            obj.update = UIButton();
            obj.update.setParent(right_panel.widget)
            obj.update.setPosition([0 0.05 1 .05]);
            obj.update.setText('Обновить');
            obj.update.hide();
        end

    end
    
    
end

