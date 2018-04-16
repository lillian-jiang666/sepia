%% qsm_hub
%
% Description: This is a GUI of QSMHub, which is a pipeline control tool
% for standard QSM processing.
%
% Kwok-shing Chan @ DCCN
% k.chan@donders.ru.nl
% Date created: 10 April 2018
% Date last modified:
%
%

clear 

qsm_hub_AddPath

global h fig

screenSize = get(0,'ScreenSize');
posLeft = round(screenSize(3)/4);
posBottom = round(screenSize(4)/6);
guiSizeHori = round(screenSize(3)/3);
guiSizeVert = round(screenSize(4)*2/3);
if guiSizeHori < 500
    guiSizeHori = 500;
end
if guiSizeVert < 650
    guiSizeVert = 650;
end

fig=figure('Units','pixels','position',[posLeft posBottom guiSizeHori guiSizeVert],...
    'MenuBar','None','Toolbar','None','Name','QSM hub','NumberTitle','off');

h.TabGroup = uitabgroup(fig,'position',[.01 .01 1 1]);
h.TabQSMWhole = uitab(h.TabGroup,'Title','One-stop QSM processing');
h.TabPhaseUnwrap = uitab(h.TabGroup,'Title','Phase unwrapping');
h.TabBKGRemoval = uitab(h.TabGroup,'Title','Background field removal');
h.TabQSM = uitab(h.TabGroup,'Title','QSM');

%% initialise GUI with QSM one-stop station tab
% I/O
h = qsmhub_handle_panel_dataIO(h.TabQSMWhole,fig,h,[0.01 0.8]);
% phase unwrap
h = qsmhub_handle_panel_phaseUnwrap(h.TabQSMWhole,fig,h,[0.01 0.59]);
% background field
h = qsmhub_handle_panel_bkgRemoval(h.TabQSMWhole,fig,h,[0.01 0.33]);
% QSM
h = qsmhub_handle_panel_qsm(h.TabQSMWhole,fig,h,[0.01 0.07]);
% Start button
h.OneStop_pushbutton_start = uicontrol('Parent',h.TabQSMWhole,'Style','pushbutton',...
    'String','Start',...
    'units','normalized','Position',[0.85 0.01 0.1 0.05],...
    'backgroundcolor',get(fig,'color'));

%% Set Callback
h = SetAllCallbacks(h);

