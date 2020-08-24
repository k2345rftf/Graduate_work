classdef Controller_TabRezultGraf < handle

    properties
        UI;
        index;
    end
    
    methods
        function obj = Controller_TabRezultGraf(Parent, Position, index)
            obj.UI = UI_TabRezultGraf();
            obj.UI.setParent(Parent);
            obj.UI.setPosition(Position);
            
            obj.index = index;
            obj.UI.button.setCallBack(@obj.changeGraf);
        end

        function setData(obj, TData)
            obj.UI.table.clearTable();
            
            obj.UI.table.setColumnWidth({210, 'auto'});
            obj.UI.table.setRowName('numbered');
            obj.UI.table.setData(TData);
        end

        function setSettings(obj, list_settings, list_vars)
            list_settings = ['Траектория ЛА' list_settings];
            index_vars = [0 list_vars];
            obj.UI.input_widget.setValues(list_settings, index_vars);
        end
        
        function UI = getWidget(obj)
            UI = obj.UI;
        end
        
        function changeGraf(obj,src,event)
            global list_info_about_variable;
            global rezult_path;
            data = evalin('base', 'rezult_calc'); 
            if obj.UI.input_widget.getValue()
                indx = obj.UI.input_widget.getValue();
                x = data{obj.index}.('Time');
                y = data{obj.index}.(list_info_about_variable{indx}{1});
                
                lab_x = 'Time,sec';
                lab_y = [list_info_about_variable{indx}{1} ',' list_info_about_variable{indx}{3}];
                title = list_info_about_variable{indx}{2};
                
                var = {x,y,lab_x,lab_y,title};
            else
                x = data{obj.index}.('Xg');
                y = data{obj.index}.('Zg');
                z = data{obj.index}.('Yg');
                
                lab_x = 'Xg,m';
                lab_y = 'Zg,m';
                lab_z = 'Yg,m';
                var = {x,y,z,lab_x,lab_y,lab_z};
            end
            obj.UI.drawGraf(var{:});
            
            
        end
        
        
    end
    
end

