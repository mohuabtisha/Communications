clc;
clear all;

FRM1 = 512;
FRM2 = 1024;
FRM3 = 2048;
FRM4 = 4096;
maxNumErrs = 200;
maxNumBits = 1e7;
EbNo_vector = 0:10;
%initializing
Modulator = comm.QPSKModulator('BitInput', true);
AWGN = comm.AWGNChannel;
Demodulator = comm.QPSKDemodulator('BitOutput', true);
BitError = comm.ErrorRate;
BER_vector = zeros(size(EbNo_vector));

%QPSK
for EbNo = EbNo_vector;           %FRM1=512
    snr = EbNo + 10*log10(2);
    AWGN.EbNo = snr;
    numErrs = 0;
    numBits = 0;
    results = zeros(3,1);
    %inner
    while((numErrs < maxNumErrs)&&(numBits < maxNumBits))
        %transmitter
        u = randi([0,1],FRM1,1); % Generate a FRM1-by-1 column vector of uniformly distributed random integers from the sample interval [0,1]..
        mod_sig = step(Modulator,u);
        %channel
        rx_sig = step(AWGN,mod_sig);
        %receiver
        y = step(Demodulator,rx_sig);
        results = step(BitError,u,y);
        numErrs = results(2);
        numBits = results(3);
    end
    %Compute BER
    ber = results(1);
    bits = results(3);
    %clean up & collect results
    reset(BitError);
    BER_vector(EbNo +1) = ber;
end
%visualize results
subplot(4,4,1);
EbNoLin = 10.^(EbNo_vector/10);
theoretical_results = 0.5*erfc(sqrt(EbNoLin));
semilogy(EbNo_vector,BER_vector);
grid on;
title('BER VS EbNo - QPSK (FRM = 512)');
xlabel('Eb/No(dB)');
ylabel('BER');
hold;
semilogy(EbNo_vector,theoretical_results,'dr');
hold;
legend('Simulation','Theoretical');

for EbNo = EbNo_vector;      %FRM2=1024
    snr = EbNo + 10*log10(2);
    AWGN.EbNo = snr;
    numErrs = 0;
    numBits = 0;
    rsults = zeros(3,1);
    %inner
    while((numErrs < maxNumErrs)&&(numBits < maxNumBits))
        %transmitter
        u = randi([0,1],FRM2,1);
        mod_sig = step(Modulator,u);
        %channel
        rx_sig = step(AWGN,mod_sig);
        %receiver
        y = step(Demodulator,rx_sig);
        results = step(BitError,u,y);
        numErrs = results(2);
        numBits = results(3);
    end
    %Compute BER
    ber = results(1);
    bits = results(3);
    %clean up & collect results
    reset(BitError);
    BER_vector(EbNo +1) = ber;
end
%visualize results
subplot(4,4,2);
EbNoLin = 10.^(EbNo_vector/10);
theoretical_results = 0.5*erfc(sqrt(EbNoLin));
semilogy(EbNo_vector,BER_vector);
grid on;
title('BER VS EbNo for QPSK(FRM = 1024).');
xlabel('Eb/No(dB)');
ylabel('BER');
hold;
semilogy(EbNo_vector,theoretical_results,'dr');
hold;
legend('Simulation','Theoretical');

for EbNo = EbNo_vector;             %FRM3=2048
    snr = EbNo + 10*log10(2);
    AWGN.EbNo = snr;
    numErrs = 0;
    numBits = 0;
    rsults = zeros(3,1);
    %inner
    while((numErrs < maxNumErrs)&&(numBits < maxNumBits))
        %transmitter
        u = randi([0,1],FRM3,1);
        mod_sig = step(Modulator,u);
        %channel
        rx_sig = step(AWGN,mod_sig);
        %receiver
        y = step(Demodulator,rx_sig);
        results = step(BitError,u,y);
        numErrs = results(2);
        numBits = results(3);
    end
    %Compute BER
    ber = results(1);
    bits = results(3);
    %clean up & collect results
    reset(BitError);
    BER_vector(EbNo +1) = ber;
