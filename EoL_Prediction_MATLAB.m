function [fitresult, gof] = createFit(CycleNo, ActualSOH)
%CREATEFIT(CYCLENO,ACTUALSOH)
%  Create a fit.
% code applicable for LFP type batteries only
% Constant temperature of 300K is assumed
% y = - 0.27*z^{7} - 0.51*z^{6} + 1.2*z^{5} + 1.5*z^{4} - 1.3*z^{3} - 0.65*z^{2} - 6.1*z + 90
%where z = (x - 1.2e+03)/6.7e+02 (where x is no. of cycles elapsed), consider only upto 80% residual capacity 
%  Data for 'untitled fit 1' fit:
%      X Input : CycleNo
%      Y Output: ActualSOH
%      Weights : ActualSOH
%  Output:
%      fitresult : a fit object representing the fit.
%      gof : structure with goodness-of fit info.
%
%  See also FIT, CFIT, SFIT.



%% Fit: 'untitled fit 1'.
[xData, yData] = prepareCurveData( CycleNo, ActualSOH );

% Set up fittype and options.
ft = fittype( 'poly7' );
opts = fitoptions( ft );
opts.Lower = [-Inf -Inf -Inf -Inf -Inf -Inf -Inf -Inf];
opts.Upper = [Inf Inf Inf Inf Inf Inf Inf Inf];
opts.Normalize = 'on';

% Fit model to data.
[fitresult, gof] = fit( xData, yData, ft, opts );

% Plot fit with data.
figure( 'Name', 'untitled fit 1' );
h = plot( fitresult, xData, yData );
legend( h, 'ActualSOH vs. CycleNo', 'untitled fit 1', 'Location', 'NorthEast' );
% Label axes
xlabel( 'CycleNo' );
ylabel( 'ActualSOH' );
grid on
