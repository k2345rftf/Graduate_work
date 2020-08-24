classdef UIPopupMenu < UI_Properties
    properties (Access = protected)
        values;
    end
    
    methods
        function obj = UIPopupMenu()
            obj.widget.Style = 'popupmenu';
            obj.values = {};
        end
        
        function value = getValue(obj)
            try
                value = obj.values{obj.widget.Value};
            catch
                value = obj.values(obj.widget.Value);
            end
        end
        
        function setValues(obj, values)
            obj.values = values;
        end
    end
    
end

