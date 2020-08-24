classdef UIGrafWidget < UIPanel
    properties
        ax;
    end
    
    methods
        function obj = UIGrafWidget()
%             ������� ��� ������ �������
            obj.ax = axes();
            obj.ax.Parent = obj.widget;
            obj.ax.Position = [0.1 0.1 0.87 0.87];
        end
        
        % ��������� ������
        % ��������� ������� ����������� x �� y ��� ��������
        % drawGraf(x,y)
        % ��������� ������� ����������� x �� y � ��������������� ��������� ��� �����
        % drawGraf(x,y,label_x,label_y)
        % ��������� ������� ����������� x �� y � ��������������� ��������� ��� �����
        % � � ������������� �������
        % drawGraf(x,y,label_x,label_y, title)
        % ��������� ������� ����������� z �� x � y ��� ��������
        % drawGraf(x,y,z)
        % ��������� ������� ����������� z �� x � y � ��������������� ��������� ��� �����
        % drawGraf(x,y,z,label_x,label_y)
        % ��������� ������� ����������� z �� x � y � ��������������� ��������� ��� �����
        % � � ������������� �������
        % drawGraf(x,y,z,label_x,label_y,label_z, title)

        function drawGraf(obj,varargin)
            if nargin == 4 || nargin == 7 || nargin == 8
                
                plot3(obj.ax, varargin{1},varargin{2},varargin{3}, 'color', 'k')

                if nargin == 7 || nargin == 8
                    xlabel(obj.ax,varargin{4});
                    ylabel(obj.ax,varargin{5});
                    zlabel(obj.ax,varargin{6});
                    if nargin == 8
                        legend(obj.ax, varargin{7});
                    end
                end
            elseif nargin == 3 || nargin == 5 || nargin == 6
                plot(obj.ax, varargin{1},varargin{2},'color', 'k')
                
                if nargin == 5 || nargin == 6
                    xlabel(obj.ax,varargin{3});
                    ylabel(obj.ax,varargin{4});
                    if nargin == 6
                        legend(obj.ax, varargin{5});
                    end
                end
            end

        end
        
    end
    
end

