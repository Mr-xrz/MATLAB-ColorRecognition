function varargout = GUI(varargin)
%GUI MATLAB code file for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('Property','Value',...) creates a new GUI using the
%      given property value pairs. Unrecognized properties are passed via
%      varargin to GUI_OpeningFcn.  This calling syntax produces a
%      warning when there is an existing singleton*.
%
%      GUI('CALLBACK') and GUI('CALLBACK',hObject,...) call the
%      local function named CALLBACK in GUI.M with the given input
%      arguments.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 13-Dec-2021 19:59:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
                   'gui_LayoutFcn',  [], ...
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


% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, ~, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   unrecognized PropertyName/PropertyValue pairs from the
%            command line (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(~, ~, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(~, ~, ~)
obj= videoinput('winvideo',2,'RGB24_800x600');  %设备采集图像输入,适配器名称,图像格式
src = getselectedsource(obj); 
src.ColorEnable = 'off';
src.Brightness = 30000;%
src.Gain = 100;%增益
src.Gamma = 50;%灰度
src.Saturation = 130;%饱和度
preview(obj);
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function pushbutton2_Callback(~, ~, ~)
% --- Executes on button press in pushbutton2.
flag= imread('D:\123\1.jpg','jpg');
gray_img = rgb2gray(flag);%灰度化处理
n=graythresh(gray_img);%自动确定阈值
BW=im2bw(gray_img,n);%二值化处理
imwrite(BW,'D:\123\2.jpg','jpg');

imshow(BW);
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(~, eventdata, handles)
flag = imread('D:\123\1.jpg','jpg');
flag_hsv = rgb2hsv(flag); % 将图像的rgb色彩空间转化至hsv色彩空间     
flag_new = 255*ones(size(flag));% 创建一个白色图像，将特定颜色提取到此处
flag_new_hsv = rgb2hsv(flag_new);% 将该图像转至hsv色彩空间

color=['yellow','red','blue','green'];
for k = 1:length(color)
    switch k
        case 1
        %提取红色部分
        [row, col] = ind2sub(size(flag_hsv),find((flag_hsv(:,:,1)>0.00...
        & flag_hsv(:,:,1)< 0.08) |( flag_hsv(:,:,1)>0.95 & flag_hsv(:,:,1)<1)&flag_hsv(:,:,2)>0.16 & flag_hsv(:,:,3)>0.18));

        % 将图像中的红色像素复制到刚才新建的白色图像中
        for i = 1 : length(row)
        flag_new_hsv(row(i),col(i),:) = flag_hsv(row(i),col(i),:);
        end
        flag_red = hsv2rgb(flag_new_hsv);% 将提取出来的红色，转化至rgb空间，进行展示
        imshow(flag_red);
    end
end
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
flag = imread('D:\123\1.jpg','jpg');
flag_hsv = rgb2hsv(flag); % 将图像的rgb色彩空间转化至hsv色彩空间     
flag_new = 255*ones(size(flag));% 创建一个白色图像，将特定颜色提取到此处
flag_new_hsv = rgb2hsv(flag_new);% 将该图像转至hsv色彩空间

color=['yellow','red','blue','green'];
for k = 1:length(color)
    switch k
        case 2
        %提取绿色部分
        [row, col] = ind2sub(size(flag_hsv),find(flag_hsv(:,:,1)>0.18...
        & flag_hsv(:,:,1)< 0.48 & flag_hsv(:,:,2)>0.16 & flag_hsv(:,:,3)>0.18));

        % 将图像中的绿色像素复制到刚才新建的白色图像中
        for i = 1 : length(row)
        flag_new_hsv(row(i),col(i),:) = flag_hsv(row(i),col(i),:);
        end
        flag_green = hsv2rgb(flag_new_hsv);% 将提取出来的绿色，转化至rgb空间，进行展示
        imshow(flag_green);
    end
end


% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(~, ~, ~)
flag = imread('D:\123\1.jpg','jpg');
flag_hsv = rgb2hsv(flag); % 将图像的rgb色彩空间转化至hsv色彩空间     
flag_new = 255*ones(size(flag));% 创建一个白色图像，将特定颜色提取到此处
flag_new_hsv = rgb2hsv(flag_new);% 将该图像转至hsv色彩空间

color=['yellow','red','blue','green'];
for k = 1:length(color)
    switch k
   case 3
            %提取黄色部分
        [row, col] = ind2sub(size(flag_hsv),find(flag_hsv(:,:,1)>0.08...
        & flag_hsv(:,:,1)< 0.23 & flag_hsv(:,:,2)>0.16 & flag_hsv(:,:,3)>0.18));

        % 将图像中的黄色像素复制到刚才新建的白色图像中
        for i = 1 : length(row)
        flag_new_hsv(row(i),col(i),:) = flag_hsv(row(i),col(i),:);
        end
        flag_yellow = hsv2rgb(flag_new_hsv);% 将提取出来的黄色，转化至rgb空间，进行展示
        imshow(flag_yellow);
    end
end
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(~, eventdata, handles)
flag = imread('D:\123\1.jpg','jpg');
flag_hsv = rgb2hsv(flag); % 将图像的rgb色彩空间转化至hsv色彩空间     
flag_new = 255*ones(size(flag));% 创建一个白色图像，将特定颜色提取到此处
flag_new_hsv = rgb2hsv(flag_new);% 将该图像转至hsv色彩空间

color=['yellow','red','blue','green'];
for k = 1:length(color)
    switch k
        case 4
            %提取蓝色部分
        [row, col] = ind2sub(size(flag_hsv),find(flag_hsv(:,:,1)>0.5...
        & flag_hsv(:,:,1)< 0.7 & flag_hsv(:,:,2)>0.16  & flag_hsv(:,:,3)>0.18));

        % 将图像中的蓝色像素复制到刚才新建的白色图像中
        for i = 1 : length(row)
        flag_new_hsv(row(i),col(i),:) = flag_hsv(row(i),col(i),:);
        end
        flag_blue = hsv2rgb(flag_new_hsv);% 将提取出来的蓝色，转化至rgb空间，进行展示
        imshow(flag_blue);
    end
end

% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in togglebutton1.
function togglebutton1_Callback(hObject, eventdata, handles)
axes(handles.axes1);
[filename,pathname]=uigetfile({'*.bmp;*.jpg;*.png;*.jpeg;*.tif'});
str=[pathname filename];
    flag = imread(str);
    imshow(flag);
imwrite(flag,'D:\123\1.jpg','jpg');

% hObject    handle to togglebutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton1


% --- Executes on button press in pushbutton8.
function pushbutton8_Callback(hObject, eventdata, handles)
I=imread('D:\123\1.jpg','jpg');
S=strel('diamond',8);%建立一个8*8的菱形结构元素
A1=imdilate(I,S);
A2=imdilate(A1,S);
A3=imdilate(A2,S);%膨胀三次

imshow(A3);

% hObject    handle to pushbutton8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton9.
function pushbutton9_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in togglebutton3.
function togglebutton3_Callback(hObject, eventdata, handles)
flag = imread('D:\123\1.jpg','jpg');
imshow(flag);
% hObject    handle to togglebutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton3


% --- Executes on button press in togglebutton4.
function togglebutton4_Callback(hObject, eventdata, handles)
obj= videoinput('winvideo',2,'RGB24_800x600');  %设备采集图像输入,适配器名称,图像格式
src = getselectedsource(obj); 
src.ColorEnable = 'off';
src.Brightness = 30000;%
src.Gain = 100;%增益
src.Gamma = 50;%灰度
src.Saturation = 130;%饱和度
pause(3);%延时函数，单位：秒
flag = getsnapshot(obj);
imshow(flag);%显示图片frame
imwrite(flag,'D:\123\1.jpg','jpg');
% hObject    handle to togglebutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of togglebutton4


% --- Executes on button press in pushbutton15.
function pushbutton15_Callback(hObject, eventdata, handles)
flag= imread('D:\123\1.jpg','jpg');
gray_img = rgb2gray(flag);%灰度化处理
n=graythresh(gray_img);%自动确定阈值
BW=im2bw(gray_img,n);%二值化处理
L=bwlabel(BW);
STATS=regionprops(L,'all');%选取所有连通区域

imshow(BW);
for i = 1:size(STATS, 1)     %获取行数
    boundary=STATS(i).BoundingBox;
    rectangle('position',boundary, 'EdgeColor', 'r');%绘制连通区域矩形框
end
% hObject    handle to pushbutton15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton16.
function pushbutton16_Callback(hObject, eventdata, handles)
BW = imread('D:\123\2.jpg','jpg');
bw1=imfill(BW,'holes');%填充
imshow(bw1);


% hObject    handle to pushbutton16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton17.
function pushbutton17_Callback(hObject, eventdata, handles)
BW = imread('D:\123\2.jpg','jpg');
BW=1-BW;
bw2=imfill(BW,'holes');%填充
imshow(bw2);

% hObject    handle to pushbutton17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton18.
function pushbutton18_Callback(hObject, eventdata, handles)
I=imread('D:\123\1.jpg','jpg');
S=strel('diamond',8);%建立一个8*8的菱形结构元素
A1=imdilate(I,S);
A2=imdilate(A1,S);
A3=imdilate(A2,S);%膨胀三次

sel=strel('disk',8);%建立一个半径为8的圆盘结构
B1=imerode(A3,sel);
B2=imerode(B1,sel);
B3=imerode(B2,sel);%腐蚀三次

C1=imfill(B3,'holes');%填充
imshow(C1);

% hObject    handle to pushbutton18 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton19.
function pushbutton19_Callback(hObject, eventdata, handles)
I2=imread('D:\123\1.jpg','jpg');
sel=strel('disk',8);%建立一个半径为8的圆盘结构
B1=imerode(I2,sel);
B2=imerode(B1,sel);
B3=imerode(B2,sel);%腐蚀三次
imshow(B3);

% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton20.
function pushbutton20_Callback(hObject, eventdata, handles)
flag= imread('D:\123\1.jpg','jpg');
gray_img = rgb2gray(flag);%灰度化处理
n=graythresh(gray_img);%自动确定阈值
BW=im2bw(gray_img,n);%二值化处理
BW=1-BW;%颜色反转
L=bwlabel(BW);
STATS=regionprops(L,'all');%选取所有连通区域
imshow(BW);
for i = 1:size(STATS, 1)     %获取行数
    boundary=STATS(i).BoundingBox;
    rectangle('position',boundary, 'EdgeColor', 'r');%绘制连通区域矩形框
end

% hObject    handle to pushbutton20 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function pushbutton19_CreateFcn(hObject, eventdata, handles)
% hObject    handle to pushbutton19 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in pushbutton21.
function pushbutton21_Callback(hObject, eventdata, handles)
flag= imread('D:\123\1.jpg','jpg');
gray_img = rgb2gray(flag);%灰度化处理
imshow(gray_img);

% hObject    handle to pushbutton21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
