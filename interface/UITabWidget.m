classdef UITabWidget < handle
    properties
        widget;
        tabs;
        num_tabs;
    end
    
    methods
        function obj = UITabWidget(Parent, Position)

            obj.widget = uitabgroup();
            obj.widget.Parent = Parent.widget;
            obj.widget.Position=Position;
            
            obj.tabs = {};
            obj.num_tabs = 0;

        end
        
        function addTab(obj,elem_uipanel, varargin)
            title = num2str(obj.num_tabs + 1);
            if nargin == 3
                title = varargin{1};
            end
            
            obj.tabs{end+1} = UITab(obj.widget, title);
            obj.tabs{end}.setMainWidget(elem_uipanel);
            obj.num_tabs = obj.num_tabs + 1;
        end
        
        function delTab(obj, index)
            t = {};
            for i = 1:obj.num_tabs
                if i == index
                    obj.tabs{i}.delTab();
                    delete(obj.tabs{i});
                    continue
                end
                t = obj.tabs{i};
            end
            obj.tabs = obj.clearTabs();
            obj.tabs = t;
        end
        
        function clearTabs(obj)
            for i = 1:obj.num_tabs
                obj.tabs{i}.delTab();
            end
            obj.tabs = {};
            obj.num_tabs = 0;
        end
    end
    
end

