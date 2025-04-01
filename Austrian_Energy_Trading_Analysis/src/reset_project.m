function reset_project()
% RESET_PROJECT Clears all generated files for a fresh start

% Delete raw data files
rawFiles = dir(fullfile('..', 'data', 'raw', '*.csv'));
for i = 1:length(rawFiles)
    delete(fullfile(rawFiles(i).folder, rawFiles(i).name));
end

% Delete processed data files
procFiles = dir(fullfile('..', 'data', 'processed', '*.mat'));
for i = 1:length(procFiles)
    delete(fullfile(procFiles(i).folder, procFiles(i).name));
end

% Clear figure files
figFiles = dir(fullfile('..', 'results', 'figures', '*'));
for i = 1:length(figFiles)
    if ~figFiles(i).isdir
        delete(fullfile(figFiles(i).folder, figFiles(i).name));
    end
end

% Clear table files
tabFiles = dir(fullfile('..', 'results', 'tables', '*.csv'));
for i = 1:length(tabFiles)
    delete(fullfile(tabFiles(i).folder, tabFiles(i).name));
end

fprintf('Project reset complete.\n');
fprintf('Run generate_data.m to recreate sample data.\n');
end