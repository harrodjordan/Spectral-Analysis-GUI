%% SPECTRUM_EXTRACTION
%
% Spectrum_Extration() 
%
% GUI for a more interactive spectral analysis of EEG data
%
% TO USE: To help with code readability press ctrl and + simultaneously to
%         minimize all functions; all other directions are contained in
%         the readme on Github
%
% Written by Taylor Baum for NSRL at MIT (tbaum@mit.edu) - Last Updated 12/20/2017

function varargout = Spectrum_Extraction(varargin)
% Last Modified by GUIDE v2.5 18-Dec-2017 08:59:44

% Begin initialization code - DO NOT EDIT --------------------------------------------------------------------------------------------------------------------------------
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Spectrum_Extraction_OpeningFcn, ...
                   'gui_OutputFcn',  @Spectrum_Extraction_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end

function Spectrum_Extraction_OpeningFcn(hObject, eventdata, handles, varargin) 
% Choose default command line output for Spectrum_Extraction
handles.output = hObject;

global amplitude amplitudeArray

% initialize the check boxes to 0
handles.multi = 0;
handles.findPeaks = 0;
handles.typeRange = 0;

amplitudeArray = [1, 3, 5, 10, 25, 50, 75, 100, 125, 150, 200, 225, 250, 300, 350, 400, 450, 500];
amplitude = amplitudeArray(2);
ampValueString = sprintf('%.0f uV', amplitude);
set(handles.ampValue, 'String', ampValueString);

handles.cFontSize = 8;
handles.mostRecent = '';

guidata(hObject, handles);

timeSeriesDesign(1, handles);


function varargout = Spectrum_Extraction_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% TYPE-EDIT FIELD FUNCTIONS BY BAUM 2017 **********************************************************************************************************************

function timeSeriesLength_Callback(hObject, eventdata, handles)

handles.length = str2double(get(handles.timeSeriesLength, 'String'));
plot_Horizontal_Lines(handles)
guidata(hObject, handles);

function timeSeriesLength_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.length = 5;
guidata(hObject, handles);

function playbackSpeed_Callback(hObject, eventdata, handles)

handles.speed = str2double(get(handles.playbackSpeed, 'String'));
guidata(hObject, handles);

function playbackSpeed_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.speed = 1;
guidata(hObject, handles);

% BUTTON FUNCTIONS BY BAUM 2017 **********************************************************************************************************************

