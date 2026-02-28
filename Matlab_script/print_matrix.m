function print_matrix(name, M)
% PRINT_MATRIX  Pretty-print a named matrix to the console.
    fprintf('\n%s:\n', name);
    for i = 1:size(M,1)
        fprintf('  ');
        fprintf('%14.6g  ', M(i,:));
        fprintf('\n');
    end
end
