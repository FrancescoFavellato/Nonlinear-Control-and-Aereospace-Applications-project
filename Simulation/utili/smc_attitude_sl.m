function M = smc_attitude_sl(q, omega, q_r, omega_r, J, K, eta, phi, M_sat)
    % Normalizzazione
    q = q / norm(q);
    q_r = q_r / norm(q_r);
    % Errore di quaternione
    q_r_inv = [q_r(1); - q_r(2:4)];
    q_r_inv = q_r_inv / (q_r'*q_r);
    q_e = quat_mult_sl(q_r_inv,q);
    qe0 = q_e(1); qev = q_e(2:4);
    % Errore velocità angolare
    omega_e = omega - omega_r;
    %% Superficie sliding
    if qe0 >= 0
        sign_q = 1;
    else
        sign_q = -1;
    end
    s = omega_e + K*(sign_q * qev);
    % Derivata della parte vettoriale
    S = [0       -qev(3)    qev(2);
         qev(3)    0       -qev(1);
        -qev(2)   qev(1)    0];
    qev_dot = 0.5*(qe0 * eye(3) + S) * omega_e;
    % Feedforward giroscopico
    M_ff = cross(omega,J*omega);
    % Termine feedback
    M_fb = -J*(K*(sign_q*qev_dot));
    % Termine robusto
    M_rob = -J*(eta.*tanh(s./phi));
    % Coppia totale 
    M = M_ff + M_fb + M_rob;
    %% Saturazione
    for i = 1:3
        if M(i) > M_sat(i)
            M(i) = M_sat(i);
        elseif M(i) < -M_sat(i)
            M(i) = -M_sat(i);
        end
    end
end