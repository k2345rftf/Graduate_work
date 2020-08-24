classdef Controller_ChooseVariables < handle
    properties
        window;
        UI;
    end
    methods
        function obj = Controller_ChooseVariables()
            global list_info_about_variable;
            obj.UI = UI_ChoosePanel('Выбор отображаемых параметров', [0.33 0.4 0.33 0.55]);
            count_checkbox = length(list_info_about_variable);

            for i = 1:count_checkbox
                obj.UI.addCheckBox(list_info_about_variable{i}{2},list_info_about_variable{i}{4});
            end
            obj.UI.setCallBack(@obj.chooseVars);
            obj.UI.setNameButton('Сохранить');
        end
        function chooseVars(obj, src, event)
            global list_info_about_variable;
            indx = obj.UI.getValues();
            
            for i=1:length(indx)
                if indx(i)
                    list_info_about_variable{i}{4} = 1;
                else
                    list_info_about_variable{i}{4} = 0;
                end
            end
            
            close(gcf);
        end
    end
    
end
