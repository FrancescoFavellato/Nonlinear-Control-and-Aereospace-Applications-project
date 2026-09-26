function q_r = pointing_ref_gen_sl(los_i, up_i, boresight_b, body_secondary)
    % Genera il quaternione di riferimento che allinea il boresight body con la LOS.
    % DCM: body -> LVLH
    % Normalizzazione LOS
    r1 = los_i / norm(los_i);
    % Secondo asse LVLH
    temp = cross(r1,up_i);
    if norm(temp) < 1e-8
        temp = [0;1;0];
    end
    r2 = temp / norm(temp);
    % Terzo asse
    r3 = cross(r1,r2);
    % Normalizzazione boresight
    s1 = boresight_b / norm(boresight_b);
    % Secondo asse body
    temp = cross(s1,body_secondary);
    if norm(temp) < 1e-8
        temp = [0;1;0];
    end
    s2 = temp / norm(temp);
    % Terzo asse body
    s3 = cross(s1,s2);
    % Matrici di riferimento
    R_lvlh = [r1 r2 r3];
    R_body = [s1 s2 s3];
    % DCM body -> LVLH
    DCM = R_lvlh * R_body';
    % Conversione DCM -> quaternione
    tr = trace(DCM);
    q_r = zeros(4,1);
    if tr > 0
        q0 = 0.5*sqrt(1 + tr);
        q1 = (DCM(3,2)-DCM(2,3))/(4*q0);
        q2 = (DCM(1,3)-DCM(3,1))/(4*q0);
        q3 = (DCM(2,1)-DCM(1,2))/(4*q0);
    elseif DCM(1,1) >= DCM(2,2) && DCM(1,1) >= DCM(3,3)
        q1 = 0.5*sqrt(max(1 + DCM(1,1) - DCM(2,2) - DCM(3,3),0));
        if q1 > 1e-12
            q0 = (DCM(3,2)-DCM(2,3))/(4*q1);
            q2 = (DCM(1,2)+DCM(2,1))/(4*q1);
            q3 = (DCM(1,3)+DCM(3,1))/(4*q1);
        else
            q0 = 0;
            q2 = 0;
            q3 = 0;
        end
    elseif DCM(2,2) >= DCM(3,3)
        q2 = 0.5*sqrt(max(1 - DCM(1,1) + DCM(2,2) - DCM(3,3),0));
        if q2 > 1e-12
            q0 = (DCM(1,3)-DCM(3,1))/(4*q2);
            q1 = (DCM(1,2)+DCM(2,1))/(4*q2);
            q3 = (DCM(2,3)+DCM(3,2))/(4*q2);
        else
            q0 = 0;
            q1 = 0;
            q3 = 0;
        end
    else
        q3 = 0.5*sqrt( max(1 - DCM(1,1) - DCM(2,2) + DCM(3,3),0));
        if q3 > 1e-12
            q0 = (DCM(2,1)-DCM(1,2))/(4*q3);
            q1 = (DCM(1,3)+DCM(3,1))/(4*q3);
            q2 = (DCM(2,3)+DCM(3,2))/(4*q3);
        else
            q0 = 0;
            q1 = 0;
            q2 = 0;
        end
    end
    q_r = [q0;q1;q2;q3];
    q_r = q_r / norm(q_r);
end