classdef scheduler
    properties
        raypackage
        surfaces % Store references to all surfaces
        receiver
        freq_axis
    end

    methods

        function obj = scheduler(rayPackages, surfaces, receiver, freq)
            obj.raypackage = rayPackages;
            obj.surfaces = surfaces;
            obj.receiver = receiver;
            obj.freq_axis = freq;
        end

        function propagate(obj)
            % Propagate rays within ray packages through the environment

            for i = 1:numel(obj.raypackage)
                rayPackage = obj.raypackage(i);
                Rays = rayPackage.getRays();
                for j = 1:numel(Rays)
                    ray = Rays(j);
                    hold on;
                    ray.PlotRay(ray.origin);
                    for k = 1:numel(obj.surfaces)
                        % Calculate the intersection with surface
                        intersection = obj.surfaces{k}.intersect(ray);
                        if ~isempty(intersection)
                            c = 343;
                            D = norm(intersection - ray.origin);
                            if ray.propagation_time == 0
                                dA = 1/D;
                            else
                                dA = ray.distance./(ray.distance+D);
                            end
                            ray.distance = ray.distance+D;
                            ray.propagation_time = ray.propagation_time+D/c;
                            dFi = D/c*2*pi*obj.freq_axis;
                            ray.amplitude = ray.amplitude.* dA.* exp(-1i*dFi);
                            obj.surfaces{k}.reflect(ray, intersection);
                            break; % Break the loop after reflecting the ray
                        end
                    end
                    % TODO:: Receive 
               %     intersection = obj.receiver.receive(ray);
                end
            end

            rayPackage.EliminateRays;
        end


    end
end

