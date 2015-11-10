%% mydata_my_pet
% Sets referenced data

%%
function [data, auxData, metaData, txtData, weights] = mydata_Sardina_pilchardus 
  % created by Starrlight Augustine, Bas Kooijman, Dina Lika, Goncalo Marques and Laure Pecquerie 2015/03/31
  % last modified: 2015/07/28 
  
  %% Syntax
  % [data, auxData, metaData, txtData, weights] = <../mydata_my_pet.m *mydata_my_pet*>
  
  %% Description
  % Sets data, pseudodata, metadata, auxdata, explanatory text, weights coefficients.
  % Meant to be a template in add-my-pet
  %
  % Output
  %
  % * data: structure with data
  % * auxData: structure with auxilliairy information concerning the data
  %   (temperature, food, initial size of organisms etc.). auxData is
  %   unpacked in predict and the user needs to construct predictions
  %   accordingly.
  % * txtData: text vector for the presentation of results
  % * metaData: structure with info about this entry
  % * weights: structure with weights for each data set
  
  %% To do (remove these remarks after editing this file)
  % * copy this template; replace 'my_pet' by the name of your species (Genus_species)
  % * fill in metaData fields with the proper information
  % * insert references for each data (an example is given), for multiple references, please use commas to separate references
  % * edit real data; remove all data that to not belong to your pet
  % * list facts - this is where you can add relevant/interesting information on its biology
  % * edit discussion concerning e.g. choice of model, assumptions needed to model certain data sets etc. 
  % * fill in all of the references

%% set metaData

metaData.phylum     = 'Chordata'; 
metaData.class      = 'Actinopterygii'; 
metaData.order      = 'Clupeiformes'; 
metaData.family     = 'Clupeidae';
metaData.species    = 'Sardina_pilchardus'; 
metaData.species_en = 'European pilchard'; 
metaData.T_typical  = C2K(15); % K, body temp
metaData.data_0     = {'ab'; 'ap'; 'am'; 'Lb'; 'Lj'; 'Lp'; 'Li'; 'Wwb'; 'Wwp'; 'Wwi'; 'Ri'; 'Wd0'; 'E0'}; % tags for different types of zero-variate data
metaData.data_1     = {'t-L'; 'L-W'}; % tags for different types of uni-variate data

metaData.COMPLETE = 2.5; % using criteria of LikaKear2011

metaData.author   = {'Cristina Nunes, Gonçalo M. Marques, Tânia Sousa, Bas Kooijman'};                              % put names as authors as separate strings:  {'author1','author2'} , with corresponding author in first place 
metaData.date_acc = [2013 08 26];                             % [year month day], date of entry is accepted into collection
metaData.email    = {'cnunes@ipma.pt'};                   % e-mail of corresponding author
metaData.address  = {'IPMA, Lisbon, Portugal'};        % affiliation, postcode, country of the corresponding author

% uncomment and fill in the following fields when the entry is updated:
 metaData.author_mod_1  = {'Laure Pecquerie, Gonçalo M. Marques' };          % put names as authors as separate strings:  {'author1','author2'} , with corresponding author in first place 
 metaData.date_mod_1    = [2015 08 24];                      % [year month day], date modified entry is accepted into the collection
 metaData.email_mod_1   = {'laure.pecquerie@ird.fr'};            % e-mail of corresponding author
 metaData.address_mod_1 = {'IRD/LEMAR, 29280, Plouzané, France'}; % affiliation, postcode, country of the corresponding author

% for curators only ------------------------------
% metaData.curator     = {'FirstName LastName'};
% metaData.email_cur   = {'myname@myuniv.univ'}; 
% metaData.date_acc    = [2015 04 22]; 
%-------------------------------------------------

%% set data
% zero-variate data;
% typically depend on scaled functional response f.
% here assumed to be equal for all real data; the value of f is specified in pars_init_my_pet.
% add an optional comment structure to give any additional explanations on
% how the value was chosen, see the last column of the ab data set for an
% example

% age 0 is at onset of embryo development
data.ah = 2.5;      units.ah = 'd';    label.ah = 'age at hatching';  bibkey.ab = 'Mene2003';   comment.ab  = 'ab = 2-3 days'; 
  temp.ah = C2K(15);  units.temp.ah = 'K'; label.temp.ah = 'temperature';
data.ab = 8;      units.ab = 'd';    label.ab = 'age at birth';  bibkey.ab = 'Mene2003';   comment.ab  = 'ab = ah + 4d - Mene2003'; 
  temp.ab = C2K(15);  units.temp.ab = 'K'; label.temp.ab = 'temperature';
data.aj = 100; units.aj = 'd';    label.aj = 'age at metamorphosis';  bibkey.aj = 'Laure guess';   comment.aj  = 'we need to constrain a_j, I guess a 4cm sardine at 15degC could be 100 days'; 
  temp.aj = C2K(15);  units.temp.aj = 'K'; label.temp.aj = 'temperature';
data.ap = 365;     units.ap = 'd';    label.ap = 'age at puberty'; bibkey.ap = 'Guessed';
  temp.ap = C2K(15);  units.temp.ap = 'K'; label.temp.ap = 'temperature';
data.am = 8 * 365;     units.am = 'd';    label.am = 'life span';     bibkey.am = 'Guessed';   
  temp.am = C2K(15);  units.temp.am = 'K'; label.temp.am = 'temperature'; 
data.Lb  = 0.5;   units.Lb  = 'cm';   label.Lb  = 'standard length at birth';    bibkey.Lb  = 'Mene2003';  
data.Lj  = 4;    units.Lj  = 'cm';   label.Lj  = 'standard length at metamorphosis';    bibkey.Lj  = 'ReMene2009'; %[LAURE : see Cristina]
data.Lp  = 13;   units.Lp  = 'cm';   label.Lp  = 'total length at puberty';      bibkey.Lp  = 'Guessed'; % for multiple references, please use commas to separate references
data.Li  = 23.8;   units.Li  = 'cm';   label.Li  = 'ultimate total length';      bibkey.Li  = 'Fishbase';
data.Wwb = 2.5e-4; units.Wwb = 'g';    label.Wwb = 'wet weight at birth';        bibkey.Wwb = 'Anon2015';
data.Wwp = 20;   units.Wwp = 'g';    label.Wwp = 'wet weight at puberty';      bibkey.Wwp = 'Anon2015';
data.Wwi = 112;   units.Wwi = 'g';    label.Wwi = 'ultimate wet weight';        bibkey.Wwi = 'Fishbase';
data.Ri  = 1035;    units.Ri  = '#/d';  label.Ri  = 'maximum reprod rate';        bibkey.Ri  = 'Guessed';   
comment.Ri = [' for an individual of ultimate length Li, 8-9 months of spawning season (8.5)'...
   'a spawning event every 12-15 days (13.5), a maximum of 45000 eggs at the peak;'...
   '((8.5*30/13.5)*45000)/365 = 2329 eggs/day ~ 2300 eggs/day;'...
   'let us suppose the peak the average is 1/2 of the peak and we have Ri = 1150;'...
   'for f = 0.9. guess Ri = 1150 * 0.9 = 1035 '];
  temp.Ri = C2K(15);  units.temp.Ri = 'K'; label.temp.Ri = 'temperature';