end
%visualize results
subplot(4,4,3);
EbNoLin = 10.^(EbNo_vector/10);
theoretical_results = 0.5*erfc(sqrt(EbNoLin));
semilogy(EbNo_vector,BER_vector);
grid on;
title('BER VS EbNo - QPSK(FRM = 2048).');
xlabel('Eb/No(dB)');
ylabel('BER');
hold;
semilogy(EbNo_vector,theoretical_results,'dr');
hold;
legend('Simulation','Theoretical');

for EbNo = EbNo_vector;           %FRM4=4096
    snr = EbNo + 10*log10(2);
    AWGN.EbNo = snr;
    numErrs = 0;
    numBits = 0;
    rsults = zeros(3,1);
    %inner
    while((numErrs < maxNumErrs)&&(numBits < maxNumBits))
        %transmitter
        u = randi([0,1],FRM4,1);
        mod_sig = step(Modulator,u);
        %channel
        rx_sig = step(AWGN,mod_sig);
        %receiver
        y = step(Demodulator,rx_sig);
        results = step(BitError,u,y);
        numErrs = results(2);
        numBits = results(3);
    end
    %Compute BER
    ber = results(1);
    bits = results(3);
    %clean up & collect results
    reset(BitError);
    BER_vector(EbNo +1) = ber;
end
%visualize results
subplot(4,4,4);
EbNoLin = 10.^(EbNo_vector/10);
theoretical_results = 0.5*erfc(sqrt(EbNoLin));
semilogy(EbNo_vector,BER_vector);
grid on;
title('BER VS EbNo - QPSK(FRM = 4096).');
xlabel('Eb/No(dB)');
ylabel('BER');
hold;
semilogy(EbNo_vector,theoretical_results,'dr');
hold;
legend('Simulation','Theoretical');

%QAM
Modulator= comm.RectangularQAMModulator('BitInput',true);   
  AWGN = comm.AWGNChannel;
Demodulator = comm.RectangularQAMDemodulator('BitOutput',true); 
BitError = comm.ErrorRate;
BER_vector=zeros(size(EbNo_vector));
for EbNo=EbNo_vector  %FRM1=512
    snr=EbNo+10*log10(2);
    AWGN.EbNo=snr;
    numErrs=0;
    numBits=0;
    results=zeros(3,10);
    while ((numErrs < maxNumErrs) && (numBits < maxNumBits))
           u = randi([0,1],FRM1,1);
           mod_sig = step(Modulator,u);
           rx_sig = step(AWGN,mod_sig);
           y = step(Demodulator,rx_sig);
         results = step(BitError,u,y);
         numErrs = results(2);                                                      
         numBits = results(3);
    end
    ber =results(1);
    bits= results(3);
     reset(BitError);
     BER_vector(EbNo+1)=ber;
end
EbNoLin = 10.^(EbNo_vector/10);
theoretical_results = 0.5*erfc(sqrt(EbNoLin)); 
subplot(4,4,5);
semilogy(EbNo_vector,BER_vector);
grid on;
title('BER VS EbNo - QAM(FRM = 512)') 
xlabel('Eb/No (dB)');
ylabel('BER');
hold;
semilogy(EbNo_vector,theoretical_results,'dr'); 
 hold;
legend('Simulation','Theoretical');

for EbNo=EbNo_vector  %FRM2=1024
    snr=EbNo+10*log10(2);
    AWGN.EbNo=snr;
    numErrs=0;
    numBits=0;
    results=zeros(3,10);
    while ((numErrs < maxNumErrs) && (numBits < maxNumBits))
           u = randi([0,1],FRM2,1);
           mod_sig = step(Modulator,u);
           rx_sig = step(AWGN,mod_sig);
           y = step(Demodulator,rx_sig);
         results = step(BitError,u,y);
         numErrs = results(2);                                                      
         numBits = results(3);
    end
    ber =results(1);
    bits= results(3);
     reset(BitError);
     BER_vector(EbNo+1)=ber;
end
EbNoLin = 10.^(EbNo_vector/10);
theoretical_results = 0.5*erfc(sqrt(EbNoLin)); 
subplot(4,4,6);
semilogy(EbNo_vector,BER_vector);
grid on;
title('BER VS EbNo - QAM(FRM = 1024)') 
xlabel('Eb/No (dB)');
ylabel('BER');
hold;
semilogy(EbNo_vector,theoretical_results,'dr'); 
 hold;
