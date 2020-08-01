
function varargout = Base(varargin)
% BASE MATLAB code for Base.fig
%      BASE, by itself, creates a new BASE or raises the existing
%      singleton*.
%
%      H = BASE returns the handle to a new BASE or the handle to
%      the existing singleton*.
%
%      BASE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in BASE.M with the given input arguments.
%
%      BASE('Property','Value',...) creates a new BASE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Base_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Base_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to push_run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Base

% Last Modified by GUIDE v2.5 14-Oct-2018 19:18:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Base_OpeningFcn, ...
                   'gui_OutputFcn',  @Base_OutputFcn, ...
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
% End initialization code - DO NOT EDIT


% --- Executes just before Base is made visible.
function Base_OpeningFcn(hObject, eventdata, handles, varargin)

axes(handles.Rect_Image)
matlabImage = imread('Rectangle.jpg');
image(matlabImage)
axis off
axis image

axes(handles.Result)
matlabImage = imread('Result.png');
image(matlabImage)
axis off
axis image

% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Base (see VARARGIN)

% Choose default command line output for Base
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Base wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Base_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in push_run.
function push_run_Callback(hObject, eventdata, handles)
% hObject    handle to push_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

data.Temp_Presc_1 = str2double(get(handles.data11,'String'));
data.Temp_Presc_2 = str2double(get(handles.data21,'String'));
data.Temp_Presc_3 = str2double(get(handles.data31,'String'));
data.Temp_Presc_4 = str2double(get(handles.data41,'String'));

data.Flux_1 = str2double(get(handles.data12,'String'));
data.Flux_2 = str2double(get(handles.data22,'String'));
data.Flux_3 = str2double(get(handles.data32,'String'));
data.Flux_4 = str2double(get(handles.data42,'String'));

data.Conv_1 = str2double(get(handles.data13,'String'));
data.Conv_2 = str2double(get(handles.data23,'String'));
data.Conv_3 = str2double(get(handles.data33,'String'));
data.Conv_4 = str2double(get(handles.data43,'String'));

data.Temp_Amb_1 = str2double(get(handles.data14,'String'));
data.Temp_Amb_2 = str2double(get(handles.data24,'String'));
data.Temp_Amb_3 = str2double(get(handles.data34,'String'));
data.Temp_Amb_4 = str2double(get(handles.data44,'String'));

data.divisions = str2double(get(handles.n,'String'));
data.conduction = str2double(get(handles.k,'String'));
data.geration = str2double(get(handles.ger,'String'));

if (strcmp(get(handles.Change1,'String'),'Temperatura Prescrita') == 1)
    data.state_1 = 1;
else
    data.state_1 = 2;
end
if (strcmp(get(handles.Change2,'String'),'Temperatura Prescrita') == 1)
    data.state_2 = 1;
else
    data.state_2 = 2;
end
if (strcmp(get(handles.Change3,'String'),'Temperatura Prescrita') == 1)
    data.state_3 = 1;
else
    data.state_3 = 2;
end
if (strcmp(get(handles.Change4,'String'),'Temperatura Prescrita') == 1)
    data.state_4 = 1;
else
    data.state_4 = 2;
end

len_test = str2double(get(handles.comp,'String'));
wid_test = str2double(get(handles.larg,'String'));
[data.width, data.length] = check_rect(len_test,wid_test);

[out1, out2] = calculate_heat(data);

axes(handles.Result)
matlabImage = imread('Result.png');
image(matlabImage)
axis off
axis image

textLabel = sprintf('Resultado do Balanço de energia: %d J\nNúmero de iterações: %d\nTolerância: 10e-7 e dimensões %.2d x %.2d [m]',out1,out2,data.length,data.width);

set(handles.Output, 'String', textLabel);


function data41_Callback(hObject, eventdata, handles)
% hObject    handle to data41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data41 as text
%        str2double(get(hObject,'String')) returns contents of data41 as a double


% --- Executes during object creation, after setting all properties.
function data41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function n_Callback(hObject, eventdata, handles)
% hObject    handle to n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n as text
%        str2double(get(hObject,'String')) returns contents of n as a double


% --- Executes during object creation, after setting all properties.
function n_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function k_Callback(hObject, eventdata, handles)
% hObject    handle to k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of k as text
%        str2double(get(hObject,'String')) returns contents of k as a double


