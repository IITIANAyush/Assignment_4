function [NM, MM] = moisture_loads(plies, z, dC)
% MOISTURE_LOADS  Compute hygroscopic force and moment resultants.
%   [NM, MM] = moisture_loads(plies, z, dC)

%   Inputs:
%     plies  - cell array of ply structs
%     z      - interface z-coordinates from compute_z()
%     dC     - moisture concentration change [% weight fraction]

%   Outputs:
%     NM  - 3x1 hygroscopic force resultants  [N/m]
%     MM  - 3x1 hygroscopic moment resultants [N]

    n  = numel(plies);
    NM = zeros(3,1);
    MM = zeros(3,1);

    for k = 1:n
        ply  = plies{k};
        Qb   = Qbar_matrix(ply);
        beta = transform_expansion(ply, ply.beta1, ply.beta2);

        z_bot = z(k);
        z_top = z(k+1);

        NM = NM + Qb * beta * dC * (z_top - z_bot);
        MM = MM + Qb * beta * dC * 0.5 * (z_top^2 - z_bot^2);
    end
end
