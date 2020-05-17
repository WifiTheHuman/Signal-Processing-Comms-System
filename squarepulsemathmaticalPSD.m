%This code generates a plot of PSM against bandwidth given frequency and
%bandwidth using the mathmatical approach.

f = 1000000;
T = 1/500000;
f = linspace(0, f, 1000000);

S = 5 * T * (sinc(pi * f * T)).^2;

figure(1);
plot(S)
xlabel('Frequency (MHz)')
ylabel('Power Spectral Density')
title('Mathmatical PSD of 4-PAM Signal With Rectangular Pulse')
