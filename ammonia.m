%{
    Script file: Pumps_Lab_1.m

    Purpose:
        a) To build a Mass percentage vs. Temperature calibrating plot;
        b) Find analytically and graphically boiling point temperature for 15%, 25% and 50%
of NH3 mass concentration;

    Record of revisions:
            Date               Programmer                   Description of change
       ========       ============               ===================
        05/05/22          T. K. Koziupa                         Original code
        07/05/22          T. K. Koziupa                         Second plot added
added, trend line equations for certain mass percantage-boiling temperature regions added

    Define variables:
        mass_conc -- Row-vector of NH3 mass concentration in ammonia-water solution, unuits: Percents;
        boil_temp -- Row-vector of boiling temperature values corresponding to NH3 mass concentration, 
unuits: degrees Celcius;
        mass_conc_trend -- Row-vector of NH3 mass concentration used for building trend line, unuits: Percents;
        trend_line -- Linear model of the trend line that covers all concentration range and provides user with 
visualization of the overall shape of change tendency, unuits: unitless;
        trend_line_eqn -- Symbolic equation of trend line, used for plotting, unuits: unitless;
        boil_0_40 -- Linear model of the trend line that covers concentration range from 0% to 40%, unuits: unitless;
***Variables 'boil_40_60', 'boil_60_80', 'boil_80_100' have the same meaning as boil_0_40, but 
cover different concentration ranges (e. g. 'boil_40_60' - covers NH3 concentration range from 0% to
40% and so on)***
        boil_0_40_eqn -- Symbolic equation of trend line that covers concentration range from 0% to 40%, 
used for plotting, unuits: unitless;
***Variables 'boil_40_60_eqn', 'boil_60_80_eqn', 'boil_80_100_eqn' have the same meaning as boil_0_40_eqn, 
but cover different concentration ranges (e. g. 'boil_40_60_eqn' - covers NH3 concentration range from 0% to
40% and so on)***
        boil_temp_trend -- Row-vector of boiling temperature used for building trend line, unuits: degrees Celcius;
        mass_conc_unknown -- Vector of NH3 mass concentration values for which boiling temperatures are 
to be found, unuits: Percents;
        boil_temp_unknown -- Boiling temperature values that are to be found, unuits: degrees Celcius;
%}

%%
clc
clear all
close all

%%
mass_conc = [0 10 12 14 16 18 20 22 24 100];
boil_temp = [100 90.6 85 76.7 73.3 65.6 58.3 50 43.3 -33.34];

mass_conc_trend = 0:0.1:100;

trend_line = fitlm(mass_conc, boil_temp, 'quadratic');

syms x1
trend_line_eqn = @(x1) (trend_line.Coefficients{1:3, ['Estimate']}(3)).*x1.^2 + (trend_line.Coefficients{1:3, ['Estimate']}(2)).*x1 + (trend_line.Coefficients{1:3, ['Estimate']}(1));

figure
plot(mass_conc(2:(length(mass_conc) - 1)), boil_temp(2:(length(boil_temp) - 1)), 'ko', mass_conc_trend, trend_line_eqn(mass_conc_trend), 'k-.', 'LineWidth', 1)
grid on; grid minor
title('\itMass percantage vs. Temperature', 'FontName', 'Euclid', 'FontSize', 16)
xlabel('\itNH_3 concentration, %_{of solution mass}', 'FontName', 'Euclid', 'FontSize', 14)
ylabel('\itT, \circC', 'FontName', 'Euclid', 'FontSize', 14)
legend('\itOriginal empirical data', '\itTrend line', 'FontName', 'Euclid', 'FontSize', 12)

boil_0_40 = fitlm(mass_conc_trend(find(mass_conc_trend == 0):find(mass_conc_trend == 40)), trend_line_eqn(mass_conc_trend(find(mass_conc_trend == 0):find(mass_conc_trend == 40))), 'linear');
syms x2
boil_0_40_eqn = @(x2) (boil_0_40.Coefficients{1:2, ['Estimate']}(2)).*x2 + (boil_0_40.Coefficients{1:2, ['Estimate']}(1));
mass_conc_0_40 = 0:0.1:40;
boil_40_60 = fitlm(mass_conc_trend(find(mass_conc_trend == 40):find(mass_conc_trend == 60)), trend_line_eqn(mass_conc_trend(find(mass_conc_trend == 40):find(mass_conc_trend == 60))), 'linear');
syms x3
boil_40_60_eqn = @(x3) (boil_40_60.Coefficients{1:2, ['Estimate']}(2)).*x3 + (boil_40_60.Coefficients{1:2, ['Estimate']}(1));
mass_conc_40_60 = 40:0.1:60;
boil_60_80 = fitlm(mass_conc_trend(find(mass_conc_trend == 60):find(mass_conc_trend == 80)), trend_line_eqn(mass_conc_trend(find(mass_conc_trend == 60):find(mass_conc_trend == 80))), 'linear');
syms x4
boil_60_80_eqn = @(x4) (boil_60_80.Coefficients{1:2, ['Estimate']}(2)).*x4 + (boil_60_80.Coefficients{1:2, ['Estimate']}(1));
mass_conc_60_80 = 60:0.1:80;
boil_80_100 = fitlm(mass_conc_trend(find(mass_conc_trend == 80):find(mass_conc_trend == 100)), trend_line_eqn(mass_conc_trend(find(mass_conc_trend == 80):find(mass_conc_trend == 100))), 'linear');
syms x5
boil_80_100_eqn = @(x5) (boil_80_100.Coefficients{1:2, ['Estimate']}(2)).*x5 + (boil_80_100.Coefficients{1:2, ['Estimate']}(1));
mass_conc_80_100 = 80:0.1:100;

figure
hold on
plot(mass_conc(2:(length(mass_conc) - 1)), boil_temp(2:(length(boil_temp) - 1)), 'ko', mass_conc_trend, trend_line_eqn(mass_conc_trend), 'k-.',  'LineWidth', 1)
plot(mass_conc_0_40, boil_0_40_eqn(mass_conc_0_40), mass_conc_40_60, boil_40_60_eqn(mass_conc_40_60), mass_conc_60_80, boil_60_80_eqn(mass_conc_60_80), mass_conc_80_100, boil_80_100_eqn(mass_conc_80_100), 'LineWidth', 1.5)
grid on; grid minor
title('\itMass percantage vs. Temperature', 'FontName', 'Euclid', 'FontSize', 16)
xlabel('\itNH_3 concentration, %_{of solution mass}', 'FontName', 'Euclid', 'FontSize', 14)
ylabel('\itT, \circC', 'FontName', 'Euclid', 'FontSize', 14)
legend('\itOriginal empirical data', '\itTrend line', 'FontName', 'Euclid', 'FontSize', 12)
hold off

mass_conc_unknown = [15 25 50];
boil_temp_unknown = double(trend_line_eqn(mass_conc_unknown));
fprintf('Water-ammonia solution boiling temperatures for 15, 25 and 50 percents of NH3 mass are: %.2f degree Celcius, %.2f degree Celcius and %.2f degree Celcius respectively.\n', boil_temp_unknown(1), boil_temp_unknown(2), boil_temp_unknown(3))