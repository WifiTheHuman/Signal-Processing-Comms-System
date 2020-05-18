dataSize = 10;
fsamp = 8;%sample at 8 times data rate

%Generate raised cosine pulse with alpha = 1
delay_rc=3;
prcos = rcosdesign( 1, delay_rc*2, fsamp);

%convert bit sequence to modulated data set
bitSequence = [0; 0; 1; 0; 1; 1; 0; 1; 1; 1];
predataSet = zeros(dataSize);
for i = 1 : 2 : dataSize
    if (bitSequence(i) == 0) && (bitSequence(i+1) == 0)
        predataSet(i) = -3;
    elseif (bitSequence(i) == 0) && (bitSequence(i+1) == 1)
        predataSet(i) = -1;
    elseif (bitSequence(i) == 1) && (bitSequence(i+1) == 0)
        predataSet(i) = 3;
    elseif (bitSequence(i) == 1) && (bitSequence(i+1) == 1)
        predataSet(i) = 1;
    end
end

dataSet = zeros(dataSize/2,1);
for i = 1 : 1 : dataSize/2
    dataSet(i) = predataSet(2 * i - 1);
end

%dataSet = [-3; 3; 1; -1; 1];
transpose(dataSet);
upData=upsample(dataSet,fsamp);

%generate message
message=conv(upData,prcos);

figure(1)
plot(2 * message)
xlabel('Bit Sequence With Oversampling')
ylabel('Amplitude Level')
title('Simulated Output Signal For Bit Sequence [0 0 1 0 1 1 0 1 1 1] ')