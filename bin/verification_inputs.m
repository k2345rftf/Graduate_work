function [status, err_msg] = verification_inputs(value, field_name, field_visibility)
    count_elem = length(value);
    err_msg = '';
    status = 0;
    if ~count_elem
%         
% 
        [status, err_msg] = getError(field_name);
        return
    end
    for l = 1:length(value)
        if val(l) <= 0  && (field_visibility == 1)
            [status, err_msg] = getError(field_name);
            return
        end
    end


end

function [status, err_msg] = getError(field_name)
    err_msg = ['����: ' field_name ' �� ���������, ��� �������� ���� ���������������!!!'];
    status = 1;
end

