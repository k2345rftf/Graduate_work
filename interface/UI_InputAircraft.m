classdef UI_InputAircraft < UIWindow
    
    properties
        inputs;
        button;
    end
    
    methods
        function obj = UI_InputAircraft(title, position)
            global aircraft_params;
            
            obj.setTitle(title);
            obj.setPosition(position);
            
            obj.inputs = {};
            y = 0.89;
            step = y/(length(aircraft_params));
            for i = 1:length(aircraft_params)
                obj.inputs{end+1} = UI_Input(aircraft_params{i}{2},aircraft_params{i}{3});
                obj.inputs{end}.setParent(obj.widget);
                obj.inputs{end}.setPosition([0 y-(i-1)*step 1 step]);
                obj.inputs{end}.setValues(aircraft_params{i}{4});
            end
            obj.button = UIButton();
            obj.button.setParent(obj.widget);
            obj.button.setPosition([0 0.01 1 step-0.01]);
            obj.button.setText('Сохранить');
            
        end
        
        function setCallBack(obj,callback_func)
            obj.button.setCallBack(callback_func);
        end
        


    end
    
end

