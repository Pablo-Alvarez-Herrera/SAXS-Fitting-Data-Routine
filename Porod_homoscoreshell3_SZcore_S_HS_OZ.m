function [Im] = Porod_homoscoreshell3_SZcore_S_HS_OZ(q,Kp,m,Io,Rc,t_shell,n_c,n_s,n_sol,phi,phi_HS,R_HS,I_oz,e,B,R,sig)

%% The contribution of the core-shell spheres here
Ics=homocoreshell3_SZcore(q,Io,Rc,t_shell,n_c,n_s,n_sol,phi,R,sig).*Hard_sphere(q,phi_HS,R_HS);
%% The rest
Im=zeros(length(q),1);

for i=1:length(q)
    Im(i)=(I_oz./(1+(q(i).*e).^2))+(Kp./(q(i).^m))+B+Ics(i); 
end

end