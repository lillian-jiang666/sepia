%% h = sepia_handle_panel_qsm_FANSI(hParent,h,position)
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
% Description: This GUI function creates a panel for FANSI method
%
% Kwok-shing Chan @ DCCN
% k.chan@donders.ru.nl
% Date created: 1 June 2018
% Date last modified: 
%
%
function h = sepia_handle_panel_qsm_FANSI(hParent,h,position)

%% set default values
defaultTol      = 1;
defaultLambda   = 3e-5;
defaultMu       = 5e-5;
defaultMu2      = 1;
defaultMaxIter  = 50;

%% Parent handle of CFS panel children

h.qsm.panel.FANSI = uipanel(hParent,...
        'Title','FAst Nonlinear Susceptibility Inversion (FANSI)',...
        'position',position,...
        'backgroundcolor',get(h.fig,'color'),'Visible','off');

%% Children of CFS panel
    
    % text|edit field pair: tolerance
    h.qsm.FANSI.text.tol = uicontrol('Parent',h.qsm.panel.FANSI,...
        'Style','text',...
        'String','Tolerance:',...
        'units','normalized','position',[0.01 0.75 0.2 0.2],...
        'HorizontalAlignment','left',...
        'backgroundcolor',get(h.fig,'color'),...
        'tooltip','Convergence limit, change rate in the solution');
    h.qsm.FANSI.edit.tol = uicontrol('Parent',h.qsm.panel.FANSI,...
        'Style','edit',...
        'String',num2str(defaultTol),...
        'units','normalized','position',[0.25 0.75 0.2 0.2],...
        'backgroundcolor','white');

    % text|edit field pair: gradient L1 penalty
    h.qsm.FANSI.text.lambda = uicontrol('Parent',h.qsm.panel.FANSI,...
        'Style','text',...
        'String','Gradient L1 penalty:',...
        'units','normalized','position',[0.01 0.5 0.2 0.2],...
        'HorizontalAlignment','left',...
        'backgroundcolor',get(h.fig,'color'),...
        'tooltip','Regularisation rate');
    h.qsm.FANSI.edit.lambda = uicontrol('Parent',h.qsm.panel.FANSI,...
        'Style','edit',...
        'String',num2str(defaultLambda),...
        'units','normalized','position',[0.25 0.5 0.2 0.2],...
        'backgroundcolor','white');

    % text|edit field pair: gradient consistency
    h.qsm.FANSI.text.mu = uicontrol('Parent',h.qsm.panel.FANSI,...
        'Style','text',...
        'String','Gradient consistency:',...
        'units','normalized','position',[0.5 0.5 0.23 0.2],...
        'HorizontalAlignment','left',...
        'backgroundcolor',get(h.fig,'color'));
    h.qsm.FANSI.edit.mu = uicontrol('Parent',h.qsm.panel.FANSI,...
        'Style','edit',...
        'String',num2str(defaultMu),...
        'units','normalized','position',[0.75 0.5 0.2 0.2],...
        'backgroundcolor','white');

    % text|edit field pair: fidelity consistency
    h.qsm.FANSI.text.mu2 = uicontrol('Parent',h.qsm.panel.FANSI,...
        'Style','text',...
        'String','Fidelity consistency:',...
        'units','normalized','position',[0.5 0.75 0.23 0.2],...
        'HorizontalAlignment','left',...
        'backgroundcolor',get(h.fig,'color'));
    h.qsm.FANSI.edit.mu2 = uicontrol('Parent',h.qsm.panel.FANSI,...
        'Style','edit',...
        'String',num2str(defaultMu2),...
        'units','normalized','position',[0.75 0.75 0.2 0.2],...
        'backgroundcolor','white');

    % text|edit field pair: maximum iterations
    h.qsm.FANSI.text.maxIter = uicontrol('Parent',h.qsm.panel.FANSI,...
        'Style','text',...
        'String','Max. iterations:',...
        'units','normalized','position',[0.01 0.25 0.2 0.2],...
        'HorizontalAlignment','left',...
        'backgroundcolor',get(h.fig,'color'),...
        'tooltip','Maximum iterations allowed');
    h.qsm.FANSI.edit.maxIter = uicontrol('Parent',h.qsm.panel.FANSI,...
        'Style','edit',...
        'String',num2str(defaultMaxIter),...
        'units','normalized','position',[0.25 0.25 0.2 0.2],...
        'backgroundcolor','white');

    % text|popup field pair: solver
    h.qsm.FANSI.text.solver = uicontrol('Parent',h.qsm.panel.FANSI,...
        'Style','text',...
        'String','Solver:',...
        'units','normalized','position',[0.01 0.01 0.2 0.2],...
        'HorizontalAlignment','left',...
        'backgroundcolor',get(h.fig,'color'));
    h.qsm.FANSI.popup.solver = uicontrol('Parent',h.qsm.panel.FANSI,...
        'Style','popup',...
        'String',{'Linear','Non-linear'},...
        'units','normalized','position',[0.25 0.01 0.2 0.2],...
        'backgroundcolor','white');

    % text|popup field pair: constraint
    h.qsm.FANSI.text.constraints = uicontrol('Parent',h.qsm.panel.FANSI,...
        'Style','text',...
        'String','Constraint:',...
        'units','normalized','position',[0.5 0.01 0.2 0.2],...
        'HorizontalAlignment','left',...
        'backgroundcolor',get(h.fig,'color'));
    h.qsm.FANSI.popup.constraints = uicontrol('Parent',h.qsm.panel.FANSI,...
        'Style','popup',...
        'String',{'TV','TGV'},...
        'units','normalized','position',[0.75 0.01 0.2 0.2],...
        'backgroundcolor','white');

%% set callbacks
set(h.qsm.FANSI.edit.lambda,	'Callback', {@EditInputMinMax_Callback,defaultLambda,   0,0});
set(h.qsm.FANSI.edit.maxIter,	'Callback', {@EditInputMinMax_Callback,defaultMaxIter,  1,1});
set(h.qsm.FANSI.edit.mu,     	'Callback', {@EditInputMinMax_Callback,defaultMu,       0,0});
set(h.qsm.FANSI.edit.mu2,     	'Callback', {@EditInputMinMax_Callback,defaultMu2,      0,0});
set(h.qsm.FANSI.edit.tol,    	'Callback', {@EditInputMinMax_Callback,defaultTol,      0,0});

end