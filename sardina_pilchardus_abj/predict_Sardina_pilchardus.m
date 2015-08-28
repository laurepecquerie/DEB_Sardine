%% predict_my_pet
% Obtains predictions, using parameters and data

%%
function [prdData, info] = predict_Sardina_pilchardus(par, data, auxData)
  % created by Starrlight Augustine, Dina Lika, Bas Kooijman, Goncalo Marques and Laure Pecquerie 2015/01/30; 
  % last modified 2015/07/29
  
  %% Syntax
  % [prdData, info] = <../predict_my_pet.m *predict_my_pet*>(par, chem, data)
  
  %% Description
  % Obtains predictions, using parameters and data
  %
  % Input
  %
  % * par: structure with parameters (see below)
  % * chem: structure with biochemical parameters
  % * data: structure with data (not all elements are used)
  %  
  % Output
  %
  % * prdData: structure with predicted values for data
  % * info: identified for correct setting of predictions (see remarks)
  
  %% Remarks
  % Template for use in add_my_pet.
  % The code calls <parscomp_st.html *parscomp_st*> in order to compute
  % scaled quantities, compound parameters, molecular weights and compose
  % matrixes of mass to energy couplers and chemical indices.
  % With the use of filters, setting info = 0, prdData = {}, return, has the effect
  % that the parameter-combination is not selected for finding the
  % best-fitting combination; this setting acts as customized filter.
  
  %% Example of a costumized filter
  % See the lines just below unpacking
  
  % unpack par, data, auxData
  cPar = parscomp_st(par); %vars_pull(par); 
  vars_pull(par); vars_pull(cPar); % w_E and w_V are overwritten in the next line (we want to estimate them, they are set in pars_init)
  vars_pull(data);  vars_pull(auxData);
    
  % customized filters
    if f_juv_pen <= 0 || f_juv_lag <= 0 || f_tL_larv <= 0 || f_tL_ad <= 0 % non-negativity
      info = 0;
      prdData = {};
      return
    end
    
    if f_juv_pen > 1.6 || f_juv_lag > 1.6 || f_tL_larv > 1.6 || f_tL_ad > 1.6 % 
      info = 0;
      prdData = {};
      return
    end

  if mu_E <= 0 || d_E <= 0 || w_E <= 0|| w_V <= 0 % non-negativity
    info = 0;
    prdData = {};
    return
  end
  
  if mu_E / w_E > 37000 || mu_E / w_E < 21000% (only lipids or lower than the observed minimum value total weight)
    info = 0;
    prdData = {};
    return
  end
  
  if mu_V / w_V > 21000 || mu_V / w_V < 15000  || mu_V > mu_E % if larger than 21000, larger than the minimum value observed
    info = 0;
    prdData = {};
    return
  end
  
  if d_E >= 1 || d_V >= 1 % fraction
    info = 0;
    prdData = {};
    return
  end
  
  % mu_X will be fixed once we obtain safistactory values for mu_E and mu_V
  if kap_G >= mu_V / mu_E %|| kap_X >= mu_X / mu_E  % constraint required for mass conservation and no production of CO2
    info = 0;
    prdData = {};
    return
  end
  
  if del_M < del_Mb 
       info = 0;
       prdData = {};
       return
   end
   
   if var_f_tL_ad < 0 || var_f_tL_ad > f_tL_ad
       info = 0;
       prdData = {};
       return
   end
   
   if ~reach_birth(g, k, v_Hb, f_tL_ad) % constraint required for reaching birth with f
     info = 0;
     prdData = {};
     return;
   end  
   
   % constraint required for reaching puberty with f_tL_ad (adults in the wild)
   pars_lj = [g; k; l_T; v_Hb; v_Hj; v_Hp];
   [t_j t_p t_b l_j l_p l_b l_i rho_j rho_B info] = get_tj(pars_lj, f_tL_ad);
   if info ~= 1 % numerical procedure failed
     fprintf('warning: invalid parameter value combination for get_tj \n')
   end
   s_M = l_j / l_b;
   if k * v_Hp >= f_tL_ad^3 * s_M^3 % constraint required for reaching puberty with f_tL_ad (adults in the wild)
     info = 0;
     prdData = {};
     return
   end
   
   if L_init_tE * del_M / L_m < l_p %  all individuals larger than L_init_tE should be adults 
       info = 0;
       prdData = {};
       return
   end

   
  del_M_SL = del_M / 0.87; % -, shape coefficient for standard length - juveniles and adults % Gaygusuz et al. 2006
  
  % compute temperature correction factors
  TC_ab = tempcorr(temp.ab, T_ref, T_A);
  TC_ap = tempcorr(temp.ap, T_ref, T_A);
  TC_am = tempcorr(temp.am, T_ref, T_A);
  TC_Ri = tempcorr(temp.Ri, T_ref, T_A);
  TC_tL_juv1 = tempcorr(temp.tL_juv1, T_ref, T_A);
  TC_tL_juv2 = tempcorr(temp.tL_juv2, T_ref, T_A);
  TC_tL_juv3 = tempcorr(temp.tL_juv3, T_ref, T_A);
  TC_tL_juv4 = tempcorr(temp.tL_juv4, T_ref, T_A);
  TC_tL_juv5 = tempcorr(temp.tL_juv5, T_ref, T_A);
  TC_tL_juv6 = tempcorr(temp.tL_juv6, T_ref, T_A);
  TC_tL_larv = tempcorr(temp.tL_larv, T_ref, T_A);
  TC_tL_ad = tempcorr(temp.tL_ad_f, T_ref, T_A); % same for adult females and males
  TC_LW_ad = tempcorr(temp.LW_ad, T_ref, T_A);

