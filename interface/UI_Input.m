classdef UI_Input < UIPanel

    properties
        input_widget;
        text;
    end
    
    methods
        function obj = UI_Input(Style, Title)
            obj.text = UIText();
            obj.text.setText(Title);
            obj.text.setParent(obj.widget);
            obj.text.setPosition([0 .5 1 .5]);
            
            if strcmp(Style,'edit')
                obj.input_widget = UILineEdit();
            elseif strcmp(Style,'popupmenu')
                obj.input_widget = UIPopupMenu();
            end
                
            obj.input_widget.setParent(obj.widget);
            obj.input_widget.setPosition([0 0 1 .5]);
        end
        
        function hide(obj)
            obj.text.hide();
            obj.input_widget.hide();
            obj.widget.Visible = 'off';
        end
        
        function bool = isVisible(obj)
            if strcmp(obj.widget.Visible, 'off')
                bool = 0;
                return
            end
            bool = 1;
        end
        
        function show(obj)
            obj.text.show();
            obj.input_widget.show();
            obj.widget.Visible = 'on';
        end
        
        function setValues(obj, varargin)
            obj.input_widget.setText(varargin{1});
            if nargin == 3
                obj.input_widget.setValues(varargin{2});
            end
        end
        
        function setCallBack(obj, func)
            obj.input_widget.setCallBack(func);
        end
        
        function value = getValue(obj)
            value = obj.input_widget.getValue();
        end
    end
    
end

