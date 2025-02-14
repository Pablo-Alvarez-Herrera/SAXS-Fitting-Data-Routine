function [S] = Hard_sphere(q,x,R)

a=((1+2.*x).^2)/((1-x).^4);
b=-6.*x.*(((1+x./2).^2)/((1-x).^4));
c=(x*a)./2;
A=2.*R.*q;
G=zeros(length(A),1);
S=zeros(length(A),1);

for i=1:length(A)
    
G(i)=(a.*((sin(A(i))-A(i).*cos(A(i)))/(A(i).^2)))+(b.*((2.*A(i).*sin(A(i))+(2-A(i).^2).*cos(A(i))-2)/(A(i).^3)))+(c.*(((-A(i).^4).*cos(A(i))+4.*(((3.*A(i).^2)-6).*cos(A(i))+((A(i).^3)-6.*A(i)).*sin(A(i))+6))/(A(i).^5)));

end

for i=1:length(G)
    S(i)=1./(1+24.*x*(G(i)/A(i)));
end
end

