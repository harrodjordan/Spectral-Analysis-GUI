
%% use example :

% Define cutoff frequencies
TT = 120;
sofreq = 10;
orderfilt = 1;
alfreq = 15;
phasefreq = [2 4]; ampfreq = [9 11]; order=100;
Npb=18;
pbins=linspace(-pi, pi, Npb+1);
PAMusual=zeros(Npb, TT);
lengthWind = 120;

%loop on ~120s windows
for tt=1:TT
    [x_so, tail1] = quickbandpass(signal(tt), Fs, sofreq,orderfilt);
    [x_al, tail2] = quickbandpass(signal(tt), Fs, alfreq,orderfilt);
    
    Phi_filt_so=angle(hilbert(x_so));
    A_filt_al  =  abs(hilbert(x_al));

    pam_filt_tmp=phaseamp(A_filt_al ,Phi_filt_so,pbins);
    PAMusual(:,tt)=pam_filt_tmp;
    
end

figure;

imagesc((1:TT)*lengthWind/(Fs*60),pbins,PAMusual);
col = redbluemap; cax=colormap(p6,col);
set(gca, 'clim', [0.2 1.8]); %0.2-1.8
xlabel('(min)');
ylabel('(rad)')