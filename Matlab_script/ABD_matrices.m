function [A, B, D] = ABD_matrices(plies, z)

%calculation of A,B and D matrix

    n = numel(plies);

    A = zeros(3,3);
    B = zeros(3,3);
    D = zeros(3,3);

    for k = 1:n
        Qb    = Qbar_matrix(plies{k});
        z_bot = z(k);
        z_top = z(k+1);

        A = A + Qb * (z_top - z_bot);
        B = B + 0.5 * Qb * (z_top^2 - z_bot^2);
        D = D + (1/3) * Qb * (z_top^3 - z_bot^3);
    end
end
