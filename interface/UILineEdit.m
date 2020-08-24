classdef UILineEdit < UI_Properties

    methods
        function obj = UILineEdit()
            obj.widget.Style = 'edit';
        end
        
        function hide(obj)
            obj.widget.Visible = 'off';
            obj.widget.String = '0';
        end
    end
    
end

