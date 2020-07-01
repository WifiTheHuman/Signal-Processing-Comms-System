# Signal-Processing-Wave-Generation
This repository contains Matlab code to enable data transfer using a physical channel and a wave generator.  
Firstly the bitstream can be optionally encoded into 4-PAM to double the speed of transmission.  
Next, the transmitter can modulate the bitstream onto a signal waveform using convolution and send this across the channel to the receiver.
It can modulate onto either a square wave or root raised cosine wave.  
Simulation code has been written so the user can visualise the output waveform of the transmitter and the power spectral density and adjust their transmissions accordingly.  
The receiver demodulates the signal waveform using a matched filter and 4-PAM decoder, so the original data can be retrieved.  
It can display the received waveform which has been impacted by the noise across the channel as well as an eye diagram so the user can visualise the effect of channel noise.
The bit error rate due to noise can be plotted so the user can determine if the system is adequate for their application.
