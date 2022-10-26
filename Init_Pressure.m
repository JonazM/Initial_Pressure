function [Pnod,Stiff] = Init_Pressure(grf)
%   This function calculates the intial pressure that is needed to make the
%   volume of a cylinder to change. Knowing the value of initial pressure 
%   that staistfies the pressure due to a person's bodyweight and the
%   volume, we can then calculate the stiffness. 
%   INPUTS: 
%      grf - Maximum force being applied to the cylinder.
%       
%   OUTPUTS:
%      Pnod - the initial pressure that can make the object change in
%      volume
%      Stiff - Stiffness of the object/shape that is being analyzed
% This function is based on the follow relation between initial pressure
% and pressure after the object has been compressed due to a force like
% bodyweight 
% 
%   Pnod*Vnod = P1*V1 
%  Pnod - initial preassure force inside the cylinders
%  Vnod - initial volume without being deflected
%  P1 - Preassure based on the force and corss sectional area
%  V1 - volume after the object has been deflected
%--------------------------------------------------------------------------
format short 
% Defining initial volume of a cylinder
r = 4;          % radius (cm)
h = 0.8;        % initial height (cm)
A = pi*r^2;     % Area of cylinder
Vnod = A*h;     % Initial volume
P1 = grf/A;     % Pressure dependent on GRF and cross sectional area

%containers for the varialbes
Pnod = zeros(4,1);   % initial pressure - OUTPUT
V1 = zeros(4,1);     % new volume after changing height
d = zeros(4,1);      % displacement of the cylinder
Stiff = zeros(4,1);  % Stiffness

% for loop that calculates the initial pressure based on the person's GRF
% This for-loop calculates all the output variables and puts them in a 4x1
% matrix. Each row represents an initial pressure after the cylinder has
% been displaced (volume becomes smaller)
for i = 1:4
    d(i) = h-(i*0.2);
    if d(i) == 0
        break
    end
    V1(i) = A*(h-d(i)); % Volume after the cyilinder has been displaced
    Pnod(i) = (P1*V1(i))/Vnod;
    Stiff(i) = grf/d(i); % Stiffness as a function of the displacement and
                         % GRF. 
end 

figure
plot(Pnod,Stiff)

end