data.Wd0 = 3e-5;  units.Wd0 = 'g';    label.Wd0 = 'egg dry weight';    bibkey.Wd0 = 'Nunes2015' ;
comment.Wd0 = '18 to 40 microg dry weight - see Cristina Nunes for ref';
data.E0 = data.Wd0 * 29e3;  units.E0 = 'J';    label.E0 = 'egg energy content';    bibkey.E0 = {'Lask1962','Nunes2015'} ;
comment.E0 = 'Energy density of an egg between 20 and 30kJ /g dry weight in Kalmer 2005';
%% !! should be consistent with <E> = mu_E/w_E
  
% uni-variate data

% uni-variate data
%------------------
% Mene2003 - Chap. 5
% t time since start of otolith formation. days
%   otolith ring deposition starts after the absortion of the yolk/vitelline sac
%   this corresponds to birth in DEB 

% Peniche. spring 89 
% data extracted from figures in Mene2003 ; figs 3 and 6 in Chap. 5
data.tL_juv1 = [186.97	10.98;
           188.10	10.76;
           195.10	10.68;
           196.00	10.99;
           215.07	11.48;
           221.06	11.24;
           227.04	11.29;
           229.07	11.73;
           239.00	12.01;
           241.03	11.63;
           243.07	11.88;
           248.14	11.86;];
