function zddot = hcw_accel_sl(z, zdot, u, omega_orb)
    zddot = zeros(3,1);
    zddot(1) = 3*omega_orb^2*z(1) + 2*omega_orb*zdot(2) + u(1);
    zddot(2) = -2*omega_orb*zdot(1) + u(2);
    zddot(3) = -omega_orb^2*z(3) + u(3);
end