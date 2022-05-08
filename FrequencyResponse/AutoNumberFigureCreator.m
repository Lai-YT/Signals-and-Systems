classdef AutoNumberFigureCreator < handle
    % Automatically increase the number of figure by 1 everytime a new figure is created.
    %
    % Manually maintain the number of figure is cumbersome,
    % so AutoNumberFigureCreator handles that for you.
    % BUT make sure you consistenly create figures with the creator object
    % to keep the number under control.

    properties (SetAccess=private)
        % The figure number will start from 1.
        next_fig_no = 1;
    end

    methods
        function fig = CreateFigure(obj)
            % Creates a new figure with the number automatically increased.
            fig = figure(obj.next_fig_no);
            obj.IncreaseNumber();
        end
    end

    methods (Access=private)
        function obj = IncreaseNumber(obj)
            obj.next_fig_no = obj.next_fig_no + 1;
        end
    end
end
