sampleTime=1/50000;
maxDopplerShift=200;
delayVector=1.0e-004*[0 0.0400 0.0800 0.1200];
gainVector=[0 -3 -6 -9];
specDopplerShift=100;
KFactor=10;
rayChanObj=rayleighchan(sampleTime,maxDopplerShift,delayVector,...
gainVector);
rayChanObj.StoreHistory=1;
ricChanObj=ricianchan(sampleTime,maxDopplerShift,KFactor,...
    delayVector,gainVector,specDopplerShift);
ricChanObj.StoreHistory=1;
hMod=comm.QPSKModulator();%hMod=comm.RectangularQAMModulator(16);%hMod=comm.RectangularQAMModulator(64);
%hMod=comm.QPSKModulator('bitInput',true,'PhaseOffset',pi/4);
bitsPerFrame=1000;
msg=randi([0 1],bitsPerFrame,1);
modSignal=step(hMod,msg);
filter(rayChanObj,modSignal);
filter(ricChanObj,modSignal);
plot(rayChanObj);
delayVector=(0.3)*(4e-6);
gainVector=(0.3)*(4e-6);
maxDopplerShift=5;
channel_vis(rayChanObj,'close');
h = scatterplot(0);
title('Received Signal after Rayleigh fading');
xlabel('In-phase amplitude');
ylabel('Quadrature amplitude');
xlim([-2 2]);
ylim([-2 2]);
grid on;
rayChanObj=rayleighchan(sampleTime,maxDopplerShift,delayVector,...
    gainVector);
rayChanObj.StoreHistory=1;
rayChanObj.ResetBeforeFiltering=0;
numFrames=100;
for i=1:numFrames
    msg=randi([0 1],bitsPerFrame,1);
    modSignal=step(hMod,msg);
    rayFiltSig=filter(rayChanObj,modSignal); 
end
set(get(get(h,'Children','Children'),'XData',...
    real(rayFiltSig(6:end)),'Ydata',imag(rayFiltSig(6:end))));
pause(0.05);
drawnow;
close(h);
reset(rayChanObj);
rayChanObj.InputSamplePeriod=1/500000;
h=scatterplot(0);
title('Received Signal after Rayleigh fading');
xlabel('In-phase amplitude');
ylabel('Quadrature amplitude');
xlim([-2 2]);
ylim([-2 2]);
grid on;
close(h);
reset(rayChanObj);
bitsPerFrame=1000;
rayChanObj.MaxDopplerShift=200;
numFrames=13;
for i=1:numFrames
    msg=randi([0 1],bitsPerFrame,1);
    modSignal=step(hMod,msg);
    filter(rayChanObj,modSignal); 
end
plot(rayChanObj);


