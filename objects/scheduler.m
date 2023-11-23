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
                eps=0.0001;
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
                                c=343;                                        %ezekhez majd gettereket és settereket írni
                                D = norm(intersection - ray.origin);
                                ray.distance = ray.distance+D;
                                ray.propagation_time = ray.propagation_time+D/c;
                                %decay factor inicailzálás
                                decayFactor = ones(1024,1);                    %ide is valahogy a frek tengelyt átadni
                                decayFactor = decayFactor./D;


                                fs = 44.1e3;
                                Nt = 1024;
                                freq = (0:Nt-1)/Nt*fs;
                                  dA = decayFactor;


                                dFi = D/c*2*pi*freq;
                                ray.amplitude = ray.amplitude * dA * exp(-1i*dFi);
                                %ezután lehetne egy if, hogy ha eps érték
                                %alá esik az amplitúdó akkor ray elimináció
                                % if ray.amplitude<eps
                                %     EliminateRays;
                                % end
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

