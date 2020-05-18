%This code generates a plot of PSD for a rect() function
%against bandwidth given frequency and
%bandwidth using the mathmatical and simulated approach.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mathmatical section
frequency = 1000000;
bandwidth = 500000;
Ts = 1/bandwidth;
frequency = linspace(-frequency, frequency, frequency);

S = zeros(1000000, 1);
S(250000:750000) = 5 / 4 * Ts * (1 + cos(pi * frequency(250000:750000) * Ts)).^2;

figure(1);
plot(S)
xlabel('Frequency (MHz)')
ylabel('Power Spectral Density')
title('Mathmatical PSD of 4-PAM Signal With Raised Cosine Pulse')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%