% uncomment if you need this for computing moles of a gas to a volume of gas
% - else feel free to delete  these lines
% molar volume of gas at 1 bar and 20 C is 24.4 L/mol
% T = C2K(20); % K, temp of measurement equipment- apperently this is
% always the standard unless explicitely stated otherwise in a paper (pers.
% comm. Mike Kearney).
% X_gas = T_ref/ T/ 24.4;  % M,  mol of gas per litre at T_ref and 1 bar;
  
% zero-variate data

  % life cycle

  % egg -  
  pars_E0 = [V_Hb; g; k_J; k_M; v]; % pars for initial_scaled_reserve
  [U_E0 L_b info] = initial_scaled_reserve(f, pars_E0); % d cm^2, initial scaled reserve
  E_0 = p_Am * U_E0;    % J, initial reserve (of embryo)
  Wd_0 = E_0 * w_E / mu_E;
  
  %pars_lj = [g; k; l_T; v_Hb; v_Hj; v_Hp];
  [t_j t_p t_b l_j l_p l_b l_i rho_j rho_B info] = get_tj(pars_lj, f);
  if info ~= 1 % numerical procedure failed
    fprintf('warning: invalid parameter value combination for get_tj \n')
  end
  
  % birth
  L_b = l_b * L_m;                            % cm, structural length at birth at f
  Lw_b = L_b/ del_Mb;                         % cm, standard length at birth at f
  Ww_Vb = L_b^3;                              % g, wet weight of structure at f
  Ww_Eb = w_E / mu_E / d_E * f * E_m * L_b^3; % g, wet weight of reserve at f
  Ww_b = Ww_Vb + Ww_Eb;                       % g, wet weight at birth at f
  a_b = t_b/ k_M; aT_b = a_b/ TC_ab;          % d, age at birth at f, temp corrected

  % metamorphosis
  L_j = l_j * L_m;                       % cm, length at metamorphosis
  a_j = t_j/ k_M;                        % d, age at metam at f and T_ref
  Lw_j = L_j/ del_M_SL;                  % cm, standard length at metamorphosis at f
  
  % puberty 
  L_p = l_p * L_m; 					          % cm, structural length at puberty
  Lw_p = L_p/ del_M;                          % cm, physical length at puberty
  Ww_Vp = L_p^3;                              % g, wet weight of structure at f
  Ww_Ep = w_E / mu_E / d_E * f * E_m * L_p^3; % g, wet weight of reserve at f
  Ww_p = Ww_Vp + Ww_Ep;                       % g, wet weight at puberty at f
  aT_p = t_p/ k_M/ TC_ap;                     % d, age at puberty

  % ultimate
  L_i = L_m * l_i;                       % cm, ultimate structural length
  Lw_i = L_i/ del_M;                     % cm, ultimate physical length
  Ww_Vi = L_i^3;                              % g, wet weight of structure at f
  Ww_Ei = w_E / mu_E / d_E * f * E_m * L_i^3; % g, wet weight of reserve at f
  Ww_i = Ww_Vi + Ww_Ei;                       % g, wet weight at puberty at f
    
  % life span
  pars_tm = [g; l_T; h_a/ k_M^2; s_G];   % compose parameter vector
  t_m = get_tm_s(pars_tm, f, l_b, l_p);  % -, scaled mean life span
  a_m = t_m/ k_M; aT_m = a_m/ TC_am;        % d, mean life span

  % reproduction
  pars_R = [kap, kap_R, g, k_J, k_M, L_T, v, U_Hb, U_Hj, U_Hp];
  [R_i, UE0, Lb, Lj, Lp, info]  =  reprod_rate_j(L_i, f, pars_R);                 % ultimate reproduction rate
  RT_i = TC_Ri * R_i;
    
  %% pack to output
  % the names of the fields in the structure must be the same as the data names in the mydata file
  prdData.ab  = aT_b;
  prdData.ap  = aT_p;
  prdData.am  = aT_m;
  prdData.Lb  = Lw_b;
  prdData.Lj  = Lw_j;
  prdData.Lp  = Lw_p;
  prdData.Li  = Lw_i;
  prdData.Wwb = Ww_b;
  prdData.Wwp = Ww_p;
  prdData.Wwi = Ww_i;
  prdData.Ri  = RT_i;
  prdData.Wd0 = Wd_0;
  prdData.E0  = E_0;
  
  % uni-variate data
  
  % juvenile data set 1
   f = f_juv_pen; 
  pars_E0 = [V_Hb; g; k_J; k_M; v]; % pars for initial_scaled_reserve
  [U_E0 L_b info] = initial_scaled_reserve(f, pars_E0); % d cm^2, initial scaled reserve
  E_0 = p_Am * U_E0;    % J, initial reserve (of embryo)
  pars_lj = [g; k; l_T; v_Hb; v_Hj; v_Hp];
  [t_j t_p t_b l_j l_p l_b l_i rho_j rho_B info] = get_tj(pars_lj, f);
  L_b = L_m * l_b;                       % cm, structural length at birth at f
  L_j = l_j * L_m;                       % cm, length at metamorphosis

  vT = v * TC_tL_juv1;kT_J = k_J * TC_tL_juv1;
  pT_Am = p_Am * TC_tL_juv1;
 
  a = [-1e-10;tL_juv1(:,1)];
  [a ELH] = ode45(@dget_ELH_pj, a, [E_0 1e-10 0], [], L_b, L_j, L_m, pT_Am, vT, g, kT_J, kap, E_Hb, E_Hj, f); 
  ELH(1,:) = []; L = ELH(:,2); % L3 = L.^3; U = LUH(:,2); 
  EL1 = L/ del_M_SL;
