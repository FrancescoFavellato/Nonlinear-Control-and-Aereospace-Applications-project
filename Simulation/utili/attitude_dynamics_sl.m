function xdot = attitude_dynamics_sl(q, omega, M, J)
    q = q / norm(q);
    omega_dot = J \ (-cross(omega, J*omega) + M);
    q_dot = 0.5 * quat_mult_sl(q, [0; omega]);
    xdot = [q_dot; omega_dot];
end