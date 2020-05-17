%This code generates a plot of PSM against bandwidth given frequency and
%bandwidth using the mathmatical approach.


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Mathmatical section
frequency = 1000000;
bandwidth = 500000;
Ts = 1/bandwidth;
frequency = linspace(0, frequency, frequency);

S = 5 * Ts * (sinc(pi * frequency * Ts)).^2;

figure(1);
plot(S)
xlabel('Frequency (MHz)')
ylabel('Power Spectral Density')
title('Mathmatical PSD of 4-PAM Signal With Rectangular Pulse')
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Simulation section

fsamp = 8;%sample at 8 times data rate

% Generating a rectangular pulse shape
prect=ones(1,fsamp);
prect=prect/norm(prect);
prectmatch=prect(end:-1:1);

% Generating random signal data for polar signaling
dataArray = zeros(500, 1);
for i=1:500
   num = round(3*rand(1));
   switch (num) 
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
upData = upsample(s_data,fsamp);

%pass data through rectangular filter
message=conv(upData,prect);

%Perfect channel

%Pass received message through matching rectangular filter
%PSDSim = conv(message,prectmatch);


[Psd2,f]=pwelch(xrect, [], [], [], 'twosided' ,f_ovsamp);


figure(2);
plot(PSDSim)
xlabel('Frequency (MHz)')
ylabel('Power Spectral Density')
title('Simulated PSD of 4-PAM Signal With Rectangular Pulse')