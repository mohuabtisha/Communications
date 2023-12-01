function[ber,bits]=exp2(EbNo,MaxNumErrs,MaxNumBits)
persistent Modulator AWGN DeModulator BitError
if isempty(Modulator)
    Modulator = comm.QPSKModulator('BitInput',true);
    AWGN = comm.AWGNChannel;
    DeModulator = comm.QPSKDemodulator('BitOutput',true);
       BitError = comm.ErrorRate;
end
FRM=1024;
M=4;
k=log2(M)
 Snr = EbNo + 10*log10(k);
AWGN.EbNo= Snr
numErrs=0;
numBits=0;
results=zeros(3,1);
while((numErrs<MaxNumErrs)&&(numBits<MaxNumBits))
    u=randi([0,1],FRM,1);
    mod_sig=step(Modulator,u);
    rx_sig=step(AWGN,mod_sig);
    y=step(DeModulator,rx_sig);
    results=step(BitError,u,y);
    numErrs=results(2);
    numBits=results(3);
end
ber=results(1);
bits=results(3);
reset(BitError);