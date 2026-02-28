function Q = Q_matrix(ply)

% Output:
% Q - 3x3 reduced stiffness matrix

    denom = 1 - ply.nu12 * ply.nu21;

    Q11 = ply.E1  / denom;
    Q22 = ply.E2  / denom;
    Q12 = ply.nu12 * ply.E2 / denom;
    Q66 = ply.G12;

    Q = [ Q11, Q12,   0  ; ...
          Q12, Q22,   0  ; ...
           0,   0,   Q66 ];
end
