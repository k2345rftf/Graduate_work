classdef UITab < handle

    properties
        tab_widget;
        main_panel;
    end
    
    methods
        function obj = UITab(Parent, title)
            obj.tab_widget = uitab(Parent);
            obj.tab_widget.Title = title;
            
            obj.main_panel = UIPanel();
            obj.main_panel.setParent(obj.tab_widget);
            obj.main_panel.setPosition([0 0 1 1]);

        end
        
        function setMainWidget(obj, elem_uipanel)
            obj.main_panel = elem_uipanel;
            obj.main_panel.setParent(obj.tab_widget);
            obj.main_panel.setPosition([0 0 1 1]);
        end
        
        function delTab(obj)
            obj.tab_widget.Parent = [];
        end
    end
    
end

