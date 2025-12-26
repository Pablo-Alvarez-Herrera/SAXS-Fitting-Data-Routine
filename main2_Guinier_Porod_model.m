tic
clear all
% Fitting 1 
%% Read the data
q_raw=xlsread('Data_Example_main2.xlsx','Sheet1','A:A');
I_raw=xlsread('Data_Example_main2.xlsx','Sheet1','B:B');
dI_raw=xlsread('Data_Example_main2.xlsx','Sheet1','C:C');

[q,I,dI]=positive_filter(q_raw,I_raw,dI_raw);

%% Define the parameters of the scan

G_i=9e5;G_f=11e5; G_d=20000; G_vector=G_i:G_d:G_f; % Parameter 1
Rg_i=140;Rg_f=160;Rg_d=2; Rg_vector=Rg_i:Rg_d:Rg_f;% Parameter 2
m_i=4.1;m_f=4.5; m_d=0.1; m_vector=m_i:m_d:m_f; % Parameter 3
Io_i=0.25; Io_f=0.65; Io_d=0.02; Io_vector=Io_i:Io_d:Io_f;% Parameter 4
e_i=1.8; e_f=3.0; e_d=0.1; e_vector=e_i:e_d:e_f;% Parameter 5
B_i=0.13;B_f=0.15;B_d=0.005;B_vector=B_i:B_d:B_f; % Parameter 6
%% Calculating number of iterations
n_iterations=length(G_vector).*length(Rg_vector).*length(m_vector).*length(Io_vector).*length(e_vector).*length(B_vector);

%% Defining optimal parameters and their initial values
G_opt=G_vector(1); 
Rg_opt=Rg_vector(1); 
m_opt=m_vector(1); 
Io_opt=Io_vector(1);
e_opt=e_vector(1);
B_opt=B_vector(1);

X2_r_opt=CHI2_red(GuinierPorod_OZ(q,G_opt,Rg_opt,m_opt,Io_opt,e_opt,B_opt),I,dI,6);
%% Defining performance variable 
Iteracion=zeros(n_iterations,1);
G_Iteracion=zeros(n_iterations,1);
m_Iteracion=zeros(n_iterations,1);
Io_Iteracion=zeros(n_iterations,1);
Rg_Iteracion=zeros(n_iterations,1);
e_Iteracion=zeros(n_iterations,1);
B_Iteracion=zeros(n_iterations,1); 
CHI2_red_Iteracion_vector=zeros(n_iterations,1);
index_Iteracion=0;
%% Start the iterations 

for i1 = 1:length(G_vector)
    for i2=1:length(Rg_vector)
          for i3=1:length(m_vector)
              for i4=1:length(Io_vector)
                  for i5=1:length(e_vector)
                      for i6=1:length(B_vector)
                          index_Iteracion=index_Iteracion+1;
                          CHI2_red_Iteracion=CHI2_red(GuinierPorod_OZ(q,G_vector(i1),Rg_vector(i2),m_vector(i3),Io_vector(i4),e_vector(i5),B_vector(i6)),I,dI,6);
                          Iteracion(index_Iteracion)=index_Iteracion;
                          CHI2_red_Iteracion_vector(index_Iteracion)=CHI2_red_Iteracion;
                          G_Iteracion(index_Iteracion)=G_vector(i1);
                          Rg_Iteracion(index_Iteracion)=Rg_vector(i2);
                          m_Iteracion(index_Iteracion)=m_vector(i3);
                          Io_Iteracion(index_Iteracion)=Io_vector(i4);
                          e_Iteracion(index_Iteracion)=e_vector(i5);
                          B_Iteracion(index_Iteracion)=B_vector(i6);
                          if CHI2_red_Iteracion < X2_r_opt
                              X2_r_opt=CHI2_red_Iteracion;
                              G_opt=G_vector(i1);
                              Rg_opt=Rg_vector(i2);
                              m_opt=m_vector(i3);
                              Io_opt=Io_vector(i4);
                              e_opt=e_vector(i5);
                              B_opt=B_vector(i6);
                          end
                      end
                  end

              end                                
          end
    end
end


[Im,Ioz,Igp,Bkg]=GuinierPorod_OZ_comp(q,G_opt,Rg_opt,m_opt,Io_opt,e_opt,B_opt);

figure(1)
loglog(q,I,'ro','LineWidth',0.5)
ylim([1e-1 1e5])
hold on
loglog(q,Im,'b','LineWidth',2)
hold on
loglog(q,Igp,'c--',q,Ioz,'g--',q,Bkg,'m--','LineWidth',2)
legend('Data','Model','Porod-Guinier','OZ','Background')
hold off


index_opt=index_Ro(CHI2_red_Iteracion_vector,min(CHI2_red_Iteracion_vector));

figure(2)
subplot(4,2,1:2)
x_vectical12=[index_opt, index_opt];
y_vectical12=[min(CHI2_red_Iteracion_vector),max(CHI2_red_Iteracion_vector)];
x_horizontal12=[1, n_iterations];
y_horizontal12=[CHI2_red_Iteracion_vector(index_opt),CHI2_red_Iteracion_vector(index_opt)];
plot(Iteracion,CHI2_red_Iteracion_vector,'LineWidth',0.5)
hold on
plot(x_vectical12,y_vectical12,'r--','LineWidth',2.0)
hold on
plot(x_horizontal12,y_horizontal12,'r--','LineWidth',2.0)
hold off
title('CHI reduced X_2')
xlabel('Iteration') 
ylabel('X_2')
ylim([(min(CHI2_red_Iteracion_vector)-0.25.*max(CHI2_red_Iteracion_vector)) (max(CHI2_red_Iteracion_vector)+0.25.*max(CHI2_red_Iteracion_vector))])

