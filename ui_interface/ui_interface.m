function [] = ui_interface()
%%
%root panel of the user interface
%setup basic properties of the ui
    root_fig = figure('units','pixels',...
					'position',[100 80 1200 700],...
	                'numbertitle','off',...
	                'name','Track CME wave front',...
	                'resize','off'); 


    panel = uipanel(root_fig); 
    set(gcf,'menubar','none');
    set(gcf,'defaultuicontrolunits','normalized')
%%
%wedget components of the text    
    	h_textbox_0 = uicontrol('Style', 'text', 'String', 'Solar Motion Tracker',...
		'fontsize',40, 'fontname','agency fb',...
		'parent',panel,'position',[0 0.8 1 0.16]); 
        set(h_textbox_0,'visible','on')
    
        h_textbox_1 = uicontrol('Style', 'text', 'String', 'eroded image',...
		'fontsize',10, 'fontname','courier',...
		'parent',panel,'position',[0.35 0.77  0.1 0.023]);
        set(h_textbox_1,'visible','on')
    
        h_textbox_2 = uicontrol('Style', 'text', 'String', 'enhanced image',...
		'fontsize',10, 'fontname','courier',...
		'parent',panel,'position',[0.54 0.77  0.1 0.023]);
        set(h_textbox_2,'visible','on')
    
        h_textbox_3 = uicontrol('Style', 'text', 'String', 'Track',...
		'fontsize',10, 'fontname','courier',...
		'parent',panel,'position',[0.72 0.77  0.07 0.023]);
        set(h_textbox_3,'visible','on')
        
        h_textbox_4 = uicontrol('Style', 'text', 'String','x_velocity distribution',...
		'fontsize',10, 'fontname','courier',...
		'parent',panel,'position',[0.59 0.38  0.16 0.023]);
        set(h_textbox_4,'visible','on')        
        
        h_textbox_5 = uicontrol('Style', 'text', 'String','y_velocity distribution',...
		'fontsize',10, 'fontname','courier',...
		'parent',panel,'position',[0.59 0.19  0.16 0.023]);
        set(h_textbox_5,'visible','on')        
        
        h_textbox_6 = uicontrol('Style', 'text', 'String','velocity in scatter view',...
		'fontsize',10, 'fontname','courier',...
		'parent',panel,'position',[0.35 0.4  0.2 0.023]);
        set(h_textbox_6,'visible','on')

        h_textbox_7 = uicontrol('Style', 'text', 'String','',...
		'fontsize',10, 'fontname','courier',...
		'parent',panel,'position',[0 0 0.5 0.023],...
        'horizontalalignment','left');
        set(h_textbox_7,'visible','on')
        
