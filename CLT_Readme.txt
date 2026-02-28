Classical Lamination Theory (CLT) – MATLAB Implementation

OVERVIEW

This project implements Classical Lamination Theory (CLT) for multilayer
composite laminates using MATLAB.

The program evaluates: - A (extensional stiffness matrix) - B
(bending–extension coupling matrix) - D (bending stiffness matrix) -
Midplane strains and curvatures - Thermal residual resultants -
Hygroscopic (moisture) resultants - Ply-level stresses in both global
and local coordinates

The script analyzes multiple standard laminate configurations using a
typical Carbon/Epoxy material system.

THEORY BACKGROUND

Classical Lamination Theory relates laminate force and moment resultants
to midplane strains and curvatures through:

    [N] = [A  B][eps0] - [NT + NM]
    [M]   [B  D][kappa]   [MT + MM]

Where: N = in-plane force resultants (N/m) M = moment resultants (N) A =
extensional stiffness matrix B = bending-extension coupling matrix D =
bending stiffness matrix eps0 = midplane strain kappa = curvature NT,MT
= thermal resultants NM,MM = moisture resultants

FILE STRUCTURE

create_ply.m - Creates ply data structure Q_matrix.m - Reduced stiffness
matrix [Q] Qbar_matrix.m - Transformed stiffness [Qbar]
transform_expansion.m - Thermal/hygroscopic expansion transform
compute_z.m - Through-thickness coordinate generation ABD_matrices.m -
Computes A, B, D matrices ABD_full.m - Builds 6x6 laminate stiffness
matrix solve_for_strain.m - Solves for midplane strain & curvature
solve_for_loads.m - Forward load solver thermal_loads.m - Thermal
force/moment resultants moisture_loads.m - Hygroscopic force/moment
resultants ply_stresses.m - Ply-level stress evaluation
build_laminate.m - Constructs laminate from stacking sequence
print_matrix.m - Console formatting utility run_analysis.m - Main
execution script

MATERIAL SYSTEM USED

Typical Carbon/Epoxy properties:

E1 = 135 GPa E2 = 10 GPa G12 = 5 GPa nu12 = 0.3 Ply thickness = 0.125 mm
alpha1 = -0.5 x 10^-6 /K alpha2 = 25 x 10^-6 /K beta1 = 0.02 x 10^-3
beta2 = 0.3 x 10^-3

All units are in SI.

HOW TO RUN

1.  Place all .m files in the same directory.

2.  Open MATLAB.

3.  Navigate to the project folder.

4.  Run:

    run_analysis

The script will print stiffness matrices, midplane strain, curvature,
thermal/moisture resultants, and ply-level stresses.

KEY EXPECTED BEHAVIOR

-   Symmetric laminates → B matrix equals zero
-   Balanced laminates → A16 and A26 equal zero
-   Unsymmetric laminates → bending–extension coupling present
-   Thermal mismatch → curvature in unsymmetric laminates
-   Moisture effects → increase transverse stresses

