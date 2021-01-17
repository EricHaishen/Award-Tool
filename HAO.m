%% Award Tool
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% m�ļ����ܣ�
%    1����һ��hai��ť,Attendence set ���ּ�һ��ͬʱ�䱳������ɫ��ɫ���л�����ʼ������ɫ
%       ͬʱ��Total Number ������֮�ı�
%    2���޸�Attendence set�����֣�Total Number ������֮�ı�
%    3�����Exit �˳�
%    4������pic 
%    5��ҡ�˰�ť�ĵ����ʾ����
%    6��������Լ��齱�������ʾ��
%       ʹ��randperm(n,1)�����õ������
%    7��TODO : ʵ��������Լ��齱����Ķ�̬��ʾ
% Written by:Eric�� 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function HAO 
    close all 
    h = 300;%���ڸ߶� 
    w = 500;%���ڿ�� 
    %d_h =30;%��������С�߶� 
    pos = get(0, 'screensize');% ��ȡ��ʾ����Ļ�ߴ磬��1 1 1536 864�� �������ֱ�����Ļ��Ⱥ͸߶�
    left_start = (pos(3)-w)/2; % ���������ʼ�߽�
    down_start = (pos(4)-h)/2; % ����ײ���ʼ�߽�

    %% �������fig��λ��Ϊ��Ļ���룬
    %�ڿ��˹��ں�GUI60�ʵ�20��֮��õ���һ�ּ򵥵ľ��з���������Ȥ��ȥup�����ں�,����Ǳ���up
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
    %Ĭ������£�axes��ֵΪ����ͼ�Ĺ�һ��ֵ������doc axes()�鿴�����Ϣ����ʵ��
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

    %======== �ؼ����� ========
    %�������
    %��������ı���С
    button_title_w = 150;
    button_title_h = 30;
    %������ʼλ��
    button_title_left = left_start-380+40;
    button_title_down = down_start-70+50;
    GUI.title_hai=uicontrol('Parent',GUI.hai,'style','text','position',[button_title_left,button_title_down,button_title_w,button_title_h],...
        'string','HAI Award Tool ','fontsize',14,'fontweight','bold','horizontalAlignment','center');

    %���尴ť��С
    button_w = 50;
    button_h = 30;
    %������ʼλ��
    button_left = left_start-380+20;
    button_down = down_start-70;
    GUI.button = uicontrol('Parent',GUI.hai,'Style','pushbutton','string','hai',...
        'position',[button_left button_down button_w button_h],'fontsize',12,'visible','on',...
        'callback',@changeEditFcn);
    %����button��ť������text1��λ�ã���������buttonʱ��text����ŵ���
    text1_left = button_left-130;
    text1_down = button_down;
    GUI.text1 = uicontrol('Parent',GUI.hai,'Style','text','string','Mode Select:',...
        'position',[text1_left,text1_down,125,30],'fontsize',12,'foregroundcolor','black',...
        'fontweight','bold','horizontalAlignment','left');

    %����button��ť������text2��λ�ã���������buttonʱ��text����ŵ���
    text_left = button_left-130;
    text_down = button_down-40;
    GUI.text2 = uicontrol('Parent',GUI.hai,'Style','text','string','Attendence set:',...
        'position',[text_left,text_down,125,30],'fontsize',12,'foregroundcolor','black',...
        'fontweight','bold','horizontalAlignment','left');

    %����button��ť������text��λ�ã���������buttonʱ��text����ŵ���
    text3_left = button_left-130;
    text3_down = text_down-40;
    GUI.text1 = uicontrol('Parent',GUI.hai,'Style','text','string','Total Number:',...
        'position',[text3_left,text3_down,125,30],'fontsize',12,'foregroundcolor','black',...
        'fontweight','bold','horizontalAlignment','left');


%     %����һ��״̬��ť
%     button_start_left = text3_left;
%     button_start_down = text3_down-40;
%     GUI.START = uicontrol('Parent',GUI.hai,'Style','pushbutton','string','state:0',...
%         'position',[button_start_left,button_start_down,button_w+10,button_h],'fontsize',12,'foregroundcolor','black',...
%         'fontweight','bold','horizontalAlignment','left','callback',@CountStrt);

    %����һ��ֹͣ��ť
    button_stop_left = text3_left + 15 + button_w;
    button_stop_down = text3_down-40;
    GUI.STOP = uicontrol('Parent',GUI.hai,'Style','pushbutton','string','Press',...
        'position',[button_stop_left,button_stop_down,button_w+5,button_h],'fontsize',12,'foregroundcolor','black',...
        'fontweight','bold','horizontalAlignment','left','callback',@CountStop);

    %����һ���˳���ť
    button_exit_left = button_stop_left + 15 + button_w;
    button_exit_down = text3_down-40;
    GUI.exit = uicontrol('Parent',GUI.hai,'Style','pushbutton','string','Exit',...
        'position',[button_exit_left,button_exit_down,button_w,button_h],'fontsize',12,'foregroundcolor','black',...
        'fontweight','bold','horizontalAlignment','left','callback',@haiExitFcn);
    %����edit��λ��
    edit_left = button_left;%�����button����
    edit_down = text_down;%�ױ���text����
    edit_w = 50;
    edit_h = 30;
    GUI.edit = uicontrol('Parent',GUI.hai,'Style','edit','string','4',...
        'position',[edit_left,edit_down,edit_w,edit_h],'fontsize',12,'backgroundcolor','white',...
        'fontweight','bold','visible','on','callback',@fillinNumber);

    %����button��ť������text��λ�ã���������buttonʱ��text����ŵ���
    text4_left = button_left;
    text4_down = text_down-40;
    GUI.text4 = uicontrol('Parent',GUI.hai,'Style','pushbutton','string','4',...
        'position',[text4_left,text4_down,button_w,button_h],'fontsize',12,'foregroundcolor','black',...
        'fontweight','bold','horizontalAlignment','left');

    %����result����ʾ�ؼ�
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
    % ���Ըı䱳����ɫ
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

%ע�⣬д�ص�����ʱ��������û�����������һ��Ҫд�� function func_name(~,~)����ʽ
function haiExitFcn(~,~)
    close
end

function CountStrt(~,~)
   global GUI
   set(GUI.strt,'visible','off');
   set(GUI.stop,'visible','on');
   GUI.text_change_flag = 1;
   %���������ֵ��ʾ
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
    edit_val = str2double(edit_val);     % �ַ�ת��Ϊ����
    switch edit_val
        case 3
            %todo,������Կ��Ƕ������������֣�������Ӧ���ַ������飬��������������ѡ��ĳһ���ַ���
            num_res = randperm(edit_val,1);      % ʹ��randperm��1��edit_val�����ȡ��һ����
            set(GUI.result,'string',num2str(num_res));
        case 4
            GUI.lab_1412=["�麽";"����";"��ǿ";"����"];
            num_res = randperm(edit_val,1);      % ʹ��randperm��1��edit_val�����ȡ��һ����
            set(GUI.result,'string',GUI.lab_1412(num_res));  
        case 6
            num_res = randperm(edit_val,1);      % ʹ��randperm��1��edit_val�����ȡ��һ����
            set(GUI.result,'string',num2str(num_res));
        otherwise
            num_res = randperm(edit_val,1);      % ʹ��randperm��1��edit_val�����ȡ��һ����
            set(GUI.result,'string',num2str(num_res));
    end
end
