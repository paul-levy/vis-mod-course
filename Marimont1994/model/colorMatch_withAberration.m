% usage:    colorMatch_withAberration(p,disp1,disp2,dispFig)
% by:       Michael Jigo
% purpose:  Compute the matched color images between 2 displays (disp1 & disp 2)
%
% INPUTS:
% p         parameters for the model (default = [])
% disp1     3xn matrix of spectral power distribution for the primaries in dispaly 1
% disp2     primary matrix for display 2
% dispFig   logical input (0 or 1) to display figures

function colorMatch_withAberration(p,disp1,disp2,dispFig)
if ~exist('dispFig','var')
    dispFig = 1;
end
%% Validate parameters
p.im = zeros(1,40);
p.im(20) = 1;
if ~exist('p','var') || isempty(p)
    p = inputParams;
else
    p = inputParams(p);
end

%% Create OTF
p = otf(p,dispFig);

%% Add chromatic-independent aberrations
p = otf_independentAberr(p,dispFig);

%% Generate linespread
p = otf2Linespread(p,dispFig);

%% Generate photopigment sensitivities
p = otf2Cones(p,dispFig);

%% Colormatch between displays
if ~exist('disp1')
    load phosphors
    disp1 = p1;
    disp2 = p2;
end
colorMatch(p,disp1,disp2,dispFig);
