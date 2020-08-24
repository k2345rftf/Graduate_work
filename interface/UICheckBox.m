classdef UICheckBox < UI_Properties
    methods
        function obj = UICheckBox()
            obj.widget.Style = 'checkbox'; 
        end
        
        function setValue(obj,value)
            if value
              obj.widget.Value = 1;
            else
              obj.widget.Value = 0;
            end
        end
        
        function value = getValue(obj)
            value = obj.widget.Value;
        end
    end
    
end