%% utils function
function h=SetAllCallbacks(h)
set(h.TabGroup,                 'SelectionChangedFcn', {@test_Callback})
set(h.button_input,           	'Callback',{@ButtonGetInputDir_Callback});
set(h.button_output,            'Callback',{@ButtonGetOutputDir_Callback});
set(h.checkbox_brainExtraction,	'Callback',{@CheckboxBrainExtraction_Callback});
set(h.button_maskdir,       	'Callback',{@ButtonGetMaskDir_Callback});
% set(h.popup_phaseUnwrap,          'Callback',{@imageselect_Callback,h});
% set(h.popup_unit,                 'Callback',{@imageselect_Callback,h});
set(h.popup_bkgRemoval,      	'Callback',{@PopupBkgRemoval_Callback});
set(h.popup_qsm,                'Callback',{@PopupQSM_Callback});
set(h.checkbox_cfs_lambda,      'Callback',{@CheckboxCFS_Callback});
set(h.checkbox_iLSQR_lambda,    'Callback',{@CheckboxiLSQR_Callback});
set(h.OneStop_pushbutton_start,	'Callback',{@PushbuttonOneStopStart_Callback});
set(h.checkbox_excludeMask,     'Callback',{@CheckboxExcludeMask_Callback});
set(h.checkbox_MEDI_smv,        'Callback',{@CheckboxMEDISMV_Callback});
set(h.checkbox_MEDI_lambda_csf, 'Callback',{@CheckboxMEDILambdaCSF_Callback});
set(h.edit_excludeMask,         'Callback',{@EditRange01_Callback});
set(h.edit_LBV_depth,           'Callback',{@EditMin_Callback});
set(h.edit_LBV_peel,            'Callback',{@EditNonNegative_Callback});
set(h.edit_LBV_tol,             'Callback',{@EditNonNegative_Callback});
set(h.edit_PDF_maxIter,        	'Callback',{@EditNonNegative_Callback});
set(h.edit_PDF_tol,             'Callback',{@EditNonNegative_Callback});
set(h.edit_PDF_padSize,      	'Callback',{@EditNonNegative_Callback});
set(h.edit_RESHARP_lambda,     	'Callback',{@EditNonNegative_Callback});
set(h.edit_RESHARP_radius,     	'Callback',{@EditNonNegative_Callback});
set(h.edit_SHARP_radius,     	'Callback',{@EditNonNegative_Callback});
set(h.edit_SHARP_threshold,    	'Callback',{@EditNonNegative_Callback});
set(h.edit_VSHARP_minRadius,   	'Callback',{@EditNonNegative_Callback});
set(h.edit_VSHARP_maxRadius,   	'Callback',{@EditVSHARPMaxRadius_Callback});
set(h.edit_VSHARPSTI_smvSize,   'Callback',{@EditNonNegative_Callback});
set(h.edit_iHARPERELLA_maxIter,	'Callback',{@EditNonNegative_Callback});
set(h.edit_TKD_threshold,       'Callback',{@EditRange01_Callback});
set(h.edit_cfs_lambda,          'Callback',{@EditNonNegative_Callback});
set(h.edit_cfs_lambda,          'Callback',{@EditNonNegative_Callback});
set(h.edit_Star_padSize,       	'Callback',{@EditNonNegative_Callback});
set(h.edit_iLSQR_lambda,       	'Callback',{@EditNonNegative_Callback});
set(h.edit_iLSQR_maxIter,      	'Callback',{@EditNonNegative_Callback});
set(h.edit_iLSQR_tol,           'Callback',{@EditNonNegative_Callback});
set(h.edit_STIiLSQR_maxIter,   	'Callback',{@EditNonNegative_Callback});
set(h.edit_STIiLSQR_padSize,   	'Callback',{@EditNonNegative_Callback});
set(h.edit_STIiLSQR_threshold, 	'Callback',{@EditNonNegative_Callback});
set(h.edit_STIiLSQR_tol1,   	'Callback',{@EditNonNegative_Callback});
set(h.edit_STIiLSQR_tol2,   	'Callback',{@EditNonNegative_Callback});
set(h.edit_FANSI_lambda,        'Callback',{@EditNonNegative_Callback});
set(h.edit_FANSI_maxIter,       'Callback',{@EditNonNegative_Callback});
set(h.edit_FANSI_mu,            'Callback',{@EditNonNegative_Callback});
set(h.edit_FANSI_tol,           'Callback',{@EditNonNegative_Callback});
end
% end
%% Callback
function test_Callback(source,eventdata)
global h fig
switch eventdata.NewValue.Title
    case 'One-stop QSM processing'
        %% QSM one-stop station
        % I/O
        h = qsmhub_handle_panel_dataIO(h.TabQSMWhole,fig,h,[0.01 0.8]);
        % phase unwrap
        h = qsmhub_handle_panel_phaseUnwrap(h.TabQSMWhole,fig,h,[0.01 0.59]);
        % background field
        h = qsmhub_handle_panel_bkgRemoval(h.TabQSMWhole,fig,h,[0.01 0.33]);
        % QSM
        h = qsmhub_handle_panel_qsm(h.TabQSMWhole,fig,h,[0.01 0.07]);
        % Start button
        h.OneStopTab_pushbutton_start = uicontrol('Parent',h.TabQSMWhole,'Style','pushbutton',...
            'String','Start',...
            'units','normalized','Position',[0.85 0.01 0.1 0.05],...
            'backgroundcolor',get(fig,'color'));
        
    case 'Phase unwrapping'
        %% Phase unwrapping tab
        % I/O
        h = qsmhub_handle_panel_dataIO(h.TabPhaseUnwrap,fig,h,[0.01 0.8]);
        % phase unwrap
        h = qsmhub_handle_panel_phaseUnwrap(h.TabPhaseUnwrap,fig,h,[0.01 0.59]);
        % Start button
        h.PhaseUnwrapTab_pushbutton_start = uicontrol('Parent',h.TabPhaseUnwrap,'Style','pushbutton',...
            'String','Start',...
            'units','normalized','Position',[0.85 0.01 0.1 0.05],...
            'backgroundcolor',get(fig,'color'));
        
    case 'Background field removal'
        %% background field removal tab
        % I/O
        h = qsmhub_handle_panel_dataIO(h.TabBKGRemoval,fig,h,[0.01 0.8]);
        % background field
        h = qsmhub_handle_panel_bkgRemoval(h.TabBKGRemoval,fig,h,[0.01 0.59]);
        % Start button
        h.BKGRemovalTab_pushbutton_start = uicontrol('Parent',h.TabBKGRemoval,'Style','pushbutton',...
            'String','Start',...
            'units','normalized','Position',[0.85 0.01 0.1 0.05],...
            'backgroundcolor',get(fig,'color'));
        
    case 'QSM'
        %% qsm tab
        % I/O
        h = qsmhub_handle_panel_dataIO(h.TabQSM,fig,h,[0.01 0.8]);
        % QSM
        h = qsmhub_handle_panel_qsm(h.TabQSM,fig,h,[0.01 0.59]);
        % Start button
        h.QSMTab_pushbutton_start = uicontrol('Parent',h.TabQSM,'Style','pushbutton',...
            'String','Start',...
            'units','normalized','Position',[0.85 0.01 0.1 0.05],...
            'backgroundcolor',get(fig,'color'));
        
