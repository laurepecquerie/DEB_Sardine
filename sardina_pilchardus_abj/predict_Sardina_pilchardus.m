%% predict_Sardina_pilchardus
% Obtains predictions, using parameters and data

%%
function [Prd_data, info] = predict_Sardina_pilchardus(par, chem, T_ref, data)
  % created by Starrlight Augustine, Dina Lika, Bas Kooijman, Goncalo Marques and Laure Pecquerie 2015/01/30
  
  %% Syntax
  % [Prd_data, info] = <../predict_my_pet.m *predict_my_pet*>(par, chem, data)
  
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
  % * Prd_data: structure with predicted values for data
  
  %% Remarks
  % Template for use in add_my_pet
  
  %% unpack par, chem, cpar and data
  cpar = parscomp_st(par, chem);
  v2struct(chem); v2struct(par);  v2struct(cpar);% order is important for now ; we overwrite w_V ; d_E ; w_E in chem
  v2struct(data);
  
  del_M_SL = del_M / 0.87; % -, shape coefficient for standard length - juveniles and adults % Gaygusuz et al. 2006
  
  %% customized filters
  if f_juv_pen <= 0 || f_juv_lag <= 0 || f_tL_larv <= 0 || f_tL_ad <= 0 % non-negativity
    info = 0;
    Prd_data = {};
    return
  end

  if mu_E <= 0 || d_E <= 0 || w_E <= 0|| w_V <= 0 % non-negativity
    info = 0;
    Prd_data = {};
    return
  end

  if d_E >= 1  % fraction
    info = 0;
    Prd_data = {};
    return
  end
  
  if kap_G >= mu_V / mu_E || kap_X >= mu_X / mu_E  % constraint required for mass conservation and no production of O2
    info = 0;
    Prd_data = {};
    return
  end

  %% compute temperature correction factors
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


  %% zero-variate data

  %-------- error below
   % egg -  TC_ab is used = guess
  %vT = v * TC_ab;kT_J = k_J * TC_ab;
  %kT_M = k_M * TC_ab; pT_Am = p_Am * TC_ab;
  % V_Hb should also be corrected for T in the scaling.
  %pars_E0 = [V_Hb; g; kT_J; kT_M; vT]; % pars for initial_scaled_reserve
  %[U_E0 L_b info] = initial_scaled_reserve(f, pars_E0); % d cm^2, initial scaled reserve
  %E_0 = pT_Am * U_E0;    % J, initial reserve (of embryo)
  %Wd_0 = E_0 / mu_E;
  