%tL_juv1 = [tL_juv1, 10./tL_juv1(:,2).^2];      % append weight coefficients for WLS criterion
data.tL_juv1(:,1) = data.ab + data.tL_juv1(:,1);  % tranforming otolith age into organism age
% % [LAURE : current thoughts : we should not add ab as we mention in the
% label that it is time since birth?
% [LAURE : are we sure it's similar T between ab and tL-juv?] ? 
units.tL_juv1 = {'d', 'cm'};     label.tL_juv1 = {'time since birth', 'standard length'};  bibkey.tL_juv1 = 'Mene2003';
%   temp.tL_juv1 = T_C + 15;  % K, temperature [LAURE: which temp? should we set it as a parameter?]
  temp.tL_juv1 = C2K(15); units.temp.tL_juv1 = 'K'; label.temp.tL_juv1 = 'temperature';  % K, temperature [LAURE: which temp? should we set it as a parameter?]

% Peniche. winter 89 
data.tL_juv2 = [125.01	8.68
           125.57	8.39
           139.00	9.25
           142.05	9.07
           143.07	8.76
           145.1	9.35
           148.03	9.64
           149.05	8.94
           150.51	8.54
           152.09	8.44
           152.55	9.58
           152.88	10.13
           153.00	9.5
           155.03	9.07
           156.61	9.95
           157.96	9.23
           158.08	8.62
           158.09	9.85
           158.53	8.83
           158.64	9.18
           159.43	9.8
           159.66	9.54
           162.03	8.54
           163.04	9.76
           165.41	9.54
           166.88	9.98
           167.67	10.08
           168.23	9.52
           168.24	10.08
           169.25	9.96
           172.52	9.51
           173.09	9.48
           173.54	9.95
           173.99	9.28
           174.78	9.7
           176.81	9.54
           177.04	9.87
           178.62	9.72
           180.09	9.43
           180.76	9.98
           180.99	9.34
           182.12	10
           189.00	10.05
           189.12	9.22
           189.91	9.91
           190.70	9.73
           192.05	10.94
           192.95	9.51
           193.52	10.37
           193.63	9.42
           194.19	9.77
           194.98	10.79
           195.44	9.85
           195.55	10.02
           196.45	9.59
           197.24	9.77
           198.03	10.17
           198.93	9.62
           199.05	10.47
           203.00	10.63
           203.56	11.24
           206.05	10.76
           209.09	9.76
           214.96	10.07
           217.56	11.22
           219.02	10.47
           219.03	11.51
           220.27	10.71
           221.96	11.66
           239.00	10.5
           240.92	10.2
           243.97	10.66
           252.09	11.5
           261.69	11.7
           263.04	12.45
           273.31	11.57];
%tL_juv2 = [tL_juv2, 10./tL_juv2(:,2).^2];      % append weight coefficients for WLS criterion
data.tL_juv2(:,1) = data.ab + data.tL_juv2(:,1);  % tranforming otolith age into organism age
units.tL_juv2 = {'d', 'cm'};     label.tL_juv2 = {'time since birth', 'standard length'};  bibkey.tL_juv2 = 'Mene2003';
  temp.tL_juv2 = C2K(13);  units.temp.tL_juv2 = 'K'; label.temp.tL_juv2 = 'temperature';% K, temperature [LAURE: which temp? should we set it as a parameter?]

% Peniche. spring 90 
data.tL_juv3 = [145.10	9.14
           145.55	9.56
           156.95	9.54
           158.87	9.77
           160.11	10.24
           160.56	9.68
           164.06	9.86
           164.07	9.41
           165.53	10.07
           170.49	9.80
           171.96	10.37
           174.44	9.50
           175.12	10.99
           177.49	10.07
           178.96	9.95
           185.95	10.79
           186.07	10.41
           188.10	11.00
           194.98	10.91
           197.58	10.11
           205.14	11.57
           210.56	10.45
           215.07	10.54
           215.08	11.53
           223.09	11.96
           243.52	12.31];
%tL_juv3 = [tL_juv3, 10./tL_juv3(:,2).^2];      % append weight coefficients for WLS criterion
data.tL_juv3(:,1) = data.ab + data.tL_juv3(:,1);  % tranforming otolith age into organism age
% LAURE : are we sure it's similar T ? 
units.tL_juv3 = {'d', 'cm'};     label.tL_juv3 = {'time since birth', 'standard length'};  bibkey.tL_juv3 = 'Mene2003';
  temp.tL_juv3 = C2K(15);  units.temp.tL_juv3 = 'K'; label.temp.tL_juv3 = 'temperature';% K, temperature [LAURE: which temp? should we set it as a parameter?]

% Lagoa de Óbidos. summer 89 
data.tL_juv4 = [69.63	3.87
           70.04	4.50
           71.40	4.37
           72.95	4.98
           72.96	5.02
           74.83	4.58
           74.98	4.05
           75.97	4.17
           75.98	4.89
           76.96	4.93
           78.98	5.44
           81.01	4.40
           81.17	4.87
           84.49	5.18
           85.01	5.51
           86.47	5.39
           87.46	5.18
           87.47	5.22
           89.02	5.13
           90.37	5.51
           90.94	5.52
           91.98	5.14
           92.08	5.00
           92.50	5.49
           92.51	5.54
           93.85	5.62
           94.00	5.91
           94.99	5.70
           95.20	5.53
           95.51	5.48
           95.98	4.93
           97.49	6.25
           98.47	5.51
           98.94	5.53
           101.02	5.68
           101.44	5.98
           101.75	6.04
           101.96	5.56
           104.97	6.17
           104.98	6.25
           106.95	5.80
           107.21	5.56
           107.36	5.86
           107.52	6.24
           107.57	6.13
           111.88	6.32
           112.04	6.20
           114.01	5.99
           114.48	6.28
           114.53	5.95
           115.00	5.62
           115.99	5.44
           118.48	6.37
           118.54	5.72
           121.97	5.80
           121.98	6.45
           122.49	6.41
           123.94	6.33];
%data.tL_juv4 = [tL_juv4, 10./tL_juv4(:,2).^2];      % append weight coefficients for WLS criterion
data.tL_juv4(:,1) = data.ab + data.tL_juv4(:,1);  % tranforming otolith age into organism age
units.tL_juv4 = {'d', 'cm'};     label.tL_juv4 = {'time since birth', 'standard length'};  bibkey.tL_juv4 = 'Mene2003';
  temp.tL_juv4 = C2K(23); units.temp.tL_juv4 = 'K'; label.temp.tL_juv4 = 'temperature'; % K, temperature [LAURE: which temp? should we set it as a parameter?]


% Lagoa de Óbidos. spring 90 % LAURE: temp should be checked

data.tL_juv5 = [42.97	3.27
           45.93	3.12
           49.98	3.37
           50.97	3.53
           52.53	3.24
           57.00	3.42
           60.48	3.54
           60.49	3.42
           60.95	3.51
           62.46	3.65
           78.00	5.37
           78.52	5.39
           88.70	5.16
           90.00	5.81
           91.46	5.48
           94.94	5.65
           95.46	5.53
           97.43	6.32
           99.25	6.03
           108.45	6.84
           115.47	6.53
           119.00	6.51];
%tL_juv5 = [tL_juv5, 10./tL_juv5(:,2).^2];      % append weight coefficients for WLS criterion
data.tL_juv5(:,1) = data.ab + data.tL_juv5(:,1);  % tranforming otolith age into organism age
units.tL_juv5 = {'d', 'cm'};     label.tL_juv5 = {'time since birth', 'standard length'};  bibkey.tL_juv5 = 'Mene2003';
  temp.tL_juv5 = C2K(18);  units.temp.tL_juv5 = 'K'; label.temp.tL_juv5 = 'temperature';% K, temperature [LAURE: which temp? should we set it as a parameter?]

% Lagoa de Óbidos. summer 90 % temp should be checked

data.tL_juv6 = [61.94	3.99
           62.82	3.96
           66.46	4.03
           67.76	4.29
           68.43	4.01
           69.47	4.06
           72.95	4.81
           72.96	3.93
           73.99	4.22
           76.02	4.35
           78.98	4.29
           80.49	4.45
           80.96	4.68
           81.95	4.74
           81.96	4.51
           82.47	4.19
           83.51	5.03
           85.48	4.41
           88.03	4.78
           88.04	4.94
           88.96	5.32
           90.83	4.98
           90.89	4.80
           91.56	5.00
           91.87	4.81
           92.08	4.93
           92.91	5.12
           93.02	4.78
           93.48	4.65
           94.00	5.08
           94.94	4.86
           94.95	4.76
           95.46	5.04
           97.49	5.04
           98.53	4.96
           98.99	4.86
           100.50	5.28
           100.97	5.16
           101.02	5.05
           101.07	5.24
           103.00	5.40
           103.05	5.30
           103.52	5.49
           104.97	5.04
           104.98	5.00];
%tL_juv6 = [tL_juv6, 10./tL_juv6(:,2).^2];      % append weight coefficients for WLS criterion
data.tL_juv6(:,1) = data.ab + data.tL_juv6(:,1);  % tranforming otolith age into organism age
units.tL_juv6 = {'d', 'cm'};     label.tL_juv6 = {'time since birth', 'standard length'};  bibkey.tL_juv6 = 'Mene2003';
  temp.tL_juv6 = C2K(23); units.temp.tL_juv6 = 'K'; label.temp.tL_juv6 = 'temperature'; % K, temperature [LAURE: which temp? should we set it as a parameter?]

% Larval data - fig. 7c in Mene2003

data.tL_larv = [4.03     6.00 % 4 days is the average age at first feeding (absorption of yolk sac) since hatching
           4.50 	8.00
           7.01 	7.98
           8.01     8.51
           8.52     12.00
           8.99     11.01
           9.01 	7.98
           10.01	10.02
           11.51	12.00
           11.511	11.52
           11.512	10.02
           12.01	12.99
           12.50	12.00
           12.501	10.99
           13.00	12.48
           13.001	14.00
           13.02	9.01
           13.021	12.99
           13.51	14.00
           13.511	13.01
           14.01	13.01
           14.011	14.00
           14.012	14.51
           14.51	14.96
           14.511	14.00
           15.00	14.00
           15.001	13.01
           15.51	12.99
           15.99	14.51
           15.991	14.99
           16.01	13.01
           16.011	12.00
           17.00	14.53
           17.51	16.00
           17.511	14.00
           17.512	13.49
           17.99	16.00
           17.991	14.99
           17.992	14.51
           17.993	14.00
           17.994	13.49
           17.995	12.99
           18.50	18.00
           18.501	16.00
           18.502	14.48
           18.98	18.77
           18.981	16.48
           18.982	14.00
           18.983	12.99
           19.49	15.49
           19.99	18.02
           19.991	18.80
           21.00	16.99
           21.001	14.51
           21.50	17.49
           21.501	16.00
           21.99	15.49
           23.01	16.51
           23.50	16.00
           24.51	18.00
           26.52	18.02
           26.98	20.02
           27.50	22.00
           28.49	20.55
           30.99	22.00
           31.99	25.04
           33.48	25.04
           36.98	25.01];
data.tL_larv(:,2) = data.tL_larv(:,2)/10;  % converting mm to cm 
%tL_larv = [tL_larv, 1./tL_larv(:,2).^2];      % append weight coefficients for WLS criterion
units.tL_larv = {'d', 'cm'};     label.tL_larv = {'time since birth', 'standard length'};  bibkey.tL_larv = 'Mene2003';
  temp.tL_larv = C2K(15); units.temp.tL_larv = 'K'; label.temp.tL_larv = 'temperature'; % K, temperature [LAURE: which temp? should we set it as a parameter?]
% [LAURE : should we add data.ab as in the previous dataset?]

% adult female average data 2000-2005
data.tL_ad_f = [1.00	14.42
           2.00	18.23
           3.00	20.08
           4.00	20.96
           5.00	21.40
           6.00	21.61];
data.tL_ad_f(:,1) = data.tL_ad_f(:,1)*365;  % converting years to days 
%tL_ad_f = [tL_ad_f, 100./tL_ad_f(:,2).^2];      % append weight coefficients for WLS criterion
units.tL_ad_f = {'d', 'cm'};     label.tL_ad_f = {'time since birth', 'total length'};  bibkey.tL_ad_f = 'SilvCarr2008';
  temp.tL_ad_f = C2K(15);  units.temp.tL_ad_f = 'K'; label.temp.tL_ad_f = 'temperature';% K, temperature [LAURE: which temp? should we set it as a parameter?]

% adult male average data [LAURE : bibkey, temp]
%data.tL_ad_m = [1.00	14.38
%            2.00	17.98
%            3.00	19.73
%            4.00	20.56
%            5.00	20.97
%            6.00	21.15];
% data.tL_ad_m(:,1) = data.tL_ad_m(:,1)*365;  % converting years to days 
%tL_ad_m = [tL_ad_m, 100./tL_ad_m(:,2).^2];      % append weight coefficients for WLS criterion
% units.tL_ad_m = {'d', 'cm'};     label.tL_ad_m = {'time since birth', 'total length'};  bibkey.tL_ad_m = '';
%   temp.tL_ad_m = C2K(15); units.temp.tL_ad_m = 'K'; label.temp.tL_ad_m = 'temperature'; % K, temperature [LAURE: which temp? should we set it as a parameter?]

% Lagoa de Óbidos. summer 89 

data.LW_juv4 = [3.8446	0.57421875
           4.0465	0.734375
           4.1635	0.7734375
           4.3654	0.92578125
           4.3974	0.97265625
           4.4038	0.9375
           4.4952	0.9296875
           4.5641	1.08984375
           4.6154	1.0078125
           4.8654	1.1640625
           4.9151	1.12109375
           4.9152	1.16015625
           4.9984	1.08203125
           5.0144	1.43359375
           5.0337	1.359375
           5.0481	1.59765625
           5.0673	1.48046875
           5.0674	1.55078125
           5.1137	1.51953125
           5.1154	1.28125
           5.1651	1.6328125
           5.1827	1.44140625
           5.2003	1.31640625
           5.2163	1.51953125
           5.2163	1.6015625
           5.234	1.5859375
           5.266	1.4765625
           5.3157	1.59375
           5.3173	1.79296875
           5.3174	1.75390625
           5.3494	1.71875
           5.351	1.66796875
           5.3653	1.90625
           5.3814	1.7890625
           5.3846	1.62890625
           5.4006	1.8359375
           5.4167	1.5625
           5.4295	1.76953125
           5.4327	1.4765625
           5.4328	1.7109375
           5.4535	1.7890625
           5.4663	1.72265625
           5.4679	1.66796875
           5.4856	1.765625
           5.4952	1.7265625
           5.4984	1.78125
           5.5      2.02734375
           5.5016	1.91015625
           5.516	1.75390625
           5.5176	1.828125
           5.5321	1.71484375
           5.5337	1.7890625
           5.5338	1.94140625
           5.5513	1.71484375
           5.5657	1.98828125
           5.5658	1.83984375
           5.5801	2.06640625
           5.5817	1.94921875
           5.601	2.18359375
           5.6011	1.8359375
           5.617	2.2265625
           5.6171	1.796875
           5.6172	1.95703125
           5.6186	2.3828125
           5.6202	2.1015625
           5.6346	1.7578125
           5.6362	1.91015625
           5.6506	1.8359375
           5.6651	1.98046875
           5.6683	1.94921875
           5.6731	2.0234375
           5.6875	1.98046875
           5.7163	2.3046875
           5.7196	2.14453125
           5.734	1.7890625
           5.7516	2.01953125
           5.7676	2.30078125
           5.7677	1.515625
           5.7678	2.421875
           5.7837	2.03515625
           5.7838	1.9765625
           5.7853	2.3828125
           5.7997	2.18359375
           5.8029	2.1015625
           5.8189	2.3828125
           5.819	2.265625
           5.8237	2.1171875
           5.8349	2.26171875
           5.8526	1.66796875
           5.8702	2.1875
           5.8702	2.30859375
           5.9022	2.4609375
           5.9151	2.421875
           5.9167	2.265625
           5.9343	2.2421875
           5.9519	2.4140625
           5.952	2.45703125
           5.9679	2.65234375
           5.9696	2.57421875
           5.9824	2.62109375
           5.9856	2.41796875
           5.9857	2.18359375
           6.0353	2.6484375
           6.0354	2.69921875
           6.0355	2.7734375
           6.0356	2.85546875
           6.0529	2.89453125
           6.053	2.453125
           6.0849	2.5
           6.1186	2.53515625
           6.1187	2.58203125
           6.1188	2.69921875
           6.1346	2.890625
           6.1683	2.5
           6.1699	2.96875
           6.1859	2.6953125
           6.189	2.61328125
           6.1875	3.05078125
           6.1876	2.890625
           6.2019	2.77734375
           6.202	2.421875
           6.2212	2.65625
           6.234	2.578125
           6.2356	2.734375
           6.2357	2.85546875
           6.2372	2.33984375
           6.2532	2.57421875
           6.2548	2.8125
           6.266	2.85546875
           6.2692	3.015625
           6.2724	2.58203125
           6.2725	2.7421875
           6.2869	2.265625
           6.287	2.84765625
           6.2871	2.92578125
           6.2872	2.96875
           6.2885	2.77734375
           6.2886	2.65625
           6.3029	2.58203125
           6.3173	2.921875
           6.3189	2.5390625
           6.3205	2.265625
           6.3206	2.8515625
           6.3221	2.65625
           6.3365	2.578125
           6.3366	3.0234375
           6.3381	2.5
           6.3686	3.01171875
           6.3686	3.0859375
           6.3878	2.77734375
           6.4038	2.9296875
           6.4551	3.0546875
           6.4872	2.8515625
           6.4873	2.7734375
           6.4874	3.0859375
           6.5384	2.8125
           6.5385	2.77734375
           6.5386	3.0546875
           6.5387	2.97265625
           6.5528	2.8125
           6.5545	3.20703125
           6.5849	3.08984375
           6.6378	3.16796875
           6.6379	3.40234375
           6.6875	3.51953125
           6.7212	3.125
           6.7885	3.25
           6.8718	3.6015625
           6.9728	3.2890625
           7.0417	3.875
           7.0737	3.72265625
           7.141	4.11328125
           7.1411	3.98828125
           7.1747	3.79296875
           7.2917	3.43359375
           7.3413	3.7578125];
 units.LW_juv4 = {'cm', 'g'};     label.LW_juv4 = {'total length', 'wet weight'};  bibkey.LW_juv4 = 'Mene2003';
  temp.LW_juv4= temp.tL_juv4;  units.temp.LW_juv4 = 'K'; label.temp.LW_juv4 = 'temperature';% K, temperature [LAURE: which temp? should we set it as a parameter?]


% Lagoa de Óbidos. spring 90 

data.LW_juv5 = [3.1266	0.21875
           3.2099	0.296875
           3.2596	0.33203125
           3.2597	0.2578125
           3.3109	0.30078125
           3.3446	0.30078125
           3.3798	0.37109375
           3.3814	0.33984375
           3.4263	0.375
           3.4615	0.4140625
           3.5096	0.41015625
           3.5304	0.34375
           3.5449	0.453125
           3.6458	0.49609375
           4.399	0.8515625
           5.0673	1.31640625
           5.3333	1.47265625
           5.351	1.5546875
           6.0385	2.109375
           6.1378	2.77734375
           6.3381	2.96875
           6.5401	2.9296875
           6.5402	3
           6.8558	3.4453125];
units.LW_juv5 = {'cm', 'g'};     label.LW_juv5 = {'total length', 'wet weight'};  bibkey.LW_juv5 = 'Mene2003';
  temp.LW_juv5= temp.tL_juv5; units.temp.LW_juv5 = 'K'; label.temp.LW_juv5 = 'temperature'; % K, temperature [LAURE: which temp? should we set it as a parameter?]

% Lagoa de Óbidos. summer 90 

data.LW_juv6 = [3.9792	0.77734375
           4.2804	1.00390625
           4.2837	0.84765625
           4.2981	0.96484375
           4.3974	1.1640625
           4.3975	1.08203125
           4.4824	1.0859375
           4.5417	1.15625
           4.5481	1.1953125
           4.5657	1.23828125
           4.5658	1.19140625
           4.601	1.16796875
           4.6011	1.12109375
           4.6138	1.28515625
           4.617	1.12109375
           4.6314	1.08203125
           4.6315	1.2421875
           4.649	1.1640625
           4.6491	1.28515625
           4.6635	1.23046875
           4.6651	1.3203125
           4.6652	1.26171875
           4.6683	1.19921875
           4.6907	1.25390625
           4.6955	1.31640625
           4.7067	1.27734375
           4.7131	1.36328125
           4.7324	1.1953125
           4.7484	1.36328125
           4.7628	1.2890625
           4.7644	1.43359375
           4.7645	1.2265625
           4.766	1.37109375
           4.7981	1.2421875
           4.7982	1.38671875
           4.7983	1.328125
           4.8141	1.43359375
           4.8157	1.31640625
           4.8221	1.3984375
           4.8462	1.3671875
           4.851	1.43359375
           4.8654	1.4765625
           4.8654	1.328125
           4.8655	1.24609375
           4.9151	1.3671875
           4.9167	1.2890625
           4.9327	1.28125
           4.9503	1.515625
           4.96 	1.42578125
           4.9647	1.48046875
           4.984	1.6328125
           4.9984	1.35546875
           5.0016	1.5546875
           5.016	1.58984375
           5.0176	1.53125
           5.0337	1.4296875
           5.0481	1.546875
           5.0625	1.51953125
           5.1154	1.6328125
           5.234	1.7109375
           5.3013	1.6796875];
units.LW_juv6 = {'cm', 'g'};     label.LW_juv6 = {'total length', 'wet weight'};  bibkey.LW_juv6 = 'Mene2003';
  temp.LW_juv6= temp.tL_juv6; units.temp.LW_juv6 = 'K'; label.temp.LW_juv6 = 'temperature'; % K, temperature [LAURE: which temp? should we set it as a parameter?]


% Catchment 2002-2011 
%    length(cm)  tot_weight(g)	gon_weight(g)
LW_ad   = [ 12.2    14      0.63
            13.0    16      1.24
            13.0	17      0.68
            13.4	17      0.7
            13.5	17      0.73
            13.2	18      0.93
            13.2	18      0.93
            13.5	18      1.17
            13.5	18      1.04
            13.6	18      1.72
            13.4	19      1.78
            13.4	19      1.15
            13.4	19      1.07
            13.5	19      1.3
            13.5	19      1.25
            13.5	19      1.05
            13.5	19      1.05
            13.7	19      1.13
            13.9	19      0.92
            13.0	20      1.65
            13.4	20      3.61
            13.5	20      2.14
            13.6	20      1.66
            13.6	20      1.5
            13.7	20      1.77
            13.7	20      1.25
            13.9	20      2.35
            14.0	20      2.49
            14.0	20      1.88
            14.0	20      1.63
            14.0	20      1.46
            14.1	20.1	2.34
            13.8	21      2.1
            13.9	21      2.54
            13.9	21      1.31
            13.9	21      1.15
            14.0	21      2.6
            14.0	21      1.94
            14.0	21      1.69
            14.2	21      1.78
            14.3	21      1.58
            14.4	21      1.64
            14.2	21.4	1.69
            13.7	22      1.24
            14.0	22      3.59
            14.2	22      2.3
            14.3	22      4.03
            14.3	22.3	2.42
            14.3	23      2.84
            14.4	23      1.62
            14.4	23      1.15
            14.7	23      2.11
            14.8	23.2	2.07
            14.3	24      2.59
            14.7	25      2.76
            15.1	25      2.55
            14.8	26      3.62
            14.8	26      3.57
            14.8	27      3.98
            14.9	27      3.87
            15.2	27      3.36
            15.4	27      4.25
            15.0	28      3.51
            15.2	28      5.09
            15.4	28      3.99
            15.4	28      3.85
            15.5	28      3.36
            15.1	29      3.21
            15.2	29      4.78
            15.3	29      4.51
            15.4	29      3.44
            15.6	29      2.84
            15.7	29      3.16
            15.7	30      4.52
            16.0	30      3.19
            15.3	31      5.65
            15.6	31      2.7
            15.7	31      3.47
            15.8	31      5.2
            15.8	31      4.92
            15.9	31      5.49
            15.9	31      4.75
            15.9	31      3.69
            15.9	31      3
            15.6	32      5.38
            15.9	32      6.17
            16.0	32      3.51
            16.1	32      5.11
            16.2	32      1.76
            15.8	33      6.06
            15.8	33      4.66
            16.2	33      3.43
            16.6	33      3.32
            16.9	33      3.43
            19.5	33      7.73
            16.1	33.3	3.27
            16.5	34      4.1
            15.8	35      4.54
            16.0	35      4.74
            16.2	35      6.14
            16.2	35      3.02
            16.5	35      3.48
            16.6	35      3.36
            17.0	35.8	3.55
            15.9	36      5.19
            16.0	36      5.6
            16.2	36      5.43
            16.2	36      3
            16.2	36      2.56
            16.3	36      3.51
            16.6	36      5.88
            16.7	36      3.85
            16.7	36      3.22
            17.0	36      4.55
            16.6	37      5.9
            16.7	37      4.95
            16.2	38      4.24
            16.9	38      4.61
            17.0	38      5.17
            17.1	38      3.99
            17.4	38      4.19
            16.1	39      5.36
            16.1	39      3.1
            16.6	39      5.53
            16.9	39      4.56
            16.9	39      3.67
            17.0	39      6.18
            18.2	39      6.42
            16.6	40      4.93
            17.0	40      3.17
            17.4	40      5.59
            17.5	40.5	4.07
            16.5	41      5.39
            16.8	41      6.72
            16.9	41      5.7
            17.1	41      5.58
            17.1	41      4.32
            17.3	41      5.47
            17.5	41      9.31
            17.6	41      4.57
            18.0	41.6	3.15
            16.4	42      6.53
            16.6	42      4.59
            17.1	42      5.42
            17.7	42      3.15
            16.8	43      6.94
            16.8	43      6.44
            17.1	43      5.62
            17.1	43      4.79
            17.2	43      5.68
            17.3	43      6.04
            17.5	43      5.18
            17.9	43      5.6
            17.9	43      4.54
            18.9	43      8.2
            17.5	44      5.19
            17.6	44      6.22
            17.3	45      7.04
            17.4	45      6.51
            17.4	45      6.46
            17.4	45      5.04
            17.6	45      6.49
            18.3	45      3.99
            19.5	45      6.56
            17.4	46      6.62
            17.9	46      6.07
            18.4	46      4.95
            19.7	46     10.12
            17.4	47      5.8
            17.6	47      5.89
            19.7	47     10.29
            18.5	47.7	5
            17.7	48      7.06
            17.8	48      5.82
            19.5	48     10.42
            19.7	48      7.38
            18.6	48.1	3.01
            17.3	49      6.77
            17.8	49      6.91
            17.9	49      7.78
            18.0	49      6.04
            18.4	49      5.13
            17.3	50      8.75
            18.6	50      5.92
            20.5	50      8.44
            21.1	50     13.63
            17.6	51      8.47
            17.7	51      8.91
            17.9	51      8.49
            18.2	51      9.25
            18.9	51      6.59
            19.2	51      3.99
            19.5	51      5.27
            20.2	51      9.81
            20.4	51      9.42
            18.0	52      9.93
            18.1	52      7.28
            19.5	52      3.87
            19.4	52.9	4.51
            19.0	53      6.74
            19.3	53      5.76
            18.3	54      8.27
            19.0	54      8.05
            19.0	54      6.13
            19.4	54      6.62
            19.7	54      7
            19.9	54      5.74
            19.2	55      6.49
            19.3	55      7.57
            19.3	55      7.06
            19.6	55      7.16
            20.1	55      8.36
            19.9	55.8	4.39
            17.9	56      7.47
            19.0	56      7.67
            19.3	56      9.14
            19.6	56      7.28
            18.9	57      8.11
            19.4	57      8.12
            19.5	57      6.72
            19.6	57      7.16
            20.5	57      9.11
            21.3	57     16.05
            20.0	57.9	7.06
            19.3	58      7.83
            19.5	58      6.81
            19.6	58      7.26
            19.8	58      7.77
            19.9	58      9.79
            20.0	58.9	6.3
            19.0	59      9.13
            19.1	59     10.55
            19.9	59      9.38
            19.9	59      8.5
            19.3	60      7.88
            19.5	60      7.48
            19.7	60     10.03
            21.0	60.5	3.93
            19.6	61      5.94
            20.2	61      8.94
            20.2	61      7.62
            20.3	61      6.38
            20.5	61      8.9
            21.0	61      6.23
            21.6	61     10.14
            19.5	62      9.14
            19.7	62      9.08
            19.7	62      8.55
            19.9	62      8.22
            20.0	63      7.24
            20.2	63      9.17
            20.5	63      8.69
            20.6	63      6.11
            21.5	63     15.61
            20.5	63.1	4.59
            20.8	63.8	5.89
            20.0	64      7.88
            20.1	64      9.68
            20.1	64      8.24
            20.2	64     12.56
            20.2	64      6.88
            20.3	64      9.82
            20.3	64      8.17
            20.4	64      7.14
            20.4	64      6.91
            20.4	64.3	6.23
            19.6	65     11.36
            20.3	65      8.69
            20.4	65      8.92
            20.5	65     11.09
            20.9	65.3	6.85
            19.8	66     12.32
            20.1	66      8.92
            20.1	66      8.75
            20.3	66      9.68
            20.7	66      7.35
            21.9	66     11.4
            20.3	67      6.86
            20.5	67      9.08
            20.5	67      8.58
            20.7	67      7.83
            19.6	68     11.55
            19.8	68     14.36
            19.8	68     11.36
            20.2	68     11.85
            20.3	68     12.13
            20.6	68      6.84
            21.0	68      9.7
            21.2	68      7.87
            21.2	68      6.73
            21.7	68      9.07
            20.4	69      9.87
            21.0	69      6.96
            21.4	69      8.17
            21.5	69      6.42
            20.6	70      6.86
            20.7	70      8.61
            21.0	70      8.63
            20.3	71     13.85
            20.3	71     10.85
            20.6	71     12.18
            21.2	71     10.77
            21.3	71      9.42
            21.3	71      5.36
            20.5	72     10.34
            20.8	72      9.67
            20.9	72     11.59
            20.2	73     11.54
            20.5	73     13.32
            21.0	73     11.03
            21.5	73     10.28
            20.2	74     13.51
            20.3	74     10.18
            20.7	74      8.07
            20.8	74     10.7
            20.8	74     10.28
            20.9	74     10.03
            20.9	74      9.12
            21.0	74     11.49
            20.5	75      6.06
            21.3	75     11.62
            21.9	75      9.51
            20.7	76     17.97
            20.7	76     10.76
            21.0	76     10.42
            21.0	76      8.32
            21.5	76     10.82
            20.3	77     17.26
            20.3	77     16.82
            20.5	77     14.66
            21.2	77     12.17
            21.3	78      9.69
            21.4	78     13.16
            21.8	78     11.31
            21.9	78     12.11
            22.1	78     11.81
            20.8	79     12.8
            21.9	79     11.09
            22.5	79     11.43
            20.9	80     14.61
            20.8	81     14.71
            21.5	81     14.82
            21.9	81     10.79
            21.9	81     10.43
            21.8	81.3	9.47
            21.0	83     13.34
            21.6	83     14.24
            22.4	83      9.95
            21.1	84     18.53
            22.7	85     14.35
            22.0	86     10.74
            21.9	87     13.03
            22.1	87     12.75
            21.3	88     15.24
            21.7	88     11.84
            21.4	95     14.73
            22.7	95     15.77
            22.0	96     18.48
            22.2	97     16.68
            23.8	102    13.79
            22.0	106    22.81
            23.0	106    15.38
            22.4	108    18.86];
data.LW_ad(:,1) = LW_ad(:,1);
data.LW_ad(:,2) = LW_ad(:,2) - LW_ad(:,3);          % remove the gonad 
units.LW_ad = {'d', 'cm'};     label.LW_ad = {'total length', 'wet weight without gonads'};  bibkey.LW_ad = 'IPMA';
  temp.LW_ad = C2K(15);  units.temp.LW_ad = 'K'; label.temp.LW_ad = 'temperature';% K, temperature [LAURE: which temp? should we set it as a parameter?]
      

%% dw / ww ratio  = (1 - Water content)
mwWater = [  2,  3,  4,  5,  6,  7,  8,  9,  10,  11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 4, 5, 6, 7, 8, 9, 10, 11, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 1, 2, 3, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6; ...
          77.8, 76.9, 76.1, 74.9, 69.6, 66.4, 63.1, 59.3, 63.4, 63.1, 64.6, 72.4, 73.8, 76.8, 75.7, 74.6, 68.2, 69.5, 65.3, 62.9, 60.8, 64.5, 65.7, 75.2, 71.5, 64.0, 65.1, 58.3, 58.4, 61.2, 64.5, 67.2, 65.7, 61.7, 64.6, 67.1, 70.8, 75.9, 78.1, 76.0, 75.9, 70.6, 63.1, 62.5, 66.3, 61.2, 59.2, 59.5, 63.2, 69.8, 76.4, 78.1, 74.0, 70.2, 68.2, 67.6, 62.6, 62.3, 62.4, 67.8, 72.5, 73.4, 74.2, 67.3, 68.3, 59.4, 60.9, 60.0, 66.5, 66.0, 73.3, 79.2, 79.2, 76.0, 69.0, 67.1, 67.7, 54.4, 56.4, 59.0, 62.2, 66.7, 71.2, 74.2, 76.5, 78.5, 69.3, 72.7, 66.8, 66.3, 61.9, 62.7, 64.3, 65.7, 67.1, 74.5, 77.0, 76.1, 71.6, 72.3, 71.3, 71.2, 67.8, 65.9, 67.1, 69.6, 71.0, 73.7, 76.0, 76.9, 73.3, 66.9, 63.4, 58.0, 56.8, 61.2, 59.9, 64.8, 73.2, 74.9, 77.0, 73.0, 69.4, 65.5];

for i = 1:12
  wWater(i, 1) = mean(mwWater(2, (mwWater(1, :) == i)))/100;
end
t = linspace(55, 365+55, 13)';
data.tdw = [t, 1 - wWater([3:12, 1:3], 1)]; % beacuse it is from Mar to Mar we use [3:12, 1:3]
units.tdw = {'d', '-'};     label.tdw= {'day of the year', 'dry weight / wet weight ratio'};  bibkey.tdw = 'RosaGonz2010';

%% Energy density J/g ww
mE_per_Ww = [  2,  3,  4,  5,  6,  7,  8,  9,  10,  11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 4, 5, 6, 7, 8, 9, 10, 11, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 1, 2, 3, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 1, 2, 3, 4, 5, 6; ...
     4740, 4670, 5276, 5630, 7914, 9257, 11161, 11527, 9906, 10734, 9779, 6887, 6037, 4991, 5488, 5530, 8587, 7958, 9785, 10848, 11712, 10180, 9700, 5529, 7244, 10234, 9890, 12775, 12585, 11552, 10228, 8908, 9817, 11507, 10058, 8852, 7507, 5415, 4954, 5367, 5408, 7385, 10536, 10246, 9306, 11573, 12091, 11353, 10599, 8231, 4907, 4424, 5770, 7506, 8499, 8952, 10167, 10433, 10423, 8441, 7001, 6091, 5202, 8555, 8244, 11773, 10500, 11508, 9171, 8850, 6450, 4219, 4079, 5255, 8305, 9222, 8970, 14182, 13574, 12206, 11058, 9233, 7086, 6125, 5162, 4434, 8092, 6688, 8905, 9418, 11050, 10759, 10186, 9683, 9097, 5853, 5063, 5004, 7492, 6780, 6921, 7369, 8558, 9590, 8784, 7837, 7355, 6329, 5454, 5139, 6504, 9017, 10473, 12870, 13551, 11665, 12198, 9681, 6553, 5482, 4702, 6252, 7814, 9683];

mE_per_Wd = mE_per_Ww;
mE_per_Wd(2, :) = mE_per_Ww(2, :) ./(1 - mwWater(2, :)/100); % conversion from wet to dry weight
for i = 1:12
  E_per_Wd(i, 1) = mean(mE_per_Wd(2, (mE_per_Wd(1, :) == i)))/1000; % from J to kJ
end
data.tE = [t, E_per_Wd([3:12, 1:3], 1)];
units.tE = {'d', 'kJ.g-1 dw'};     label.tE = {'day of the year', 'specific energy density'};  bibkey.tE = 'RosaGonz2010';

%% set weights for all real data
weights = setweights(data, []);

% if one wants to ovewrite one of the weights it should always present an explanation example:

% zero-variate data 
 % --> more weight to real data (/pseudodata) to correspond to old mydata_Sardina_pilchardus
 nm = fieldnames(weights); % vector of cells with names of data sets
 for i = 1:numel(nm)
    eval(['[ndata nvar] = size(data.', nm{i},');']);
    if nvar == 1 % zero-variate data
      eval(['weights.', nm{i},' = 10 * weights.', nm{i}, ';']);
    end
 end
 %weights.Ri = 10 * weights.Ri;
 
%  weights.ab = 0; 
weights.Lj = 20 * weights.Lj;


 % uni-variate data: 
 weights.tL_juv1 = 10 * weights.tL_juv1;
 weights.tL_juv2 = 10 * weights.tL_juv2;
 weights.tL_juv3 = 10 * weights.tL_juv3;
 weights.tL_juv4 = 10 * weights.tL_juv4;
 weights.tL_juv5 = 10 * weights.tL_juv5;
 weights.tL_juv6 = 10 * weights.tL_juv6;
 weights.tL_ad_f = 10 * weights.tL_ad_f ;    
 %weight.tL_ad_m =  100 * weight.tL_ad_m;   
 weights.LW_juv4 = 10 * weights.LW_juv4;
 weights.LW_juv5 = 10 * weights.LW_juv5;
 weights.LW_juv6 = 10 * weights.LW_juv6;
 weights.LW_ad =  100  * weights.LW_ad;    
 %weights.tE =  200  * weights.tE;    
 %weights.tdw = 100 * weights.tdw;

 

%% set pseudodata and respective weights
% (pseudo data are in data.psd and weights are in weights.psd)
[data, units, label, weights] = addpseudodata(data, units, label, weights);

 data.psd.muw_E = 33000;      units.psd.muw_E = 'J/g';    label.psd.muw_E = 'energy content per g dry weight of reserve';       % bibkey.psd.d_E = 'Fill';    
 weights.psd.muw_E = 10 * 1 ./ data.psd.muw_E^2;
 
 data.psd.muw_V = 19000;      units.psd.muw_V = 'J/g';    label.psd.muw_V = 'energy content per g dry weight of structure';       % bibkey.psd.d_E = 'Fill';    
 weights.psd.muw_V = 10 * 1 ./ data.psd.muw_V^2;

% data.psd.w_E = 20;      units.psd.w_E = 'g/mol';    label.psd.w_E = 'molecular weight of reserve';      %  bibkey.psd.w_E = 'Fill';    
% weights.psd.w_E = 100 * 1 ./ data.psd.w_E^2;
 
% data.psd.w_V = 23;      units.psd.w_V = 'g/mol';    label.psd.w_V = 'molecular weight of reserve';      %  bibkey.psd.w_V = 'Fill';    
% weights.psd.w_V = 100 * 1 ./ data.psd.w_V^2;

%% pack auxData and txtData for output
auxData.temp = temp;
txtData.units = units;
txtData.label = label;
txtData.bibkey = bibkey;
if exist('comment','var')
  txtData.comment = comment;
end

%% Discussion points
%D1 = 'Author_mod_1: I found information on the number of eggs per female as a function of length in Anon2013 that was much higher than in Anon2015 but chose to not include it as the temperature was not provided';
% optional bibkey: metaData.bibkey.D1 = 'Anon2013';
%D2 = 'Author_mod_1: I was surprised to observe that the weights coefficient for ab changed so much the parameter values';     
% optional bibkey: metaData.bibkey.D2 = 'Kooy2010';
%metaData.discussion = struct('D1', D1, 'D2', D2);

%% Facts
% list facts: F1, F2, etc.
% make sure each fact has a corresponding bib key
% do not put any DEB modelling assumptions here, only relevant information on
% biology and life-cycles etc.
%F1 = 'The larval stage lasts 202 days and no feeding occurs';
%metaData.bibkey.F1 = 'Wiki'; % optional bibkey
%metaData.facts = struct('F1',F1);

%% References
% the following two references should be kept-----------------------------------------------------------
bibkey = 'Kooy2010'; type = 'Book'; bib = [ ...  % used in setting of chemical parameters and pseudodata
'author = {Kooijman, S.A.L.M.}, ' ...
'year = {2010}, ' ...
'title  = {Dynamic Energy Budget theory for metabolic organisation}, ' ...
'publisher = {Cambridge Univ. Press, Cambridge}, ' ...
'pages = {Table 4.2 (page 150), 8.1 (page 300)}, ' ...
'howpublished = {\url{http://www.bio.vu.nl/thb/research/bib/Kooy2010.html}}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'LikaKear2011'; type = 'Article'; bib = [ ...  % used for the estimation method
'author = {Lika, K. and Kearney, M.R. and Freitas, V. and van der Veer, H.W. and van der Meer, J. and Wijsman, J.W.M. and Pecquerie, L. and Kooijman, S.A.L.M.},'...
'year = {2011},'...
'title = {The ''''covariation method'''' for estimating the parameters of the standard Dynamic Energy Budget model \textrm{I}: Philosophy and approach},'...
'journal = {Journal of Sea Research},'...
'volume = {66},'...
'number = {4},'...
'pages = {270-277},'...
'DOI = {10.1016/j.seares.2011.07.010},'...
'howpublished = {\url{http://www.sciencedirect.com/science/article/pii/S1385110111001055}}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%------------------------------------------------------------------------------------------------------

 % References for the data, following BibTex rules
 % author names : author = {Last Name, F. and Last Name2, F2. and Last Name 3, F3. and Last Name 4, F4.}
 % latin names in title e.g. \emph{Pleurobrachia pileus}

bibkey = 'Wiki'; type = 'Misc'; bib = [...
'howpublished = {\url{http://en.wikipedia.org/wiki/European_pilchard}},'...
'note = {Accessed : 2015-04-30}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'Fishbase'; type = 'Misc'; bib = [...
'howpublished = {\url{http://www.fishbase.org/summary/1350}},'...
'note = {Accessed : 2015-04-30}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];

bibkey = 'Mene2003'; type = 'phdthesis'; bib = [ ...  
  'author = {Meneses. I}, ' ...
  'year = {2003}, ' ...
  'title  = {Estimação de factores que condicionam a variabilidade do recrutamento de peixes na costa atlântica da península Ibérica}, ' ...
  'school = {Instituto Nacional de Investigação Agrária e das Pescas}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'RosaGonz2010'; type = 'Article'; bib = [ ... %
   'author = {Rosa, Rui and Gonzalez, Liliana and Broitman, Bernardo R. and Garrido, Susana and Santos, A. Miguel P. and Nunes, Maria L.}, ' ... 
   'year = {2010}, ' ...
   'title = {Bioenergetics of small pelagic fishes in upwelling systems: relationship between fish condition, coastal ecosystem dynamics and fisheries}, '...
   'journal = {Marine Ecology Progress Series}, ' ...
   'volume = {410}, ' ...
   'pages = {205--218}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
%
bibkey = 'SilvCarr2008'; type = 'Article'; bib = [ ...  
'author = {Silva, A. and P. Carrera and J. Masse and A. D. Uriarte and M. B. Santos and P. B. Oliveira and E. Soares and C. Porteiro and Y. Stratoudakis}, ' ...
'year = {2008}, ' ...
'title = {Geographic variability of sardine growth across the northeastern Atlantic and the Mediterranean Sea.}, ' ... 
'journal = {Fisheries Research}, ' ...
'volume = 90, '...
'pages = {56--69}'];
metaData.biblist.(bibkey) = ['''@', type, '{', bibkey, ', ' bib, '}'';'];