%   EWt1 = J_E_Am * U * w_E + L3 * d_V;
%  EW1 = L3 * d_V * (1 + f * w);

  % juvenile data set 2
  f = f_juv_pen;
  vT = v * TC_tL_juv2;kT_J = k_J * TC_tL_juv2;
  pT_Am = p_Am * TC_tL_juv2;
  a = [-1e-10;tL_juv2(:,1)];
  [a ELH] = ode45(@dget_ELH_pj, a, [E_0 1e-10 0], [], L_b, L_j, L_m, pT_Am, vT, g, kT_J, kap, E_Hb, E_Hj, f); 
  ELH(1,:) = []; L = ELH(:,2); % L3 = L.^3; U = LUH(:,2); 
  EL2 = L/ del_M_SL;
%   EWt2 = J_E_Am * U * w_E + L3 * d_V;
%   EW2 = L3 * d_V * (1 + f * w);

  % juvenile data set 3
  f = f_juv_pen;
  vT = v * TC_tL_juv3;kT_J = k_J * TC_tL_juv3;
  pT_Am = p_Am * TC_tL_juv3;
  a = [-1e-10;tL_juv3(:,1)];
  [a ELH] = ode45(@dget_ELH_pj, a, [E_0 1e-10 0], [], L_b, L_j, L_m, pT_Am, vT, g, kT_J, kap, E_Hb, E_Hj, f); 
  ELH(1,:) = []; L = ELH(:,2); % L3 = L.^3; U = LUH(:,2); 
  EL3 = L/ del_M_SL;
