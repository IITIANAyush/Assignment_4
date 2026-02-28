function [epsilon0, kappa] = solve_for_strain(plies, z, N, M, dT, dC)
% SOLVE_FOR_STRAIN  Solve for midplane strains and curvatures given loads.

%
%   Outputs:
%     epsilon0 - 3x1 midplane strains  [ex0; ey0; gxy0]
%     kappa    - 3x1 curvatures        [kx; ky; kxy]   [1/m]

    if nargin < 5, dT = 0; end
    if nargin < 6, dC = 0; end

    ABD = ABD_full(plies, z);

    % Environmental loads
    [NT, MT] = thermal_loads(plies, z, dT);
    [NM, MM] = moisture_loads(plies, z, dC);

    % Effective mechanical loads (subtract environmental)
    N_eff = N - (NT + NM);
    M_eff = M - (MT + MM);

    loads    = [N_eff; M_eff];
    solution = ABD \ loads;

    epsilon0 = solution(1:3);
    kappa    = solution(4:6);
end
