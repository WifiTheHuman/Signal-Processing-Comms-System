clear;clf;
fsamp = 50;%sample at 50 times data rate

%Generate raised cosine pulse with alpha = 1
delay_rc = 2;
delayrc = 2 * delay_rc * fsamp;

prcos = rcosdesign(1, delay_rc*2, fsamp);
matchedFilter = prcos(end:-3:3);

% Generating random signal data
dataSize = 10000;
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

upData = upsample(dataArray,fsamp);

message=conv(upData,prcos);

msgLen=length(message); 
noiseq=randn(msgLen,1) ;

SNRMAX = 10;
SNRDB = zeros(SNRMAX, 1);
BER = zeros(SNRMAX, 1);
dataArray = zeros(dataSize, 1);
for i = 1 : 1 : SNRMAX
    %add noise over channel
    
    SNRDB(i) = i;                          % 10dB SNR
    SNR=10^(SNRDB(i)/10);           % SNR in linear scale
    Var_n=1/(2*SNR);               % 1/SNR is the noise variance
    signoise=sqrt(Var_n);                % standard deviation
    awgnoise=signoise*noiseq;             % AWGN
    % Add noise to signals at the channel output
    noisymessage=message + awgnoise;
    
    %apply matched filter
    rxmessage = conv(noisymessage,matchedFilter);
    
    sampMsg = rxmessage(delayrc+1:fsamp:end);
    decisionisone = sign(sampMsg(1:dataSize));
    
    BER(i) = 0.5*erfc(sqrt(SNR));
end

figure(1)
semilogy(SNRDB,BER);
xlabel('SNR(dB)')
ylabel('Bit Error Rate')
title('Bit Error Rate vs SNR')