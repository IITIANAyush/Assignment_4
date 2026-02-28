function Qb = Qbar_matrix(ply)

% QBAR_MATRIX  Transformed reduced stiffness matrix in global (x-y) axes.


%   where
%  T1 is the stress transformation matrix 
%  T2 is the strain transformation matrix 

    m  = cos(ply.theta);
    n  = sin(ply.theta);

    Q  = Q_matrix(ply);

    % Stress transformation:  sigma_12 = T1 * sigma_xy
    T1 = [ m^2,    n^2,    2*m*n  ; ...
           n^2,    m^2,   -2*m*n  ; ...
          -m*n,    m*n,    m^2-n^2 ];

    % Strain transformation (engineering shear):  eps_12 = T2 * eps_xy
    T2 = [ m^2,    n^2,    m*n    ; ...
           n^2,    m^2,   -m*n    ; ...
          -2*m*n,  2*m*n,  m^2-n^2 ];

    % Qbar = inv(T1) * Q * T2   [NOT inv(T2) — that would be wrong]
    Qb = T1 \ Q * T2;
end
