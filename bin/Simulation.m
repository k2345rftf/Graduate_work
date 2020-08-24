classdef Simulation
    properties
        name_engine;
        filename;
        rezult_model_path;
    end
    properties (Constant)
        flight_mode = '/Режим полета';
        control_calc ='/Управление расчетом';
        object = '/Объект 1';
    end
    
    methods
        function obj = Simulation(name_engine)
            obj.filename = ['engine\' name_engine '.slx'];
            obj.name_engine = name_engine;

            open_system(obj.filename,'loadonly');
        end
      
        function setInputParam(obj, M_LA, xt_0, H_zad, V_zad, r_zad, TIME, Ba, S_kr, L_kr, Ix, Iy, Iz, varargin)
            name_subsystem_flight_mode = [obj.name_engine obj.flight_mode];
            name_subsystem_control_calc = [obj.name_engine obj.control_calc];
            name_subsystem_object = [obj.name_engine obj.object];
            
            set_param(name_subsystem_flight_mode,'H_0',num2str(H_zad))
            set_param(name_subsystem_flight_mode,'M_LA',num2str(M_LA))
            set_param(name_subsystem_flight_mode,'V_0',num2str(V_zad))
            set_param(name_subsystem_object,'S_kr',num2str(S_kr))
            set_param(name_subsystem_object,'Ba',num2str(Ba))
            set_param(name_subsystem_control_calc,'xt_0',num2str(xt_0))
            set_param(name_subsystem_object,'Iz',num2str(Iz))
            
            if ~isempty(r_zad)
                set_param(name_subsystem_flight_mode,'r_0',num2str(r_zad))
                set_param(name_subsystem_flight_mode,'TIME',num2str(TIME))
                set_param(name_subsystem_object,'Ix',num2str(Ix))
                set_param(name_subsystem_object,'Iy',num2str(Iy))
            end
            if ~isempty(L_kr)
                set_param(name_subsystem_flight_mode,'l_wing',num2str(L_kr))
            end
%             set_param(obj.name_engine,'MaxConsecutiveZCsMsg','none');
            
            if nargin == 18
                max_d_e = varargin{1};
                min_d_e = varargin{2};
                max_d_n = varargin{3};
                min_d_n = varargin{4};
                max_d_v = varargin{5};
                min_d_v = varargin{6};
                
                set_param(name_subsystem_control_calc,'maximum_d_e',num2str(max_d_e))
                set_param(name_subsystem_control_calc,'minimum_d_e',num2str(min_d_e))
                set_param(name_subsystem_control_calc,'maximum_d_n',num2str(max_d_n))
                set_param(name_subsystem_control_calc,'minimum_d_n',num2str(min_d_n))
                set_param(name_subsystem_control_calc,'maximum_d_v',num2str(max_d_v))
                set_param(name_subsystem_control_calc,'minimum_d_v',num2str(min_d_v))
                
            end

            
        end
        
        function run(obj, sim_time)
            sim(obj.name_engine, 'StopTime', num2str(sim_time));
        end
        
        function delete(obj)
            save_system(obj.filename);
            close_system(obj.filename);
        end

        
    end
    
end