subplot(4,2,3)
x_vectical3=[index_opt, index_opt];
y_vectical3=[min(G_Iteracion),max(G_Iteracion)];
x_horizontal3=[1, n_iterations]; 
y_horizontal3=[G_Iteracion(index_opt),G_Iteracion(index_opt)];
plot(Iteracion,G_Iteracion,'LineWidth',0.5)
hold on
plot(x_vectical3,y_vectical3,'r--','LineWidth',2.0)
hold on
plot(x_horizontal3,y_horizontal3,'r--','LineWidth',2.0)
hold off
title('Guinier Constant G')
xlabel('Iteration') 
ylabel('G')

subplot(4,2,4)
x_vectical4=[index_opt, index_opt];
y_vectical4=[min(Rg_Iteracion),max(Rg_Iteracion)];
x_horizontal4=[1, n_iterations]; 
y_horizontal4=[Rg_Iteracion(index_opt),Rg_Iteracion(index_opt)];
plot(Iteracion,Rg_Iteracion,'LineWidth',0.5)
hold on
plot(x_vectical4,y_vectical4,'r--','LineWidth',2.0)
hold on
plot(x_horizontal4,y_horizontal4,'r--','LineWidth',2.0)
hold off
title('Radius of giration R_g')
xlabel('Iteration') 
ylabel('R_g')

subplot(4,2,5)
x_vectical5=[index_opt, index_opt];
y_vectical5=[min(m_Iteracion),max(m_Iteracion)];
x_horizontal5=[1, n_iterations]; y_horizontal5=[m_Iteracion(index_opt),m_Iteracion(index_opt)];
plot(Iteracion,m_Iteracion,'LineWidth',0.5)
hold on
plot(x_vectical5,y_vectical5,'r--','LineWidth',2.0)
hold on
plot(x_horizontal5,y_horizontal5,'r--','LineWidth',2.0)
hold off
title('Porod constant m')
xlabel('Iteration') 
ylabel('m')

subplot(4,2,6)
x_vectical6=[index_opt, index_opt];
y_vectical6=[min(Io_Iteracion),max(Io_Iteracion)];
x_horizontal6=[1, n_iterations]; y_horizontal6=[Io_Iteracion(index_opt),Io_Iteracion(index_opt)];
plot(Iteracion,Io_Iteracion,'LineWidth',0.5)
hold on
plot(x_vectical6,y_vectical6,'r--','LineWidth',2.0)
hold on
plot(x_horizontal6,y_horizontal6,'r--','LineWidth',2.0)
hold off
title('Orstein-Zernike pre-exp-factor Io')
xlabel('Iteration') 
ylabel('Io')

subplot(4,2,7)
x_vectical7=[index_opt, index_opt];
y_vectical7=[min(e_Iteracion),max(e_Iteracion)];
x_horizontal7=[1, n_iterations]; 
y_horizontal7=[e_Iteracion(index_opt),e_Iteracion(index_opt)];
plot(Iteracion,e_Iteracion,'LineWidth',0.5)
hold on
plot(x_vectical7,y_vectical7,'r--','LineWidth',2.0)
hold on
plot(x_horizontal7,y_horizontal7,'r--','LineWidth',2.0)
hold off
title('Correlation length e')
xlabel('Iteration') 
ylabel('e')

subplot(4,2,8)
x_vectical8=[index_opt, index_opt];
y_vectical8=[min(B_Iteracion),max(B_Iteracion)];
x_horizontal8=[1, n_iterations]; 
y_horizontal8=[B_Iteracion(index_opt),B_Iteracion(index_opt)];
plot(Iteracion,B_Iteracion,'LineWidth',0.5)
hold on
plot(x_vectical8,y_vectical8,'r--','LineWidth',2.0)
hold on
plot(x_horizontal8,y_horizontal8,'r--','LineWidth',2.0)
hold off
title('Background B')
xlabel('Iteration') 
ylabel('B')

disp('-------------- Scan information ------------------')

infoa=sprintf('Total number of iterations=%g',n_iterations);disp(infoa)
infob=sprintf('The value of Xi_r is=%g',X2_r_opt);disp(infob)
disp('------------ Information about the parameters ------------')
disp('Initial_Value | Step | Final_Value | N° values | Optimun_value')
info1=sprintf('G: | %g | %g | %g | %g | %g ',G_i,G_d,G_f,length(G_vector),G_opt);disp(info1)
info2=sprintf('Rg: | %g | %g | %g | %g | %g ',Rg_i,Rg_d,Rg_f,length(Rg_vector),Rg_opt);disp(info2)
info3=sprintf('m: | %g | %g | %g | %g | %g ',m_i,m_d,m_f,length(m_vector),m_opt);disp(info3)
info4=sprintf('Io: | %g | %g | %g | %g | %g ',Io_i,Io_d,Io_f,length(Io_vector),Io_opt);disp(info4)
info5=sprintf('e: | %g | %g | %g | %g | %g ',e_i,e_d,e_f,length(e_vector),e_opt);disp(info5)
info6=sprintf('B: | %g | %g | %g | %g | %g ',B_i,B_d,B_f,length(B_vector),B_opt);disp(info6)
disp('-------------- ----------------------- ------------------')
toc



