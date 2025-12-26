clear all
tic
%% Reading the data
% The data must be located in a file called "data_file.xlsx".
% The q-values (momentum transfer), I-values (Intensity), dq-values
... (intensity uncertainties) must be placed in columns A, B and C,
... respectively
q=xlsread('Data_Example_main1.xlsx','Sheet1','A:A');
I=xlsread('Data_Example_main1.xlsx','Sheet1','B:B');
dI=xlsread('Data_Example_main1.xlsx','Sheet1','C:C');

[q_filter,I_filter,dI_filter]=positive_filter(q,I,dI);

%% Define the parameters of the scan
% For each parameter of eq.2, an initial value, final value and step value
... must be given.  
data_info='Write here data info';
Kp_i=3.5e-05;Kp_f=3.5e-05;Kp_d=3.5e-05; Kp_vector=Kp_i:Kp_d:Kp_f; % Parameter 1
m_i=4.60;m_f=4.70;m_d=0.05; m_vector=m_i:m_d:m_f;% Parameter 2
Io_i=120;Io_f=140;Io_d=10; Io_vector=Io_i:Io_d:Io_f; % Parameter 3
Rc_i=4.1; Rc_f=4.10;Rc_d=4.10;Rc_vector=Rc_i:Rc_d:Rc_f;% Parameter 4
t_shell_i=1.00;t_shell_f=2.00;t_shell_d=0.50; t_shell_vector=t_shell_i:t_shell_d:t_shell_f; % Parameter 5
phi_i=0.950; phi_f=0.950; phi_d=0.95; phi_vector=phi_i:phi_d:phi_f; % Parameter 6
phi_HS_i=0.25; phi_HS_f=0.35; phi_HS_d=0.050; phi_HS_vector=phi_HS_i:phi_HS_d:phi_HS_f; % Parameter 7
R_HS_i=7.5; R_HS_f=8.5; R_HS_d=0.50; R_HS_vector=R_HS_i:R_HS_d:R_HS_f; % Parameter 8
I_oz_i=0.4;I_oz_f=0.6;I_oz_d=0.1;I_oz_vector=I_oz_i:I_oz_d:I_oz_f; % Parameter 9
e_i=2.0;e_f=2.0;e_d=2.0;e_vector=e_i:e_d:e_f; % Parameter 10
B_i=0.09;B_f=0.09;B_d=0.09;B_vector=B_i:B_d:B_f; % Parameter 11
sig_i=1.5;sig_f=1.5;sig_d=1.5;sig_vector=sig_i:sig_d:sig_f; % Parameter 12


%% Define SLD of solvent (n_sol), micellar shell (n_s) and core (n_c) 
n_sol=6.40e-4; n_s=8.14e-5; n_c=1.06e-4;
R=0.01:0.01:20;
%% Calculating number of iterations
n_iterations=length(Kp_vector).*length(m_vector).*length(Io_vector).*length(Rc_vector).*length(t_shell_vector).*length(phi_vector).*length(phi_HS_vector).*length(R_HS_vector).*length(I_oz_vector).*length(e_vector).*length(B_vector).*length(sig_vector);
disp(n_iterations)
%% Defining optimal parameters and their initial values
Kp_opt=Kp_vector(1);
m_opt=m_vector(1);
Io_opt=Io_vector(1);
Rc_opt=Rc_vector(1);
t_shell_opt=t_shell_vector(1);
phi_opt=phi_vector(1);
phi_HS_opt=phi_HS_vector(1);
R_HS_opt=R_HS_vector(1);
I_oz_opt=I_oz_vector(1);
e_opt=e_vector(1);
B_opt=B_vector(1);
sig_opt=sig_vector(1);
X2_r_opt=CHI2_red(Porod_homoscoreshell3_SZcore_S_HS_OZ(q_filter,Kp_opt,m_opt,Io_opt,Rc_opt,t_shell_opt,n_c,n_s,n_sol,phi_opt,phi_HS_opt,R_HS_opt,I_oz_opt,e_opt,B_opt,R,sig_opt),I_filter,dI_filter,12);
%% Defining performance variable 
Iteracion=zeros(n_iterations,1);
Kp_Iteracion=zeros(n_iterations,1);
m_Iteracion=zeros(n_iterations,1);
Io_Iteracion=zeros(n_iterations,1);
Rc_Iteracion=zeros(n_iterations,1);
t_shell_Iteracion=zeros(n_iterations,1);
phi_Iteracion=zeros(n_iterations,1);
phi_HS_Iteracion=zeros(n_iterations,1);
R_HS_Iteracion=zeros(n_iterations,1);
I_oz_Iteracion=zeros(n_iterations,1);
e_Iteracion=zeros(n_iterations,1);
B_Iteracion=zeros(n_iterations,1);
sig_Iteracion=zeros(n_iterations,1); 
CHI2_red_Iteracion_vector=zeros(n_iterations,1);
index_Iteracion=0;
%% Create tracers
tracers=zeros(10,1);
tracers_index=1;
for j=1:10
    tracers(j)=(j./10).*n_iterations;
