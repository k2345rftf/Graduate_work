classdef Controller_SaveVariabels < UI_ChoosePanel

    properties
        UI;
        indexes;
        data;
    end
    methods
        function obj = Controller_SaveVariabels(data)
            global list_info_about_variable;
            obj.data = data;
            count_checkbox = length(list_info_about_variable);
            obj.UI = UI_ChoosePanel('Сохранение результатов расчета в файл',[0.33 0.1 0.33 0.85]);
            indx = [];
            for i = 1:count_checkbox
                if list_info_about_variable{i}{4}
                    indx(end+1) = i;
                    obj.UI.addCheckBox(list_info_about_variable{i}{2},0);
                end
            end
            obj.UI.addCheckBox('Записать только поледние значения',0);
            obj.UI.setCallBack(@obj.save);
            obj.UI.setNameButton('Сохранить');
        end
        function obj = save(obj, src, event)
            global list_info_about_variable;
            
            [file,path] = uiputfile('*.xlsx');
            filename = [path file];
            count_exp = length(obj.data);
            indx = obj.UI.getValues();
            l1 = {};
            header = {};
            for i = 1:count_exp
                line = {};
                k = 1;
                for j = 1:length(list_info_about_variable)
                    if list_info_about_variable{j}{4}
                        if indx(k)
                            rez = num2cell(obj.data{i}.(list_info_about_variable{j}{1}));
                            for l = 1:length(rez)
                                if isinf(rez{l})
                                    rez{l} = 'Inf';
                                end
                            end
                            line(end+1,:) = rez;
                            if i == 1
                                header{end+1} = list_info_about_variable{j}{2};
                            end
                        end
                        k = k+1;
                        if k > length(indx)
                            break
                        end
                    end
                end
                if isempty(line)
                    return
                end
                if obj.data{i}.('r_') == inf
                    r_zad = 'Inf';
                else
                    r_zad = obj.data{i}.('r_');
                end
                ll = line';
                if ~indx(end)
                    init_value = {'Заданная масса', obj.data{i}.('M_LA');...
                        'Заданная высота', obj.data{i}.('H_zad');...
                        'Заданная скороcть', obj.data{i}.('V_zad');...
                        'Заданная координата Xt', obj.data{i}.('xt_0');...
                        'Заданный радиус разворота', r_zad};
                    xlswrite(filename,init_value,['Эксперимент №' num2str(i)], 'A1');
                    xlswrite(filename,header,['Эксперимент №' num2str(i)], 'A5');
                    xlswrite(filename,line',['Эксперимент №' num2str(i)], 'A6');
                    
                end
                l1(end+1,:) = ll(end,:);
            end
            
            if indx(end)
                xlswrite(filename,header,'Результаты расчетов', 'A1');
                xlswrite(filename,l1,'Результаты расчетов', 'A2');
            end
            close(gcf);
        end
    end
    
end

