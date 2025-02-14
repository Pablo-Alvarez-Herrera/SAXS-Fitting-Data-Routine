function [I] = homocoreshell3_SZcore(q,Io,R1,t_shell,n_c,n_s,n_sol,phi,R,sig)

SZ=Schulz_Zimm_dist(1,R1,sig,R);
I=zeros(length(q),1);

for i=1:length(q)
  
    Y_i=zeros(length(R),1);
    
    for j=1:length(R)
       Y_i(j)=homocoreshell3(q(i),Io,R(j),(R1+t_shell),n_c,n_s,n_sol,phi)*SZ(j);                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    ;
    end
    
    I(i)=trapz(R,Y_i) ;
end


end