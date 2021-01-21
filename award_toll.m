%% Award Tool
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% m文件功能：
%    1、按一下hai按钮,Attendence set 数字加一，同时其背景在绿色红色间切换，初始背景白色
%       同时，Total Number 数字随之改变
%    2、修改Attendence set的数字，Total Number 数字随之改变
%    3、点击Exit 退出
%    4、增加pic 
%    5、摇杆按钮的点击显示功能
%    6、随机数以及抽奖结果的显示，
%       使用randperm(n,1)函数得到随机数
%    7、TODO : 实现随机数以及抽奖结果的动态显示
% Written by:Eric海 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function HAO 
    close all 
    h = 300;%窗口高度 
    w = 500;%窗口宽度 
    %d_h =30;%窗口上面小高度 
    pos = get(0, 'screensize');% 获取显示器屏幕尺寸，【1 1 1536 864】 最后两项分别是屏幕宽度和高度
    left_start = (pos(3)-w)/2; % 计算左边起始边界
    down_start = (pos(4)-h)/2; % 计算底部起始边界

    %% 定义出现fig的位置为屏幕中央，
    %在看了公众号GUI60问第20问之后得到另一种简单的居中方法，感兴趣的去up主公众号,真的是宝藏up
    global GUI 
    GUI.color_flag = 1;
    GUI.text_change_flag = 1;
    GUI.hai = figure('units','pixels','position',[left_start down_start w h],...%GUI.hai = figure('units','pixels','position',[10 300 w h],...
        'menubar', 'none',... 
        'name', 'get award',... 
        'numbertitle', 'off',...
        'resize', 'off');

    %========add pic ========
    interfacePic = imread('pic.png');
    %默认情况下，axes的值为基于图的归一化值，可以doc axes()查看相关信息，看实例
    axes('parent',GUI.hai,'position',[+0.38,+0,0.6,1])
    imshow(interfacePic)

    %========add award button up  ========
    awardIcon = imread('awardIcon.png');
    % resize_w = 31;
    % resize_h = 95;
    resize_w = 40;
    resize_h = 141;
    awardIcon = imresize(awardIcon,[resize_h,resize_w]); 
    button_icon_left = left_start-105;%left_start-98;
    button_icon_down = down_start-100-80-10;%down_start-100-80+22;
    GUI.strt = uicontrol('parent',GUI.hai,'style','pushbutton','string','',...
        'position',[button_icon_left,button_icon_down,resize_w,resize_h],'callback',@CountStrt,...
        'Cdata',awardIcon,'visible','on');

    %========add award button down  ========
    awardIcon2 = imread('awardIcon2.png');
    % resize_w = 31;
    % resize_h = 95;
    resize_w = 40;
    resize_h = 141;
    awardIcon2 = imresize(awardIcon2,[resize_h,resize_w]); 
    button_icon_left = left_start-105;%left_start-98;
    button_icon_down = down_start-100-80-10;
    GUI.stop = uicontrol('parent',GUI.hai,'style','pushbutton','string','',...
        'position',[button_icon_left,button_icon_down,resize_w,resize_h],'callback',@CountStop,...
        'Cdata',awardIcon2,'visible','off');

    %======== 控件内容 ========
    %定义标题
    %定义标题文本大小
    button_title_w = 150;
    button_title_h = 30;
    %定义起始位置
    button_title_left = left_start-380+40;
    button_title_down = down_start-70+50;
    GUI.title_hai=uicontrol('Parent',GUI.hai,'style','text','position',[button_title_left,button_title_down,button_title_w,button_title_h],...
        'string','HAI Award Tool ','fontsize',14,'fontweight','bold','horizontalAlignment','center');

    %定义按钮大小
    button_w = 50;
    button_h = 30;
    %定义起始位置
    button_left = left_start-380+20;
    button_down = down_start-70;
    GUI.button = uicontrol('Parent',GUI.hai,'Style','pushbutton','string','hai',...
        'position',[button_left button_down button_w button_h],'fontsize',12,'visible','on',...
        'callback',@changeEditFcn);
    %根据button按钮来设置text1的位置，这样调整button时，text会跟着调整
    text1_left = button_left-130;
    text1_down = button_down;
    GUI.text1 = uicontrol('Parent',GUI.hai,'Style','text','string','Mode Select:',...
        'position',[text1_left,text1_down,125,30],'fontsize',12,'foregroundcolor','black',...
        'fontweight','bold','horizontalAlignment','left');

    %根据button按钮来设置text2的位置，这样调整button时，text会跟着调整
    text_left = button_left-130;
    text_down = button_down-40;
    GUI.text2 = uicontrol('Parent',GUI.hai,'Style','text','string','Attendence set:',...
        'position',[text_left,text_down,125,30],'fontsize',12,'foregroundcolor','black',...
        'fontweight','bold','horizontalAlignment','left');

    %根据button按钮来设置text的位置，这样调整button时，text会跟着调整
    text3_left = button_left-130;
    text3_down = text_down-40;
    GUI.text1 = uicontrol('Parent',GUI.hai,'Style','text','string','Total Number:',...
        'position',[text3_left,text3_down,125,30],'fontsize',12,'foregroundcolor','black',...
        'fontweight','bold','horizontalAlignment','left');


%     %设置一个状态按钮
%     button_start_left = text3_left;
%     button_start_down = text3_down-40;
%     GUI.START = uicontrol('Parent',GUI.hai,'Style','pushbutton','string','state:0',...
%         'position',[button_start_left,button_start_down,button_w+10,button_h],'fontsize',12,'foregroundcolor','black',...
%         'fontweight','bold','horizontalAlignment','left','callback',@CountStrt);

    %设置一个停止按钮
    button_stop_left = text3_left + 15 + button_w;
    button_stop_down = text3_down-40;
    GUI.STOP = uicontrol('Parent',GUI.hai,'Style','pushbutton','string','Press',...
        'position',[button_stop_left,button_stop_down,button_w+5,button_h],'fontsize',12,'foregroundcolor','black',...
        'fontweight','bold','horizontalAlignment','left','callback',@CountStop);

    %设置一个退出按钮
    button_exit_left = button_stop_left + 15 + button_w;
    button_exit_down = text3_down-40;
    GUI.exit = uicontrol('Parent',GUI.hai,'Style','pushbutton','string','Exit',...
        'position',[button_exit_left,button_exit_down,button_w,button_h],'fontsize',12,'foregroundcolor','black',...
        'fontweight','bold','horizontalAlignment','left','callback',@haiExitFcn);
    %设置edit的位置
    edit_left = button_left;%左边与button对齐
    edit_down = text_down;%底边与text对齐
    edit_w = 50;
    edit_h = 30;
    GUI.edit = uicontrol('Parent',GUI.hai,'Style','edit','string','4',...
        'position',[edit_left,edit_down,edit_w,edit_h],'fontsize',12,'backgroundcolor','white',...
        'fontweight','bold','visible','on','callback',@fillinNumber);

    %根据button按钮来设置text的位置，这样调整button时，text会跟着调整
    text4_left = button_left;
    text4_down = text_down-40;
    GUI.text4 = uicontrol('Parent',GUI.hai,'Style','pushbutton','string','4',...
        'position',[text4_left,text4_down,button_w,button_h],'fontsize',12,'foregroundcolor','black',...
        'fontweight','bold','horizontalAlignment','left');

    %设置result的显示控件
    result_left = edit_left + 153;
    result_down = edit_down-20;
    result_w = 60;
    result_h = 30;
    GUI.result = uicontrol('Parent',GUI.hai,'Style','text',...
        'position',[result_left,result_down,result_w,result_h],'fontsize',14,...
        'fontweight','bold','horizontalAlignment','center','string','Ready');
end

function changeEditFcn(~,~)
    global GUI
    % 测试改变背景颜色
    if(GUI.color_flag)
        set(GUI.edit,'backgroundcolor','green');
        GUI.color_flag=~GUI.color_flag;
    else
        set(GUI.edit,'backgroundcolor','red');
        GUI.color_flag=~GUI.color_flag;
    end
    edit_value = get(GUI.edit,'string');
    edit_value = str2double(edit_value)+1;
    edit_value = num2str(edit_value);
    set(GUI.edit,'string',edit_value);
    set(GUI.text4,'string',edit_value);
end

% Make Total Number be same with Attendence set
function fillinNumber(~,~)
    global GUI
    str = get(GUI.edit,'string');
    set(GUI.text4,'string',str);
end

%注意，写回调函数时，不管有没有输入参数，一定要写成 function func_name(~,~)的形式
function haiExitFcn(~,~)
    close
end

function CountStrt(~,~)
   global GUI
   set(GUI.strt,'visible','off');
   set(GUI.stop,'visible','on');
   GUI.text_change_flag = 1;
   %加入滚动数值显示
end

function CountStop(~,~)
    global GUI    
    set(GUI.strt,'visible','on');
    set(GUI.stop,'visible','off');
%     if(GUI.text_change_flag)
%         set(GUI.START,'string','state:0');
%         GUI.text_change_flag = 0;
%     else
%         set(GUI.START,'string','state:1');
%         GUI.text_change_flag = 1;
%     end
    edit_val = get(GUI.edit,'string');
    edit_val = str2double(edit_val);     % 字符转换为数字
    switch edit_val
        case 3
            %TODO,
            %Here you can consider reading the name data from a input edit uicontril element ,
            %throug a for or while loop ,repeating the "name reading" action 3 times,and then 
            %create a string array includding 3 strings, by using the function--randperm(eidt_val,1) 
            %to get a string of your string array, then use this string to set it as the string content  
            %of GUI.result.
            %这里可以考虑读入输入框的名字，建立对应的字符串数组，根据下面的随机数选择某一个字符串,将其设置为
            %GUI.result的内容
            num_res = randperm(edit_val,1);      % 使用randperm从1到edit_val中随机取出一个数
            set(GUI.result,'string',num2str(num_res));
        case 4
            num_res = randperm(edit_val,1);      % 使用randperm从1到edit_val中随机取出一个数
            set(GUI.result,'string',GUI.lab_1412(num_res));  
        case 6
            num_res = randperm(edit_val,1);      % 使用randperm从1到edit_val中随机取出一个数
            set(GUI.result,'string',num2str(num_res));
        otherwise
            num_res = randperm(edit_val,1);      % 使用randperm从1到edit_val中随机取出一个数
            set(GUI.result,'string',num2str(num_res));
    end
end
