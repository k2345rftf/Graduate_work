classdef Model < handle
    
    properties
       errormsg;
       errorpath;
    end
    properties (Constant)
        path_rezult = 'bin/rezult.mat';
    end
    
    methods
        
        function obj = Model()
            obj.errormsg = '';
            obj.errorpath = '';
        end

        
        function rezult = runExp(obj,name_model,sim_time, H_zad, V_zad, r_zad, TIME,M_LA, xt_0, Ba, S_kr, varargin)
            global rezult_path;
            
            try
                L_kr = [];
                Ix = [];
                Iy = [];
                Iz = [];
                disp(varargin{1})
                if nargin == 12
                    Iz = varargin{1};
                elseif nargin == 14
                    Ix = varargin{1};
                    Iy = varargin{2};
                    Iz = varargin{3};
                elseif nargin == 15
                    L_kr = varargin{1};
                    Ix = varargin{2};
                    Iy = varargin{3};
                    Iz = varargin{4};
                end
                model = Simulation(name_model);
                count_H_zad = length(H_zad);
                count_V_zad = length(V_zad);
                count_r_zad = length(r_zad);
                per = 0;
                step = 1/(count_H_zad*count_V_zad*count_r_zad);
                progressbar('Расчет моделей');
                for i =1:count_H_zad
                    for j = 1:count_V_zad
                        for k = 1:count_r_zad
                            per = per + step;
                            if r_zad(k)
                                r_ = r_zad(k);
                            else
                                r_ = [];
                            end
                            model.setInputParam(M_LA, xt_0, H_zad(i), V_zad(j), r_, TIME, Ba, S_kr, L_kr, Ix, Iy, Iz);
                            model.run(sim_time);
                            
                            obj.retranslate_data(M_LA, xt_0, H_zad(i), V_zad(j), r_);
                            progressbar(per);
                        end
                    end
                end
%                 delete(gcp);
                load(rezult_path, 'data');
                rezult = data;
                delete(rezult_path)
                progressbar(1);
            catch error
                obj.errormsg = ['Описание ошибки: ' error.message ];
                obj.errorpath = ['Путь: ' error.stack(1,:).file error.stack(1,:).name '. Строка: ' num2str(error.stack(1,:).line)];
                rezult = 0;
            end
        end
        
        function retranslate_data(obj,M_LA, xt_0, H_zad, V_zad, r_)
            global list_info_about_variable;
            global rezult_path;
            
            list_var =  list_info_about_variable;
            load(obj.path_rezult, 'Variable');
            Var = Variable;
            rezult = struct;
            rezult.('M_LA') = M_LA;
            rezult.('xt_0') = xt_0;
            rezult.('H_zad') = H_zad;
            rezult.('V_zad') = V_zad;
            rezult.('r_') = r_;
            rezult.('Time') = Var(1,:);
            for i =2:(length(list_var)+1)
                if list_var{i-1}{4}
                    rezult.(list_var{i-1}{1}) = Var(i,:);
                end
            end
            delete(obj.path_rezult)
            try
                load(rezult_path,'data');
            catch
                data = {};
            end
            data{end+1}=rezult;
            save(rezult_path, 'data');
        end
    end
    
end

