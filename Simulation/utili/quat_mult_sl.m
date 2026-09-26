function q_out = quat_mult_sl(a,b)
    % Moltiplicazione di quaternioni: q = [q0;q1;q2;q3]
    a0 = a(1); av = a(2:4);
    b0 = b(1); bv = b(2:4);
    q_out = zeros(4,1);
    q_out(1) = a0*b0 - av'*bv;
    q_out(2:4) = a0*bv + b0*av + cross(av,bv);
end