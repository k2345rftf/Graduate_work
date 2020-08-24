classdef UIWindow < handle
    %UNTITLED3 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        window;
        widget;
    end
    
    methods
        function obj = UIWindow()
            obj.window = figure();
            obj.window.Name = '';
            obj.window.NumberTitle = 'off';
            obj.window.MenuBar = 'none';
            obj.window.ToolBar = 'none';
            obj.window.Units = 'normalized';
            
            
            w = UIPanel();
            w.setParent(obj.window);
            w.setPosition([0 0 1 1]);
            
            obj.widget = w.widget;
            
        end
        
        function setTitle(obj, title)
            obj.window.Name = title;
        end
        
        function setPosition(obj, position)
            obj.window.OuterPosition = position;
        end
        
    end
    
end

