%% h = sepia_handle_panel_bkgRemoval_VSHARP(hParent,h,position)
%
% Input
% --------------
% hParent       : parent handle of this panel
% h             : global structure contains all handles
% position      : position of this panel
%
% Output
% --------------
% h             : global structure contains all new and other handles
%
% Description: This GUI function creates a panel for VSHARP 
%
% Kwok-shing Chan @ DCCN
% k.chan@donders.ru.nl
% Date created: 1 June 2018
% Date last modified: 
%
%
function h = sepia_handle_panel_bkgRemoval_VSHARP(hParent,h,position)

%% Parent handle of VSHARP panel children

h.bkgRemoval.panel.VSHARP = uipanel(hParent,...
    'Title','Variable SHARP',...
    'position',position,...
    'backgroundcolor',get(h.fig,'color'),'Visible','off');

%% Children of VSHARP panel

    % text|edit field pair: maximum radius
    h.bkgRemoval.VSHARP.text.maxRadius = uicontrol('Parent',h.bkgRemoval.panel.VSHARP,...
        'Style','text',...
        'String','Max. radius (voxel):',...
        'units','normalized','position',[0.01 0.75 0.2 0.2],...
        'HorizontalAlignment','left',...
        'backgroundcolor',get(h.fig,'color'),...
        'tooltip','Maximum radius of spherical mean kernel');
    h.bkgRemoval.VSHARP.edit.maxRadius = uicontrol('Parent',h.bkgRemoval.panel.VSHARP,...
        'Style','edit',...
        'String','10',...
        'units','normalized','position',[0.25 0.75 0.2 0.2],...
        'backgroundcolor','white');

    % text|edit field pair: minimum radius
    h.bkgRemoval.VSHARP.text.minRadius = uicontrol('Parent',h.bkgRemoval.panel.VSHARP,...
        'Style','text',...
        'String','Min. radius (voxel):',...
        'units','normalized','position',[0.01 0.5 0.2 0.2],...
        'HorizontalAlignment','left',...
        'backgroundcolor',get(h.fig,'color'),...
        'tooltip','Minimum radius of spherical mean kernel');
    h.bkgRemoval.VSHARP.edit.minRadius = uicontrol('Parent',h.bkgRemoval.panel.VSHARP,...
        'Style','edit',...
        'String','3',...
        'units','normalized','position',[0.25 0.5 0.2 0.2],...
        'backgroundcolor','white');

%% set callbacks
set(h.bkgRemoval.VSHARP.edit.minRadius, 'Callback', {@EditVSHARPRadius_Callback,h});
set(h.bkgRemoval.VSHARP.edit.maxRadius, 'Callback', {@EditVSHARPRadius_Callback,h});

end

%% Callback
function EditVSHARPRadius_Callback(source,eventdata,h)
% constraint the minimum of maximum radius is always larger then the
% minimum radius

% global h

% check minimum of minimum radius input
if str2double(h.bkgRemoval.VSHARP.edit.minRadius.String)<0
    h.bkgRemoval.VSHARP.edit.minRadius.String = num2str(0);
end

% if the minimum radius is not integer then rounds it to interger
h.bkgRemoval.VSHARP.edit.minRadius.String = num2str(round(str2double(h.bkgRemoval.VSHARP.edit.minRadius.String)));

% ensure maximum radius is always larger then minimum radius
if str2double(h.bkgRemoval.VSHARP.edit.maxRadius.String) <= str2double(h.bkgRemoval.VSHARP.edit.minRadius.String)
    h.bkgRemoval.VSHARP.edit.maxRadius.String = num2str(str2double(h.bkgRemoval.VSHARP.edit.minRadius.String) +1);
end

% if the maximum radius is not integer then rounds it to interger
h.bkgRemoval.VSHARP.edit.maxRadius.String = num2str(round(str2double(h.bkgRemoval.VSHARP.edit.maxRadius.String)));

end
