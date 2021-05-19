%% Preparation
clear; clc; close all;
%% initialization
DATADIR = 'C:\Users\bexal\BCI Project\';
ERPDATA = 'EEG_ERP.mat';
SSVEPDATA = 'EEG_SSVEP.mat';
MIDATA = 'EEG_MI.mat';
STRUCTINFO = {'EEG_ERP_train', 'EEG_ERP_test'};
% SESSIONS = {'session1', 'session2'};
SESSIONS = {'session1'};
TOTAL_SUBJECTS = 54;
out_folder = 'not_noised';
if ~exist(out_folder, 'dir')
       mkdir(out_folder)
end
%% Feature extraction
for sessNum = 1:length(SESSIONS)
    session = SESSIONS{sessNum};
    fprintf('\n%s validation\n',session);
    for subNum = 1:TOTAL_SUBJECTS
        subject = sprintf('s%d',subNum);
        fprintf('LOAD %s ...\n',subject);
        
        sessPrefix = sprintf('%02.0f', sessNum);
        subPrefix = sprintf('%02.0f', subNum);
        
        ERPDATA = append('sess', sessPrefix, '_', 'subj',...
                         subPrefix, '_', ERPDATA);
        MIDATA = append('sess', sessPrefix, '_', 'subj',...
                         subPrefix, '_', MIDATA);
        SSVEPDATA = append('sess', sessPrefix, '_', 'subj',...
                         subPrefix, '_', SSVEPDATA);
        
        erp_data = load(fullfile(DATADIR,session,subject,ERPDATA));
        mi_data = load(fullfile(DATADIR,session,subject,MIDATA));
        ssvep_data = load(fullfile(DATADIR,session,subject,SSVEPDATA));
        
        out_erp_tr = func_erp(erp_data.EEG_ERP_train);
        out_erp_test = func_erp(erp_data.EEG_ERP_test);
        erp_path_tr = fullfile(out_folder, strcat(extractBefore(ERPDATA, '.mat'), 'train'));
        erp_path_test = fullfile(out_folder, strcat(extractBefore(ERPDATA, '.mat'), 'test'));
        % Saving train data
        save_erp_tr.x = out_erp_tr.x;
        save_erp_tr.y = out_erp_tr.y_logic;
        % Saving test data
        save_erp_te.x = out_erp_test.x;
        save_erp_te.y = out_erp_test.y_logic;
        
        save(erp_path_tr, 'save_erp_tr');
        save(erp_path_test, 'save_erp_te');
        
        out_mi_tr = func_mi(mi_data.EEG_MI_train);
        out_mi_test = func_mi(mi_data.EEG_MI_test);
        mi_path_tr = fullfile(out_folder, strcat(extractBefore(MIDATA, '.mat'), 'train'));
        mi_path_test = fullfile(out_folder, strcat(extractBefore(MIDATA, '.mat'), 'test'));
        % Saving train data
        save_mi_tr.x = out_mi_tr.x;
        save_mi_tr.y = out_mi_tr.y_logic;
        % Saving test data
        save_mi_te.x = out_mi_test.x;
        save_mi_te.y = out_mi_test.y_logic;
        
        save(mi_path_tr, 'save_mi_tr');
        save(mi_path_test, 'save_mi_te');
        
        out_ssvep_tr = func_ssvep(ssvep_data.EEG_SSVEP_train);
        out_ssvep_test = func_ssvep(ssvep_data.EEG_SSVEP_test);
        ssvep_path_tr = fullfile(out_folder, strcat(extractBefore(SSVEPDATA, '.mat'), 'train'));
        ssvep_path_test = fullfile(out_folder, strcat(extractBefore(SSVEPDATA, '.mat'), 'test'));
        % Saving train data
        save_ssvep_tr.x = out_ssvep_tr.x;
        save_ssvep_tr.y = out_ssvep_tr.y_logic;
        % Saving test data
        save_ssvep_te.x = out_ssvep_test.x;
        save_ssvep_te.y = out_ssvep_test.y_logic;
        
        save(ssvep_path_tr, 'save_ssvep_tr');
        save(ssvep_path_test, 'save_ssvep_te');
        
        ERPDATA = 'EEG_ERP.mat';
        SSVEPDATA = 'EEG_SSVEP.mat';
        MIDATA = 'EEG_MI.mat';
        fprintf('FINISHED %s ...\n',subject);
        clear CNT
    end
end