function main_analysis()
% MAIN_ANALYSIS Working version for Austrian energy market analysis

%% 1. Initialize Environment
clc; close all; 
fprintf('=== Austrian Energy Market Analysis ===\n');

% Create results directory
resultsDir = fullfile('..','results');
if ~exist(resultsDir, 'dir')
    mkdir(resultsDir);
    mkdir(fullfile(resultsDir,'figures'));
    mkdir(fullfile(resultsDir,'tables'));
end

%% 2. Load and Prepare Data (FIXED)
dataDir = fullfile('..','data','raw');
fprintf('Loading data from: %s\n', dataDir);

% Read data as tables first
elecTable = readtable(fullfile(dataDir,'electricity_prices.csv'));
gasTable = readtable(fullfile(dataDir,'gas_prices.csv'));
renewTable = readtable(fullfile(dataDir,'renewables.csv'));

% Convert to timetables with explicit time variable
elecData = table2timetable(elecTable, 'RowTimes', 'Timestamp');
gasData = table2timetable(gasTable, 'RowTimes', 'Timestamp');
renewData = table2timetable(renewTable, 'RowTimes', 'Timestamp');

% Rename variables for clarity
elecData.Properties.VariableNames = {'Elec_Price'};
gasData.Properties.VariableNames = {'Gas_Price'};
renewData.Properties.VariableNames = {'Wind_Gen', 'Solar_Gen'};

% Merge data (FIXED time handling)
combinedData = synchronize(elecData, gasData, renewData, 'regular', 'linear', 'TimeStep', hours(1));

%% 3. Price Analysis (FIXED plotting)
fprintf('Generating price analysis plots...\n');

figure('Position', [100 100 900 600]);

% Plot electricity prices
subplot(2,1,1);
plot(combinedData.Timestamp, combinedData.Elec_Price, 'b', 'LineWidth', 1.5); % Changed to .Timestamp
hold on;
plot(combinedData.Timestamp, combinedData.Gas_Price, 'r', 'LineWidth', 1.5);
title('Energy Prices - Austria','FontSize',12);
legend({'Electricity','Natural Gas'},'Location','best');
ylabel('Price (€/MWh)');
grid on;

% Plot renewable generation
subplot(2,1,2);
plot(combinedData.Timestamp, combinedData.Wind_Gen, 'Color',[0 0.5 0], 'LineWidth',1.5);
hold on;
plot(combinedData.Timestamp, combinedData.Solar_Gen, 'Color',[0.8 0.5 0], 'LineWidth',1.5);
title('Renewable Generation','FontSize',12);
legend({'Wind','Solar'},'Location','best');
ylabel('Generation (MW)');
grid on;

saveas(gcf, fullfile(resultsDir,'figures','price_analysis.png'));

%% 4. Risk Assessment
fprintf('Calculating risk metrics...\n');

% Calculate returns
returns = diff(combinedData.Elec_Price)./combinedData.Elec_Price(1:end-1);

% Compute VaR and CVaR
var95 = quantile(returns, 0.05);
cvar95 = mean(returns(returns < var95));

% Display results
riskMetrics = table(-var95*100, -cvar95*100, ...
    'VariableNames', {'VaR_95%','CVaR_95%'});
disp('Risk Metrics:');
disp(riskMetrics);

% Save results
writetable(riskMetrics, fullfile(resultsDir,'tables','risk_metrics.csv'));

fprintf('Analysis complete. Results saved in:\n%s\n', resultsDir);
end