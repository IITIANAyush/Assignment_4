function ply = create_ply(E1, E2, G12, nu12, thickness, theta_deg, ...
                           alpha1, alpha2, beta1, beta2)

%   Inputs:
%     E1, E2      - Longitudinal / transverse Young's modulus [Pa]
%     G12         - In-plane shear modulus [Pa]
%     nu12        - Major Poisson's ratio [-]
%     thickness   - Ply thickness [m]
%     theta_deg   - Fibre angle [degrees]
%     alpha1,alpha2 - Thermal expansion coefficients [1/K]  (default 0)
%     beta1, beta2  - Hygroscopic expansion coefficients [1/%M] (default 0)
%
%   Output:
%     ply  - struct with fields: E1,E2,G12,nu12,nu21,t,theta,
%                                alpha1,alpha2,beta1,beta2
   
    if nargin < 7,  alpha1 = 0; end
    if nargin < 8,  alpha2 = 0; end
    if nargin < 9,  beta1  = 0; end
    if nargin < 10, beta2  = 0; end

    ply.E1     = E1;
    ply.E2     = E2;
    ply.G12    = G12;
    ply.nu12   = nu12;
    ply.nu21   = (E2/E1) * nu12; %Maxwell reciporocal relation
    ply.t      = thickness;
    ply.theta  = deg2rad(theta_deg);% store in radians internally

    ply.alpha1 = alpha1;
    ply.alpha2 = alpha2;
    ply.beta1  = beta1;
    ply.beta2  = beta2;
end