end
%% Start the iterations 

for i1 = 1:length(Kp_vector)
    for i2=1:length(m_vector)
          for i3=1:length(Io_vector)
              for i4=1:length(Rc_vector)
                  for i5=1:length(t_shell_vector)
                      for i6=1:length(phi_vector)
                          for i7=1:length(phi_HS_vector)
                              for i8=1:length(R_HS_vector)
                                  for i9=1:length(I_oz_vector)
                                      for i10=1:length(e_vector)
                                          for i11=1:length(B_vector)
                                              for i12=1:length(sig_vector)
                                                  index_Iteracion=index_Iteracion+1;
                                                  CHI2_red_Iteracion=CHI2_red(Porod_homoscoreshell3_SZcore_S_HS_OZ(q_filter,Kp_vector(i1),m_vector(i2),Io_vector(i3),Rc_vector(i4),t_shell_vector(i5),n_c,n_s,n_sol,phi_vector(i6),phi_HS_vector(i7),R_HS_vector(i8),I_oz_vector(i9),e_vector(i10),B_vector(i11),R,sig_vector(i12)),I_filter,dI_filter,12);
                                                  Iteracion(index_Iteracion)=index_Iteracion;
                                                  CHI2_red_Iteracion_vector(index_Iteracion)=CHI2_red_Iteracion;
                                                  Kp_Iteracion(index_Iteracion)=Kp_vector(i1);
                                                  m_Iteracion(index_Iteracion)=m_vector(i2);
                                                  Io_Iteracion(index_Iteracion)=Io_vector(i3);
                                                  Rc_Iteracion(index_Iteracion)=Rc_vector(i4);
                                                  t_shell_Iteracion(index_Iteracion)=t_shell_vector(i5);
                                                  phi_Iteracion(index_Iteracion)=phi_vector(i6);
                                                  phi_HS_Iteracion(index_Iteracion)=phi_HS_vector(i7);
                                                  R_HS_Iteracion(index_Iteracion)=R_HS_vector(i8);
                                                  I_oz_Iteracion(index_Iteracion)=I_oz_vector(i9);
                                                  e_Iteracion(index_Iteracion)=e_vector(i10);
                                                  B_Iteracion(index_Iteracion)=B_vector(i11);
                                                  sig_Iteracion(index_Iteracion)=sig_vector(i12);
        
                                                  if CHI2_red_Iteracion < X2_r_opt
                                                      X2_r_opt=CHI2_red_Iteracion;
                                                      Kp_opt=Kp_vector(i1);
                                                      m_opt=m_vector(i2);
                                                      Io_opt=Io_vector(i3);
                                                      Rc_opt=Rc_vector(i4);
                                                      t_shell_opt=t_shell_vector(i5);
                                                      phi_opt=phi_vector(i6);
                                                      phi_HS_opt=phi_HS_vector(i7);
                                                      R_HS_opt=R_HS_vector(i8);
                                                      I_oz_opt=I_oz_vector(i9);
                                                      e_opt=e_vector(i10);
                                                      B_opt=B_vector(i11);
                                                      sig_opt=sig_vector(i12);
                                                     

                                                      
                                                  end
                                                  if index_Iteracion == round(tracers(tracers_index))
                                                      disp(fprintf('Process completed %d percent\n',10.*tracers_index))
                                                      tracers_index=tracers_index+1;

                                                  end

                                              end
                                          end

                                      end                                     
                                  end
                              end
                          end

                      end
                  end

              end                                
          end
    end
