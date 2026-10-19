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
            [~,idx] = closestNode(X,Y,trajectory);
            nAhead = 10;
            trajpt = trajectory(idx+nAhead,:);
            x = trajpt(1);
            y = trajpt(2);
            %trajectory(idx+nAhead)
            phi = atan2(y-Y,x-X);
            angleError = wrapToPi(phi-psi);
            Kpsi = 10;
            
           
            
            delta = Kpsi*angleError;  % Safe placeholder; replace with controller output.

            % ---------------|Longitudinal Controller|--------------------
            % Design the longitudinal controller here and assign F.
            %
            %
            Vref = 50;
            V = sqrt(xdot^2+ydot^2);
            Ev = Vref-V;
            Kv = 100;
            %
            %
            F = Kv*Ev;      % Safe placeholder; replace with controller output.
        end
    end
end
