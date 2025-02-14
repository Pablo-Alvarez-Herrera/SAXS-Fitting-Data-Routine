function [X2_r] = CHI2_red(Im,Id,dId,Np)
CHI_2_vector=zeros(length(Id),1);

for i=1:length(CHI_2_vector)
    CHI_2_vector(i)=((Id(i)-Im(i)).^2)./((dId(i)).^2);
end

X2_r=(sum(CHI_2_vector))./(length(Id)-Np);
end