end



        
[Im,Ip,Ics,Ioz,Bkg]=Porod_homoscoreshell3_SZcore_S_HS_OZ_comp(q_filter,Kp_opt,m_opt,Io_opt,Rc_opt,t_shell_opt,n_c,n_s,n_sol,phi_opt,phi_HS_opt,R_HS_opt,I_oz_opt,e_opt,B_opt,R,sig_opt);
%% Ploting data and model in figure 1
figure(1)
loglog(q_filter,I_filter,'ro','LineWidth',0.5)
txt = ['Reduced X_2 :' X2_r_opt];
title(['X_2:',num2str(X2_r_opt)]);
% Define y-axis limits for the plots
ylim([1e-1 1e3])
hold on
loglog(q_filter,Im,'b','LineWidth',2)
hold on
loglog(q_filter,Ip,'c--',q_filter,Ics,'k--',q_filter,Ioz,'g--',q_filter,Bkg,'m--','LineWidth',2)
legend('Data','Model','Porod-Guinier','Core-Shell sphere','OZ','Background')
hold off

%% Scan information
disp('-------------- Scan information ------------------')
disp(data_info)
infoa=sprintf('Total number of iterations=%g',n_iterations);disp(infoa)
infob=sprintf('The value of Xi_r is=%g',X2_r_opt);disp(infob)
disp('------------ Information about the parameters ------------')
disp('Initial_Value | Step | Final_Value | N° values | Optimun_value')
info1=sprintf('Kp: | %g | %g | %g | %g | %g ',Kp_i,Kp_d,Kp_f,length(Kp_vector),Kp_opt);disp(info1)
info2=sprintf('m: | %g | %g | %g | %g | %g ',m_i,m_d,m_f,length(m_vector),m_opt);disp(info2)
info3=sprintf('Io: | %g | %g | %g | %g | %g ',Io_i,Io_d,Io_f,length(Io_vector),Io_opt);disp(info3)
info4=sprintf('Rc: | %g | %g | %g | %g | %g ',Rc_i,Rc_d,Rc_f,length(Rc_vector),Rc_opt);disp(info4)
info5=sprintf('t_shell: | %g | %g | %g | %g | %g ',t_shell_i,t_shell_d,t_shell_f,length(t_shell_vector),t_shell_opt);disp(info5)
info6=sprintf('phi: | %g | %g | %g | %g | %g ',phi_i,phi_d,phi_f,length(phi_vector),phi_opt);disp(info6)
info7=sprintf('phi_HS: | %g | %g | %g | %g | %g ',phi_HS_i,phi_HS_d,phi_HS_f,length(phi_HS_vector),phi_HS_opt);disp(info7)
info8=sprintf('R_HS: | %g | %g | %g | %g | %g ',R_HS_i,R_HS_d,R_HS_f,length(R_HS_vector),R_HS_opt);disp(info8)
info9=sprintf('I_oz: | %g | %g | %g | %g | %g ',I_oz_i,I_oz_d,I_oz_f,length(I_oz_vector),I_oz_opt);disp(info9)
info10=sprintf(':e | %g | %g | %g | %g | %g ',e_i,e_d,e_f,length(e_vector),e_opt);disp(info10)
info11=sprintf('B: | %g | %g | %g | %g | %g ',B_i,B_d,B_f,length(B_vector),B_opt);disp(info11)
info12=sprintf('sig: | %g | %g | %g | %g | %g ',sig_i,sig_d,sig_f,length(sig_vector),sig_opt);disp(info12)
disp('-------------- ----------------------- ------------------')
toc