function ABD = ABD_full(plies, z)
% Output:
% ABD    - 6x6 matrix:
%   [ A  B ]
%   [ B  D ]

    [A, B, D] = ABD_matrices(plies, z);
    ABD = [ A, B ; B, D ];
end
