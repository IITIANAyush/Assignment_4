function alpha_xy = transform_expansion(ply, c1, c2)
% TRANSFORM_EXPANSION  Transform ply-axis expansion coefficients to global axes.

% 0utput:
%  alpha_xy - 3x1 vector [cx; cy; cxy] in global x-y frame

    m = cos(ply.theta);
    n = sin(ply.theta);

    % T2 is the strain transformation matrix
    T2 = [ m^2,    n^2,    m*n    ; ...
           n^2,    m^2,   -m*n    ; ...
          -2*m*n,  2*m*n,  m^2-n^2 ];

    % Global expansion = inv(T2) * [c1; c2; 0]
    alpha_xy = T2 \ [c1; c2; 0];
end
