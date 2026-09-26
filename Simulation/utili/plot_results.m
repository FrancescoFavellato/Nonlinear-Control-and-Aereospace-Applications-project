%%  1. QUATERNIONE: REALE VS RIFERIMENTO
t_q = out.q_out.Time;
q = out.q_out.Data;
t_qr = out.q_r_out.Time;

q_r_raw = out.q_r_out.Data;
if ndims(q_r_raw) == 3
    q_r = squeeze(q_r_raw).';
    if size(q_r,1) == 4 && size(q_r,2) == length(t_qr)
        q_r = q_r.';
    end
else
    q_r = q_r_raw;
    if size(q_r,1) == 4 && size(q_r,2) == length(t_qr)
        q_r = q_r.';
    end
end

q_labels  = {'q_0','q_1','q_2','q_3'};
qr_labels = {'$q_{r0}$','$q_{r1}$','$q_{r2}$','$q_{r3}$'};
q_titles  = {'Componente scalare $q_0$','Componente $q_1$','Componente $q_2$','Componente $q_3$'};

for i = 1:4
    figure('Name',['Quaternione ' q_labels{i} ' - reale vs riferimento'], 'NumberTitle','off');
    plot(t_q, q(:,i), 'LineWidth', 1.2);
    hold on
    plot(t_qr, q_r(:,i), '--', 'LineWidth', 1.2);
    grid on
    xlabel('Tempo [s]')
    ylabel(q_labels{i}, 'Interpreter','latex')
    title(q_titles{i}, 'Interpreter','latex')
    legend(q_labels{i}, qr_labels{i}, 'Interpreter','latex', 'Location','best');
end

%% 2. ERRORE DI ASSETTO
t_qerr = out.q_err_out.Time;
q_err_raw = out.q_err_out.Data;

if ndims(q_err_raw) == 3
    q_err = squeeze(q_err_raw).';
    if size(q_err,1) == 4 && size(q_err,2) == length(t_qerr)
        q_err = q_err.';
    end
else
    q_err = q_err_raw;
    if size(q_err,1) == 4 && size(q_err,2) == length(t_qerr)
        q_err = q_err.';
    end
end

figure('Name','Errore di assetto','NumberTitle','off');
plot(t_qerr, q_err(:,1), 'LineWidth', 1.2);
hold on
plot(t_qerr, q_err(:,2), 'LineWidth', 1.2);
plot(t_qerr, q_err(:,3), 'LineWidth', 1.2);
plot(t_qerr, q_err(:,4), 'LineWidth', 1.2);
grid on
xlabel('Tempo [s]')
ylabel('Errore')
title('Errore di assetto - quaternione di errore')
legend('$e_{q0}$', '$e_{q1}$', '$e_{q2}$', '$e_{q3}$', 'Interpreter','latex', 'Location','best');

%% 3. VELOCITA' ANGOLARE (3 grafici separati)
t_w = out.w_out.Time;
w = out.w_out.Data;

w_labels = {'omega_x','omega_y','omega_z'};

for i = 1:3
    figure('Name',['Velocita'' angolare ' w_labels{i}],'NumberTitle','off');
    plot(t_w, w(:,i), 'LineWidth', 1.2);
    grid on
    xlabel('Tempo [s]')
    ylabel([w_labels{i} ' [rad/s]'], 'Interpreter','latex')
    title(['Velocita'' angolare ' w_labels{i}], 'Interpreter','latex')
end

%% 4. MOMENTO DI CONTROLLO
t_M = out.M_out.Time;
M = out.M_out.Data;

figure('Name','Momento di controllo','NumberTitle','off');
plot(t_M, M(:,1), 'LineWidth', 1.2);
hold on
plot(t_M, M(:,2), 'LineWidth', 1.2);
plot(t_M, M(:,3), 'LineWidth', 1.2);
grid on
xlabel('Tempo [s]')
ylabel('Momento [Nm]')
title('Momento di controllo')
legend('$M_x$', '$M_y$', '$M_z$', 'Interpreter','latex', 'Location','best');

