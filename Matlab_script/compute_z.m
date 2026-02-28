function z = compute_z(plies)

%   Note: Laminate mid-plane is at z = 0.

    n = numel(plies);
    total_t = 0;
    for k = 1:n
        total_t = total_t + plies{k}.t;
    end

    z = zeros(n+1, 1);
    z(1) = -total_t / 2;
    for k = 1:n
        z(k+1) = z(k) + plies{k}.t;
    end
end
