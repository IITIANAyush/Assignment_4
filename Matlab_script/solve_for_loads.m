function [N, M] = solve_for_loads(plies, z, epsilon0, kappa)

% SOLVE_FOR_LOADS  Compute force/moment resultants from midplane strains.
%   Outputs:
%     N  - 3x1 force resultants  [N/m]
%     M  - 3x1 moment resultants [N]


    ABD   = ABD_full(plies, z);
    state = [epsilon0; kappa];
    loads = ABD * state;

    N = loads(1:3);
    M = loads(4:6);
end
