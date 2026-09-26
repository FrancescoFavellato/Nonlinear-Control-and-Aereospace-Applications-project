clear all; close all; clc;
animazione = false;         % true per vedere l'animazione

%% INIZIALIZZAZIONE PARAMETRI
fprintf('==========================================\n');
fprintf('6DOF CHASER SIMULATION\n');
fprintf('==========================================\n');

addpath(fullfile(pwd, 'utili'));
init_param;

%% SIMULAZIONE
nome_sim = 'model_6dof';

T_sim = 600;        %  [s]
fprintf('Simulazione in corso ...\n');
out = sim(nome_sim, 'StopTime', num2str(T_sim));
fprintf('Simulazione completata.\n');

%% PLOT
plot_results

%% ANIMAZIONE
if (animazione == true)
    fprintf('Avvio dell''animazione...\n');
    animate
end