end
% set callbacks
h=SetAllCallbacks(h);
end

function ButtonGetInputDir_Callback(source,eventdata)

global h

pathDir = uigetdir;

if pathDir ~= 0
    set(h.edit_input,'String',pathDir);
    parts = strfind(pathDir, '/');
    pathDirParent = pathDir(1:parts(end));
%     set(h.edit_output,'String',[pathDirParent 'output']);
    set(h.edit_output,'String',[pathDir filesep 'output']);
end
end

function ButtonGetOutputDir_Callback(source,eventdata)

global h

pathDir = uigetdir;

if pathDir ~= 0
    set(h.edit_output,'String',pathDir);qsmhub_handle_panel_bkgRemoval
end
end

function CheckboxBrainExtraction_Callback(source,eventdata)

global h

if ~h.checkbox_brainExtraction.Value
    set(h.button_maskdir,'Enable','on');
    set(h.edit_maskdir,'Enable','on');
else
    set(h.button_maskdir,'Enable','off');
    set(h.edit_maskdir,'Enable','off');
end
end
    
function ButtonGetMaskDir_Callback(source,eventdata)

global h

[maskfileName,pathDir] = uigetfile({'*.nii.gz';'*.nii'},'Select the mask file');

if pathDir ~= 0
    set(h.edit_maskdir,'String',fullfile(pathDir,maskfileName));
end
end

function PopupBkgRemoval_Callback(source,eventdata)

global h

method = source.String{source.Value,1} ;