%   EWt3 = J_E_Am * U * w_E + L3 * d_V;
%   EW3 = L3 * d_V * (1 + f * w);

  % juvenile data set 4
  % we recalcultate E0, Lb and Lj as f is assumed to be different between
  % Peniche and Lagoa de Obidos
  f = f_juv_lag;
  pars_E0 = [V_Hb; g; k_J; k_M; v]; % pars for initial_scaled_reserve
  [U_E0 L_b info] = initial_scaled_reserve(f, pars_E0); % d cm^2, initial scaled reserve
  E_0 = p_Am * U_E0;    % J, initial reserve (of embryo)
  pars_lj = [g; k; l_T; v_Hb; v_Hj; v_Hp];
  [t_j t_p t_b l_j l_p l_b l_i rho_j rho_B info] = get_tj(pars_lj, f);
  L_b = L_m * l_b;                       % cm, structural length at birth at f
  L_j = l_j * L_m;  
  
  vT = v * TC_tL_juv4;kT_J = k_J * TC_tL_juv4;
  pT_Am = p_Am * TC_tL_juv4;
  
  a = [-1e-10;tL_juv4(:,1)];
  [a ELH] = ode45(@dget_ELH_pj, a, [E_0 1e-10 0], [], L_b, L_j, L_m, pT_Am, vT, g, kT_J, kap, E_Hb, E_Hj, f); 
  ELH(1,:) = []; L = ELH(:,2); 
  EL4 = L/ del_M_SL;
  
  Ww_V = (del_M_SL * LW_juv4(:,1)).^3;                              % g, wet weight of structure at f
  Ww_E = w_E / mu_E / d_E * f * E_m * (del_M_SL * LW_juv4(:,1)).^3; % g, wet weight of reserve at f
  EW4 = Ww_V + Ww_E;                       % g, wet weight at f
  
  
  % juvenile data set 5
  f = f_juv_lag;
  vT = v * TC_tL_juv5;kT_J = k_J * TC_tL_juv5;
  pT_Am = p_Am * TC_tL_juv5;
  a = [-1e-10;tL_juv5(:,1)];
  [a ELH] = ode45(@dget_ELH_pj, a, [E_0 1e-10 0], [], L_b, L_j, L_m, pT_Am, vT, g, kT_J, kap, E_Hb, E_Hj, f); 
  ELH(1,:) = []; L = ELH(:,2); % L3 = L.^3; U = LUH(:,2); 
  EL5 = L/ del_M_SL;
  
  Ww_V = (del_M_SL * LW_juv5(:,1)).^3;                              % g, wet weight of structure at f
  Ww_E = w_E / mu_E / d_E * f * E_m * (del_M_SL * LW_juv5(:,1)).^3; % g, wet weight of reserve at f
  EW5 = Ww_V + Ww_E;                       % g, wet weight at f
 
  % juvenile data set 6
  f = f_juv_lag;
  vT = v * TC_tL_juv6;kT_J = k_J * TC_tL_juv6;
  pT_Am = p_Am * TC_tL_juv6;
  a = [-1e-10;tL_juv6(:,1)];
  [a ELH] = ode45(@dget_ELH_pj, a, [E_0 1e-10 0], [], L_b, L_j, L_m, pT_Am, vT, g, kT_J, kap, E_Hb, E_Hj, f); 
  ELH(1,:) = []; L = ELH(:,2); 
  EL6 = L/ del_M_SL;
  Ww_V = (del_M_SL * LW_juv6(:,1)).^3;                              % g, wet weight of structure at f
  Ww_E = w_E / mu_E / d_E * f * E_m * (del_M_SL * LW_juv6(:,1)).^3; % g, wet weight of reserve at f
  EW6 = Ww_V + Ww_E;                       % g, wet weight at f
 
  % larval data set
  f = f_tL_larv;
   [t_j t_p t_b l_j l_p l_b l_i rho_j rho_B info] = get_tj(pars_lj, f);
  L_b = L_m * l_b;                       % cm, structural length at birth at f
  L_j = l_j * L_m;  
  vT = v * TC_tL_larv;kT_J = k_J * TC_tL_larv;
  pT_Am = p_Am * TC_tL_larv;
  a = [-1e-10;tL_larv(:,1)];
  [a ELH] = ode45(@dget_ELH_pj, a, [E_0 1e-10 0], [], L_b, L_j, L_m, pT_Am, vT, g, kT_J, kap, E_Hb, E_Hj, f); 
  ELH(1,:) = []; L = ELH(:,2); 
  EL_larv = L/ del_Mb;

  %------------------
  % adult female data set
  f = f_tL_ad;
  [t_j t_p t_b l_j l_p l_b l_i rho_j rho_B info] = get_tj(pars_lj, f);
  L_b = L_m * l_b;                       % cm, structural length at birth at f
  L_j = l_j * L_m;  
 
  vT = v * TC_tL_ad;kT_J = k_J * TC_tL_ad;
  kT_M = k_M * TC_tL_ad; pT_Am = p_Am * TC_tL_ad;
 
  a = [-1e-10;tL_ad_f(:,1)];
  [a ELH] = ode45(@dget_ELH_pj, a, [E_0 1e-10 0], [], L_b, L_j, L_m, pT_Am, vT, g, kT_J, kap, E_Hb, E_Hj, f); 
  ELH(1,:) = []; L = ELH(:,2); % L3 = L.^3; U = LUH(:,2); 
  EL_ad_f = L/ del_M;

  % adult female length-weigth data set - without reproduction buffer and
  % without gonads
  aL = LW_ad(:,1);
  Ww_V = (del_M * aL).^3;                              % g, wet weight of structure at f
  Ww_E = w_E / mu_E / d_E * f * E_m * (del_M * aL).^3; % g, wet weight of reserve at f
  EW_ad = Ww_V + Ww_E;                       % g, wet weight at f  
  
  % We look at a year cycle for an individual of L_init_tE cm, starting day 55 (minimum T)
  % we assume same average f as for the tL_ad_f dataset, thus same Lb, Lj
  L_init = L_init_tE * del_M;% cm; structural length
  f_init = f_tL_ad + var_f_tL_ad * sin(2 * pi * (tE(1,1)+220)/365); 
  E_init = f_init * L_init.^3 * p_Am / v ;  
  t = tdw(:, 1);
  % 1st spawning : day 275 = October 2nd - spawning every 20 days = every other time point
  initSpawningTime = 275; % day
  spawningInterval = 20;  % days
  time2spawn = initSpawningTime:spawningInterval:t(end);
  
  mergedTime = union(tdw(:,1)', time2spawn');
  posDataTime = ismember(mergedTime, tdw(:,1)');
  posSpawningTime = ismember(mergedTime, time2spawn');
  
  [mergedTime, ELHR] = ode45(@dget_ELHR_j, mergedTime, [E_init L_init E_Hp 0], [], Lb, Lj, L_m, p_Am, v, g, k_J, kap, E_Hb, E_Hj, E_Hp, T_A, T_ref, f_tL_ad, var_f_tL_ad); 
  E = ELHR(posDataTime,1); L = ELHR(posDataTime,2); E_R = ELHR(posDataTime,4); 
  Wd_V = L.^3 * d_V ;
  E_V = L.^3 * M_V * mu_V;
  Wd_E = E * w_E / mu_E;
  
  Ww_V = L.^3 * 1;% we assume dV = 1g/cm^3 in ww
  Ww_E = E / mu_E * w_E / d_E; % we assume dE = 1g / cm^3 in ww
  
  Espawn = ELHR(posSpawningTime, 1); Lspawn = ELHR(posSpawningTime, 2); E_Rspawn = ELHR(posSpawningTime, 4); 
  Ww_Vspawn = Lspawn.^3 * 1;% we assume dV = 1g/cm^3 in ww
  Ww_Espawn = Espawn / mu_E * w_E / d_E; % we assume dE = 1g / cm^3 in ww

  i = 1;
  isE_Rempty = (E_Rspawn(1) == 0);
  while i <= length(time2spawn) && ~isE_Rempty
    % relative fecundity : 338-448 eggs/ g (ovary-free weight?) - zwolinski et al. 2001
    N_batch(i) = 400 * (Ww_Vspawn(i) + Ww_Espawn(i)); % for now I ignore Ww_R to calculate the batch fecundity
    E_batch(i) = N_batch(i) * E_0; % Energy in batch
    
    if E_Rspawn(i) < E_batch(i) / kap_R
      E_batch(i) = kap_R * E_Rspawn(i);
      isE_Rempty = 1;  % stop spawning when E_R empties
    end
    
    E_R(t >= time2spawn(i)) = E_R(t >= time2spawn(i)) - E_batch(i) / kap_R;
    E_Rspawn(time2spawn >= time2spawn(i)) = max(E_Rspawn(time2spawn  >= time2spawn(i)) - E_batch(i) / kap_R, 0);
    
    i = i + 1;
  end
    
  % compute the initial E_R if the periodicity condition is not fulfilled
  if E_R(end) > 0 && i <= length(time2spawn) % if i > length(time2spawn) there is no more possible batch could lower the final E_R
    E_R = findInitE_R(t, E_R, time2spawn, L(1)^3, L(end)^3, Ww_Vspawn + Ww_Espawn, N_batch(i-1) * E_0 - E_batch(i-1), i, kap_R, E_0);
  end

  Wd_R = E_R * w_E / mu_E;
  Etot_per_Wd = ((E + E_V + E_R) ./ (Wd_E + Wd_V + Wd_R)) / 1000;% in kJ/g dw
 
  EE = Etot_per_Wd; % including E_R
  
  % dry to wet weight ratio
  Ww_R = E_R / mu_E * w_E / d_E; % we assume dE = 1g / cm^3 in ww
  Edw = (Wd_E + Wd_V + Wd_R) ./ (Ww_V + Ww_E + Ww_R);
  %Edw = (Wd_E + Wd_V ) ./ (Ww_V + Ww_E );

  
  
  %% pack to output
  % the names of the fields in the structure must be the same as the data names in the mydata file
  prdData.tL_juv1 = EL1;
  prdData.tL_juv2 = EL2;
  prdData.tL_juv3 = EL3;
  prdData.tL_juv4 = EL4;
  prdData.tL_juv5 = EL5;
  prdData.tL_juv6 = EL6;
  prdData.tL_larv = EL_larv;
  prdData.tL_ad_f = EL_ad_f;
  prdData.LW_juv4 = EW4;
  prdData.LW_juv5 = EW5;
  prdData.LW_juv6 = EW6;
  prdData.LW_ad   = EW_ad;
  prdData.tE      = EE;
  prdData.tdw     = Edw;

  
  %% extra pseudodata
  
 % prdData.psd.d_E = d_E;
  
  
  %% sub subfuctions

  function dELH = dget_ELH_pj(t, ELH, Lb, Lj, Lm, p_Am, v, g, k_J, kap, Hb, Hj, f)
  %% change in state variables during juvenile stage
  %% dELH = dget_ELH_pj(t, ELH)
  %% ELH: 3-vector
  %%  E: reserve E
  %%  L: structural length
  %%  H: maturity E_H
  %% dELH: change in reserve, length, maturity
  
  % all parameter rates are already T corrected
 
  %% unpack variables
  E = ELH(1); L = ELH(2); H = ELH(3);
  
   if H < Hb 
    sM = 1; % -, multiplication factor for v and {p_Am}
  elseif H < Hj
    sM = L/ Lb;
  else
    sM = Lj/ Lb;
  end


  e = v * E/ L^3/ p_Am; % -, scaled reserve density; 
  r =  sM * v * (e/ L - 1/ Lm/ sM)/ (e + g); % 1/d, spec growth rate
  p_C = E * (sM * v/ L - r); % cm^2, scaled mobilisation
  
  % generate dH/dt, dE/dt, dL/dt
  dH = (1 - kap) * p_C - k_J * H;
  dE = (H > Hb)  * sM * p_Am * f * L^2 - p_C;
  dL = r * L/3;

  %% pack derivatives
  dELH = [dE; dL; dH];
  
  
  function dELHR = dget_ELHR_j(t, ELHR, Lb, Lj, Lm, p_Am, v, g, k_J, kap, Hb, Hj, Hp, T_A, T_ref, f_tL_ad, var_f_tL_ad)
  % change in state variables during juvenile stage
  % dELHR = dget_ELHR_j(t, ELHR)
  % ELHR: 4-vector
  %  E: reserve E
  %  L: structural length
  %  H: maturity E_H
  %   R: reproduction buffer
  %% dELH: change in reserve, length, maturity, reproduction buffer
  
  % forcing functions
  T = 273.15 + 17 + 2.5 * sin(2 * pi * (t+220)/365);
  f = f_tL_ad + var_f_tL_ad * sin(2 * pi * (t+200)/365); % to correspond to the peak of the energy density in the data (cf Rosa et al. 2010)
 
  %% unpack variables
  E = ELHR(1); L = ELHR(2); H = ELHR(3); R = ELHR(4);
  
  %TC = tempcorr(273 + 15, T_ref, T_A);
  TC = tempcorr(T, T_ref, T_A);
  vT = v * TC; kT_J = k_J * TC; pT_Am = p_Am * TC;
  
  if H < Hb 
    sM = 1; % -, multiplication factor for v and {p_Am}
  elseif H < Hj
    sM = L/ Lb;
  else
    sM = Lj/ Lb;
  end
 
 e = vT * E/ L^3/ pT_Am; % -, scaled reserve density; 
  rT = sM * vT * (e/ L - 1/ Lm/ sM)/ (e + g); % 1/d, spec growth rate
  pT_C = E * (sM * vT/ L - rT); % cm^2, scaled mobilisation
  
  % generate dH/dt, dE/dt, dL/dt
  dE = (L > Lb) * sM * pT_Am * f * L^2 - pT_C;
  dL = rT * L/3;
  dH = (H < Hp) * (1 - kap) * pT_C - kT_J * H;
  dR = (H >= Hp) * (1 - kap) * pT_C - kT_J * H;

  %% pack derivatives
  dELHR = [dE; dL; dH ; dR];
  
  function E_R = findInitE_R(t, E_R, time2spawn, VInit, VFinal, Wwspawn, workingBatch, i, kap_R, E_0) 
  %% compute E_R in the casethe periodicity condition is not fulfiled with an initial E_R equal to 0
    
  periodic = 0;
  while i <= length(time2spawn) && ~periodic
    % relative fecundity : 338-448 eggs/ g (ovary-free weight?) - zwolinski et al. 2001
    E_RInitDensity = E_R(1)/ VInit;
    E_RFinalDensity = E_R(end)/ VFinal; 
    
    if E_RFinalDensity - E_RInitDensity <= (workingBatch/ kap_R)/ VInit
      workingBatch = kap_R * (E_RFinalDensity - E_RInitDensity) * VInit;
      periodic = 1;  % stop spawning when E_R empties
    end
    E_R(t < time2spawn(i)) = E_R(t < time2spawn(i)) + workingBatch/ kap_R;
 
    if i < length(time2spawn)
      N_batch = 400 * Wwspawn(i+1); % for now I ignore Ww_R to calculate the batch fecundity
      workingBatch = N_batch * E_0; % Energy in batch
    end
        
    i = i + 1;
  end  
  
  
  
  
     