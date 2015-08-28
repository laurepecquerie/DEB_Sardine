%% results_my_pet
% presents results of univariate data graphically

%%
function custom_results_Sardina_pilchardus(par, metaPar, data, txtData, auxData)
%par, metaPar, txtPar, data, auxData, metaData, txtData, weights
  % created by Starrlight Augustine, Dina Lika, Bas Kooijman, Goncalo Marques and Laure Pecquerie 2015/04/12
  % modified 2015/08/25
  
  %% Syntax
  % <../custom_results_template.m *custom_results_template*>(par, metaPar, txtData, data, auxData)
  
  %% Description
  % present customized results of univariate data
  %
  % * inputs 
  %
  % * par: structure with parameters (see below)
  % * metaPar: structure with field T_ref for reference temperature
  % * txt_data: text vector for the presentation of results
  % * data: structure with data
  % * auxData: structure with temperature data and potential food data
  
  %% Remarks
  % Called from estim_pars and printmat
  


  % get predictions
  data2plot = data;              % copy data to Prd_data
  tL1 = linspace(185, 250, 100)';   % set independent variable
  tL2 = linspace(125, 275, 100)';   % set independent variable
  tL3 = linspace(145, 245, 100)';   % set independent variable
  tL4 = linspace(70, 125, 100)';   % set independent variable
  tL5 = linspace(43, 120, 100)';   % set independent variable
  tL6 = linspace(62, 105, 100)';   % set independent variable
  tLlarv = linspace(4, 37, 100)';   % set independent variable
  tLad = linspace(365, 365*6, 100)';   % set independent variable
  L4 = linspace(3, 8, 100)';
  L = linspace(12, 24, 100)'; % set independent variable
  t = linspace(55, 364+55, 100)';
  
  data2plot.tL_juv1 = tL1; % overwrite independent variable in tL
  data2plot.tL_juv2 = tL2; % overwrite independent variable in tL
  data2plot.tL_juv3 = tL3; % overwrite independent variable in tL
  data2plot.tL_juv4 = tL4; % overwrite independent variable in tL
  data2plot.tL_juv5 = tL5; % overwrite independent variable in tL
  data2plot.tL_juv6 = tL6; % overwrite independent variable in tL
  data2plot.tL_larv = tLlarv; % overwrite independent variable in tL
  data2plot.tL_ad_f = tLad; % overwrite independent variable in tL
  data2plot.LW_juv4 = L4; % overwrite independent variable in tL
  data2plot.LW_juv5 = L4; % overwrite independent variable in tL
  data2plot.LW_juv6 = L4; % overwrite independent variable in tL
  data2plot.LW_ad = L; % overwrite independent variable in LW
  data2plot.tE = t; % overwrite independent variable in tE
  data2plot.tdw = t; % overwrite independent variable in tE

  % overwrite Prd_data to obtain dependent variables
  [prdData, info] = predict_Sardina_pilchardus(par, data2plot, auxData);
   statnm = ['statistics_', metaPar.model];
  [stat, txt_stat]  = feval(statnm, par, C2K(15), par.f, metaPar.model);
 
  if isfield(stat,'s_M')
    fprintf(['\nacceleration factor s_M is ', num2str(stat.s_M), ' \n'])
  end
  fprintf(['age at metamorphosis at ', num2str(stat.T - 273.15),' degC is ', num2str(stat.a_j), 'd \n'])
  fprintf(['d_E = ', num2str(par.d_E),'  \n'])
  fprintf(['mu_E = ', num2str(par.mu_E),' J/mol \n'])
  fprintf(['kap_G < ', num2str(par.mu_V/par.mu_E),' and kap_X < ', num2str(par.mu_X/par.mu_E),' \n'])

  % unpack data & predictions
  v2struct(data)
  EL1     = prdData.tL_juv1; % predictions (dependent variable) first set
  EL2     = prdData.tL_juv2; % predictions (dependent variable) first set
  EL3     = prdData.tL_juv3; % predictions (dependent variable) first set
  EL4     = prdData.tL_juv4; % predictions (dependent variable) first set
  EL5     = prdData.tL_juv5; % predictions (dependent variable) first set
  EL6     = prdData.tL_juv6; % predictions (dependent variable) first set
  ELlarv  = prdData.tL_larv; % predictions (dependent variable) first set
  ELad  = prdData.tL_ad_f; % predictions (dependent variable) first set  
  EW4     = prdData.LW_juv4;
  EW5     = prdData.LW_juv5;
  EW6     = prdData.LW_juv6;
  EW     = prdData.LW_ad; % predictions (dependent variable) second set
  EE     = prdData.tE;
  Edw    = prdData.tdw;
  close all % remove existing figures, else you get more and more if you retry

  figure %    figure to show results of uni-variate data
  subplot(2,3,1)
  plot(tL_juv1(:,1), tL_juv1(:,2), '.k', tL1, EL1, 'k', ...
     tL_juv2(:,1), tL_juv2(:,2), '.b', tL2, EL2, 'b', ...
     tL_juv3(:,1), tL_juv3(:,2), '.m', tL3, EL3, 'm')
  xlabel('age, d')
  ylabel('length, cm')
  axis([0 280 0 15])
  title('Mene2003, Peniche')

  subplot(2,3,2)
  plot(tL_juv4(:,1), tL_juv4(:,2), '.k', tL4, EL4, 'k', ...
     tL_juv5(:,1), tL_juv5(:,2), '.b', tL5, EL5, 'b', ...
     tL_juv6(:,1), tL_juv6(:,2), '.m', tL6, EL6, 'm')
  xlabel('age, d')
  ylabel('length, cm')
  axis([0 140 0 15])
  title('Mene2003, Lagoa de Obidos')

  subplot(2,3,3)
  plot(tL_larv(:,1), tL_larv(:,2), '.g', tLlarv, ELlarv, 'g') 
  xlabel('age, d')
  ylabel('length, cm')
  axis([0 40 0 5])
  title('Mene2003')

  subplot(2,3,4)
  plot(tL_juv1(:,1), tL_juv1(:,2), '.k', tL1, EL1, 'k', ...
      tL_juv2(:,1), tL_juv2(:,2), '.b', tL2, EL2, 'b', ...
     tL_juv3(:,1), tL_juv3(:,2), '.m', tL3, EL3, 'm', ...
     tL_juv4(:,1), tL_juv4(:,2), '.r', tL4, EL4, 'r', ...
     tL_juv5(:,1), tL_juv5(:,2), '.b', tL5, EL5, 'b', ...
     tL_juv6(:,1), tL_juv6(:,2), '.c', tL6, EL6, 'c', ...
     tL_larv(:,1), tL_larv(:,2), '.g', tLlarv, ELlarv, 'g')
  xlabel('age, d')
  ylabel('length, cm')
  axis([0 280 0 15])
  title('Mene2003')

  subplot(2,3,5)
  plot(tL_ad_f(:,1), tL_ad_f(:,2), '.k', tLad, ELad, 'k')
  xlabel('age, d')
  ylabel('length, cm')
  axis([0 2200 0 27])
  title('Silv')
 
  subplot(2,3,6)
  plot(tL_juv1(:,1), tL_juv1(:,2), '.k', tL1, EL1, 'k', ...
     tL_juv2(:,1), tL_juv2(:,2), '.b', tL2, EL2, 'b', ...
     tL_juv3(:,1), tL_juv3(:,2), '.m', tL3, EL3, 'm', ...
     tL_juv4(:,1), tL_juv4(:,2), '.r', tL4, EL4, 'r', ...
     tL_juv5(:,1), tL_juv5(:,2), '.b', tL5, EL5, 'b', ...
     tL_juv6(:,1), tL_juv6(:,2), '.c', tL6, EL6, 'c', ...
     tL_larv(:,1), tL_larv(:,2), '.g', tLlarv, ELlarv, 'g',...
     tL_ad_f(:,1), tL_ad_f(:,2), '.k', tLad, ELad, 'k')
  xlabel('age, d')
  ylabel('length, cm')
  axis([0 2200 0 27])
  title('All')
   % set(gca, 'Fontsize', 15, 'Box', 'on')

  print -dpng results_Sardina_pilchardus_01.png


  figure % length-weight
  subplot(3,1,1)
  hold on
  plot(L4, EW4, 'r', LW_juv4(:,1), LW_juv4(:,2), '.r', 'markersize', 15, 'linewidth', 2)
  plot(L4, EW5, 'b', LW_juv5(:,1), LW_juv5(:,2), '.b', 'markersize', 15, 'linewidth', 2)
  plot(L4, EW6, 'c', LW_juv6(:,1), LW_juv6(:,2), '.c', 'markersize', 15, 'linewidth', 2)
   set(gca, 'Fontsize', 12, 'Box', 'on')
 xlabel('total length, cm')
  ylabel('wet weight, g')
  title('All')

  
  subplot(3,1,2)
  plot(L, EW, 'g', LW_ad(:,1), LW_ad(:,2), '.r', 'markersize', 15, 'linewidth', 2)
  set(gca, 'Fontsize', 12, 'Box', 'on')
  xlabel('total length, cm')
  ylabel('wet weight, g')
  title('Catchment 2002-2011')
  axis([0 25 0 100])
  
  subplot(3,1,3)
  hold on
  plot(L4, EW4, 'r', LW_juv4(:,1), LW_juv4(:,2), '.r', 'markersize', 15, 'linewidth', 2)
  plot(L4, EW5, 'b', LW_juv5(:,1), LW_juv5(:,2), '.b', 'markersize', 15, 'linewidth', 2)
  plot(L4, EW6, 'c', LW_juv6(:,1), LW_juv6(:,2), '.c', 'markersize', 15, 'linewidth', 2)
  plot(L, EW, 'g', LW_ad(:,1), LW_ad(:,2), '.r', 'markersize', 15, 'linewidth', 2)
    set(gca, 'Fontsize', 12, 'Box', 'on')

  title('Juveniles')
  xlabel('total length, cm')
  ylabel('wet weight, g')
 
  
  print -dpng results_Sardina_pilchardus_02.png
  

  figure()
  subplot(2,1,1)
  plot(t, EE, 'g', tE(:,1), tE(:,2), '.r', 'markersize', 15, 'linewidth', 2)
  title('Energy density - yearly cycle')
  xlabel('time, d')
  ylabel('energy density, kJ/g dw')
  
  subplot(2,1,2)
  plot(t, Edw, 'g', tdw(:,1), tdw(:,2), '.r', 'markersize', 15, 'linewidth', 2)
  xlabel('time, d')
  ylabel('Dry to wet weight ratio, -')
  title('Dry to wet weight ratio - yearly cycle')


  print -dpng results_Sardina_pilchardus_03.png
