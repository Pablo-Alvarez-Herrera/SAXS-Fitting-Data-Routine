function [q_new,I_new,dI_new] = positive_filter(q,I,dI)
n_neg=0;

for i=1:length(q)
    if I(i) <= 0
        n_neg=n_neg+1;
        
    end
end

l_new=length(I)-n_neg; index=1;

q_new=zeros(l_new,1);I_new=zeros(l_new,1);dI_new=zeros(l_new,1);

for i=1:length(I)
    if I(i) > 0
        I_new(index)=I(i);
        q_new(index)=q(i);
        dI_new(index)=dI(i);
        index=index+1;
    end
end

end