%%
%wigdet panels for plot data
    main_panel = uipanel('position',[0.07 0.38 0.4*7/12 0.4],'parent',panel);
	
    %for main image with original velocity and trajectory path
        h_main_axes = axes('units','normalized',...
        'position',[0 0 1 1],'parent',main_panel,...
        'visible','off');
		set(gca,'color', [0.8 .8 .8]);
        
    %plot the spectra of the image
        h_main_sub_spec = uipanel('position',...
            [0.07 0.27 0.4*7/12 0.12],'parent',panel);
        h_main_sub_axes = axes('units','normalized',...
        'position',[0 0 1 1],'parent',h_main_sub_spec,...
        'visible','off');
    
        v=VideoReader('test.mp4');
        video=read(v,1);
        imshow(video,'parent',h_main_axes)
    
     %for 3 plots of pre-processing images  
        
        %plot the eroded image
        plot_panel_1 = uipanel('position',[0.35  0.45 0.32*7/12 0.32],'parent',panel);
		h_plot_axes_1 = axes('units','normalized',...
        'position',[0 0 1 1],'parent',plot_panel_1,...
        'visible','off');
		set(gca,'color', [0.8 .8 .8]);
	    
        %plot the enhanced image
        plot_panel_2 = uipanel('position',[0.35+0.32*7/12  0.45 0.32*7/12 0.32],'parent',panel);
		h_plot_axes_2 = axes('units','normalized',...
        'position',[0 0 1 1],'parent',plot_panel_2,...
        'visible','off');
		set(gca,'color', [0.8 .8 .8]);
        
        %plot the track image
        plot_panel_3 = uipanel('position',[0.35+0.32*7/6  0.45 0.32*7/12 0.32],'parent',panel);
		h_plot_axes_3 = axes('units','normalized',...
        'position',[0 0 1 1],'parent',plot_panel_3,...
        'visible','off');
		set(gca,'color', [0.8 .8 .8]);
        
        
        %plot the vr and v_theta
        plot_panel_4 = uipanel('position',[0.35  0.03 0.37*7/12 0.37],'parent',panel);
		h_plot_axes_4 = axes('units','normalized',...
        'position',[0.12 0.12 .87 .87],'parent',plot_panel_4,...
        'visible','off');
		set(gca,'color', [0.8 .8 .8]);
        
        %plot distribution of vx
        plot_panel_5 = uipanel('position',[0.37+0.37*7/12 0.22 0.55*7/12 0.16],'parent',panel);
		h_plot_axes_5 = axes('units','normalized',...
        'position',[0.06 0.2 0.96 0.85],'parent',plot_panel_5,...
        'visible','off');
		set(h_plot_axes_5,'color', [0.8 .8 .8]);
        
        %plot distribution of vy
        plot_panel_6 = uipanel('position',[0.37+0.37*7/12 0.03 0.55*7/12 0.16],'parent',panel);
		h_plot_axes_6 = axes('units','normalized',...
        'position',[0.06 0.2 0.96 0.85],'parent',plot_panel_6,...
        'visible','off');
		set(h_plot_axes_6,'color', [0.8 .8 .8]);
        
        %widgets for controlling the system
        control_panel = uipanel(panel,'Title','control parameters',...
            'fontsize',13,'fontname','consolas',...
            'position',[ 0.07 0.03 0.235 0.2]);
        
        generate_key = uicontrol('Style', 'pushbutton',...
							'String', 'run tracker',...
							'position',[0.21 0.01 0.43 0.14],...
                            'parent',control_panel,...
							'callback',@run_tracker_cbk);
        set(generate_key,'visible','on');
        
        %labels of the control widget
        h_text_control_1 = uicontrol('Style', 'text', 'String','.   window size',...
		'fontsize',9,'fontname','courier',...
		'parent',control_panel,'position',[0.05 0.75 0.5 0.12]);
        set(h_text_control_1,'visible','on')
        
        h_text_control_2 = uicontrol('Style', 'text', 'String','.    erode size',...
		'fontsize',9,'fontname','courier',...
		'parent',control_panel,'position',[0.05 0.60 0.5 0.12]);
        set(h_text_control_2,'visible','on')
        
        h_text_control_3 = uicontrol('Style', 'text', 'String','. desample size',...
		'fontsize',9,'fontname','courier',...
		'parent',control_panel,'position',[0.05 0.45 0.5 0.12]);
        set(h_text_control_3,'visible','on')
        
        h_text_control_4 = uicontrol('Style', 'text', 'String','.    frame jump',...
		'fontsize',9,'fontname','courier',...
		'parent',control_panel,'position',[0.05 0.3 0.5 0.12]);
        set(h_text_control_4,'visible','on')
 
        h_text_control_5 = uicontrol('Style', 'text', 'String','.image compress',...
		'fontsize',9,'fontname','courier',...
		'parent',control_panel,'position',[0.05 0.15 0.5 0.12]);
        set(h_text_control_5,'visible','on')

%% edit controls for the tracker        
        edit_win=uicontrol('Style' ,'edit' ,'String','15',...
				'parent',control_panel,...
				'position',[0.6,0.75,0.25,0.12]);
            set(edit_win,'visible','on');
        edit_dif=uicontrol('Style' ,'edit' ,'String','2',...
				'parent',control_panel,...
				'position',[0.6,0.60,0.25,0.12]);
            set(edit_dif,'visible','on');
        edit_des=uicontrol('Style' ,'edit' ,'String','25',...
				'parent',control_panel,...
				'position',[0.6,0.45,0.25,0.12]);
            set(edit_des,'visible','on');
        edit_fra=uicontrol('Style' ,'edit' ,'String','1',...
				'parent',control_panel,...
				'position',[0.6,0.30,0.25,0.12]);
            set(edit_fra,'visible','on');
        edit_imc=uicontrol('Style' ,'edit' ,'String','0',...
				'parent',control_panel,...
				'position',[0.6,0.15,0.25,0.12]);
            set(edit_imc,'visible','on');
        
%% set up menus for the application
        h0_menu0 = uimenu(gcf ,'label' ,'file');	

    	h0_submenu1 = uimenu(h0_menu0,'label','Open video file','callback',@open_file_cbk);
        set(h0_submenu1,'visible','on');
                
        
