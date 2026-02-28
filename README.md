# Classical Lamination Theory (CLT) – MATLAB Implementation

## 📖 Overview
This project implements **Classical Lamination Theory (CLT)** for multi-layer composite laminates using MATLAB.

The program evaluates:
- In-plane stiffness matrix **A**
- Bending–extension coupling matrix **B**
- Bending stiffness matrix **D**
- Midplane strains and curvatures
- Thermal residual resultants
- Hygroscopic (moisture) resultants
- Ply-level stresses (global and local coordinates)

The script analyzes multiple standard laminate stacking configurations using a typical **Carbon/Epoxy** material system.

---

## ⚙️ Governing Equation
Classical Lamination Theory relates laminate force and moment resultants to midplane strains and curvatures:

[ N ]   [ A  B ] [ eps0 ]   [ NT + NM ]
[ M ] = [ B  D ] [ kappa ] -[ MT + MM ]

Where:
- **N** → In-plane force resultants (N/m)  
- **M** → Moment resultants (N)  
- **A** → Extensional stiffness matrix  
- **B** → Bending–extension coupling matrix  
- **D** → Bending stiffness matrix  
- **ε₀** → Midplane strain  
- **κ** → Curvature  
- **NT, MT** → Thermal resultants  
- **NM, MM** → Moisture resultants  

---

## 📂 File Structure
Each physical step in CLT is implemented modularly:

- `create_ply.m`          → Creates ply data structure  
- `Q_matrix.m`            → Reduced stiffness matrix [Q]  
- `Qbar_matrix.m`         → Transformed stiffness matrix [Qbar]  
- `transform_expansion.m` → Thermal/hygroscopic expansion transform  
- `compute_z.m`           → Through-thickness coordinate generation  
- `ABD_matrices.m`        → Computes A, B, D matrices  
- `ABD_full.m`            → Builds 6×6 laminate stiffness matrix  
- `solve_for_strain.m`    → Solves for midplane strain & curvature  
- `solve_for_loads.m`     → Forward load solver  
- `thermal_loads.m`       → Thermal force/moment resultants  
- `moisture_loads.m`      → Hygroscopic force/moment resultants  
- `ply_stresses.m`        → Ply-level stress evaluation  
- `build_laminate.m`      → Constructs laminate from stacking sequence  
- `print_matrix.m`        → Console formatting utility  
- `run_analysis.m`        → Main execution script  

---

## 🧵 Material System Used
Typical **Carbon/Epoxy** properties:

| Property       | Value                |
|----------------|----------------------|
| E1             | 135 GPa              |
| E2             | 10 GPa               |
| G12            | 5 GPa                |
| ν12            | 0.3                  |
| Ply thickness  | 0.125 mm             |
| α1             | -0.5 × 10⁻⁶ /K       |
| α2             | 25 × 10⁻⁶ /K         |
| β1             | 0.02 × 10⁻³          |
| β2             | 0.3 × 10⁻³           |

_All units are SI._

---

## 🧩 Laminate Configurations Analyzed
- [0]ⁿ (n = 4)  
- [90]ⁿ (n = 4)  
- [0/90]T (unsymmetric cross-ply)  
- [0/90]s (symmetric cross-ply)  
- [+45/-45]  
- Balanced Quasi-Isotropic: [0/45/-45/90]s  

These configurations allow comparison of:
- Symmetric vs unsymmetric laminates  
- Balanced vs unbalanced laminates  
- Coupling behavior (**B matrix effects**)  
- Shear–extension coupling (**A16, A26 terms**)  
- Thermal and moisture-induced curvature  

---

## ▶️ How to Run
1. Place all `.m` files in the same directory.  
2. Open MATLAB.  
3. Navigate to the project folder.  
4. Run:

```matlab
run_analysis
