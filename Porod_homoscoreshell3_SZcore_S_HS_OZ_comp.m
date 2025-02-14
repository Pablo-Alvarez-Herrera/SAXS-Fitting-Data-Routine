function [Im,Ip,Ics,Ioz,Bkg] = Porod_homoscoreshell3_SZcore_S_HS_OZ_comp(q,Kp,m,Io,Rc,t_shell,n_c,n_s,n_sol,phi,phi_HS,R_HS,I_oz,e,B,R,sig)

Im=zeros(length(q),1);
Ip=zeros(length(q),1);
Ioz=zeros(length(q),1);
Bkg=zeros(length(q),1);

Ics=homocoreshell3_SZcore(q,Io,Rc,t_shell,n_c,n_s,n_sol,phi,R,sig).*Hard_sphere(q,phi_HS,R_HS);

for i=1:length(q)
    Ip(i)=(Kp./(q(i).^m));
    Ioz(i)=(I_oz./(1+(q(i).*e).^2));
    Bkg(i)=B;
    Im(i)=(Kp./(q(i).^m))+(I_oz./(1+(q(i).*e).^2))+Bkg(i)+Ics(i); 
end
end