legend('Simulation','Theoretical');

for EbNo=EbNo_vector  %FRM2=2048
    snr=EbNo+10*log10(2);
    AWGN.EbNo=snr;
    numErrs=0;
    numBits=0;
    results=zeros(3,10);
    while ((numErrs < maxNumErrs) && (numBits < maxNumBits))
           u = randi([0,1],FRM3,1);
           mod_sig = step(Modulator,u);
           rx_sig = step(AWGN,mod_sig);
           y = step(Demodulator,rx_sig);
         results = step(BitError,u,y);
         numErrs = results(2);                                                      
         numBits = results(3);
    end
    ber =results(1);
    bits= results(3);
     reset(BitError);
     BER_vector(EbNo+1)=ber;
end
EbNoLin = 10.^(EbNo_vector/10);
theoretical_results = 0.5*erfc(sqrt(EbNoLin)); 
subplot(4,4,7);
semilogy(EbNo_vector,BER_vector);
grid on;
title('BER VS EbNo - QAM(FRM = 2048)') 
xlabel('Eb/No (dB)');
ylabel('BER');
hold;
semilogy(EbNo_vector,theoretical_results,'dr'); 
 hold;
legend('Simulation','Theoretical');

for EbNo=EbNo_vector  %FRM4=4096
    snr=EbNo+10*log10(2);
    AWGN.EbNo=snr;
    numErrs=0;
    numBits=0;
    results=zeros(3,10);
    while ((numErrs < maxNumErrs) && (numBits < maxNumBits))
           u = randi([0,1],FRM4,1);
           mod_sig = step(Modulator,u);
           rx_sig = step(AWGN,mod_sig);
           y = step(Demodulator,rx_sig);
         results = step(BitError,u,y);
         numErrs = results(2);                                                      
         numBits = results(3);
    end
    ber =results(1);
    bits= results(3);
     reset(BitError);
     BER_vector(EbNo+1)=ber;
end
EbNoLin = 10.^(EbNo_vector/10);
theoretical_results = 0.5*erfc(sqrt(EbNoLin)); 
subplot(4,4,8);
semilogy(EbNo_vector,BER_vector);
grid on;
title('BER VS EbNo - QAM(FRM = 4096)') 
xlabel('Eb/No (dB)');
ylabel('BER');
hold;
semilogy(EbNo_vector,theoretical_results,'dr'); 
 hold;
legend('Simulation','Theoretical');

%16QAM
Modulator= comm.RectangularQAMModulator(16,'BitInput',true);
  AWGN = comm.AWGNChannel;
Demodulator = comm.RectangularQAMDemodulator(16,'BitOutput',true); 
BitError = comm.ErrorRate;
BER_vector=zeros(size(EbNo_vector));
for EbNo=EbNo_vector                       %512
    snr=EbNo+10*log10(2);
    AWGN.EbNo=snr;
    numErrs=0;
    numBits=0;
    results=zeros(3,10);
    while ((numErrs < maxNumErrs) && (numBits < maxNumBits))
           u = randi([0,1],FRM1,1); % Generate Random Bits
           mod_sig = step(Modulator,u);
           rx_sig = step(AWGN,mod_sig); 
          y = step(Demodulator,rx_sig);
         results = step(BitError,u,y); 
         numErrs = results(2);                                          
         numBits = results(3);
    end
    ber =results(1);
    bits= results(3);
     reset(BitError);
     BER_vector(EbNo+1)=ber;
end
EbNoLin = 10.^(EbNo_vector/10);
theoretical_results = 0.5*erfc(sqrt(EbNoLin)); 
subplot(4,4,9);
semilogy(EbNo_vector,BER_vector);
grid on;
title('BER VS EbNo - 16QAM(FRM = 512)') 
xlabel('Eb/No (dB)');
ylabel('BER');
hold;
semilogy(EbNo_vector,theoretical_results,'dr'); 
 hold;
legend('Simulation','Theoretical');

