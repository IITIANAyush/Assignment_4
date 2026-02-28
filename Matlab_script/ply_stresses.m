function stress_data = ply_stresses(plies, z, epsilon0, kappa, dT, dC)

% PLY_STRESSES  Compute ply stresses through the laminate thickness.

%   Output:

%     stress_data - struct array with fields for each ply k:
% .ply_num   - ply number (1-indexed)
% .z_mid     - z-coordinate of ply midplane [m]
% .sigma_xy  - 3x1 global stress [sigma_x; sigma_y; tau_xy] [Pa]
% .sigma_12  - 3x1 local ply stress [sigma_1; sigma_2; tau_12] [Pa]
%
%   Note:

% sigma_12 = T1 * sigma_xy  (rotated to ply 1-2 axes for failure criteria)

    if nargin < 5, dT = 0; end
    if nargin < 6, dC = 0; end

    n = numel(plies);

    for k = 1:n
        ply   = plies{k};
        Qb    = Qbar_matrix(ply);
        m     = cos(ply.theta);
        n_val = sin(ply.theta);

        % z at ply midplane
        z_mid  = 0.5 * (z(k) + z(k+1));

        % Total mechanical strain at midplane
        strain = epsilon0 + z_mid * kappa;

        % Hygro-thermal strain corrections
        alpha = transform_expansion(ply, ply.alpha1, ply.alpha2);
        beta  = transform_expansion(ply, ply.beta1,  ply.beta2);

        strain_mech = strain - alpha*dT - beta*dC;

        % Global stress (x-y frame)
        sigma_xy = Qb * strain_mech;

        % Rotate to ply 1-2 frame for failure criteria
        T1 = [ m^2,    n_val^2,    2*m*n_val  ; ...
               n_val^2, m^2,      -2*m*n_val  ; ...
              -m*n_val,  m*n_val,   m^2-n_val^2 ];

        sigma_12 = T1 * sigma_xy;

        % Store results
        stress_data(k).ply_num  = k;
        stress_data(k).z_mid    = z_mid;
        stress_data(k).sigma_xy = sigma_xy;
        stress_data(k).sigma_12 = sigma_12;
    end
end
