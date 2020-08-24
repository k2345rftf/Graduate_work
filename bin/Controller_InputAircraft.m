classdef Controller_InputAircraft
    %UNTITLED4 Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        UI;
    end
    
    methods
        function obj = Controller_InputAircraft()
            obj.UI = UI_InputAircraft('Определение параметров летательного аппарата',[0.33 0.33 0.33 0.66]);
            obj.UI.setCallBack(@obj.aircraftParam)
        end
        function aircraftParam(obj,src,event)
            global aircraft_params;
            for i = 1:length(obj.UI.inputs)
                aircraft_params{i}{4} = obj.UI.inputs{i}.input_widget.Text();
            end
            close(gcf);
        end
    end
    
end