% ----------
  
  % egg - 
  % V_Hb should also be corrected for T in the scaling or no parameter should be T corrected.
  pars_E0 = [V_Hb; g; k_J; k_M; v]; % pars for initial_scaled_reserve
  [U_E0 L_b info] = initial_scaled_reserve(f, pars_E0); % d cm^2, initial scaled reserve
  E_0 = p_Am * U_E0;    % J, initial reserve (of embryo)
  Wd_0 = E_0 * w_E / mu_E;
  
  % birth
  pars_lj = [g; k; l_T; v_Hb; v_Hj; v_Hp];
  [t_j t_p t_b l_j l_p l_b l_i rho_j rho_B info] = get_tj(pars_lj, f);
  if info ~= 1 % numerical procedure failed
    fprintf('warning: invalid parameter value combination for get_tj \n')
  end
  L_b = L_m * l_b;                       % cm, structural length at birth at f
  Lw_b = L_b/ del_Mb;                    % cm, standard length at birth at f
  Ww_b = L_b^3 * (1 + f * w);            % g, wet weight at birth at f
  a_b = t_b/ k_M; aT_b = a_b/ TC_ab;        % d, age at birth at f, temp corrected

  % metamorphosis
  L_j = l_j * L_m;                       % cm, length at metamorphosis
  a_j = t_j/ k_M;                        % d, age at metam at f and T_ref
  Lw_j = L_j/ del_M_SL;                    % cm, standard length at metamorphosis at f
  
  % puberty 
  L_p = l_p * L_m; Lw_p = L_p/ del_M;    % cm, structural, physical length at puberty
  Ww_p = L_p^3 * (1 + f * w);            % g, wet weight at puberty
  aT_p = t_p/ k_M/ TC_ap;                   % d, age at puberty

  % ultimate
  L_i = L_m * l_i; Lw_i = L_i/ del_M;       % cm, ultimate structural, physical length
  Ww_i = L_i^3 * (1 + f * w);                % g, ultimate wet weight
  
  % life span
  pars_tm = [g; l_T; h_a/ k_M^2; s_G];   % compose parameter vector
  t_m = get_tm_s(pars_tm, f, l_b, l_p);  % -, scaled mean life span
  a_m = t_m/ k_M; aT_m = a_m/ TC_am;        % d, mean life span

  % reproduction
  %pars_R = [kap; kap_R; g; k_J; k_M; L_T; v; U_Hb; U_Hp; L_b; L_j; L_p]; % compose parameter vector
  pars_R = [kap, kap_R, g, k_J, k_M, L_T, v, U_Hb, U_Hj, U_Hp];
  [R_i, UE0, Lb, Lj, Lp, info]  =  reprod_rate_j(L_i, f, pars_R);                 % ultimate reproduction rate
  RT_i = TC_Ri * R_i;
  
  %% pack to output
  % the names of the fields in the structure must be the same as the data names in the mydata file
  Prd_data.ab  = aT_b;
  Prd_data.ap  = aT_p;
  Prd_data.am  = aT_m;
  Prd_data.Lb  = Lw_b;
  Prd_data.Lj  = Lw_j;
  Prd_data.Lp  = Lw_p;
  Prd_data.Li  = Lw_i;
  Prd_data.Wwb = Ww_b;
  Prd_data.Wwp = Ww_p;
  Prd_data.Wwi = Ww_i;
  Prd_data.Ri  = RT_i;
  Prd_data.Wd0 = Wd_0;
  Prd_data.E0  = E_0;
  
  %% uni-variate data
  
  % juvenile data set 1
  f = f_juv_pen; 
  pars_E0 = [V_Hb; g; k_J; k_M; v]; % pars for initial_scaled_reserve
  [U_E0 L_b info] = initial_scaled_reserve(f, pars_E0); % d cm^2, initial scaled reserve
  E_0 = p_Am * U_E0;    % J, initial reserve (of embryo)
  pars_lj = [g; k; l_T; v_Hb; v_Hj; v_Hp];
  [t_j t_p t_b l_j l_p l_b l_i rho_j rho_B info] = get_tj(pars_lj, f);
  %L_b = L_m * l_b;                       % cm, structural length at birth at f
  L_j = l_j * L_m;                       % cm, length at metamorphosis

  
  a = [-1e-10;tL_juv1(:,1)];
  [a ELH] = ode45(@dget_ELH_pj, a, [E_0 1e-10 0], [], L_b, L_j, L_m, p_Am, v, g, k_J, kap, f, E_Hb, E_Hj, T_A, T_ref, temp.tL_juv1); 
  ELH(1,:) = []; L = ELH(:,2); % L3 = L.^3; U = LUH(:,2); 
  EL1 = L/ del_M_SL;
%   EWt1 = J_E_Am * U * w_E + L3 * d_V;
%  EW1 = L3 * d_V * (1 + f * w);

  % juvenile data set 2
  f = f_juv_pen;
  a = [-1e-10;tL_juv2(:,1)];
  [a ELH] = ode45(@dget_ELH_pj, a, [E_0 1e-10 0], [], L_b, L_j, L_m, p_Am, v, g, k_J, kap, f, E_Hb, E_Hj, T_A, T_ref, temp.tL_juv2); 
  ELH(1,:) = []; L = ELH(:,2); % L3 = L.^3; U = LUH(:,2); 
  EL2 = L/ del_M_SL;
