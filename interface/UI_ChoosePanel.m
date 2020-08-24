classdef UI_ChoosePanel < UIWindow
    properties
        checkboxes;
        button;
        count_checkboxes;
    end
    
    methods
        function obj = UI_ChoosePanel(title, position)
            
            obj.setTitle(title);
            obj.setPosition(position);
            
            obj.checkboxes = {};
            obj.count_checkboxes = 0;
            
            obj.button = UIButton();
            obj.button.setParent(obj.widget);
            obj.button.setPosition([0 0 1 0.05]);
            
        end
        
        function setCallBack(obj, func)
            obj.button.setCallBack(func);
        end
        
        function values = getValues(obj)
            values = [];
            count_cboxes = length(obj.checkboxes);
            for i =1:count_cboxes
                values(end+1) = obj.checkboxes{i}.getValue();
            end
        end
        
        function addCheckBox(obj,text,value)
            obj.checkboxes{end+1} = UICheckBox();
            obj.checkboxes{end}.setText(text);
            obj.checkboxes{end}.setValue(value);
            obj.count_checkboxes = obj.count_checkboxes + 1;
            
            step = 1/(obj.count_checkboxes+1);
            y = 1;
            for i = 1:obj.count_checkboxes
                y = y - step;
                obj.checkboxes{i}.setParent(obj.widget);
                obj.checkboxes{i}.setPosition([0 y 1 step]);
            end
            obj.button.setPosition([0 0 1 step]);
        end
        
        function setNameButton(obj, name_of_button)
            obj.button.setText(name_of_button);
        end
    end
    
end

