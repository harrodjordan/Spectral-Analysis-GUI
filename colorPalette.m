% Written by Taylor Baum for NSRL at MIT (tbaum@mit.edu) - Last Updated 7/10/2017
% Pretend Copyrighted '17

% colorPalette

function varargout = colorPalette(varargin)
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @colorPalette_OpeningFcn, ...
                   'gui_OutputFcn',  @colorPalette_OutputFcn, ...
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

function colorPalette_OpeningFcn(hObject, eventdata, handles, varargin)

% Choose default command line output for colorPalette
handles.output = hObject;

guidata(hObject, handles);

uiwait(handles.figure1)

function varargout = colorPalette_OutputFcn(hObject, eventdata, handles) 

delete(handles.figure1);

function lowColor_Callback(hObject, eventdata, handles, varargout)

global lowColorBound

lowColorBound = str2double(get(handles.lowColor, 'String')); % get current value when it is changed

function lowColor_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

global lowColorBound

lowColorBound = -25;

function highColor_Callback(hObject, eventdata, handles, varargin)

global highColorBound

highColorBound = str2double(get(handles.highColor, 'String')); % get current value when it is changed

function highColor_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

global highColorBound

highColorBound = 10;

function figure1_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to figure1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

if isequal(get(hObject,'waitstatus'), 'waiting')
    uiresume(hObject);
else
    delete(hObject);
end
