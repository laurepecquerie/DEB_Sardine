%% pars_init_my_pet
% sets (initial values for) parameters

%%
function [par, metaPar, txtPar] = pars_init_Sardina_pilchardus(metaData)
  % created by Starrlight Augustine, Dina Lika, Bas Kooijman, Goncalo Marques and Laure Pecquerie 2015/03/31
  % modified 2015/07/29 by Starrlight 
  
  %% Syntax
  % [par, metaPar, txtPar] = <../pars_init_my_pet.m *pars_init_my_pet*>(metaData)
  
  %% Description
  % sets (initial values for) parameters
  %
  % Input
  %
  % * metaData for names of phylum and class to get d_V
  %  
  % Output
  %
  % * par : structure with values of parameters
  % * metaPar: structure with information on metaparameters
  % * txtPar: structure with information on parameters

% parameters: initial values at reference temperature:
% see online manual for explanation and alternatives 
% be aware that each model type is associated with a specific list of core
% primary parameters. Those listed here are for model 'std'. See the manual
% for parameters associated with the other model types.
metaPar.model = 'abj'; 

% edit the values below such that predictions are not too far off;
% the values must be set in the standard DEB units:
%   d for time; cm for length; J for energy; K for temperature

% reference parameter (not to be changed)
par.T_ref = C2K(20); free.T_ref = 0; units.T_ref = 'K';        label.T_ref = 'Reference temperature';

%% core primary parameters
par.z    = 4.2;      free.z     = 1;   units.z     = '-';        label.z     = 'zoom factor'; %for z = 1: L_m = 1 cm
par.F_m   = 6.5;       free.F_m   = 0;   units.F_m   = 'l/d.cm^2'; label.F_m   = '{F_m}, max spec searching rate';
par.kap_X = 0.8;       free.kap_X = 0;   units.kap_X = '-';        label.kap_X = 'digestion efficiency of food to reserve';
par.kap_P = 0.1;       free.kap_P = 0;   units.kap_P = '-';        label.kap_P = 'faecation efficiency of food to faeces';
par.v     = 0.22;    free.v     = 1;   units.v     = 'cm/d';     label.v     = 'energy conductance';
par.kap   = 0.6;      free.kap   = 1;   units.kap   = '-';        label.kap   = 'allocation fraction to soma';
par.kap_R = 0.95;      free.kap_R = 0;   units.kap_R = '-';        label.kap_R = 'reproduction efficiency';
par.p_M   = 92.51;     free.p_M   = 1;   units.p_M   = 'J/d.cm^3'; label.p_M   = '[p_M], vol-spec somatic maint';
par.p_T   =  0;        free.p_T   = 0;   units.p_T   = 'J/d.cm^2'; label.p_T   = '{p_T}, surf-spec somatic maint';
par.k_J   = 0.002;     free.k_J   = 0;   units.k_J   = '1/d';      label.k_J   = 'maturity maint rate coefficient';
par.E_G   = 5800;      free.E_G   = 1;   units.E_G   = 'J/cm^3';   label.E_G   = '[E_G], spec cost for structure';
%par.E_Hh = 0.1;        free.E_Hh  = 0;   units.E_Hh = 'J';         label.E_Hh = 'E_Hh';    % maturity at hatching
par.E_Hb  = 0.5 * 1.372e0;   free.E_Hb  = 1;   units.E_Hb  = 'J';        label.E_Hb  = 'maturity at birth';
par.E_Hj  = par.E_Hb * 1.001;   free.E_Hj  = 1;    units.E_Hj = 'J';         label.E_Hj  = 'maturity at metamorphosis';
par.E_Hp  = 1.928e2;   free.E_Hp  = 1;   units.E_Hp  = 'J';        label.E_Hp  = 'maturity at puberty';
par.h_a   = 1.184e-8;  free.h_a   = 1;   units.h_a   = '1/d^2';    label.h_a   = 'Weibull aging acceleration';
par.s_G   = 1e-4;      free.s_G   = 0;   units.s_G   = '-';        label.s_G   = 'Gompertz stress coefficient';

%% auxiliary parameters
par.T_A   = 7000;    free.T_A   = 0;    units.T_A = 'K';        label.T_A = 'Arrhenius temperature';
par.del_M = 0.16;    free.del_M = 1;    units.del_M = '-';      label.del_M = 'shape coefficient';
par.del_Mb = 0.16;   free.del_Mb = 1;   units.del_Mb = '-';     label.del_Mb = 'shape coefficient for larvae at birth (standard length)';
par.L_init_tE = 17;  free.L_init_tE = 0;  units.L_init_tE = 'cm';   label.L_init_tE = 'initial length for tE data set';

%% environmental parameters (temperatures are in data)
par.f = 0.8;           free.f     = 0;       units.f = '-';           label.f = 'scaled functional response for zero-variate data';          % scaled functional response for 0-var data
par.f_juv_pen = 0.8;   free.f_juv_pen  = 1;  units.f_juv_pen = '-';   label.f_juv_pen = 'scaled functional response for Peniche';    % scaled functional response for Peniche data
par.f_juv_lag = 0.8;   free.f_juv_lag  = 1;  units.f_juv_lag = '-';   label.f_juv_lag = 'scaled functional response for Lagoa de Obidos';    % scaled functional response for Lagoa de Obidos data
par.f_tL_larv = 0.8;   free.f_tL_larv  = 1;  units.f_tL_larv = '-';   label.f_tL_larv = 'scaled functional response for larvae';    % scaled functional response for 1-var data
par.f_tL_ad = 0.8;     free.f_tL_ad  = 1;    units.f_tL_ad = '-';     label.f_tL_ad = 'scaled functional response for female adults';    % scaled functional response for 1-var data
par.var_f_tL_ad = 0.2; free.var_f_tL_ad = 0; units.var_f_tL_ad = '-'; label. var_f_tL_ad = 'amplitude of f variation for tE dataset'; 
%% set chemical parameters from Kooy2010 
%  don't change these values, unless you have a good reason
[par, units, label, free] = addchem(par, units, label, free, metaData.phylum, metaData.class);

cPar = parscomp_st(par);
g1 = cPar.g; kap1 = par.kap;
xxx1 = (1 + par.f * cPar.w)^(1/3);

% chemical parameters are modified to fit water content data and energy
% density data from RosaGonz2010
par.d_E = 0.65;      free.d_E   = 0;    
par.d_V = 0.22;      free.d_V   = 0;
par.mu_E = 660e3;    free.mu_E  = 0;   
par.mu_V = 480e3;    free.mu_V  = 0;   

% to simplify things, we estimate w_E and w_V without modifying n_O
par.w_E = 19.9;       free.w_E = 0;      units.w_E = 'g/mol';   label.w_E = 'w_E';      % molecular weight of reserve
par.w_V = 23.9;       free.w_V = 0;      units.w_V = 'g/mol';   label.w_V = 'w_V';      % molecular weight of structure

par.kap = 0.65;
par.v = par.v * par.kap/ kap1;
kap2 = par.kap;
par.kap = 0.7;
par.E_G = par.E_G * par.kap/ kap2;

cPar = parscomp_st(par);
xxx2 = (1 + par.f * cPar.w)^(1/3);
par.del_M = par.del_M * xxx1/ xxx2;
par.del_Mb = par.del_Mb * xxx1/ xxx2;
par.z = par.z * xxx1/ xxx2;


%% Pack output:
txtPar.units = units; txtPar.label = label; par.free = free; 