for EbNo=EbNo_vector                       %1024
    snr=EbNo+10*log10(2);
    AWGN.EbNo=snr;
    numErrs=0;
    numBits=0;
    results=zeros(3,10);
    while ((numErrs < maxNumErrs) && (numBits < maxNumBits))
           u = randi([0,1],FRM2,1); % Generate Random Bits
           mod_sig = step(Modulator,u);
           rx_sig = step(AWGN,mod_sig); 
          y = step(Demodulator,rx_sig);
         results = step(BitError,u,y); 
         numErrs = results(2);                                          
         numBits = results(3);
    end
    ber =results(1);
    bits= results(3);
     reset(BitError);
     BER_vector(EbNo+1)=ber;
end
EbNoLin = 10.^(EbNo_vector/10);
theoretical_results = 0.5*erfc(sqrt(EbNoLin)); 
subplot(4,4,10);
semilogy(EbNo_vector,BER_vector);
grid on;
title('BER VS EbNo - 16QAM(FRM = 1024)') 
xlabel('Eb/No (dB)');
ylabel('BER');
hold;
semilogy(EbNo_vector,theoretical_results,'dr'); 
 hold;
legend('Simulation','Theoretical');

for EbNo=EbNo_vector                       %2048
    snr=EbNo+10*log10(2);
    AWGN.EbNo=snr;
    numErrs=0;
    numBits=0;
    results=zeros(3,10);
    while ((numErrs < maxNumErrs) && (numBits < maxNumBits))
           u = randi([0,1],FRM3,1); % Generate Random Bits
           mod_sig = step(Modulator,u);
           rx_sig = step(AWGN,mod_sig); 
          y = step(Demodulator,rx_sig);
         results = step(BitError,u,y); 
         numErrs = results(2);                                          
         numBits = results(3);
    end
    ber =results(1);
    bits= results(3);
     reset(BitError);
     BER_vector(EbNo+1)=ber;
end
EbNoLin = 10.^(EbNo_vector/10);
theoretical_results = 0.5*erfc(sqrt(EbNoLin)); 
subplot(4,4,11);
semilogy(EbNo_vector,BER_vector);
grid on;
title('BER VS EbNo - 16QAM(FRM = 2048)') 
xlabel('Eb/No (dB)');
ylabel('BER');
hold;
semilogy(EbNo_vector,theoretical_results,'dr'); 
 hold;
legend('Simulation','Theoretical');

for EbNo=EbNo_vector                       %4096
    snr=EbNo+10*log10(2);
    AWGN.EbNo=snr;
    numErrs=0;
    numBits=0;
    results=zeros(3,10);
    while ((numErrs < maxNumErrs) && (numBits < maxNumBits))
           u = randi([0,1],FRM4,1); % Generate Random Bits
           mod_sig = step(Modulator,u);
           rx_sig = step(AWGN,mod_sig); 
          y = step(Demodulator,rx_sig);
         results = step(BitError,u,y); 
         numErrs = results(2);                                          
         numBits = results(3);
    end
    ber =results(1);
    bits= results(3);
     reset(BitError);
     BER_vector(EbNo+1)=ber;
end
EbNoLin = 10.^(EbNo_vector/10);
theoretical_results = 0.5*erfc(sqrt(EbNoLin)); 
subplot(4,4,12);
semilogy(EbNo_vector,BER_vector);
grid on;
title('BER VS EbNo - 16QAM(FRM = 4096)') 
xlabel('Eb/No (dB)');
ylabel('BER');
hold;
semilogy(EbNo_vector,theoretical_results,'dr'); 
 hold;
legend('Simulation','Theoretical');

%64QAM

 Modulator= comm.RectangularQAMModulator(64,'BitInput',true);
  AWGN = comm.AWGNChannel;
Demodulator = comm.RectangularQAMDemodulator(64,'BitOutput',true); 
BitError = comm.ErrorRate;
BER_vector=zeros(size(EbNo_vector));
for EbNo=EbNo_vector    %512
    snr=EbNo+10*log10(2);
    AWGN.EbNo=snr;
    numErrs=0;
    numBits=0;
    results=zeros(3,10);
    while ((numErrs < maxNumErrs) && (numBits < maxNumBits))
           u = randi([0,1],FRM1*6,1);
           mod_sig = step(Modulator,u);
           rx_sig = step(AWGN,mod_sig); 
          y = step(Demodulator,rx_sig);
         results = step(BitError,u,y); 
         numErrs = results(2);                                      
         numBits = results(3);
    end
    ber =results(1);
    bits= results(3);
     reset(BitError);
     BER_vector(EbNo+1)=ber;
