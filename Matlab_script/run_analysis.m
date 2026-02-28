clc; clear;

%  Material: Carbon/Epoxy (typical)
%  E1 E2 G12 nu12 t a1 a2 b1 b2
mat = [ 135e9,  10e9,  5e9,  0.3,  0.125e-3, -0.5e-6, 25e-6, 0.02e-3, 0.3e-3 ];

%  Laminate configurations
configs = { ...
    '[0]n (n=4)',            [0,  0,  0,  0 ]            ; ...
    '[90]n (n=4)',           [90, 90, 90, 90]            ; ...
    '[0/90]T',               [0,  90          ]           ; ...
    '[0/90]s',               [0,  90, 90, 0  ]           ; ...
    '[+45/-45]',             [45, -45          ]          ; ...
    'Balanced Quasi-Isotropic', [0, 45, -45, 90, 90, -45, 45, 0] ...
};

%  Loading conditions
N_app = [1e5; 0; 0];   % Applied force resultants  [N/m]
M_app = [0;   0; 0];   % Applied moment resultants [N]
dT    = -100;           % Temperature change        [K]
dC    =  0.02;          % Moisture change           [% weight]

%  Loop over all laminates
for i = 1:size(configs, 1)

    name = configs{i, 1};
    seq  = configs{i, 2};

    fprintf('\n====================================\n');
    fprintf('Laminate: %s\n', name);
    fprintf('Stacking: [');
    fprintf(' %d', seq);
    fprintf(' ]\n');

    % Build laminate
    [plies, z] = build_laminate(seq, mat);

    % ABD matrices
    [A, B, D] = ABD_matrices(plies, z);
    print_matrix('A Matrix [N/m]', A);
    print_matrix('B Matrix [N]',   B);
    print_matrix('D Matrix [N.m]', D);

    % Midplane strain and curvature (pure mechanical, dT=dC=0)
    [eps0, kappa] = solve_for_strain(plies, z, N_app, M_app, 0, 0);
    fprintf('\nMidplane Strain [eps_x, eps_y, gamma_xy]:\n');
    fprintf('  %14.6g  %14.6g  %14.6g\n', eps0(1), eps0(2), eps0(3));
    fprintf('Curvature [kx, ky, kxy] (1/m):\n');
    fprintf('  %14.6g  %14.6g  %14.6g\n', kappa(1), kappa(2), kappa(3));

    % Thermal resultants
    [NT, MT] = thermal_loads(plies, z, dT);
    fprintf('\nThermal Resultants NT [N/m]: %14.6g  %14.6g  %14.6g\n', NT(1), NT(2), NT(3));
    fprintf('Thermal Moments    MT [N]:   %14.6g  %14.6g  %14.6g\n', MT(1), MT(2), MT(3));

    % Moisture resultants
    [NM, MM] = moisture_loads(plies, z, dC);
    fprintf('\nMoisture Resultants NM [N/m]: %14.6g  %14.6g  %14.6g\n', NM(1), NM(2), NM(3));
    fprintf('Moisture Moments    MM [N]:   %14.6g  %14.6g  %14.6g\n', MM(1), MM(2), MM(3));

    % Ply-level stresses under mechanical load
    sd = ply_stresses(plies, z, eps0, kappa, 0, 0);
    fprintf('\nPly Stresses (global x-y frame)  [Pa]:\n');
    fprintf('  %-6s  %-10s  %-14s  %-14s  %-14s\n', ...
            'Ply', 'z_mid[m]', 'sigma_x', 'sigma_y', 'tau_xy');
    for k = 1:numel(sd)
        fprintf('  %-6d  %10.4e  %14.4e  %14.4e  %14.4e\n', ...
            sd(k).ply_num, sd(k).z_mid, ...
            sd(k).sigma_xy(1), sd(k).sigma_xy(2), sd(k).sigma_xy(3));
    end

    fprintf('\nPly Stresses (local 1-2 frame)   [Pa]:\n');
    fprintf('  %-6s  %-10s  %-14s  %-14s  %-14s\n', ...
            'Ply', 'z_mid[m]', 'sigma_1', 'sigma_2', 'tau_12');
    for k = 1:numel(sd)
        fprintf('  %-6d  %10.4e  %14.4e  %14.4e  %14.4e\n', ...
            sd(k).ply_num, sd(k).z_mid, ...
            sd(k).sigma_12(1), sd(k).sigma_12(2), sd(k).sigma_12(3));
    end

end

fprintf('\n====================================\n');
fprintf('Analysis complete.\n');