switch method
    case 'LBV'
        set(h.panel_bkgRemoval_LBV,'Visible','on');
        set(h.panel_bkgRemoval_PDF,'Visible','off');
        set(h.panel_bkgRemoval_RESHARP,'Visible','off');
        set(h.panel_bkgRemoval_SHARP,'Visible','off');
        set(h.panel_bkgRemoval_VSHARP,'Visible','off');
        set(h.panel_bkgRemoval_VSHARPSTI,'Visible','off');
        set(h.panel_bkgRemoval_iHARPERELLA,'Visible','off');
    case 'PDF'
        set(h.panel_bkgRemoval_LBV,'Visible','off');
        set(h.panel_bkgRemoval_PDF,'Visible','on');
        set(h.panel_bkgRemoval_RESHARP,'Visible','off');
        set(h.panel_bkgRemoval_SHARP,'Visible','off');
        set(h.panel_bkgRemoval_VSHARP,'Visible','off');
        set(h.panel_bkgRemoval_VSHARPSTI,'Visible','off');
        set(h.panel_bkgRemoval_iHARPERELLA,'Visible','off');
    case 'RESHARP'
        set(h.panel_bkgRemoval_LBV,'Visible','off');
        set(h.panel_bkgRemoval_PDF,'Visible','off');
        set(h.panel_bkgRemoval_RESHARP,'Visible','on');
        set(h.panel_bkgRemoval_SHARP,'Visible','off');
        set(h.panel_bkgRemoval_VSHARP,'Visible','off');
        set(h.panel_bkgRemoval_VSHARPSTI,'Visible','off');
        set(h.panel_bkgRemoval_iHARPERELLA,'Visible','off');
    case 'SHARP'
        set(h.panel_bkgRemoval_LBV,'Visible','off');
        set(h.panel_bkgRemoval_PDF,'Visible','off');
        set(h.panel_bkgRemoval_RESHARP,'Visible','off');
        set(h.panel_bkgRemoval_SHARP,'Visible','on');
        set(h.panel_bkgRemoval_VSHARP,'Visible','off');
        set(h.panel_bkgRemoval_VSHARPSTI,'Visible','off');
        set(h.panel_bkgRemoval_iHARPERELLA,'Visible','off');
    case 'VSHARP'
        set(h.panel_bkgRemoval_LBV,'Visible','off');
        set(h.panel_bkgRemoval_PDF,'Visible','off');
        set(h.panel_bkgRemoval_RESHARP,'Visible','off');
        set(h.panel_bkgRemoval_SHARP,'Visible','off');
        set(h.panel_bkgRemoval_VSHARP,'Visible','on');
        set(h.panel_bkgRemoval_VSHARPSTI,'Visible','off');
        set(h.panel_bkgRemoval_iHARPERELLA,'Visible','off');
    case 'VSHARP STI suite'
        set(h.panel_bkgRemoval_LBV,'Visible','off');
        set(h.panel_bkgRemoval_PDF,'Visible','off');
        set(h.panel_bkgRemoval_RESHARP,'Visible','off');
        set(h.panel_bkgRemoval_SHARP,'Visible','off');
        set(h.panel_bkgRemoval_VSHARP,'Visible','off');
        set(h.panel_bkgRemoval_VSHARPSTI,'Visible','on');
        set(h.panel_bkgRemoval_iHARPERELLA,'Visible','off');
    case 'iHARPERELLA'
        set(h.panel_bkgRemoval_LBV,'Visible','off');
        set(h.panel_bkgRemoval_PDF,'Visible','off');
        set(h.panel_bkgRemoval_RESHARP,'Visible','off');
        set(h.panel_bkgRemoval_SHARP,'Visible','off');
        set(h.panel_bkgRemoval_VSHARP,'Visible','off');
        set(h.panel_bkgRemoval_VSHARPSTI,'Visible','off');
        set(h.panel_bkgRemoval_iHARPERELLA,'Visible','on');
end
end

function PopupQSM_Callback(source,eventdata)

global h

method = source.String{source.Value,1} ;