end
EbNoLin = 10.^(EbNo_vector/10);
theoretical_results = 0.5*erfc(sqrt(EbNoLin)); 
subplot(4,4,13);
semilogy(EbNo_vector,BER_vector);
grid on;
title('BER VS EbNo - 64QAM(FRM = 512)') 
xlabel('Eb/No (dB)');
ylabel('BER');
hold;
semilogy(EbNo_vector,theoretical_results,'dr'); 
 hold;
legend('Simulation','Theoretical');

for EbNo=EbNo_vector    %1024
    snr=EbNo+10*log10(2);
    AWGN.EbNo=snr;
    numErrs=0;
    numBits=0;
    results=zeros(3,10);
    while ((numErrs < maxNumErrs) && (numBits < maxNumBits))
           u = randi([0,1],FRM2*6,1);
           mod_sig = step(Modulator,u);
           rx_sig = step(AWGN,mod_sig); 
          y = step(Demodulator,rx_sig);
         results = step(BitError,u,y); 
         numErrs = results(2);                                      
         numBits = results(3);
    end
    ber =results(1);
    bits= results(3);
     reset(BitError);
     BER_vector(EbNo+1)=ber;
end
EbNoLin = 10.^(EbNo_vector/10);
theoretical_results = 0.5*erfc(sqrt(EbNoLin)); 
subplot(4,4,14);
semilogy(EbNo_vector,BER_vector);
grid on;
title('BER VS EbNo - 64QAM(FRM = 1024)') 
xlabel('Eb/No (dB)');
ylabel('BER');
hold;
semilogy(EbNo_vector,theoretical_results,'dr'); 
 hold;
legend('Simulation','Theoretical');

for EbNo=EbNo_vector    %2048
    snr=EbNo+10*log10(2);
    AWGN.EbNo=snr;
    numErrs=0;
    numBits=0;
    results=zeros(3,10);
    while ((numErrs < maxNumErrs) && (numBits < maxNumBits))
           u = randi([0,1],FRM3*6,1);
           mod_sig = step(Modulator,u);
           rx_sig = step(AWGN,mod_sig); 
          y = step(Demodulator,rx_sig);
         results = step(BitError,u,y); 
         numErrs = results(2);                                      
         numBits = results(3);
    end
    ber =results(1);
    bits= results(3);
     reset(BitError);
     BER_vector(EbNo+1)=ber;
end
EbNoLin = 10.^(EbNo_vector/10);
theoretical_results = 0.5*erfc(sqrt(EbNoLin)); 
subplot(4,4,15);
semilogy(EbNo_vector,BER_vector);
grid on;
title('BER VS EbNo - 64QAM(FRM = 2048)') 
xlabel('Eb/No (dB)');
ylabel('BER');
hold;
semilogy(EbNo_vector,theoretical_results,'dr'); 
 hold;
legend('Simulation','Theoretical');

for EbNo=EbNo_vector    %4096
    snr=EbNo+10*log10(2);
    AWGN.EbNo=snr;
    numErrs=0;
    numBits=0;
    results=zeros(3,10);
    while ((numErrs < maxNumErrs) && (numBits < maxNumBits))
           u = randi([0,1],FRM4*6,1);
           mod_sig = step(Modulator,u);
           rx_sig = step(AWGN,mod_sig); 
          y = step(Demodulator,rx_sig);
         results = step(BitError,u,y); 
         numErrs = results(2);                                      
         numBits = results(3);
    end
    ber =results(1);
    bits= results(3);
     reset(BitError);
     BER_vector(EbNo+1)=ber;
end
EbNoLin = 10.^(EbNo_vector/10);
theoretical_results = 0.5*erfc(sqrt(EbNoLin)); 
subplot(4,4,16);
semilogy(EbNo_vector,BER_vector);
grid on;
title('BER VS EbNo - 64QAM(FRM = 4096)') 
xlabel('Eb/No (dB)');
ylabel('BER');
hold;
semilogy(EbNo_vector,theoretical_results,'dr'); 
 hold;
legend('Simulation','Theoretical');