classdef UITableWidget < UIPanel
    properties
        table;
    end
    
    methods
        function obj = UITableWidget()

            obj.table = uitable();
            obj.table.Parent = obj.widget;
            obj.table.Units = 'normalized';
            obj.table.Position = [0 0 1 1];
            
        end
        
        function setFontSize(obj,FontSize)
            obj.table.FontSize = FontSize;
        end
        
        function setColumnWidth(obj,ColumnWidth)
%             {210, 'auto'}
            obj.table.ColumnWidth = ColumnWidth;
        end
        
        function clearTable(obj)
            obj.table.Data = {};
            obj.table.RowName = {};
        end
        
        function setRowName(obj, headers)
            obj.table.RowName = headers;
        end
        
        function setData(obj, TData)
            obj.table.Data = TData;
        end
        
        function data = getData(obj)
            data = obj.table.Data;
        end
    end
    
end

