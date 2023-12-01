sampleTime=1/500000;
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
ricChan.StoreHistory=1;
hMod=comm.QPSKModulator('BitInput',true,'PhaseOffset',pi/4);
bitsPerFrame=1000;
msg=randi([0 1],bitsPerFrame,1);
modSignal=step(hMod,msg);
filter(rayChanObj,modSignal);
filter(ricChanObj,modSignal);
%channel_vis(rayChanObj,'Visualization','ir');
% channel_vis(rayChanObj,'Animation','medium');
 %channel_vis(rayChanObj,'SampleIndex',1);
plot(rayChanObj);
%channel_vis(rayChanObj,'close');
sampleTime=1/20000;
bitsPerFrame=1000;
numFrames=20;
rayChanObj=rayleighchan(sampleTime,maxDopplerShift,delayVector,...
    gainVector);
rayChanObj.StoreHistory=1;
rayChanObj.ResetBeforeFiltering=0;
for i=1:numFrames
    msg=randi([0 1],bitsPerFrame,1);
    modSignal=step(hMod,msg);
    filter(rayChanObj,modSignal);
    %channel_vis(rayChanObj,'Visualization','fr');
    %plot(rayChanObj);
end
plot(rayChanObj);
%channel_vis(rayChanObj,'Animation','medium');
%channel_vis(rayChanObj,'SampleIndex',1);
%channel_vis(rayChanObj,'Visualization','gain');
%channel_vis(rayChanObj,'Visualization','phasor');
%channel_vis(rayChanObj,'Animation','slow');
%channel_vis(rayChanObj,'SampleIndex',1);
%channel_vis(rayChanObj,'Visualization','gain');
%channel_vis(rayChanObj,'close');
%channel_vis(rayChanObj,'Visualization','doppler');