% --- Executes during object creation, after setting all properties.
function k_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data42_Callback(hObject, eventdata, handles)
% hObject    handle to data42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data42 as text
%        str2double(get(hObject,'String')) returns contents of data42 as a double


% --- Executes during object creation, after setting all properties.
function data42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data43_Callback(hObject, eventdata, handles)
% hObject    handle to data43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data43 as text
%        str2double(get(hObject,'String')) returns contents of data43 as a double


% --- Executes during object creation, after setting all properties.
function data43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data31_Callback(hObject, eventdata, handles)
% hObject    handle to data31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data31 as text
%        str2double(get(hObject,'String')) returns contents of data31 as a double


% --- Executes during object creation, after setting all properties.
function data31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data32_Callback(hObject, eventdata, handles)
% hObject    handle to data32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data32 as text
%        str2double(get(hObject,'String')) returns contents of data32 as a double


% --- Executes during object creation, after setting all properties.
function data32_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data33_Callback(hObject, eventdata, handles)
% hObject    handle to data33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data33 as text
%        str2double(get(hObject,'String')) returns contents of data33 as a double


% --- Executes during object creation, after setting all properties.
function data33_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data21_Callback(hObject, eventdata, handles)
% hObject    handle to data21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data21 as text
%        str2double(get(hObject,'String')) returns contents of data21 as a double


% --- Executes during object creation, after setting all properties.
function data21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data22_Callback(hObject, eventdata, handles)
% hObject    handle to data22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data22 as text
%        str2double(get(hObject,'String')) returns contents of data22 as a double


% --- Executes during object creation, after setting all properties.
function data22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data23_Callback(hObject, eventdata, handles)
% hObject    handle to data23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data23 as text
%        str2double(get(hObject,'String')) returns contents of data23 as a double


% --- Executes during object creation, after setting all properties.
function data23_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data11_Callback(hObject, eventdata, handles)
% hObject    handle to data11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data11 as text
%        str2double(get(hObject,'String')) returns contents of data11 as a double


% --- Executes during object creation, after setting all properties.
function data11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data12_Callback(hObject, eventdata, handles)
% hObject    handle to data12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data12 as text
%        str2double(get(hObject,'String')) returns contents of data12 as a double


% --- Executes during object creation, after setting all properties.
function data12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data13_Callback(hObject, eventdata, handles)
% hObject    handle to data13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data13 as text
%        str2double(get(hObject,'String')) returns contents of data13 as a double


% --- Executes during object creation, after setting all properties.
function data13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

% --- Executes on button press in Change1.
function Change1_Callback(hObject, eventdata, handles)
% hObject    handle to Change1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (strcmp(get(handles.Change1,'String'),'Aberta ao ambiente') == 1)
    set(handles.text11,'Visible','On')
    set(handles.data11,'Visible','On')
    set(handles.text12,'Visible','Off')
    set(handles.text13,'Visible','Off')
    set(handles.text14,'Visible','Off')
    set(handles.data12,'Visible','Off')
    set(handles.data13,'Visible','Off')
    set(handles.data14,'Visible','Off')
    set(handles.Change1,'String','Temperatura Prescrita');
else
    set(handles.text11,'Visible','Off')
    set(handles.text12,'Visible','On')
    set(handles.text13,'Visible','On')
    set(handles.text14,'Visible','On')
    set(handles.data11,'Visible','Off')
    set(handles.data12,'Visible','On')
    set(handles.data13,'Visible','On')
    set(handles.data14,'Visible','On')
    set(handles.Change1,'String','Aberta ao ambiente');
end

% --- Executes on button press in Change2.
function Change2_Callback(hObject, eventdata, handles)
% hObject    handle to Change2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (strcmp(get(handles.Change2,'String'),'Aberta ao ambiente') == 1)
    set(handles.text21,'Visible','On')
    set(handles.text22,'Visible','Off')
    set(handles.text23,'Visible','Off')
    set(handles.text24,'Visible','Off')
    set(handles.data21,'Visible','On')
    set(handles.data22,'Visible','Off')
    set(handles.data23,'Visible','Off')
    set(handles.data24,'Visible','Off')
    set(handles.Change2,'String','Temperatura Prescrita');
