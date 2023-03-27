clear, clc, close all
addpath(genpath('./functions'))

%% Load
load('data/data.mat','EEG');
ecg = EEG.data(ismember(upper({EEG.chanlocs(:).labels}),{'ECG','EKG'}),:);
W = load('model/weights.mat');

%% Detect
marks = deepQRS(ecg,W);

%% Plot
figure
plot(ecg)
hold on
plot(marks,ecg(marks),'*r')
title('ECG with detected peaks')
% test
