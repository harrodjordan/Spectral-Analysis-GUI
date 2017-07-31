% Written by Taylor Baum for NSRL at MIT (tbaum@mit.edu) - Last Updated 7/10/2017
% Pretend Copyrighted '17

% powerPalette

function varargout = powerPalette(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @powerPalette_OpeningFcn, ...
                   'gui_OutputFcn',  @powerPalette_OutputFcn, ...
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

function powerPalette_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

guidata(hObject, handles);

function varargout = powerPalette_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;

function minute1_Callback(hObject, eventdata, handles)

global min1 sec1

min1 = str2double(get(handles.minute1, 'String'));
sec1 = floor(min1 * 60);

function minute1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

global min1 sec1

min1 = 5;
sec1 = floor(min1 * 60);

function minute2_Callback(hObject, eventdata, handles)

global min2 sec2

min2 = str2double(get(handles.minute2, 'String'));
sec2 = floor(min2 * 60);
guidata(hObject, handles);

function minute2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

global min2 sec2

min2 = 10;
sec2 = floor(min2 * 60);

function deltaPower_Callback(hObject, eventdata, handles)

global f1 t1 sec1 sec2

timeIterationLength = t1(2) - t1(1);
timeIndex1 = floor(sec1 / timeIterationLength);
timeIndex2 = floor(sec2 / timeIterationLength);

freqIterationLength = f1(2) - f1(1);
freqIndex1 = floor(1/freqIterationLength);
freqIndex2 = floor(4/freqIterationLength);

calculatedPower = findPower(timeIndex1, timeIndex2, freqIndex1, freqIndex2);
totalCalculatedPower = findPower(timeIndex1, timeIndex2, 1, floor(40/freqIterationLength));
percentPower = 100 * calculatedPower/totalCalculatedPower;

powerMessage = sprintf('The total power fron %.0f seconds to %.0f seconds from %.0f Hz to %.0f Hz is %.3f dB. This is %.3f percent of the total power for this time window.', timeIndex1 * timeIterationLength, timeIndex2 * timeIterationLength, freqIndex1 * freqIterationLength, freqIndex2 * freqIterationLength, 10 * log10(calculatedPower), percentPower);
msgbox(powerMessage)

function slowPower_Callback(hObject, eventdata, handles)

global f1 t1 sec1 sec2

timeIterationLength = t1(2) - t1(1);
timeIndex1 = floor(sec1 / timeIterationLength);
timeIndex2 = floor(sec2 / timeIterationLength);

freqIterationLength = f1(2) - f1(1);
freqIndex1 = floor(.1/freqIterationLength);
if freqIndex1 == 0
    freqIndex1 = 1;
end
freqIndex2 = floor(1/freqIterationLength);

calculatedPower = findPower(timeIndex1, timeIndex2, freqIndex1, freqIndex2);
totalCalculatedPower = findPower(timeIndex1, timeIndex2, 1, floor(40/freqIterationLength));
percentPower = 100 * calculatedPower/totalCalculatedPower;

powerMessage = sprintf('The total power fron %.0f seconds to %.0f seconds from %.0f Hz to %.0f Hz is %.3f dB. This is %.3f percent of the total power for this time window.', timeIndex1 * timeIterationLength, timeIndex2 * timeIterationLength, freqIndex1 * freqIterationLength, freqIndex2 * freqIterationLength, 10 * log10(calculatedPower), percentPower);
msgbox(powerMessage)

function alphaPower_Callback(hObject, eventdata, handles)

global f1 t1 sec1 sec2

timeIterationLength = t1(2) - t1(1);
timeIndex1 = floor(sec1 / timeIterationLength);
timeIndex2 = floor(sec2 / timeIterationLength);

freqIterationLength = f1(2) - f1(1);
freqIndex1 = floor(7.5/freqIterationLength);
freqIndex2 = floor(12.5/freqIterationLength);

calculatedPower = findPower(timeIndex1, timeIndex2, freqIndex1, freqIndex2);
totalCalculatedPower = findPower(timeIndex1, timeIndex2, 1, floor(40/freqIterationLength));
percentPower = 100 * calculatedPower/totalCalculatedPower;

powerMessage = sprintf('The total power fron %.0f seconds to %.0f seconds from %.0f Hz to %.0f Hz is %.3f dB. This is %.3f percent of the total power for this time window.', timeIndex1 * timeIterationLength, timeIndex2 * timeIterationLength, freqIndex1 * freqIterationLength, freqIndex2 * freqIterationLength, 10 * log10(calculatedPower), percentPower);
msgbox(powerMessage)

function betaPower_Callback(hObject, eventdata, handles)

global f1 t1 sec1 sec2

timeIterationLength = t1(2) - t1(1);
timeIndex1 = floor(sec1 / timeIterationLength);
timeIndex2 = floor(sec2 / timeIterationLength);

freqIterationLength = f1(2) - f1(1);
freqIndex1 = floor(12.5/freqIterationLength);
freqIndex2 = floor(30/freqIterationLength);

calculatedPower = findPower(timeIndex1, timeIndex2, freqIndex1, freqIndex2);
totalCalculatedPower = findPower(timeIndex1, timeIndex2, 1, floor(40/freqIterationLength));
percentPower = 100 * calculatedPower/totalCalculatedPower;

powerMessage = sprintf('The total power fron %.0f seconds to %.0f seconds from %.0f Hz to %.0f Hz is %.3f dB. This is %.3f percent of the total power for this time window.', timeIndex1 * timeIterationLength, timeIndex2 * timeIterationLength, freqIndex1 * freqIterationLength, freqIndex2 * freqIterationLength, 10 * log10(calculatedPower), percentPower);
msgbox(powerMessage)

function totalPower_Callback(hObject, eventdata, handles)

global f1 t1 sec1 sec2

timeIterationLength = t1(2) - t1(1);
timeIndex1 = floor(sec1 / timeIterationLength);
timeIndex2 = floor(sec2 / timeIterationLength);

freqIterationLength = f1(2) - f1(1);
freqIndex1 = 1;
freqIndex2 = floor(40/freqIterationLength);

calculatedPower = findPower(timeIndex1, timeIndex2, freqIndex1, freqIndex2);
totalCalculatedPower = findPower(timeIndex1, timeIndex2, 1, floor(40/freqIterationLength));
percentPower = 100 * calculatedPower/totalCalculatedPower;

powerMessage = sprintf('The total power fron %.0f seconds to %.0f seconds from %.0f Hz to %.0f Hz is %.3f dB. This is %.3f percent of the total power for this time window.', timeIndex1 * timeIterationLength, timeIndex2 * timeIterationLength, freqIndex1 * freqIterationLength, freqIndex2 * freqIterationLength, 10 * log10(calculatedPower), percentPower);
msgbox(powerMessage)

function power = findPower(tIndex1, tIndex2, fIndex1, fIndex2)

global S1

sum = 0; % total power specified in the region


for i = tIndex1 : tIndex2
    for j = fIndex1 : fIndex2
        sum = sum + S1(i,j);
    end
end

power = sum;
