classdef scheduler
    properties
        raypackage
        surfaces % Store references to all surfaces
        clock % Current clock signal
        step % Time step duration
        freq_axis
    end

    methods

        function obj = scheduler(rayPackages, surfaces, step, freq)
            obj.raypackage = rayPackages;
            obj.surfaces = surfaces;
            obj.step = step; % Set the time step duration
            obj.freq_axis = freq;
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
                                c=343;                                        %TODO:ezekhez majd gettereket és settereket írni
                                D = norm(intersection - ray.origin);

                                if ray.propagation_time == 0
                                    dA = ones(1024,1)/D;
                                else
                                    dA = ones(1024,1).*ray.distance./(ray.distance+D);
                                end
                                ray.distance = ray.distance+D;
                                ray.propagation_time = ray.propagation_time+D/c;
                                %decay factor inicailzálás

                                %tehát itt ez a rész ami kicsit homály,
                                %hogy hogyan lehetne frek függővé tenni a delay factort



                                dFi = D/c*2*pi*obj.freq_axis;
                                ray.amplitude = ray.amplitude.* dA.* exp(-1i*dFi);
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

           rayPackage.EliminateRays;
        end


    end
end