else
    set(handles.text21,'Visible','Off')
    set(handles.text22,'Visible','On')
    set(handles.text23,'Visible','On')
    set(handles.text24,'Visible','On')
    set(handles.data21,'Visible','Off')
    set(handles.data22,'Visible','On')
    set(handles.data23,'Visible','On')
    set(handles.data24,'Visible','On')
    set(handles.Change2,'String','Aberta ao ambiente');
end

% --- Executes on button press in Change3.
function Change3_Callback(hObject, eventdata, handles)
% hObject    handle to Change3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (strcmp(get(handles.Change3,'String'),'Aberta ao ambiente') == 1)
    set(handles.text31,'Visible','On')
    set(handles.text32,'Visible','Off')
    set(handles.text33,'Visible','Off')
    set(handles.text34,'Visible','Off')
    set(handles.data31,'Visible','On')
    set(handles.data32,'Visible','Off')
    set(handles.data33,'Visible','Off')
    set(handles.data34,'Visible','Off')
    set(handles.Change3,'String','Temperatura Prescrita');
else
    set(handles.text31,'Visible','Off')
    set(handles.text32,'Visible','On')
    set(handles.text33,'Visible','On')
    set(handles.text34,'Visible','On')
    set(handles.data31,'Visible','Off')
    set(handles.data32,'Visible','On')
    set(handles.data33,'Visible','On')
    set(handles.data34,'Visible','On')
    set(handles.Change3,'String','Aberta ao ambiente');
end

% --- Executes on button press in Change4.
function Change4_Callback(hObject, eventdata, handles)
% hObject    handle to Change4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if (strcmp(get(handles.Change4,'String'),'Aberta ao ambiente') == 1)
    set(handles.text41,'Visible','On')
    set(handles.data41,'Visible','On')
    set(handles.text42,'Visible','Off')
    set(handles.text43,'Visible','Off')
    set(handles.text44,'Visible','Off')
    set(handles.data42,'Visible','Off')
    set(handles.data43,'Visible','Off')
    set(handles.data44,'Visible','Off')
    set(handles.Change4,'String','Temperatura Prescrita');
else
    set(handles.text41,'Visible','Off')
    set(handles.text42,'Visible','On')
    set(handles.text43,'Visible','On')
    set(handles.text44,'Visible','On')
    set(handles.data41,'Visible','Off')
    set(handles.data42,'Visible','On')
    set(handles.data43,'Visible','On')
    set(handles.data44,'Visible','On')
    set(handles.Change4,'String','Aberta ao ambiente');
end

function ger_Callback(hObject, eventdata, handles)
% hObject    handle to ger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ger as text
%        str2double(get(hObject,'String')) returns contents of ger as a double


% --- Executes during object creation, after setting all properties.
function ger_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function data14_Callback(hObject, eventdata, handles)
% hObject    handle to data14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data14 as text
%        str2double(get(hObject,'String')) returns contents of data14 as a double


% --- Executes during object creation, after setting all properties.
function data14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data44_Callback(hObject, eventdata, handles)
% hObject    handle to data44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data44 as text
%        str2double(get(hObject,'String')) returns contents of data44 as a double


