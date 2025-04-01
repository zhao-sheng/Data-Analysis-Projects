function generate_data()
% GENERATE_DATA Creates synthetic Austrian energy market datasets
% Output files:
%   - data/raw/electricity_prices.csv
%   - data/raw/gas_prices.csv 
%   - data/raw/renewables.csv

%% 1. Initialize paths and parameters
rawDataPath = fullfile('..', 'data', 'raw');
if ~exist(rawDataPath, 'dir')
    mkdir(rawDataPath);
end

startDate = datetime(2023, 1, 1);
endDate = datetime(2023, 1, 14); % 2-week period
timeVector = startDate:hours(1):endDate;
numPeriods = length(timeVector);

%% 2. Generate electricity prices (EPEX AT)
basePrice = 80 + 10*sin(hour(timeVector)*2*pi/24); % Daily pattern
spikes = 30*(rand(size(timeVector)) > 0.98);       % Random price spikes
noise = 5*randn(size(timeVector));                 % Market noise

electricityPrices = basePrice + spikes + noise;

% Create and save table
elecTable = table(timeVector', electricityPrices', ...
    'VariableNames', {'Timestamp', 'Price_EUR_MWh'});
writetable(elecTable, fullfile(rawDataPath, 'electricity_prices.csv'));

%% 3. Generate gas prices (CEGH AT)
gasPrices = 30 + 5*sin(hour(timeVector)*2*pi/24) + 3*randn(size(timeVector));
gasTable = table(timeVector', gasPrices', ...
    'VariableNames', {'Timestamp', 'Price_EUR_MWh'});
writetable(gasTable, fullfile(rawDataPath, 'gas_prices.csv'));

%% 4. Generate renewable generation
windGen = 2000*(0.6 + 0.2*sin(hour(timeVector)*2*pi/24)) .* (0.8 + 0.2*rand(size(timeVector)));
solarGen = 1500*(sin(hour(timeVector)*2*pi/24).^2) .* (0.7 + 0.3*rand(size(timeVector)));
solarGen(hour(timeVector) < 6 | hour(timeVector) > 20) = 0; % No solar at night

renewTable = table(timeVector', windGen', solarGen', ...
    'VariableNames', {'Timestamp', 'Wind_MW', 'Solar_MW'});
writetable(renewTable, fullfile(rawDataPath, 'renewables.csv'));

disp('Successfully generated:');
disp(dir(fullfile(rawDataPath, '*.csv')));
end