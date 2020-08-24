classdef UI_TabRezultGraf < UIPanel
    
    properties
        graf;
        table;
        input;
        input_widget;
        button;
    end
    
    methods
        function obj = UI_TabRezultGraf()
            x_graf = 0;
            y_graf = 0;
            width_graf = .68;
            height_graf = 1;
            graf_pos = [x_graf y_graf width_graf height_graf];
            
            x_table = width_graf;
            y_table = .15;
            width_table = 1 - width_graf;
            height_table = .85;
            table_pos = [x_table y_table width_table height_table];
            
            x_input = x_table;
            y_input = 0;
            width_input = width_table;
            height_input = y_table;
            input_pos = [x_input y_input width_input height_input];
            
            obj.graf = UIGrafWidget();
            obj.graf.setParent(obj.widget);
            obj.graf.setPosition(graf_pos);
            
            obj.table = UITableWidget();
            obj.table.setParent(obj.widget);
            obj.table.setPosition(table_pos);
            
            obj.input = UIPanel();
            obj.input.setParent(obj.widget);
            obj.input.setPosition(input_pos);
            
            obj.input_widget = UI_Input('popupmenu', 'Выбор графика');
            obj.input_widget.setParent(obj.input.widget);
            obj.input_widget.setPosition([0 0.34 1 .66]);
            
            obj.button = UIButton();
            obj.button.setText('Показать');
            obj.button.setParent(obj.input.widget);
            obj.button.setPosition([0 0 1 .33]);
        end
        
        function drawGraf(obj, varargin)
            obj.graf.drawGraf(varargin{:});
        end
        
        function setCallBack(obj, func)
            obj.button.setCallBack(func);
        end

    end
    
end