function anotherSpectrum_Callback(hObject, eventdata, handles)
% hObject    handle to anotherSpectrum (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global t1 nextIndex prevIndex

index = findClickPoint();

currentTime = t1(index);
nextIndex = index + 1;
prevIndex = index - 1;

% plotSpectrum(handles, index);

plot_Horizontal_Lines(handles);

plotTimeSeries(handles, currentTime, 0);

function Play_Callback(hObject, eventdata, handles)
% hObject    handle to Play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global t1 nextIndex prevIndex paramWinStep amplitude

i = findClickPoint();

nextIndex = i + 1;
prevIndex = i - 1;

set(handles.stopButton, 'UserData', 1)

while (get(handles.stopButton, 'UserData') ~= 0)
    
    % total iteration complete
    if i == length(t1)
        set(handles.stopButton, 'UserData', 0);
    end
    
    currentTime = t1(i); % current time value in seconds
    nextIndex = i + 1; % increment next index
    prevIndex = i + 1; % increment prev index
    
    axes(handles.spectrogram);
    xlim([currentTime - 60, currentTime + handles.length])
    
    timeSeriesDesign3(handles);

    for j = currentTime:handles.speed * .2:currentTime + paramWinStep
        axes(handles.timeSeries);
        xlim([j (j + handles.length)])
        timeSeriesTitle = sprintf('%d Second Time Series Starting at %.3f minute(s)|%.3f second(s)', handles.length, j/60, j);
        title(timeSeriesTitle)
        ylim([-amplitude/2, amplitude/2])
        yticks([-amplitude/2, amplitude/2])
        yticks([])
        pause(.2)
        get(handles.stopButton, 'UserData');
        if get(handles.stopButton, 'UserData') == 0
            break;
        end
    end
    
    i = i + 1; % increment
    pause(.01)
    get(handles.stopButton, 'UserData');
end

handles.mostRecent = 0;
guidata(hObject, handles);

function stopButton_Callback(hObject, eventdata, handles)
% hObject    handle to stopButton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

set(handles.stopButton, 'UserData', 0)
guidata(hObject, handles);

function fileUpload_Callback(hObject, eventdata, handles)
% hObject    handle to fileUpload (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,PathName,FilterIndex] = uigetfile('*.mat','Select the MATLAB code file');
addpath(PathName)
handles.fileStr = FileName;
set(handles.currentFile, 'String', FileName);
guidata(hObject, handles);
parameterPalette;
color_Callback(hObject, eventdata, handles)
replot(hObject, eventdata, handles)
timeSeriesDesign3(handles)

function next_Callback(hObject, eventdata, handles)

global nextIndex prevIndex t1

if handles.mostRecent == 1
    nextIndex = nextIndex + 2;
    prevIndex = prevIndex + 2;
else
    nextIndex = nextIndex + 1;
    prevIndex = prevIndex + 1;
end


currentTime = t1(nextIndex);

% plotSpectrum(handles, nextIndex);

axes(handles.spectrogram);
xlim([currentTime - 60, currentTime + handles.length])

plotTimeSeries(handles, currentTime, 1);

handles.mostRecent = 2;
guidata(hObject, handles);

function previous_Callback(hObject, eventdata, handles)

global prevIndex nextIndex t1

if handles.mostRecent == 2
    nextIndex = nextIndex - 2;
    prevIndex = prevIndex - 2;
else
    nextIndex = nextIndex - 1;
    prevIndex = prevIndex - 1;
end

currentTime = t1(prevIndex);

axes(handles.spectrogram);
xlim([currentTime - 60, currentTime + handles.length])

% plotSpectrum(handles, prevIndex);

plotTimeSeries(handles, currentTime, 2);

handles.mostRecent = 1;
guidata(hObject, handles);

function scoringSession_Callback(hObject, eventdata, handles)

global t1 paramWinSize ...
       paramWinStep paramTW paramTapers Fs

% set initial parameters
params.movingwin = [paramWinSize paramWinStep];
params.tapers = [paramTW paramTapers];
params.Fs = Fs;
bandpassFrequencies = [.1, 40];

set(handles.sessionState, 'String', 'open');

prompt = {'Your name: ', 'Desired file name for .txt file: ', 'Summary of purpose for session: ', 'Date: '};
title = 'Input';
dims = [4 100];
definput = {'', strtok(handles.currentFile.String, '.'), 'Annotation', date};
info = inputdlg(prompt,title,dims,definput);

fileName = info(2);
name = info(1);
purpose = info(3);
dateString = info(4);

f = fopen(fileName{1},'w');

fprintf(f, 'File being analyzed: %s\nSummary of session: %s\nCreated by %s on %s\n\n', fileName{1},  purpose{1}, name{1}, dateString{1});
fprintf(f, 'PARAMS: \n WinSize = %3f \n WinStep = %3f \n TW = %3f \n Tapers = %3f \n\n', paramWinSize, paramWinStep, paramTW, paramTapers);
fprintf(f, 'CSV Structure: \nStart of Event (sec), Start of Event (index), End of Event (sec), End of Event (index),  Name of Event\n\n');
fprintf(f, 'START\n');

stop = 0;

list = {'Burst','Sup','LOC','ROC','Awake','Arti','SCRAP', 'REM', 'NREM','Quiet'};

while ~stop
    want = inputdlg('To comment, type C. To exit, type E. ', 's');
    if want{1} == 'C'
        Message = 'Click Start of Event on the Spectrogram';
        Box = msgbox(Message);
        pause(.5)
        close(Box)
        
        message = sprintf('Adjust spectrogram to where you want to specify the event, and then click finish to click on the event!');
        uiwait(msgbox(message));
        
        beginningTimeIndex = findClickPoint;
        beginningTime = t1(beginningTimeIndex);
        
        Message = 'Click End of Event on the Spectrogram';
        Box = msgbox(Message);
        pause(.5)
        close(Box)
        
        message = sprintf('Adjust spectrogram to where you want to specify the event, and then click finish to click on the event!');
        uiwait(msgbox(message));
        
        endTimeIndex = findClickPoint;
        endTime = t1(endTimeIndex);
        
        [comment, tf] = listdlg('ListString',list);
        
        fprintf(f, '%3.3f, %3f, %3.3f, %3f, %s\n', beginningTime, beginningTimeIndex, endTime, endTimeIndex,  list{comment});

    elseif want{1} == 'E'
        stop = 1;
    else
        Message = 'Invalid input!';
        warningBox = msgbox(Message);
        pause(.5)
        close(warningBox)
    end
end

fclose(f);
set(handles.sessionState, 'String', 'closed');
Message = 'Scoring session is complete and file is now closed.';
msgbox(Message);

guidata(hObject, handles);

function color_Callback(hObject, eventdata, handles)

colorPalette; % outputs global lowColorBound and global highColorBound

replot(hObject, eventdata, handles)
guidata(hObject, handles);

function parameter_Callback(hObject, eventdata, handles)

parameterPalette; % outputs global paramWinSize paramTW paramWinStep and paramTapers

replot(hObject, eventdata, handles)
guidata(hObject, handles);

function power_Callback(hObject, eventdata, handles)

powerPalette
guidata(hObject, handles);

function timeSeriesBoundUp_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function timeSeriesBoundDown_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function timeSeriesBoundUp_Callback(hObject, eventdata, handles)

global amplitude amplitudeArray

for i = 1:length(amplitudeArray)
    if amplitude == amplitudeArray(i)
        if i == length(amplitudeArray)
            amplitude = amplitudeArray(1);
        else
            amplitude = amplitudeArray(i + 1);
        end
        break;
    end
end

ampValueString = sprintf('%.0f uV', amplitude);

set(handles.ampValue, 'String', ampValueString);

function timeSeriesBoundDown_Callback(hObject, eventdata, handles)

global amplitude amplitudeArray

for i = 1:length(amplitudeArray)
    if amplitude == amplitudeArray(i)
        if i == 1
            amplitude = amplitudeArray(end);
        else
            amplitude = amplitudeArray(i - 1);
        end
        break;
    end
end
ampValueString = sprintf('%.0f uV', amplitude);

set(handles.ampValue, 'String', ampValueString);

function getmoredata_Callback(hObject, eventdata, handles)
f = msgbox({strcat('Age:  ', num2str(handles.age));
         strcat('Weight:  ', num2str(handles.weight));
         strcat('Sex:  ', handles.sex);
         strcat('Surgery:  ', handles.surgery)});

% PLOTTING FUNCTIONS BY BAUM 2017 **********************************************************************************************************************

function replot(hObject, eventdata, handles)
% plots a spectrogram of the given data with the specified parameters in
% the edit windows of the GUI

global data filteredData channel multi dataName paramWinSize paramWinStep paramTW paramTapers S1 f1 t1 Fs lowColorBound highColorBound

handles.dataName = dataName;

plot_Horizontal_Lines(handles)

[D] = importdata(handles.fileStr);

if isstruct(D)
    if ~multi
        data = D.(handles.dataName);
        data = data.';
    else
        data = D.(handles.dataName)(channel,1:length(D.(handles.dataName)));
    end
    
     if isfield(D, 'trial_info')
         handles.age = D.trial_info.age;
         handles.weight = D.trial_info.weight_g;
         handles.sex = D.trial_info.sex;
         handles.surgery = D.trial_info.surgery;
    end
    
else
    data = D(channel,1:length(D));
end

% set initial parameters
params.movingwin = [paramWinSize paramWinStep];
params.tapers = [paramTW paramTapers];
params.Fs = Fs;
bandpassFrequencies = [.1, 40];

calculateBSP(handles, data);

% calculate spectrogram matrix
data = locdetrend(data,Fs,params.movingwin);
data = data.';
filteredData = quickbandpass(data, Fs, bandpassFrequencies);
[S1, t1, f1] = mtspecgramc(filteredData, params.movingwin, params);

% plot spectrogram
axes(handles.spectrogram);
plot_matrix(S1, t1, f1);
title('60 Second Spectrogram')
xlabel([]);
caxis([lowColorBound highColorBound]);
map = jet;
colormap(map)
c = colorbar;
c.Location = 'southoutside';
x = get(c, 'Position');
x(2) = .145;
x(1) = .035;
% x(3) = .6;
% x(4) = .02;
set(c, 'Position', x)
xlabel(c, 'Power (dB)')
set(c, 'FontSize', handles.cFontSize)
% sec2hms
ylim([0,40])
xlabel('Time (sec)');
map = jet;
colormap(map)
ylabel('Frequency (Hz)')
scrollzoompan;

plotTimeSeriesInitial(handles)
guidata(hObject, handles);

function plotSpectrum(handles, i)

global S1 f1 t1 amplitude

currentTime = t1(i);

axes(handles.axes2);
powerArray = S1(i, 1:end); % obtain spectrogram
plot(f1, 10*log10(powerArray)); % plot spectrum
xlim([0,40])
ylim([-20, 60])
spectrumTitle = sprintf('Spectrum at %.3f minute(s)|%.3f second(s)', currentTime/60, currentTime);
title(spectrumTitle)
xlabel('Frequency (Hz)')
ylabel('Power in dB Scale')

if handles.findPeaks
    [peakLoc, peakMag] = peakfinder(10*log10(powerArray), 5, 0);

    hold on
    plot(f1(peakLoc), peakMag, 'ro')
    hold off
end

function plotTimeSeriesInitial(handles)

global Fs filteredData

dataSnip = extractdatac(filteredData, Fs, [0 length(filteredData)]);

axes(handles.timeSeries);
tSnip = 1/Fs:1/Fs:length(dataSnip)/Fs;
plot(tSnip, dataSnip,'b-')

function plotTimeSeries(handles, currentTime, oneSpectrum)

global paramWinStep 

axes(handles.timeSeries);
switch oneSpectrum
    case 0
        timeSeriesDesign2(handles, currentTime); 
    case 1
        for i = (currentTime - paramWinStep):.05:currentTime
            
            timeSeriesDesign(i, handles);

            if i ~= (currentTime)
                pause(.005)
            end
            
            if (get(handles.stopButton, 'UserData') == 0)
                break;
            end

        end
    case 2
        for i = currentTime:-.05:(currentTime - paramWinStep)

            timeSeriesDesign(i, handles);
            
            if i ~= (currentTime - paramWinStep)
                pause(.005)
            end
            
            if (get(handles.stopButton, 'UserData') == 0)
                break;
            end

        end
    case 3
        for i = currentTime:.05:currentTime + paramWinStep

            timeSeriesDesign(i, handles);
            
            if i ~= currentTime + paramWinStep
                pause(.005)
            end
            
            if (get(handles.stopButton, 'UserData') == 0)
                break;
            end
        end      
end

function plot_Horizontal_Lines(handles)

axes(handles.horizontalLine)

plot(1)

xlim([-handles.length 0])
xticks(-1 * handles.length:1:0)
yticks([])
ylabel('')                
yticklabels([])
set(gca,'color','none')
set(gca, 'Box', 'off')
plt = gca;
plt.XAxis.Color = 'none';
plt.YAxis.Color = 'none';
ylabel('') 

grid on

function timeSeriesDesign(i, handles)

global amplitude

axes(handles.timeSeries)

xlim([i (i + handles.length)])
xlabel('Time (min)')
ylabel('Voltage (uV)')
timeSeriesTitle = sprintf('%d Second Time Series Starting at %.3f minute(s)|%.3f second(s)', handles.length, i/60, i);
title(timeSeriesTitle)
ylim([-amplitude/2, amplitude/2])
yticks([])
ylabel('')                
yticklabels([])
set(gca,'color','none')
set(gca, 'Box', 'off')
plt = gca;
% plt.XAxis.Color = 'none';
plt.YAxis.Color = 'none';
ylabel('') 

function timeSeriesDesign2(handles, currentTime)

global amplitude

axes(handles.timeSeries)

xlabel('Time (min)')
ylabel('Voltage (uV)')
xlim([currentTime (currentTime + handles.length)])
timeSeriesTitle = sprintf('%d Second Time Series Starting at %.3f minute(s)|%.3f second(s)', handles.length, currentTime/60, currentTime);
title(timeSeriesTitle)
ylim([-amplitude/2, amplitude/2])
yticks([])
ylabel('')                
yticklabels([])
% set(gca,'color','none')
set(gca, 'Box', 'off')
plt = gca;
% plt.XAxis.Color = 'none';
plt.YAxis.Color = 'none';
ylabel('') 

function timeSeriesDesign3(handles)

axes(handles.timeSeries);

yticks([])
ylabel('')                
yticklabels([])
set(gca,'color','none')
set(gca, 'Box', 'off')
plt = gca;
plt.XAxis.Color = 'none';
plt.YAxis.Color = 'none';
ylabel('') 

% FIND CLICK POINT FUNCTIONS BY BAUM 2017 **********************************************************************************************************************

function timeIndex = findClickPoint()

global t1

% Plot a spectrum at desired time from click input
[desiredTime, desiredFrequency] = ginput(1);
actualTime = floor(desiredTime);
timeError = (t1(2) - t1(1))/2;
gotIt = false;

% transfer click point to actual S1 matrix
for i = 1:length(t1)
    currentTime = floor(t1(i));
    if currentTime == actualTime
        index = i;
        gotIt = true;
    end    
end

% approximated click point if the value doesn't exactly match the stored S1
if ~gotIt
    for i = 1:length(t1)
        currentTime = floor(t1(i));
        if ((floor((currentTime) + timeError)) >= actualTime) && ((floor((currentTime) - timeError)) <= actualTime)
            index = i;
        end    
   end
end

timeIndex = index;

function freqIndex = findClickPointFreq()

global t1 f1

% Plot a spectrum at desired time from click input
[desiredTime, desiredFrequency] = ginput(1);
actualFreq = floor(desiredFrequency);
freqError = (f1(2) - f1(1))/2;
gotIt = false;

% transfer click point to actual S1 matrix
for i = 1:length(f1)
    currentFreq = floor(f1(i));
    if currentFreq == actualFreq
        index = i;
        gotIt = true;
    end    
end

% approximated click point if the value doesn't exactly match the stored S1
if ~gotIt
    for i = 1:length(f1)
        currentFreq = floor(f1(i));
        if ((floor((currentFreq) + freqError)) >= actualFreq) && ((floor((currentFreq) - freqError)) <= actualFreq)
            index = i;
        end    
   end
end

freqIndex = index;

function calculateBSP(handles, x_t)

    global Fs t1

    Beta = .9534;
    theta = .3;

    axes(handles.BSP);
    
    bandpassFrequencies = [1, 55];

    % Detrend Data and Filter
    x_t = quickbandpass(x_t, Fs, bandpassFrequencies);

    % Segment Binary Time Series
    for i = 1:length(x_t)  
        if i == 1
            u_t(i) = 1;
            sigma_squared(i) = 1;
        else
            u_t(i) = (Beta * u_t(i-1)) + ((1 - Beta)* x_t(i));
            sigma_squared(i) = (Beta * sigma_squared(i - 1)) + ((1-Beta)*(x_t(i)-u_t(i))) ^ 2;
        end
        z_t(i) = sigma_squared(i) < theta;
    end 

    Nt=length(z_t); t=(0:Nt-1)/Fs; eeg=x_t; binary_data=z_t; 
    
    t = linspace(0, t1(end), length(z_t));
    b = bar(t, z_t, 1)
    b.FaceColor = 'k'; b.EdgeColor = 'k'; 

    linkaxes([handles.spectrogram, handles.BSP], 'x')
    
    
    %%% add code for the model