%% run call back functions
    function run_tracker_cbk(src,evt)
        file_full_path=get(h_textbox_7,'string');
        
        %getting all parameters ready for the track
        win_size=round(str2double(get(edit_win,'string')));
        dif_size=round(str2double(get(edit_dif,'string')));
        des_size=round(str2double(get(edit_des,'string')));
        fra_jump=round(str2double(get(edit_fra,'string')));
        ima_comp=round(str2double(get(edit_imc,'string')));
        
        if ~isempty(file_full_path)
             datav_index=VideoReader(file_full_path);
             % check if the video file is empty
             if hasFrame(datav_index)
                 frame_a = readFrame(datav_index);
             end
             while hasFrame(datav_index)
                 frame_b = readFrame(datav_index);
                 [f_a,e_a]=preprocesing_track(frame_a,dif_size);
                 [f_b,e_b]=preprocesing_track(frame_b,dif_size);
                 [flow_x,flow_y,flow_size] = opt_lk...
                        (e_a,e_b,win_size,dif_size,des_size);
                 
                 flow_x=-flow_x;
                 flow_y=-flow_y;
                    
                 %plot the images
                 imshow(e_a,'parent',h_plot_axes_1);
                 imshow(frame_b,'parent',h_main_axes);
                 imshow(f_a,'parent',h_plot_axes_2);
                 
                 hist(double(f_b(f_b~=0)),255,'parent',h_main_sub_axes);
                 set(h_main_sub_axes,'xlim',[2,100]);
                 
                 plot(flow_x(1:end),flow_y(1:end),'k.','parent',h_plot_axes_4);
                 hist(double(flow_x(flow_x~=0)),150,'parent',h_plot_axes_5)
                 set(h_plot_axes_5,'xlim',[-1.5 1.5])
                 set(h_plot_axes_5,'color', [0.8 .8 .8],'visible','on');   
                 
                 hist(double(flow_y(flow_y~=0)),150,'parent',h_plot_axes_6);
                 set(h_plot_axes_6,'xlim',[-1.5 1.5])
                 set(h_plot_axes_6,'color', [0.8 .8 .8],'visible','on');
                 set(h_plot_axes_4,'xlim',[-1.2 1.2],'ylim',[-1.2 1.2]);
                 
                 quiver(flow_x,flow_y,'parent',h_plot_axes_3);
                 set(h_plot_axes_3,'xlim',[0 flow_size(1)],'ylim',[0 flow_size(1)])
                 
                 frame_a=frame_b;
                 size(flow_size);
                 drawnow;
             end
        else
                errordlg('input a valid file!!!(data file not found)')
        end
        size(src);size(evt);
    end
%%
%openfile callback fuctions
    function open_file_cbk(src,evt)
        [filename,pathname]=uigetfile({'*.*'},...
            'Open video files contains a CME event');
        fullpath=strcat(pathname,filename);
        if fullpath ~= 0
            set(h_textbox_7,'string',fullpath);
            vp=VideoReader(fullpath);
            video_frame_1=read(vp,1);
            video_frame_2=read(vp,2);
            [f_e,f_i]=preprocesing_track(video_frame_2);
            imshow(f_e,'parent',h_plot_axes_1);
            imshow(video_frame_1,'parent',h_main_axes);
            imshow(f_i,'parent',h_plot_axes_2);
            im_gray=video_frame_1(:,:,3);
            
            hist(double(im_gray(im_gray~=0)),255,'parent',h_main_sub_axes);
            set(h_main_sub_axes,'xlim',[2,100]);
            
            [fx,fy]=opt_lk(mean(video_frame_1,3),mean(video_frame_2,3),15,2,15);
            sz=size(fx);
            
            fx=-fx; %correcting the direction
            fy=-fy; %correcting the direction
            
            plot(fx(1:end),fy(1:end),'k.','parent',h_plot_axes_4);
            set(h_plot_axes_4,'xlim',[-1.2 1.2],'ylim',[-1.2 1.2])
            
        hist(double(fx(fx~=0)),150,'parent',h_plot_axes_5);
		set(h_plot_axes_5,'xlim',[-1.5 1.5])
        set(h_plot_axes_5,'color', [0.8 .8 .8]);            
        
        hist(double(fy(fy~=0)),150,'parent',h_plot_axes_6);
        set(h_plot_axes_6,'xlim',[-1.5 1.5])
        set(h_plot_axes_6,'color', [0.8 .8 .8],'visible','on');
            
            quiver(fx,fy,'parent',h_plot_axes_3);
            set(h_plot_axes_3,'xlim',[1 sz(1)],'ylim',[1,sz(2)]);
            size(src);size(evt);
            figure(); 
            quiver(fx,fy);
        end
    end
end