clc;
clear all;
hte= 100;
hre=100;
sdA=3;
sdB=5;
noiseA=sdA*randn(1,200);
noiseB=sdB*randn(1,200);
disp('Uplink Frequency=635/835/1235MHz')
disp('Downlink Frequency=680/880/1280MHz')
fc=input('put the Uplink or Downlink Frequency in MHz:')

for d=1:200
    LA(d)=46.3+33.9*log(fc)-13.82*log(hte)-[(1.1*log(fc)-0.7)*hre-[1.56*log(fc)-0.8]]+[44.9-6.55*log(hte)]*log(d)+3
    LB(d)=46.3+33.9*log(fc)-13.82*log(hte)-[(1.1*log(fc)-0.7)*hre-[1.56*log(fc)-0.8]]+[44.9-6.55*log(hte)]*log(201-d)+3
    LF(d)= 35+20*log10(fc)+20*log10(d)
    SrA(d)=60-LA(d);
    SrB(d)=60-LB(d);
    PrA(d)=60-LA(d)+noiseA(d);
    PrB(d)=60-LB(d)+noiseB(d);
end
figure(1)
grid on;
xlabel('Distance(m)');
ylabel('Received Power(dBm)');
hold on;
plot(PrA, 'b');
plot(PrB, 'r');
hold on;
legend('From Base Station A', 'From Base Station B')