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
                    currentOrigin = rayPackage.getRayOrigin(j);
                    currentDirection = rayPackage.getRayDirection(j);

                    for k = 1:numel(obj.surfaces)
                        surface = obj.surfaces{k};

                        if isa(surface, 'polygon')
                            % Calculate the intersection with a polygon surface
                            intersection = surface.intersect(currentOrigin,currentDirection);
                           if ~isempty(intersection)
                        % Update the ray's properties based on the intersection
                        rayPackage.setRayOrigin(j, intersection);
                        % Reflect the ray from the wall
                        surface.reflect(ray);
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

                    if isempty(intersection)
                        % If no intersection, move the ray to the next position
                        nextPosition = currentOrigin + currentDirection * obj.step;
                        rayPackage.setRayOrigin(j, nextPosition);  
                    end
                end
            end

      

            rayss=rayPackage.getRays();
            last_ray=rayss(end);
            hold on;
            last_ray.PlotRay(intersection);
            title('Last Propagated Ray');
            hold off;


            obj.clock = obj.clock + obj.step;
        end
    end
 end

