function [NT, MT] = thermal_loads(plies, z, dT)

% THERMAL_LOADS  Compute thermal force and moment resultants.
%   Outputs:
% NT  - 3x1 thermal force resultants  [N/m]
%  MT  - 3x1 thermal moment resultants [N]
    n  = numel(plies);
    NT = zeros(3,1);
    MT = zeros(3,1);

    for k = 1:n
        ply   = plies{k};
        Qb    = Qbar_matrix(ply);
        alpha = transform_expansion(ply, ply.alpha1, ply.alpha2);

        z_bot = z(k);
        z_top = z(k+1);

        NT = NT + Qb * alpha * dT * (z_top - z_bot);
        MT = MT + Qb * alpha * dT * 0.5 * (z_top^2 - z_bot^2);
    end
end
