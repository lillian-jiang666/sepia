%% h = sepia_handle_panel_bkgRemoval_RESHARP(hParent,h,position)
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
% Description: This GUI function creates a panel for RESHARP method
%
% Kwok-shing Chan @ DCCN
% k.chan@donders.ru.nl
% Date created: 1 June 2018
% Date last modified: 
%
%
function h = sepia_handle_panel_bkgRemoval_RESHARP(hParent,h,position)

%% set default values
defaultRadius = 4;
defaultLambda = 0.01;

%% Parent handle of RESHARP panel children

h.bkgRemoval.panel.RESHARP = uipanel(hParent,...
    'Title','Regularisation SHARP',...
    'position',position,...
    'backgroundcolor',get(h.fig,'color'),'Visible','off');

%% Children of RESHARP panel

    % text|edit field pair: radius
    h.bkgRemoval.RESHARP.text.radius = uicontrol('Parent',h.bkgRemoval.panel.RESHARP,'Style','text',...
        'String','Radius (voxel):',...
        'units','normalized','position',[0.01 0.75 0.2 0.2],...
        'HorizontalAlignment','left',...
        'backgroundcolor',get(h.fig,'color'),...
        'tooltip','Radius of spherical mean kernel');
    h.bkgRemoval.RESHARP.edit.radius = uicontrol('Parent',h.bkgRemoval.panel.RESHARP,'Style','edit',...
        'String',num2str(defaultRadius),...
        'units','normalized','position',[0.25 0.75 0.2 0.2],...
        'backgroundcolor','white');

    % text|edit field pair: regularisation parameter
    h.bkgRemoval.RESHARP.text.lambda = uicontrol('Parent',h.bkgRemoval.panel.RESHARP,'Style','text',...
        'String','Regularisation parameter:',...
        'units','normalized','position',[0.01 0.5 0.2 0.2],...
        'HorizontalAlignment','left',...
        'backgroundcolor',get(h.fig,'color'));
    h.bkgRemoval.RESHARP.edit.lambda = uicontrol('Parent',h.bkgRemoval.panel.RESHARP,'Style','edit',...
        'String',num2str(defaultLambda),...
        'units','normalized','position',[0.25 0.5 0.2 0.2],...
        'backgroundcolor','white');

%% set callbacks
set(h.bkgRemoval.RESHARP.edit.lambda,	'Callback', {@EditInputMinMax_Callback,defaultLambda,0,0});
set(h.bkgRemoval.RESHARP.edit.radius, 	'Callback', {@EditInputMinMax_Callback,defaultRadius,1,0});

end