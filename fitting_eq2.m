tic
clear all
%% Reading the data
% The data must be located in a file called "data_file.xlsx".
% The q-values (momentum transfer), I-values (Intensity), dq-values
... (intensity uncertainties) must be placed in columns A, B and C,
... respectively
q=xlsread('data_file.xlsx','Tabelle1','A:A');
I=xlsread('data_file.xlsx','Tabelle1','B:B');
dI=xlsread('data_file.xlsx','Tabelle1','C:C');

[q_filter,I_filter,dI_filter]=positive_filter(q,I,dI);

%% Define the parameters of the scan
% For each parameter of eq.2, an initial value, final value and step value
... must be given.  
data_info='Write here data info';
G_i=1.00e6;G_f=1.20e6; G_d=0.01e6; G_vector=G_i:G_d:G_f; % Parameter 1
Rg_i=80;Rg_f=160;Rg_d=20.0; Rg_vector=Rg_i:Rg_d:Rg_f;% Parameter 2
m_i=2.5;m_f=3.1; m_d=0.1; m_vector=m_i:m_d:m_f; % Parameter 3
Io_i=1.0e-10; Io_f=1.0e-10; Io_d=1.0e-10; Io_vector=Io_i:Io_d:Io_f;% Parameter 4
e_i=7.0; e_f=7.0; e_d=7.0; e_vector=e_i:e_d:e_f;% Parameter 5
B_i=0.10;B_f=0.50;B_d=0.01;B_vector=B_i:B_d:B_f; % Parameter 6
%% Calculating number of iterations
n_iterations=length(G_vector).*length(Rg_vector).*length(m_vector).*length(Io_vector).*length(e_vector).*length(B_vector);
disp(n_iterations)
%% Defining optimal parameters and their initial values
G_opt=G_vector(1); Rg_opt=Rg_vector(1); m_opt=m_vector(1); Io_opt=Io_vector(1);e_opt=e_vector(1);B_opt=B_vector(1);
X2_r_opt=CHI2_red(GuinierPorod_OZ(q_filter,G_opt,Rg_opt,m_opt,Io_opt,e_opt,B_opt),I_filter,dI_filter,6);
%% Defining performance variable 
Iteracion=zeros(n_iterations,1); G_Iteracion=zeros(n_iterations,1);m_Iteracion=zeros(n_iterations,1);Io_Iteracion=zeros(n_iterations,1);Rg_Iteracion=zeros(n_iterations,1);
e_Iteracion=zeros(n_iterations,1);B_Iteracion=zeros(n_iterations,1); CHI2_red_Iteracion_vector=zeros(n_iterations,1);
index_Iteracion=0;
%% Start the iterations 

for i1 = 1:length(G_vector)
    for i2=1:length(Rg_vector)
          for i3=1:length(m_vector)
              for i4=1:length(Io_vector)
                  for i5=1:length(e_vector)
                      for i6=1:length(B_vector)
                          index_Iteracion=index_Iteracion+1;
                          CHI2_red_Iteracion=CHI2_red(GuinierPorod_OZ(q_filter,G_vector(i1),Rg_vector(i2),m_vector(i3),Io_vector(i4),e_vector(i5),B_vector(i6)),I_filter,dI_filter,6);
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


[Im,Ioz,Igp,Bkg]=GuinierPorod_OZ_comp(q_filter,G_opt,Rg_opt,m_opt,Io_opt,e_opt,B_opt);
%% Ploting data and model in figure 1
figure(1)
loglog(q_filter,I_filter,'ro','LineWidth',0.5)
% Define y-axis limits for the plots
ylim([1e-1 1e5])
hold on
loglog(q_filter,Im,'b','LineWidth',2)
hold on
loglog(q_filter,Igp,'c--',q_filter,Ioz,'g--',q_filter,Bkg,'m--','LineWidth',2)
legend('Data','Model','Porod-Guinier','OZ','Background')
hold off

%% Display information of fitting in console. The optimun value
... for every parameter is shown.
disp('-------------- Scan information ------------------')
disp(data_info)
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



