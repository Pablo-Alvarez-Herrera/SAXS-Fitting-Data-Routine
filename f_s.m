function [I] = f_s(q,R)
I=zeros(length(q),1);
for i=1:length(q)
   I(i)=(3.*(((sin(q(i).*R)-q(i).*R.*cos(q(i).*R)))/(q(i).*R).^3)); 
end
end