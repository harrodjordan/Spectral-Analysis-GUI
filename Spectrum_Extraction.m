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

% initialize the check boxes to 0
handles.multi = 0;
handles.findPeaks = 0;
handles.typeRange = 0;

guidata(hObject, handles);

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
guidata(hObject, handles);

function timeSeriesLength_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

handles.length = 30;
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

plotSpectrum(handles, index);

plotTimeSeries(handles, currentTime, 0);

function Play_Callback(hObject, eventdata, handles)
% hObject    handle to Play (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global t1 nextIndex prevIndex

i = findClickPoint();

nextIndex = i + 1;
prevIndex = i - 1;

set(handles.stopButton, 'UserData', 1)

while (get(handles.stopButton, 'UserData') ~= 0)
    
    % total iteration complete
    if i == length(t1)
        set(handles.Play, 'UserData', 0);
    end
    
    currentTime = t1(i); % current time value in seconds
    nextIndex = i + 1; % increment next index
    prevIndex = i + 1; % increment prev index
    
    plotSpectrum(handles, i);
    
    plotTimeSeries(handles, currentTime, 3);
    
    i = i + 1; % increment
    
    get(handles.stopButton, 'UserData')
end

nextIndex = i + 1;

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
replot(handles)

function next_Callback(hObject, eventdata, handles)

global nextIndex prevIndex t1

currentTime = t1(nextIndex);

plotSpectrum(handles, nextIndex);

plotTimeSeries(handles, currentTime, 1);

nextIndex = nextIndex + 1;
prevIndex = prevIndex + 1;

function previous_Callback(hObject, eventdata, handles)

global prevIndex nextIndex t1

currentTime = t1(prevIndex);

plotSpectrum(handles, prevIndex);

plotTimeSeries(handles, currentTime, 2);

nextIndex = nextIndex - 1;
prevIndex = prevIndex - 1;

function scoringSession_Callback(hObject, eventdata, handles)

global t1

set(handles.sessionState, 'String', 'open');

name = input('Your name: ','s');
fileName = input('Desired file name for .txt file: ', 's');
purpose = input('Summary of purpose for session: ', 's');
date = input('Date (mm/dd/yyyy): ', 's');

f = fopen(fileName,'w');
fprintf(f, 'FILE: %s\nCREATED BY: %s on %s\nPURPOSE: %s\n\n', fileName, name, date, purpose);

stop = 0;

while ~stop
    want = input('----------------------\nTo comment, type C\nTo exit, type E\n----------------------\nINPUT: ', 's');
    if want == 'C'
        timeIndex = findClickPoint;
        time = t1(timeIndex);
        comment = input('Comment: ', 's');
        fprintf(f, 'At %3.3f (min): %s\n', time/60, comment);
    elseif want == 'E'
        stop = 1;
    else
        Message = 'Invalid input!';
        msgbox(Message);
    end
end

fclose(f);
set(handles.sessionState, 'String', 'closed');
Message = 'Scoring session is complete and file is now closed.';
msgbox(Message);

function color_Callback(hObject, eventdata, handles)

colorPalette; % outputs global lowColorBound and global highColorBound

replot(handles)

function parameter_Callback(hObject, eventdata, handles)

parameterPalette; % outputs global paramWinSize paramTW paramWinStep and paramTapers

replot(handles)

function power_Callback(hObject, eventdata, handles)

powerPalette

% PLOTTING FUNCTIONS BY BAUM 2017 **********************************************************************************************************************

function replot(handles)
% plots a spectrogram of the given data with the specified parameters in
% the edit windows of the GUI

global data filteredData channel multi dataName paramWinSize paramWinStep paramTW paramTapers S1 f1 t1 Fs lowColorBound highColorBound

handles.dataName = dataName;

[D] = importdata(handles.fileStr);

if ~multi
    data = D.(handles.dataName);
    data = data.';
else
    data = D.(handles.dataName)(channel,1:length(D.(handles.dataName)));
end

% set initial parameters
params.movingwin = [paramWinSize paramWinStep];
params.tapers = [paramTW paramTapers];
params.Fs = Fs;
bandpassFrequencies = [0, 40];

% calculate spectrogram matrix
data = locdetrend(data,Fs,params.movingwin);
data = data.';
filteredData = quickbandpass(data, Fs, bandpassFrequencies);
[S1, t1, f1] = mtspecgramc(filteredData, params.movingwin, params);

% plot spectrogram
axes(handles.spectrogram);
plot_matrix(S1, t1, f1);
xlabel([]);
caxis([lowColorBound highColorBound]);
% sec2hms
ylim([0,40])
xlabel('Time (sec)');
map = jet;
colormap(map)
ylabel('Frequency (Hz)')
scrollzoompan;

function plotSpectrum(handles, i)

global S1 f1 t1

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

function plotTimeSeries(handles, currentTime, oneSpectrum)

global Fs filteredData t1 paramWinStep

axes(handles.axes5);
switch oneSpectrum
    case 0
        dataSnip = extractdatac(filteredData, Fs, [currentTime (currentTime + handles.length)]);
        tSnip = 1:1:length(dataSnip);
        plot(tSnip, dataSnip,'b-')
        xlabel('Time (min)')
        ylabel('Voltage (mV)')
        set(gca, 'XTick', 0:5*(250):length(tSnip));          
        set(gca, 'XTickLabel', 0:5:t1(end)); 
        timeSeriesTitle = sprintf('%d Second Time Series Starting at %.3f minute(s)|%.3f second(s)', handles.length, currentTime/60, currentTime);
        title(timeSeriesTitle)
    case 1
        for i = currentTime - paramWinStep:currentTime
            dataSnip = extractdatac(filteredData, Fs, [i (i + handles.length)]);
            tSnip = 1:1:length(dataSnip);

            plot(tSnip, dataSnip,'b-')
            xlabel('Time (min)')
            ylabel('Voltage (mV)')
            set(gca, 'XTick', 0:5*(250):length(tSnip));          
            set(gca, 'XTickLabel', 0:5:t1(end)); 
            timeSeriesTitle = sprintf('%d Second Time Series Starting at %.3f minute(s)|%.3f second(s)', handles.length, i/60, i);
            title(timeSeriesTitle)

            if i ~= currentTime + 4
                pause(.05)
            end
        end
    case 2
        for i = currentTime:-1:currentTime - paramWinStep
            dataSnip = extractdatac(filteredData, Fs, [i (i + handles.length)]);
            tSnip = 1:1:length(dataSnip);

            plot(tSnip, dataSnip,'b-')
            xlabel('Time (min)')
            ylabel('Voltage (mV)')
            set(gca, 'XTick', 0:5*(250):length(tSnip));          
            set(gca, 'XTickLabel', 0:5:t1(end)); 
            timeSeriesTitle = sprintf('%d Second Time Series Starting at %.3f minute(s)|%.3f second(s)', handles.length, i/60, i);
            title(timeSeriesTitle)

            if i ~= currentTime + 4
                pause(.05)
            end
        end
    case 3
        for i = currentTime:currentTime + paramWinStep
            dataSnip = extractdatac(filteredData, Fs, [i (i + handles.length)]);
            tSnip = 1:1:length(dataSnip);

            plot(tSnip, dataSnip,'b-')
            xlabel('Time (min)')
            ylabel('Voltage (mV)')
            set(gca, 'XTick', 0:5*(250):length(tSnip));          
            set(gca, 'XTickLabel', 0:5:t1(end)); 
            timeSeriesTitle = sprintf('%d Second Time Series Starting at %.3f minute(s)|%.3f second(s)', handles.length, i/60, i);
            title(timeSeriesTitle)

            if i ~= currentTime + 4
                pause(.05)
            end
        end
end

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
