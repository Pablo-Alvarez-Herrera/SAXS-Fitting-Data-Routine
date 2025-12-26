function [index] = index_Ro(R,Ro)
index=0;
for i=1:length(R)
   if R(i)==Ro
      index=i; 
   end
end
end

