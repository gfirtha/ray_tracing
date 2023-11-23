classdef scheduler
    properties
        rays % Store references to all rays
        raypackage
        surfaces % Store references to all surfaces
        clock % Current clock signal
        step % Time step duration
    end

    methods

        function obj = scheduler(rayPackages, surfaces, step)
            obj.raypackage = rayPackages;
            obj.surfaces = surfaces;
            obj.clock = 0; % Initialize the clock
            obj.step = step; % Set the time step duration
        end

        function propagate(obj)
            % Propagate rays within ray packages through the environment

            for i = 1:numel(obj.raypackage)
                rayPackage = obj.raypackage(i);
                Rays = rayPackage.getRays();
                intersection = []; % Initialize intersection variable

                for j = 1:numel(Rays)
                    ray = Rays(j);
                    hold on;
                    ray.PlotRay(ray.origin);
                    for k = 1:numel(obj.surfaces)
                        surface = obj.surfaces{k};

                        if isa(surface, 'polygon')
                            % Calculate the intersection with a polygon surface
                            intersection = surface.intersect(ray);

                            if ~isempty(intersection)
                                % Ide a terjedési csillapítás és frekvencia
                                % függő fázisváltozás
                                % D = intersection - origin
                                % dA = decayFactor
                                % dFi = D/c*2*pi*freq
                                %ray.amplitude = ray.amplitude * decayFactor*exp(-1i*dFi);

                                % Implement amplitude decay based on distance traveled
                                %decayFactor = CalculateDecayFactor(ray.distance);
                                surface.reflect(ray, intersection);
                                break; % Break the loop after reflecting the ray
                            end

                        elseif isa(surface, 'my_sphere')
                            % Calculate the intersection with a sphere surface
                            intersection = surface.intersect(ray);
                            if ~isempty(intersection)
                                % Update the ray's properties based on the intersection
                                rayPackage.setRayOrigin(j, intersection);
                                % Perform other operations with spheres if required
                                break;
                            end
                        end

                        % Add other surface types as needed

                        if ~isempty(intersection)
                            % Update the ray's properties based on the intersection
                            rayPackage.setRayOrigin(j, intersection);
                            % Further ray interactions or updates can be done here
                            break;
                        end
                    end
                end
            end
        end
    end
end

