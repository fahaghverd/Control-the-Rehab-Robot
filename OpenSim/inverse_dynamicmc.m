clc;
close all;
clear all;

% Pull in the modeling classes straight from the OpenSim distribution
import org.opensim.modeling.*

% move to directory where this subject's files are kept
% subjectDir = uigetdir('C:\OpenSim 3.3\Models\', 'Select the folder that contains the current subject data')
subjectDir = 'D:\Models\Gait2354_Simbody';
% Go to the folder in the subject's folder where .mot files are
motion_data_folder = uigetdir(subjectDir, 'Select the folder that contains the motion data files in .mot format.')

% specify where results will be printed.
results_folder = uigetdir(subjectDir, 'Select the folder where the CMC Results will be printed.')

% Get and operate on the files
% Choose a generic setup file to work from
[genericSetupForCMC,genericSetupPath,FilterIndex] = ...
    uigetfile([subjectDir '\*.xml'],'Pick the/a generic setup file to/for this subject/model as a basis for changes.')
% cmcTool = CMCTool([genericSetupPath genericSetupForCMC]);
idTool = InverseDynamicsTool([genericSetupPath genericSetupForCMC]);

% specify the folder where the external loads file are 
extLoad_folder = ... 
    uigetdir(subjectDir ,'Select the folder where the external loads files are located.');

% Get the model
[modelFile,modelFilePath,FilterIndex] = ...
    uigetfile([subjectDir '\*.osim'],'Pick the the model file to be used.');

% Load the model and initialize
model = Model([modelFilePath modelFile]);
model.initSystem();

% Tell Tool to use the loaded model
idTool.setModel(model);

trialsForCMC = dir(fullfile(motion_data_folder, '*.mot'));
nTrialsMotion = size(trialsForCMC);

% Loop through the trials of .mot files 
for trial_motion = 1:nTrialsMotion;
    
    % Get the name of the file for this trial
    motionFile = trialsForCMC(trial_motion).name;
     
    % create generic external load files
%     ForceFile000 = ['PointForceCalcnL' motionFile(7:end-9) '_force000' motionFile(end-8:end-4) '.xml'];
%     ForceFile025 = ['PointForceCalcnL' motionFile(7:end-9) '_force025' motionFile(end-8:end-4) '.xml'];
%     ForceFile050 = ['PointForceCalcnL' motionFile(7:end-9) '_force050' motionFile(end-8:end-4) '.xml'];
%     ForceFile075 = ['PointForceCalcnL' motionFile(7:end-9) '_force075' motionFile(end-8:end-4) '.xml'];
%     ForceFile100 = ['PointForceCalcnL' motionFile(7:end-9) '_force100' motionFile(end-8:end-4) '.xml'];
    
%     extLoadFile = struct('forceFile',{ForceFile000,ForceFile025});%,ForceFile050,ForceFile075,ForceFile100});
     
    % Loop through the trails of div. external load files
%     for trial_force = 1:length(extLoadFile);                      

        % Create name of trial_motion from .mot file name
        name = regexprep(motionFile,'.mot','');
%         name = (['resultsCMC' extLoadFile(trial_force).forceFile(17:end-4)]);
        fullpath = ([motion_data_folder '\' motionFile]);
%         fullpath_extLoad = ([extLoad_folder '\' extLoadFile(trial_force).forceFile]);

        % Get .mot data to determine time range
        ImportMotionData = importdata(fullpath);
        motionData = ImportMotionData.data;
    %     motionData = motionData(fullpath);

        % Get initial and intial time 
    %     initial_time = motionData.getStartFrameTime();
          initial_time = motionData(1,1);
    %     final_time = motionData.getLastFrameTime();
          final_time = motionData(end,1);

        % Setup the cmcTool for this trial
%         cmcTool.setName(name);
%         cmcTool.setDesiredKinematicsFileName(fullpath);
%         cmcTool.setInitialTime(initial_time);
%         cmcTool.setFinalTime(final_time);
%         cmcTool.setResultsDir(results_folder);
%         cmcTool.setExternalLoadsFileName(fullpath_extLoad);
    idTool.setName(name);
    idTool.setCoordinatesFileName(fullpath);
    idTool.setStartTime(initial_time);
    idTool.setEndTime(final_time);
    idTool.setOutputGenForceFileName([ 'inverse_dynamics1_' name '.sto' ]);
    
    idTool.setResultsDir(results_folder);
     outfile = [ 'setup_ID_' name '.xml' ];
         % Save the settings in a setup file
%         outfile = ['setup_CMC' extLoadFile(trial_force).forceFile(17:end-4)  '.xml'];
%         cmcTool.print([genericSetupPath outfile]);
    idTool.print([genericSetupPath outfile]);
    fprintf([ 'Performing ID on trial ' name '\n'])

%         fprintf(['Performing CMC: cycle #' num2str(trial_motion) ...
%             ' of ' num2str(nTrialsMotion(1,1)) '(motion) / #' num2str(trial_force) ...
%             ' of ' num2str(length(extLoadFile)) '(force) \n ... [' outfile ']\n ... [' extLoadFile(trial_force).forceFile ']\n']);
%      
        % Run CMC
%         cmcTool.run()
        % Run ID
    idTool.run();
        fprintf([' ... [' name '_ ... .sto]\n']);
     
%         keep def. files and folders, clear all other
%         keep subjectDir motion_data_folder results_folder genericSetupForCMC ... 
%             genericSetupPath FilterIndex cmcTool extLoad_folder modelFile modelFilePath ... 
%             model trialsForCMC nTrialsMotion trial_motion motionFile extLoadFile

%     end
end
display('*** *** *** Computer Muscle Control(id) - D O N E *** *** ***');



% 
%         
% % specify where results will be printed.
% results_folder = uigetdir(subjectDir, 'Select the folder where the ID Results will be printed.');
% 
% idTool.setOutputGenForceFileName(['resultsID' extLoadFile(trial_force).forceFile(17:end-4) '.sto']);
%         idTool.setResultsDir(results_folder);