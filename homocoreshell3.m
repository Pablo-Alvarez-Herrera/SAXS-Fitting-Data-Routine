function [I] = homocoreshell3(q,Io,R1,t_shell,n_1,n_d,n_sol,phi)
n_2=n_d+(phi.*(n_sol-n_d));
I=Io.*(((n_2-n_sol).*(4./3).*pi.*((R1+t_shell).^3).*f_s(q,(R1+t_shell)))-((n_2-n_1).*(4./3).*pi.*(R1.^3).*f_s(q,R1))).^2;
end