%   EWt2 = J_E_Am * U * w_E + L3 * d_V;
%   EW2 = L3 * d_V * (1 + f * w);

  % juvenile data set 3
  f = f_juv_pen;
  a = [-1e-10;tL_juv3(:,1)];
  [a ELH] = ode45(@dget_ELH_pj, a, [E_0 1e-10 0], [], L_b, L_j, L_m, p_Am, v, g, k_J, kap, f, E_Hb, E_Hj, T_A, T_ref, temp.tL_juv3); 
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
  %L_b = L_m * l_b;                       % cm, structural length at birth at f
  L_j = l_j * L_m;  
  a = [-1e-10;tL_juv4(:,1)];
  [a ELH] = ode45(@dget_ELH_pj, a, [E_0 1e-10 0], [], L_b, L_j, L_m, p_Am, v, g, k_J, kap, f, E_Hb, E_Hj, T_A, T_ref, temp.tL_juv4); 
  ELH(1,:) = []; L = ELH(:,2); 
  EL4 = L/ del_M_SL;
  EW4 = (del_M_SL * LW_juv4(:,1)).^3  .* (1 + f * w);

  % juvenile data set 5
  f = f_juv_lag;
  a = [-1e-10;tL_juv5(:,1)];
  [a ELH] = ode45(@dget_ELH_pj, a, [E_0 1e-10 0], [], L_b, L_j, L_m, p_Am, v, g, k_J, kap, f, E_Hb, E_Hj, T_A, T_ref, temp.tL_juv5); 
  ELH(1,:) = []; L = ELH(:,2); % L3 = L.^3; U = LUH(:,2); 
  EL5 = L/ del_M_SL;
  EW5 = (del_M_SL * LW_juv5(:,1)).^3 .* (1 + f * w);

  % juvenile data set 6
  f = f_juv_lag;
  a = [-1e-10;tL_juv6(:,1)];
  [a ELH] = ode45(@dget_ELH_pj, a, [E_0 1e-10 0], [], L_b, L_j, L_m, p_Am, v, g, k_J, kap, f, E_Hb, E_Hj, T_A, T_ref, temp.tL_juv6); 
  ELH(1,:) = []; L = ELH(:,2); 
  EL6 = L/ del_M_SL;
  EW6 = (del_M_SL * LW_juv6(:,1)).^3  .* (1 + f * w);

  % larval data set
  f = f_tL_larv;
  a = [-1e-10;tL_larv(:,1)];
  [a ELH] = ode45(@dget_ELH_pj, a, [E_0 1e-10 0], [], L_b, L_j, L_m, p_Am, v, g, k_J, kap, f, E_Hb, E_Hj, T_A, T_ref, temp.tL_larv); 
  ELH(1,:) = []; L = ELH(:,2); 
  EL_larv = L/ del_Mb;


  % adult female data set
  f = f_tL_ad;
  vT = v * TC_tL_ad;kT_J = k_J * TC_tL_ad;
  kT_M = k_M * TC_tL_ad; pT_Am = p_Am * TC_tL_ad;
 
  a = [-1e-10;tL_ad_f(:,1)];
  [a ELH] = ode45(@dget_ELH_pj, a, [E_0 1e-10 0], [], L_b, L_j, L_m, p_Am, v, g, k_J, kap, f, E_Hb, E_Hj, T_A, T_ref, temp.tL_ad_f); 
  ELH(1,:) = []; L = ELH(:,2); % L3 = L.^3; U = LUH(:,2); 
  EL_ad_f = L/ del_M;

  % adult male data set