switch method
    case 'TKD'
        set(h.panel_qsm_TKD,'Visible','on');
        set(h.panel_qsm_cfs,'Visible','off');
        set(h.panel_qsm_iLSQR,'Visible','off');
        set(h.panel_qsm_STIiLSQR,'Visible','off');
        set(h.panel_qsm_FANSI,'Visible','off');
        set(h.panel_qsm_Star,'Visible','off');
        set(h.panel_qsm_MEDI,'Visible','off');
    case 'Closed-form solution'
        set(h.panel_qsm_TKD,'Visible','off');
        set(h.panel_qsm_cfs,'Visible','on');
        set(h.panel_qsm_iLSQR,'Visible','off');
        set(h.panel_qsm_STIiLSQR,'Visible','off');
        set(h.panel_qsm_FANSI,'Visible','off');
        set(h.panel_qsm_Star,'Visible','off');
        set(h.panel_qsm_MEDI,'Visible','off');
    case 'STI suite iLSQR'
        set(h.panel_qsm_TKD,'Visible','off');
        set(h.panel_qsm_cfs,'Visible','off');
        set(h.panel_qsm_iLSQR,'Visible','off');
        set(h.panel_qsm_STIiLSQR,'Visible','on');
        set(h.panel_qsm_FANSI,'Visible','off');
        set(h.panel_qsm_Star,'Visible','off');
        set(h.panel_qsm_MEDI,'Visible','off');
    case 'iLSQR'
        set(h.panel_qsm_TKD,'Visible','off');
        set(h.panel_qsm_cfs,'Visible','off');
        set(h.panel_qsm_iLSQR,'Visible','on');
        set(h.panel_qsm_STIiLSQR,'Visible','off');
        set(h.panel_qsm_FANSI,'Visible','off');
        set(h.panel_qsm_Star,'Visible','off');
        set(h.panel_qsm_MEDI,'Visible','off');
    case 'FANSI'
        set(h.panel_qsm_TKD,'Visible','off');
        set(h.panel_qsm_cfs,'Visible','off');
        set(h.panel_qsm_iLSQR,'Visible','off');
        set(h.panel_qsm_STIiLSQR,'Visible','off');
        set(h.panel_qsm_FANSI,'Visible','on');
        set(h.panel_qsm_Star,'Visible','off');
        set(h.panel_qsm_MEDI,'Visible','off');
    case 'Star'
        set(h.panel_qsm_TKD,'Visible','off');
        set(h.panel_qsm_cfs,'Visible','off');
        set(h.panel_qsm_iLSQR,'Visible','off');
        set(h.panel_qsm_STIiLSQR,'Visible','off');
        set(h.panel_qsm_FANSI,'Visible','off');
        set(h.panel_qsm_Star,'Visible','on');
        set(h.panel_qsm_MEDI,'Visible','off');
    case 'MEDI'
        set(h.panel_qsm_TKD,'Visible','off');
        set(h.panel_qsm_cfs,'Visible','off');
        set(h.panel_qsm_iLSQR,'Visible','off');
        set(h.panel_qsm_STIiLSQR,'Visible','off');
        set(h.panel_qsm_FANSI,'Visible','off');
        set(h.panel_qsm_Star,'Visible','off');
        set(h.panel_qsm_MEDI,'Visible','on');
end
end

function CheckboxCFS_Callback(source,eventdata)

global h

if ~h.checkbox_cfs_lambda.Value
    set(h.edit_cfs_lambda,'Enable','on');
else
    set(h.edit_cfs_lambda,'Enable','off');
end
end

function CheckboxMEDISMV_Callback(source,eventdata)
global h

if h.checkbox_MEDI_smv.Value
    set(h.edit_MEDI_smv_radius,'Enable','on');
else
    set(h.edit_MEDI_smv_radius,'Enable','off');
end
end

function CheckboxMEDILambdaCSF_Callback(source,eventdata)
global h

if h.checkbox_MEDI_lambda_csf.Value
    set(h.edit_MEDI_lambda_csf,'Enable','on');
else
    set(h.edit_MEDI_lambda_csf,'Enable','off');
end
end

function CheckboxiLSQR_Callback(source,eventdata)

global h

if ~h.checkbox_iLSQR_lambda.Value
    set(h.edit_iLSQR_lambda,'Enable','on');
else
    set(h.edit_iLSQR_lambda,'Enable','off');
end
end

function CheckboxExcludeMask_Callback(source,eventdata)

global h

if h.checkbox_excludeMask.Value
    set(h.edit_excludeMask,'Enable','on');
else
    set(h.edit_excludeMask,'Enable','off');
end
end

function EditVSHARPMaxRadius_Callback(source,eventdata)
global h
if str2double(source.String) <= str2double(h.edit_VSHARP_minRadius.String)
    source.String = num2str(str2double(h.edit_VSHARP_minRadius.String) +1);
