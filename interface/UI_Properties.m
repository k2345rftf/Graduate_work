classdef UI_Properties < handle
    properties
        widget;
    end
    
    methods
        function obj = UI_Properties()
            obj.widget = uicontrol();
            obj.widget.Units = 'normalized';
        end
        
        function setParent(obj, Parent)
            obj.widget.Parent = Parent;
            obj.setPosition([0 0 1 1]);
        end
        
        function setPosition(obj, Position)
            obj.widget.Position = Position;
        end
        
        function setCallBack(obj, func)
            set(obj.widget,'CallBack' , func);
        end
        
        function text = Text(obj)
            text = obj.widget.String;
        end
        
        function setText(obj,text)
            obj.widget.String = text;
        end
        
        function hide(obj)
             obj.widget.Visible = 'off';
        end
        
        function show(obj)
            obj.widget.Visible = 'on';
        end
        
        function boolean = isVisible(obj)
            boolean =  obj.widget.Visible;
        end
            
    end
    
end

