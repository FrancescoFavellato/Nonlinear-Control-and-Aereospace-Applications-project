function u = smc_translational_sl(z, zdot, z_r, omega_orb, K, eta, phi, u_sat)
    % Errore
    z_tilde = z - z_r;
    zdot_tilde = zdot;
    % Termine dinamico HCW
    A = zeros(3,1);
    A(1) = 3*omega_orb^2*z(1) + 2*omega_orb*zdot(2);
    A(2) = -2*omega_orb*zdot(1);
    A(3) = -omega_orb^2*z(3);
    % Superficie di sliding
    s = zdot_tilde + K*z_tilde;
    % Legge di controllo
    u = -A -K*zdot_tilde -eta.*tanh(s./phi);
    %% Saturazione
    for i = 1:3
        if u(i) > u_sat(i)
            u(i) = u_sat(i);
        elseif u(i) < -u_sat(i)
            u(i) = -u_sat(i);
        end
    end
end