%   a = [-1e-10;tL_ad_m(:,1)];
%   [a ELH] = ode45(@dget_ELH_pj, a, [E_0 1e-10 0], [], L_b, L_j, L_m, p_Am, v, g, k_J, kap, f, E_Hb, E_Hj, T_A, T_ref); 
%   ELH(1,:) = []; L = ELH(:,2); % L3 = L.^3; U = LUH(:,2); 
%   EL_ad_m = L/ del_M;


  % adult female length-weigth data set - without reproduction buffer and
  % without gonads
  aL = LW_ad(:,1);
  EW_ad = (del_M * aL).^3 * (1 + f * w);
  
  
  % We look at a year cycle for an individual of 17 cm, starting day 55 (minimum T)
  % reproduction is not specified yet
  L_init = 17 * del_M;
  % we assume same average f as for the tL_ad_f dataset
  f_init = f_tL_ad + 0.2 * sin(2 * pi * (tE(1,1)+220)/365); 
  E_init = f_init * L_init.^3 * p_Am / v ;
  % we check that L_init is > Lp
  pars_H = [kap, kap_R, g ,k_J, k_M, L_T, v, U_Hb U_Hj U_Hp];
   [H_init, a, info] = maturity_j(L_init, 0.7, pars_H);
   if H_init < U_Hp
       disp('not an adult')
   end                                             
  [t ELHR] = ode45(@dget_ELHR_pj, tE(:,1), [E_init L_init E_Hp 0], [], L_b, L_j, L_m, p_Am, v, g, k_J, kap, E_Hb, E_Hj, E_Hp, T_A, T_ref); 
  E = ELHR(:,1); L = ELHR(:,2); E_R = ELHR(:,4); 
  Wd_V = L.^3 * d_V ;
  E_V = L.^3 * M_V * mu_V;
  Wd_E = E * w_E / mu_E;
  E_per_Wd = ((E + E_V) ./ (Wd_E + Wd_V)) / 1000; % in kJ/g dw
  
  Ww_V = L.^3 * 1;% we assume dV = 1g/cm^3 in ww
  Ww_E = E / mu_E * w_E / d_E; % we assume dE = 1g / cm^3 in ww
  
  % relative fecundity : 338-448 eggs/ g (ovary-free weight?) - zwolinski et al. 2001
  % reproduction module (made to match time points in mydata_Sard: 
  % 1st spawning : day 275 = October 2nd - spawning every 20 days = every other time point
   i_sp1 = find( t >=275,1);
   spawn = 1; E_batch = zeros(length(t),1); N_batch = zeros(length(t),1);
   i = i_sp1;
   while and(spawn,i <=length(t)) 
        N_batch(i) = 400 * (Ww_V(i) + Ww_E(i)); % for now I ignore Ww_R to calculate the batch fecundity
        E_batch(i) = N_batch(i) * E_0; % Energy in batch
        if E_R(i) - E_batch(i) / kap_R >=0
            E_R(i:end) = E_R(i:end) - E_batch(i) / kap_R;
        else 
            E_R(i:end) = E_R(i:end) - E_R(i); % empty buffer and stop spawning
            spawn = 0;
        end
        i = i + 2;
   end
  Wd_R = E_R * w_E / mu_E;
  Etot_per_Wd = ((E + E_V + E_R) ./ (Wd_E + Wd_V + Wd_R)) / 1000;% in kJ/g dw
 
  EE = Etot_per_Wd; % including E_R
  %EE = E_per_Wd; % without E_R
  
  % dry to wet weight ratio
  Ww_R = E_R / mu_E * w_E / d_E; % we assume dE = 1g / cm^3 in ww
  Edw = (Wd_E + Wd_V + Wd_R) ./ (Ww_V + Ww_E + Ww_R);
  %Edw = (Wd_E + Wd_V ) ./ (Ww_V + Ww_E );

  
  
  %% pack to output
  % the names of the fields in the structure must be the same as the data names in the mydata file
  Prd_data.tL_juv1 = EL1;
  Prd_data.tL_juv2 = EL2;
  Prd_data.tL_juv3 = EL3;
  Prd_data.tL_juv4 = EL4;
  Prd_data.tL_juv5 = EL5;
  Prd_data.tL_juv6 = EL6;
  Prd_data.tL_larv = EL_larv;
  Prd_data.tL_ad_f = EL_ad_f;
%   Prd_data.tL_ad_m = EL_ad_m;
  Prd_data.LW_juv4 = EW4;
  Prd_data.LW_juv5 = EW5;
  Prd_data.LW_juv6 = EW6;
  Prd_data.LW_ad = EW_ad;
  Prd_data.tE = EE;
  Prd_data.tdw = Edw;

  
  %% extra pseudodata
  
  Prd_data.psd_dE = d_E;
  
  
  %% sub subfuctions

  function dELH = dget_ELH_pj(t, ELH, Lb, Lj, Lm, p_Am, v, g, kJ, kap, f, Hb, Hj, T_A, T_ref, T)
  %% change in state variables during juvenile stage
  %% dELH = dget_ELH_pj(t, ELH)
  %% ELH: 3-vector
  %%  E: reserve E
  %%  L: structural length
  %%  H: maturity E_H
  %% dELH: change in reserve, length, maturity
  
 
  %% unpack variables
  E = ELH(1); L = ELH(2); H = ELH(3);
  
  TC = tempcorr(T, T_ref, T_A);
  vT = v * TC; kT_J = kJ * TC; pT_Am = p_Am * TC;
 
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
  dH = (1 - kap) * pT_C - kT_J * H;
  dE = (L > Lb) * sM * pT_Am * f * L^2 - pT_C;
  dL = rT * L/3;

  %% pack derivatives
  dELH = [dE; dL; dH];
  
  
  function dELHR = dget_ELHR_pj(t, ELHR, Lb, Lj, Lm, p_Am, v, g, kJ, kap, Hb, Hj, Hp, T_A, T_ref)
  %% change in state variables during juvenile stage
  %% dELHR = dget_ELHR_p_pj(t, ELHR)
  %% ELHR: 4-vector
  %  E: reserve E
  %  L: structural length
  %  H: maturity E_H
  %   R: reproduction buffer
  %% dELH: change in reserve, length, maturity, reproduction buffer
  
  % forcing functions
  T = 273.15 + 17 + 2.5 * sin(2 * pi * (t+220)/365);
  f = 0.7 + 0.2 * sin(2 * pi * (t+200)/365); % to correspond to the peak of the energy density in the data (cf Rosa et al. 2010)
 
  %% unpack variables
  E = ELHR(1); L = ELHR(2); H = ELHR(3); R = ELHR(4);
  
  %TC = tempcorr(273 + 15, T_ref, T_A);
  TC = tempcorr(T, T_ref, T_A);
  vT = v * TC; kT_J = kJ * TC; pT_Am = p_Am * TC;
 
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
  
  