end
end

function EditNonNegative_Callback(source,eventdata)
if str2double(source.String)<0
    source.String = '0';
end
end

function EditMin_Callback(source,eventdata)
if str2double(source.String)<-1
    source.String = '-1';
end
end

function EditRange01_Callback(source,eventdata)

if str2double(source.String)<0
    source.String = '0';
end
if str2double(source.String)>1
    source.String = '1';
end

end

function PushbuttonOneStopStart_Callback(source,eventdata)

global h

% initialise all possible parameters
subsampling=1;
BFR_tol=1e-4;BFR_depth=4;BFR_peel=2;BFR_iteration=50;
% BFR_CGdefault=true;
BFR_padSize = 40;
BFR_radius=4;BFR_alpha=0.01;BFR_threshold=0.03;
QSM_threshold=0.15;QSM_lambda=0.13;QSM_optimise=false;
QSM_tol=1e-3;QSM_maxiter=50;QSM_tol1=0.01;QSM_tol2=0.001;QSM_padsize=[4,4,4];
QSM_mu1=5e-5;QSM_solver='linear';QSM_constraint='tv';
QSM_radius=5;QSM_zeropad=0;QSM_wData=1;QSM_wGradient=1;QSM_lambdaCSF=100;
QSM_isSMV=false;QSM_merit=false;QSM_isLambdaCSF=false;

inputDir = get(h.edit_input,'String');
outputDir = get(h.edit_output,'String');
maskDir = get(h.edit_maskdir,'String');
isBET = get(h.checkbox_brainExtraction,'Value');
phaseUnwrap = h.popup_phaseUnwrap.String{h.popup_phaseUnwrap.Value,1};
% units = h.popup_unit.String{h.popup_unit.Value,1};
BFR = h.popup_bkgRemoval.String{h.popup_bkgRemoval.Value,1};
QSM_method = h.popup_qsm.String{h.popup_qsm.Value,1};
refine = get(h.checkbox_bkgRemoval,'Value');
isEddyCorrect = get(h.checkbox_eddyCorrect,'Value');

if get(h.checkbox_excludeMask,'Value')
    excludeMaskThreshold = str2double(get(h.edit_excludeMask,'String'));
else
    excludeMaskThreshold = 1;
end

switch phaseUnwrap
    case 'Region growing'
        phaseUnwrap = 'rg';
    case 'Graphcut'
        phaseUnwrap = 'gc';
    case 'Laplacian STI suite'
        phaseUnwrap = 'laplacian_stisuite';
end

% get specific backgroud field removal algorithm parameters
switch BFR
    case 'LBV'
        BFR='lbv';
        try BFR_tol = str2double(get(h.edit_LBV_tol,'String')); catch; BFR_tol=1e-4; end
        try BFR_depth = str2double(get(h.edit_LBV_depth,'String')); catch; BFR_depth=4; end
        try BFR_peel = str2double(get(h.edit_LBV_peel,'String')); catch; BFR_peel=4; end
    case 'PDF'
        BFR='pdf';
        try BFR_tol = str2double(get(h.edit_PDF_tol,'String')); catch; BFR_tol=1e-2; end
        try BFR_iteration = str2double(get(h.edit_PDF_maxIter,'String')); catch; BFR_iteration=50; end
        try BFR_padSize = str2double(get(h.edit_PDF_padSize,'String')); catch; BFR_iteration=40; end
