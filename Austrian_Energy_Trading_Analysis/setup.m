function setup()
% SETUP Configures project environment

% Add all folders to path
folders = {'src', 'utils', 'notebooks'};
for f = folders
    addpath(genpath(f{1}));
end

fprintf('Project paths configured. Ready to run:\n');
fprintf('1. generate_data.m\n2. main_analysis.m\n');
end