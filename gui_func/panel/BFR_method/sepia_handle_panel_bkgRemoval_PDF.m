%% h = sepia_handle_panel_bkgRemoval_PDF(hParent,h,position)
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
% Description: This GUI function creates a panel for LBV method
%
% Kwok-shing Chan @ DCCN
% k.chan@donders.ru.nl
% Date created: 1 June 2018
% Date last modified: 
%
%
function h = sepia_handle_panel_bkgRemoval_PDF(hParent,h,position)

%% set default values
defaultTol = 0.1;
defaultMaxIter = 50;
defaultPadSize = 40;

%% Parent handle of PDF panel chrildren
h.bkgRemoval.panel.PDF = uipanel(hParent,...
    'Title','Projection onto dipole field (PDF)',...
    'position',position,...
    'backgroundcolor',get(h.fig,'color'),'Visible','off');

%% Children of PDF panel 

    % text|edit field pair: tolerance
    h.bkgRemoval.PDF.text.tol = uicontrol('Parent',h.bkgRemoval.panel.PDF,...
        'Style','text',...
        'String','Tolerance:',...
        'units','normalized','position',[0.01 0.75 0.2 0.2],...
        'HorizontalAlignment','left',...
        'backgroundcolor',get(h.fig,'color'));
    h.bkgRemoval.PDF.edit.tol = uicontrol('Parent',h.bkgRemoval.panel.PDF,...
        'Style','edit',...
        'String',num2str(defaultTol),...
        'units','normalized','position',[0.25 0.75 0.2 0.2],...
        'backgroundcolor','white');

    % text|edit field pair: maximium number of iterations
    h.bkgRemoval.PDF.text.maxIter = uicontrol('Parent',h.bkgRemoval.panel.PDF,...
        'Style','text',...
        'String','Max. iterations:',...
        'units','normalized','position',[0.01 0.5 0.2 0.2],...
        'HorizontalAlignment','left',...
        'backgroundcolor',get(h.fig,'color'),...
        'tooltip','Maximum iterations allowed');
    h.bkgRemoval.PDF.edit.maxIter = uicontrol('Parent',h.bkgRemoval.panel.PDF,...
        'Style','edit',...
        'String',num2str(defaultMaxIter),...
        'units','normalized','position',[0.25 0.5 0.2 0.2],...
        'backgroundcolor','white');

    % text|edit field pair: zero padding size
    h.bkgRemoval.PDF.text.padSize = uicontrol('Parent',h.bkgRemoval.panel.PDF,...
        'Style','text',...
        'String','Zeropad size:',...
        'units','normalized','position',[0.01 0.25 0.23 0.2],...
        'HorizontalAlignment','left',...
        'backgroundcolor',get(h.fig,'color'),...
        'tooltip','No. of zeros to be added');
    h.bkgRemoval.PDF.edit.padSize = uicontrol('Parent',h.bkgRemoval.panel.PDF,...
        'Style','edit',...
        'String',num2str(defaultPadSize),...
        'units','normalized','position',[0.25 0.25 0.2 0.2],...
        'backgroundcolor','white');

% deprecated
%         h.bkgRemoval.PDF.text.cgSolver = uicontrol('Parent',h.bkgRemoval.panel.PDF,'Style','text',...
%             'String','CG solver',...
%             'units','normalized','position',[0.01 0.25 0.2 0.2],...
%             'HorizontalAlignment','left',...
%             'backgroundcolor',get(h.fig,'color'),...
%             'tooltip','Select CG solver');
%         h.bkgRemoval.PDF.popup.cgSolver = uicontrol('Parent',h.bkgRemoval.panel.PDF,'Style','popup',...
%             'String',{'MEDI cgsolver','Matlab pcg'},...
%             'units','normalized','position',[0.25 0.25 0.5 0.2]);

%% Set callbacks
set(h.bkgRemoval.PDF.edit.maxIter,	'Callback', {@EditInputMinMax_Callback,defaultMaxIter,  1,1});
set(h.bkgRemoval.PDF.edit.tol,    	'Callback', {@EditInputMinMax_Callback,defaultTol,      0,0});
set(h.bkgRemoval.PDF.edit.padSize, 	'Callback', {@EditInputMinMax_Callback,defaultPadSize,  1,0});

end