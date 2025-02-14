function [SZ_dist] = Schulz_Zimm_dist(N,Ro,sig,R)

k=(Ro.^2)/(sig.^2);

SZ_dist=zeros(length(R),1);

for i=1:length(R)
   SZ_dist(i)=(N./Ro).*((R(i)./Ro).^(k-1)).*(((k.^k)*exp((-k*R(i))./Ro))./(gamma(k)));
end

end