%         try BFR_CGdefault = h.popup_PDF_cgSolver.String{h.popup_PDF_cgSolver.Value,1}; catch; BFR_CGdefault=true; end
    case 'RESHARP'
        BFR='resharp';
        try BFR_radius = str2double(get(h.edit_RESHARP_radius,'String')); catch; BFR_radius=4; end
        try BFR_alpha = str2double(get(h.edit_RESHARP_lambda,'String')); catch; BFR_alpha=0.01; end
    case 'SHARP'
        BFR='sharp';
        try BFR_radius = str2double(get(h.edit_SHARP_radius,'String')); catch; BFR_radius=4; end
        try BFR_threshold = str2double(get(h.edit_SHARP_threshold,'String')); catch; BFR_threshold=0.03; end
    case 'VSHARP'
        BFR='vsharp';
        try maxRadius = str2double(get(h.edit_VSHARP_maxRadius,'String')); catch; maxRadius=10; end
        try minRadius = str2double(get(h.edit_VSHARP_minRadius,'String')); catch; minRadius=3; end
        BFR_radius = maxRadius:-2:minRadius;
    case 'iHARPERELLA'
        BFR='iharperella';
        try BFR_iteration = str2double(get(h.edit_iHARPERELLA_maxIter,'String')); catch; BFR_iteration=100; end 
    case 'VSHARP STI suite'
        BFR='vsharpsti';
        try BFR_radius = str2double(get(h.edit_VSHARPSTI_smvSize,'String')); catch; BFR_radius=12; end
end

% get QSM algorithm parameters
switch QSM_method
    case 'TKD'
        QSM_method='tkd';
        try QSM_threshold = str2double(get(h.edit_TKD_threshold,'String')); catch; QSM_threshold=0.15; end
    case 'Closed-form solution'
        QSM_method='closedforml2';
        try QSM_lambda = str2double(get(h.edit_cfs_lambda,'String')); catch; QSM_lambda=0.13; end
        try QSM_optimise = get(h.checkbox_cfs_lambda,'Value'); catch; QSM_optimise=false; end
    case 'STI suite iLSQR'
        QSM_method='stisuiteilsqr';
        try QSM_threshold = str2double(get(h.edit_STIiLSQR_threshold,'String')); catch; QSM_threshold=0.01; end
        try QSM_maxiter = str2double(get(h.edit_STIiLSQR_maxIter,'String')); catch; QSM_maxiter=100; end
        try QSM_tol1 = str2double(get(h.edit_STIiLSQR_tol1,'String')); catch; QSM_tol1=0.01; end
        try QSM_tol2 = str2double(get(h.edit_STIiLSQR_tol2,'String')); catch; QSM_tol2=0.001; end
        try QSM_padsize = str2double(get(h.edit_STIiLSQR_padSize,'String')); catch; QSM_padsize=4; end
        QSM_padsize = [QSM_padsize,QSM_padsize,QSM_padsize];
    case 'iLSQR'
        QSM_method='ilsqr';
        try QSM_tol = str2double(get(h.edit_iLSQR_tol,'String')); catch; QSM_tol=0.001; end
        try QSM_maxiter = str2double(get(h.edit_iLSQR_maxIter,'String')); catch; QSM_maxiter=100; end
        try QSM_lambda = str2double(get(h.edit_iLSQR_lambda,'String')); catch; QSM_lambda=0.13; end
        try QSM_optimise = get(h.checkbox_iLSQR_lambda,'Value'); catch; QSM_optimise=false; end 
    case 'FANSI'
        QSM_method='fansi';
        try QSM_tol = str2double(get(h.edit_FANSI_tol,'String')); catch; QSM_tol=1; end
        try QSM_lambda = str2double(get(h.edit_FANSI_lambda,'String')); catch; QSM_lambda=3e-5; end
        try QSM_mu1 = str2double(get(h.edit_FANSI_mu,'String')); catch; QSM_mu1=5e-5; end
        try QSM_maxiter = str2double(get(h.edit_FANSI_maxIter,'String')); catch; QSM_maxiter=50; end
        try 
            QSM_solver = h.popup_FANSI_solver.String{h.popup_FANSI_solver.Value,1}; 
        catch
            QSM_solver='linear'; 
        end 
        try 
            QSM_constraint = h.popup_FANSI_constraints.String{h.popup_FANSI_constraints.Value,1}; 
        catch
            QSM_constraint='tv'; 
        end 
    case 'Star'
        QSM_method='star';
        try QSM_threshold = str2double(get(h.edit_Star_padSize,'String')); catch; QSM_padsize=4; end
    case 'MEDI'
        QSM_method='medi_l1';
        try QSM_lambda = str2double(get(h.edit_MEDI_lambda,'String')); catch; QSM_lambda=1000; end 
        try QSM_wData = str2double(get(h.edit_MEDI_weightData,'String')); catch; QSM_wData=1; end 
        try QSM_wGradient = str2double(get(h.edit_MEDI_weightGradient,'String')); catch; QSM_wGradient=1; end 
        try QSM_zeropad = str2double(get(h.edit_MEDI_zeropad,'String')); catch; QSM_zeropad=0; end 
        try QSM_radius = str2double(get(h.edit_MEDI_smv_radius,'String')); catch; QSM_radius=5; end 
        try QSM_isSMV = get(h.checkbox_MEDI_smv,'Value'); catch; QSM_isSMV=0; end 
        try QSM_merit = get(h.checkbox_MEDI_merit,'Value'); catch; QSM_merit=0; end 
        try QSM_isLambdaCSF = get(h.checkbox_MEDI_lambda_csf,'Value'); catch; QSM_isLambdaCSF=0; end 
        try QSM_lambdaCSF = str2double(get(h.edit_MEDI_lambda_csf,'String')); catch; QSM_lambdaCSF=100; end 
