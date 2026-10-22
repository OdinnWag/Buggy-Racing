classdef your_controller < BaseController
    % Fill in the respective sections to implement the controller.
    properties
        lr = 0.82
        lf = 1.18
        Ca = 20000
        Iz = 3004.5
        m = 1000
        g = 9.81
    end

    methods
        function obj = your_controller(trajectory)
            obj@BaseController(trajectory);
            % Add additional member variables as needed here.
        end

        function [X, Y, xdot, ydot, psi, psidot, F, delta] = update(obj, timestep)
            trajectory = obj.trajectory; %#ok<NASGU>
            lr = obj.lr; %#ok<NASGU>
            lf = obj.lf; %#ok<NASGU>
            Ca = obj.Ca; %#ok<NASGU>
            Iz = obj.Iz; %#ok<NASGU>
            m = obj.m; %#ok<NASGU>
            g = obj.g; %#ok<NASGU>

            [delT, X, Y, xdot, ydot, psi, psidot] = obj.getStates(timestep); %#ok<ASGLU>

            % ---------------|Lateral Controller|-------------------------
            % Design the lateral controller here and assign delta.
            %
            %
            %
            %
            %
            %
            %
            delta = 0;  % Safe placeholder; replace with controller output.

            % ---------------|Longitudinal Controller|--------------------
            % Design the longitudinal controller here and assign F.
            %
            %
            %
            %
            %
            %
            %
            F = 0;      % Safe placeholder; replace with controller output.
        end
    end
end
