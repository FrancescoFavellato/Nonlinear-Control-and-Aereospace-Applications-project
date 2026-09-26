%% ORBITA E TARGET
omega_orb = 0.0011;              % [rad/s]

% Posizione desiderata del chaser rispetto al target
z_r = [10; 0; 0];                % [m]

% Il target è nell' origine
target = [0; 0; 0];              % [m]

%% CHASER - INERZIA
J = diag([937.5, 833.3, 270.8]); % [kg m^2]
IJ = inv(J);

%% CONDIZIONI INIZIALI TRASLAZIONALI
z0 = [15; -60; 30];                % [m]

zdot0 = [0; 0; 0];               % [m/s]

%% CONDIZIONI INIZIALI ASSETTO
q0 = [1; 0; 0; 0];               % quaternione assetto iniziale

w0 = [0.01; -0.005; 0.008];                 % [rad/s]

%% POINTING
% Asse body che deve puntare verso il target
boresight_b = [1; 0; 0];    % Asse x del Chaser deve puntare verso il Target

% Vettore ausiliario nel frame LVLH
up_hint = [0; 0; 1];

% Secondo asse body utilizzato per fissare il roll
body_secondary = [0; 0; 1];

%% SMC TRASLAZIONALE
K_pos = diag([0.05, 0.05, 0.05]);

eta_pos = 0.02*ones(3,1);

phi_pos = 0.01*ones(3,1);

%%  SMC ASSETTO
K_att = diag([0.09, 0.09, 0.09]);

eta_att = 0.01*ones(3,1);

phi_att = 0.1*ones(3,1);

%% SATURAZIONI
u_sat = 1*ones(3,1);              % [m/s^2] -> SMC Traslazione

M_sat = 10*ones(3,1);             % [Nm] -> SMC Assetto

%% DISTURBI - ASSETTO
dist_amp = 0.05;                 % [Nm]
dist_freq = 0.1;                  % [rad/s]

%% DISTURBI - TRASLAZIONE
dist_amp_pos = 0.002;      % [m/s^2]    piccolo rispetto a u_sat=1
dist_freq_pos = 0.05;      % [rad/s]

%% STAMPA PARAMETRI PRINCIPALI
fprintf('\n==========================================\n');
fprintf('INIZIALIZZAZIONE SIMULAZIONE 6-DOF\n');
fprintf('==========================================\n');
fprintf('omega_orb = %.6f rad/s\n', omega_orb);
fprintf('Standoff point = [%g %g %g] m\n', z_r);
fprintf('Condizione iniziale posizione = [%g %g %g] m\n', z0);
fprintf('Condizione iniziale velocita'' = [%g %g %g] m/s\n', zdot0);
fprintf('Condizione iniziale velocita'' angolare = [%g %g %g] m/s\n', w0);
fprintf('============================================\n\n');