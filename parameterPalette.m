% Written by Taylor Baum for NSRL at MIT (tbaum@mit.edu) - Last Updated 7/10/2017
% Pretend Copyrighted '17

% parameterPalette

function varargout = parameterPalette(varargin)
% PARAMETERPALETTE MATLAB code for parameterPalette.fig
%      PARAMETERPALETTE, by itself, creates a new PARAMETERPALETTE or raises the existing
%      singleton*.
%
%      H = PARAMETERPALETTE returns the handle to a new PARAMETERPALETTE or the handle to
%      the existing singleton*.
%
%      PARAMETERPALETTE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PARAMETERPALETTE.M with the given input arguments.
%
%      PARAMETERPALETTE('Property','Value',...) creates a new PARAMETERPALETTE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before parameterPalette_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to parameterPalette_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help parameterPalette

% Last Modified by GUIDE v2.5 19-Dec-2017 23:24:54

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @parameterPalette_OpeningFcn, ...
                   'gui_OutputFcn',  @parameterPalette_OutputFcn, ...
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

function parameterPalette_OpeningFcn(hObject, eventdata, handles, varargin)

global multi

handles.output = hObject;

guidata(hObject, handles);

multi = 0;

uiwait(handles.figure1);

function varargout = parameterPalette_OutputFcn(hObject, eventdata, handles) 

global paramWinSize paramWinStep paramTW paramTapers

delete(handles.figure1);

function paramWinSize_Callback(hObject, eventdata, handles)
% hObject    handle to paramWinSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of paramWinSize as text
%        str2double(get(hObject,'String')) returns contents of paramWinSize as a double

global paramWinSize

paramWinSize = str2double(get(handles.paramWinSize, 'String')); % get current value when it is changed

function paramWinSize_CreateFcn(hObject, eventdata, handles)
% hObject    handle to paramWinSize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

global paramWinSize

paramWinSize = 8;

function paramWinStep_Callback(hObject, eventdata, handles)
% hObject    handle to paramWinStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% Hints: get(hObject,'String') returns contents of paramWinStep as text
%        str2double(get(hObject,'String')) returns contents of paramWinStep as a double

global paramWinStep

paramWinStep = str2double(get(handles.paramWinStep, 'String')); % get current value when it is changed

function paramWinStep_CreateFcn(hObject, eventdata, handles)
% hObject    handle to paramWinStep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

global paramWinStep

paramWinStep = 4;

function paramTW_Callback(hObject, eventdata, handles)
% hObject    handle to paramTW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of paramTW as text
%        str2double(get(hObject,'String')) returns contents of paramTW as a double

global paramTW

paramTW = str2double(get(handles.paramTW, 'String')); % get current value when it is changed

function paramTW_CreateFcn(hObject, eventdata, handles)
% hObject    handle to paramTW (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

global paramTW

paramTW = 4;

function paramTapers_Callback(hObject, eventdata, handles)
% hObject    handle to paramTapers (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of paramTapers as text
%        str2double(get(hObject,'String')) returns contents of paramTapers as a double

global paramTapers;

paramTapers = str2double(get(handles.paramTapers, 'String')); % get current value when it is changed

function paramTapers_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

global paramTapers;

paramTapers = 4;

function multiChannel_Callback(hObject, eventdata, handles)
% hObject    handle to multiChannel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global multi
multi = get(hObject,'Value');

function dataName_Callback(hObject, eventdata, handles)
% hObject    handle to dataName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dataName as text
%        str2double(get(hObject,'String')) returns contents of dataName as a double

global dataName

dataName = get(hObject,'String');

function dataName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dataName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

global dataName
dataName = 'data';

function samplingFrequency_Callback(hObject, eventdata, handles)
% hObject    handle to samplingFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of samplingFrequency as text
%        str2double(get(hObject,'String')) returns contents of samplingFrequency as a double

global Fs

Fs = str2double(get(handles.samplingFrequency, 'String')); % get current value when it is changed

replot(handles);

function samplingFrequency_CreateFcn(hObject, eventdata, handles)
% hObject    handle to samplingFrequency (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

global Fs

Fs = 250;

function channel_Callback(hObject, eventdata, handles)
% hObject    handle to channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global channel

channel = str2double(get(hObject,'String'));

function channel_CreateFcn(hObject, eventdata, handles)
% hObject    handle to channel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

global channel
channel = 1;

function figure1_CloseRequestFcn(hObject, eventdata, handles)

if isequal(get(hObject,'waitstatus'), 'waiting')
    uiresume(hObject);
else
    delete(hObject);
end


% --- Executes on button press in ok.
function ok_Callback(hObject, eventdata, handles)
% hObject    handle to ok (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

close
