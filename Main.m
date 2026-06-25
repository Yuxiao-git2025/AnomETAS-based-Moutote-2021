% =========================================================================
% Obtain the predicted number of events through numerical integration using
% ETAS model, and compare it with the actual values to analyze anomalous
% foreshock activity stages
% Refer to: (Moutote 2021)
% Required variables:
%   time   : event times in days
%   mag    : event magnitudes
%   tmain  : mainshock time in days
%   IDmain : mainshock ID
%   params : ETAS parameters with fields A, c, p, alpha, mu, mc
% =========================================================================
% 1. Load catalog and fitted ETAS parameters in advance
load('Data\NCEDC2019to2022.mat'); 
time=t; 
mag=m;
Mmin=1;
AnomETAS_PlotMT(time,mag);

% >> Basic Setting
Tmain=500;        % Mainshock Occurrence timing
% Tmain=time(mag==max(mag));
IDmain=1;        % Mainshock IDentifier
Wins=20;          % Window size
Shift=2;       % Sliding step
P0=0.01;         % Anomaly threshold

% >> Params Setting
% Cal ETAS-MLE in advance
% FittingWins=(time>0 & time<=200);
% paramsETAS=cal_MLE(time(FittingWins),mag(FittingWins),[],Mmin,2);
params.A     = 0.026;
params.c     = 0.001;
params.p     = 0.95;
params.alpha = 0.82;
params.mu    = 11.32;
params.Mmin  = Mmin;
%% ========================================================================
% >> Sliding-window ETAS expectation analysis
clc;
Result=AnomETAS_Forecast(time, mag, params, ...
    'Tmain', Tmain, 'Wins', Wins, 'Shift', Shift,'P0',P0,'IDmain',IDmain);
% declust=AnomETAS_Decluster(time, mag, params, ...
%     'Tmain', Tmain, 'Wins', Wins, 'Shift', Shift,'P0',P0,'IDmain',IDmain);

%% ========================================================================
% >> Plot
AnomETAS_PlotResult(time,mag,Result,[],Wins,P0,Tmain);
