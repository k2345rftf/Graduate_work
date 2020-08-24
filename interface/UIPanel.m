classdef UIPanel < handle
    
    properties
        widget;
    end
    
    methods
        function obj = UIPanel()
            obj.widget = uipanel();
            obj.widget.Units = 'normalized';
        end
        
        function setParent(obj, Parent)
            obj.widget.Parent = Parent;
            obj.setPosition([0 0 1 1]);
        end
        
        function setPosition(obj, Position)
            obj.widget.Position = Position;
        end
        
    end
    
end