%% 4b. MOMENTO DI CONTROLLO DISTURBATO
t_Md = out.M_applied.Time;
Md = out.M_applied.Data;

figure('Name','Momento di controllo disturbato','NumberTitle','off');
plot(t_M, M(:,1), 'LineWidth', 1.2);
hold on
plot(t_M, M(:,2), 'LineWidth', 1.2);
plot(t_M, M(:,3), 'LineWidth', 1.2);
grid on
xlabel('Tempo [s]')
ylabel('Momento [Nm]')
title('Momento di controllo disturbato')
legend('$M_x$', '$M_y$', '$M_z$', 'Interpreter','latex', 'Location','best');

%%  5. POSIZIONE (riferimento z_r tratteggiato)
t_z = out.z_out.Time;
z = out.z_out.Data;

z_labels   = {'z_1','z_2','z_3'};
zref_labels= {'$z_{r1}$','$z_{r2}$','$z_{r3}$'};

for i = 1:3
    figure('Name',['Posizione ' z_labels{i}],'NumberTitle','off');
    plot(t_z, z(:,i), 'LineWidth', 1.2);
    hold on
    plot([t_z(1) t_z(end)], [z_r(i) z_r(i)], '--', 'LineWidth', 1.2);
    grid on
    xlabel('Tempo [s]')
    ylabel([z_labels{i} ' [m]'], 'Interpreter','latex')
    title(['Posizione ' z_labels{i}], 'Interpreter','latex');
    legend(z_labels{i}, zref_labels{i}, 'Interpreter','latex', 'Location','best');
end

%% 6. ERRORE DI POSIZIONE
t_err = out.err_pos.Time;
err_pos = out.err_pos.Data;

figure('Name','Errore di posizione','NumberTitle','off');
plot(t_err, err_pos(:,1), 'LineWidth', 1.2);
hold on
plot(t_err, err_pos(:,2), 'LineWidth', 1.2);
plot(t_err, err_pos(:,3), 'LineWidth', 1.2);
grid on
xlabel('Tempo [s]')
ylabel('Errore di posizione [m]')
title('Errore di posizione')
legend('$e_x$', '$e_y$', '$e_z$', 'Interpreter','latex', 'Location','best');

%% 7. VELOCITA' LINEARE (3 grafici separati)
t_zdot = out.z_dot_out.Time;
z_dot = out.z_dot_out.Data;

v_labels = {'v_x','v_y','v_z'};

for i = 1:3
    figure('Name',['Velocita'' ' v_labels{i}],'NumberTitle','off');
    plot(t_zdot, z_dot(:,i), 'LineWidth', 1.2);
    grid on
    xlabel('Tempo [s]')
    ylabel([v_labels{i} ' [m/s]'], 'Interpreter','latex')
    title(['Velocita'' ' v_labels{i}], 'Interpreter','latex');
end

%% 8. COMANDO DI SPINTA
t_u = out.u_out.Time;
u = out.u_out.Data;

figure('Name','Comando di spinta','NumberTitle','off');
plot(t_u, u(:,1), 'LineWidth', 1.2);
hold on
plot(t_u, u(:,2), 'LineWidth', 1.2);
plot(t_u, u(:,3), 'LineWidth', 1.2);
grid on
xlabel('Tempo [s]')
ylabel('Comando di spinta')
title('Comando di spinta')
legend('$u_x$', '$u_y$', '$u_z$', 'Interpreter','latex', 'Location','best');

%% 8. COMANDO DI SPINTA
t_ud = out.u_applied.Time;
ud = out.u_applied.Data;

figure('Name','Comando di spinta disturbato','NumberTitle','off');
plot(t_u, u(:,1), 'LineWidth', 1.2);
hold on
plot(t_u, u(:,2), 'LineWidth', 1.2);
plot(t_u, u(:,3), 'LineWidth', 1.2);
grid on
xlabel('Tempo [s]')
ylabel('Comando di spinta')
title('Comando di spinta disturbato')
legend('$u_x$', '$u_y$', '$u_z$', 'Interpreter','latex', 'Location','best');
