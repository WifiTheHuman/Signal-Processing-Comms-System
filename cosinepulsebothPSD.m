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
plot(frequency, S)
xlabel('Frequency (MHz)')
ylabel('Power Spectral Density')
title('Mathmatical PSD of 4-PAM Signal With Raised Cosine Pulse')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Simulation section

fsamp = 8;%sample at 8 times data rate

%Generate raised cosine pulse with alpha = 1
delay_rc = 3;
prcos = rcosdesign( 1, delay_rc*2, fsamp);
prmatch=prect(end:-1:1);

% Generating random signal data for polar signaling
dataSize = 1000;
dataArray = zeros(dataSize, 1);
for i=1:dataSize
   rounded = round(3*rand(1));
   switch (rounded) 
       case 0
           dataArray(i) = -3;
       case 1
           dataArray(i) = -1;
       case 2
           dataArray(i) = 1;
       case 3
           dataArray(i) = 3;
   end 
end
transpose(dataArray);
upData = upsample(dataArray,fsamp);

message=conv(upData,prcos);
[Psd,f]=pwelch(message, [], [], [], 'twosided' ,fsamp);

figure(2);
figpsd2=semilogy(f-f_ovsamp/2,fftshift(Psd));

xlabel('Frequency (1/T)')
ylabel('Power Spectral Density')
title('Simulated PSD of 4-PAM Signal With Raised Cosine Pulse')