% --- Executes during object creation, after setting all properties.
function data44_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in push_run.
function run_Callback(hObject, eventdata, handles)
% hObject    handle to push_run (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit68_Callback(hObject, eventdata, handles)
% hObject    handle to data41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data41 as text
%        str2double(get(hObject,'String')) returns contents of data41 as a double


% --- Executes during object creation, after setting all properties.
function edit68_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit69_Callback(hObject, eventdata, handles)
% hObject    handle to edit69 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit69 as text
%        str2double(get(hObject,'String')) returns contents of edit69 as a double


% --- Executes during object creation, after setting all properties.
function edit69_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit69 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Change4.
function pushbutton16_Callback(hObject, eventdata, handles)
% hObject    handle to Change4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit70_Callback(hObject, eventdata, handles)
% hObject    handle to data43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data43 as text
%        str2double(get(hObject,'String')) returns contents of data43 as a double


% --- Executes during object creation, after setting all properties.
function edit70_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit71_Callback(hObject, eventdata, handles)
% hObject    handle to data44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data44 as text
%        str2double(get(hObject,'String')) returns contents of data44 as a double


% --- Executes during object creation, after setting all properties.
function edit71_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit72_Callback(hObject, eventdata, handles)
% hObject    handle to data11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data11 as text
%        str2double(get(hObject,'String')) returns contents of data11 as a double


% --- Executes during object creation, after setting all properties.
function edit72_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit73_Callback(hObject, eventdata, handles)
% hObject    handle to data12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data12 as text
%        str2double(get(hObject,'String')) returns contents of data12 as a double


% --- Executes during object creation, after setting all properties.
function edit73_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Change1.
function pushbutton17_Callback(hObject, eventdata, handles)
% hObject    handle to Change1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit74_Callback(hObject, eventdata, handles)
% hObject    handle to data13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data13 as text
%        str2double(get(hObject,'String')) returns contents of data13 as a double


% --- Executes during object creation, after setting all properties.
function edit74_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit75_Callback(hObject, eventdata, handles)
% hObject    handle to data14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data14 as text
%        str2double(get(hObject,'String')) returns contents of data14 as a double


% --- Executes during object creation, after setting all properties.
function edit75_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit76_Callback(hObject, eventdata, handles)
% hObject    handle to data31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data31 as text
%        str2double(get(hObject,'String')) returns contents of data31 as a double


% --- Executes during object creation, after setting all properties.
function edit76_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit77_Callback(hObject, eventdata, handles)
% hObject    handle to data32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data32 as text
%        str2double(get(hObject,'String')) returns contents of data32 as a double


% --- Executes during object creation, after setting all properties.
function edit77_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data32 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Change3.
function pushbutton18_Callback(hObject, eventdata, handles)
% hObject    handle to Change3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit78_Callback(hObject, eventdata, handles)
% hObject    handle to data33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data33 as text
%        str2double(get(hObject,'String')) returns contents of data33 as a double


% --- Executes during object creation, after setting all properties.
function edit78_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data33 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data34_Callback(hObject, eventdata, handles)
% hObject    handle to data34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data34 as text
%        str2double(get(hObject,'String')) returns contents of data34 as a double


% --- Executes during object creation, after setting all properties.
function data34_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data34 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit80_Callback(hObject, eventdata, handles)
% hObject    handle to data21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data21 as text
%        str2double(get(hObject,'String')) returns contents of data21 as a double


% --- Executes during object creation, after setting all properties.
function edit80_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit81_Callback(hObject, eventdata, handles)
% hObject    handle to data22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data22 as text
%        str2double(get(hObject,'String')) returns contents of data22 as a double


% --- Executes during object creation, after setting all properties.
function edit81_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Change2.
function pushbutton19_Callback(hObject, eventdata, handles)
% hObject    handle to Change2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit82_Callback(hObject, eventdata, handles)
% hObject    handle to data23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data23 as text
%        str2double(get(hObject,'String')) returns contents of data23 as a double


% --- Executes during object creation, after setting all properties.
function edit82_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data23 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function data24_Callback(hObject, eventdata, handles)
% hObject    handle to data24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of data24 as text
%        str2double(get(hObject,'String')) returns contents of data24 as a double


% --- Executes during object creation, after setting all properties.
function data24_CreateFcn(hObject, eventdata, handles)
% hObject    handle to data24 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit84_Callback(hObject, eventdata, handles)
% hObject    handle to k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of k as text
%        str2double(get(hObject,'String')) returns contents of k as a double


% --- Executes during object creation, after setting all properties.
function edit84_CreateFcn(hObject, eventdata, handles)
% hObject    handle to k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit85_Callback(hObject, eventdata, handles)
% hObject    handle to ger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ger as text
%        str2double(get(hObject,'String')) returns contents of ger as a double


% --- Executes during object creation, after setting all properties.
function edit85_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ger (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit86_Callback(hObject, eventdata, handles)
% hObject    handle to n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of n as text
%        str2double(get(hObject,'String')) returns contents of n as a double


% --- Executes during object creation, after setting all properties.
function edit86_CreateFcn(hObject, eventdata, handles)
% hObject    handle to n (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function larg_Callback(hObject, eventdata, handles)
% hObject    handle to larg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of larg as text
%        str2double(get(hObject,'String')) returns contents of larg as a double


% --- Executes during object creation, after setting all properties.
function larg_CreateFcn(hObject, eventdata, handles)
% hObject    handle to larg (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function comp_Callback(hObject, eventdata, handles)
% hObject    handle to comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of comp as text
%        str2double(get(hObject,'String')) returns contents of comp as a double


% --- Executes during object creation, after setting all properties.
function comp_CreateFcn(hObject, eventdata, handles)
% hObject    handle to comp (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