end

% look for mask file full name
try 
    maskFullName = maskDir;
catch
    maskFullName = [];
end

% QSMHub(inputDir,outputDir,'FSLBet',isBET,'mask',maskFullName,'unwrap',phaseUnwrap,...
%     'unit',units,'Subsampling',subsampling,'BFR',BFR,'refine',refine,'BFR_tol',BFR_tol,...
%     'depth',BFR_depth,'peel',BFR_peel,'BFR_iteration',BFR_iteration,'CGsolver',BFR_CGdefault,...
%     'BFR_radius',BFR_radius,'BFR_alpha',BFR_alpha,'BFR_threshold',BFR_threshold,...
%     'QSM',QSM_method,'QSM_threshold',QSM_threshold,'QSM_lambda',QSM_lambda,'QSM_optimise',QSM_optimise,...
%     'QSM_tol',QSM_tol,'QSM_iteration',QSM_maxiter,'QSM_tol1',QSM_tol1,'QSM_tol2',QSM_tol2,...
%     'QSM_padsize',QSM_padsize,'QSM_mu',QSM_mu1,QSM_solver,QSM_constraint,'exclude_threshold',excludeMaskThreshold);

QSMHub(inputDir,outputDir,'FSLBet',isBET,'mask',maskFullName,'unwrap',phaseUnwrap,...
    'Subsampling',subsampling,'BFR',BFR,'refine',refine,'BFR_tol',BFR_tol,...
    'depth',BFR_depth,'peel',BFR_peel,'BFR_iteration',BFR_iteration,'BFR_padsize',BFR_padSize,...
    'BFR_radius',BFR_radius,'BFR_alpha',BFR_alpha,'BFR_threshold',BFR_threshold,...
    'QSM',QSM_method,'QSM_threshold',QSM_threshold,'QSM_lambda',QSM_lambda,'QSM_optimise',QSM_optimise,...
    'QSM_tol',QSM_tol,'QSM_iteration',QSM_maxiter,'QSM_tol1',QSM_tol1,'QSM_tol2',QSM_tol2,...
    'QSM_padsize',QSM_padsize,'QSM_mu',QSM_mu1,QSM_solver,QSM_constraint,'exclude_threshold',excludeMaskThreshold,...
    'QSM_zeropad',QSM_zeropad,'QSM_wData',QSM_wData,'QSM_wGradient',QSM_wGradient,'QSM_radius',QSM_radius,...
    'QSM_isSMV',QSM_isSMV,'QSM_merit',QSM_merit,'QSM_isLambdaCSF',QSM_isLambdaCSF,'QSM_lambdaCSF',QSM_lambdaCSF,'eddy',isEddyCorrect);

end
