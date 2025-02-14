function [Im Ioz Igp Bkg] = GuinierPorod_OZ_comp(q,G,Rg,m,Io,e,B)
%UNTITLED Summary of this function goes here
Q1=(1./Rg).*(((3.*m)./2).^(1/2));
Kp=G.*exp(-m./2).*(((3.*m)./2).^(m./2)).*(1./(Rg.^m));

Im=zeros(length(q),1);
Ioz=zeros(length(q),1);
Igp=zeros(length(q),1);
Bkg=zeros(length(q),1);

for i=1:length(q)
   if q(i)< Q1 
      Im(i)=(Io./(1+(q(i).*e).^2))+(G.*exp(((-(q(i).*Rg).^2))./3))+B;
      Ioz(i)=(Io./(1+(q(i).*e).^2));
      Igp(i)=(G.*exp(((-(q(i).*Rg).^2))./3));
      Bkg(i)=B;
   else
      Im(i)=(Io./(1+(q(i).*e).^2))+(Kp./(q(i).^m))+B;
      Ioz(i)=(Io./(1+(q(i).*e).^2));
      Igp(i)=(Kp./(q(i).^m));
      Bkg(i)=B;
   end

end

end