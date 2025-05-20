%% Power Injection Setpoints
P_inj = 1;                 % Active power injection (pu)
Q_inj = 0.2e-6;                 % Reactive power injection (pu)

%% General System Parameters
f_base = 50;                 % Base frequency (Hz)
wn = 2 * pi * f_base;        % Angular base frequency (rad/s)
w=wn;
f_sample=20e3;               %f_sample 20kHz
f_step=100e3;                  %s_step 100kHz

%% Inverter Ratings
Vdc = 1.5e3;                 % DC-link voltage (V)
V_LL = 0.69e3;               % Line-to-line voltage (V)
S_base = 1e6;                % Rated power of IBR (1 MW)
Zb = V_LL^2 / S_base;        % Base impedance (Ohms)
Lb = Zb / wn;                % Base inductance (H)
%% Grid Model Parameters
SCR =5;                   % Short Circuit Ratio (SCR)
XR = 5;                      % X/R Ratio
rgpu = 1 / (SCR * sqrt(1 + XR^2));  % Grid resistance in pu
lgpu = XR * rgpu;            % Grid inductance in pu
rg = rgpu * Zb;              % Grid resistance (Ohms)
lg = lgpu * Lb;              % Grid inductance (H)

%% Switching and Control Delays
fsw = 10e3;                  % Switching frequency (Hz)
td = 1.5 / fsw;              % Delay accounting for inner control loops (s)

%% LCL Filter Parameters
lf1 = 3.5211e-05;            % Inverter-side inductor (H)
rf1 = 3e-4;                  % Inverter-side resistance (Ohms)
lf2 = 5.2817e-06;            % Grid-side inductor (H)
rf2 = 3e-4;                  % Grid-side resistance (Ohms)
cf = 4.0115e-04;             % Filter capacitor (F)
rd = 35.7e-3;                % Damping resistor (Ohms)

%% Current Control Parameters
Tic = 1e-3;                % Current control time constant (s)
k_pi = lf1 / Tic;            % Proportional gain of current controller
k_ii = rf1 / Tic;            % Integral gain of current controller
beta_v = 1;                % Voltage feedback gain factor

%% Voltage Control Parameters
wm = 2100;                    % Overriding default setting (rad/s)
k_pv = cf * wm;              % Proportional gain of voltage controller
k_iv = Tic * cf * wm^3;      % Integral gain of voltage controller
beta_i = 0; 

%% Frequency & Voltage Droop Requirements
mp = 2 * pi * (0.01 * f_base) / (2 * S_base); % 1% frequency droop setting
T_RoCoF = 0.5;               % Rate of Change of Frequency (RoCoF) limit (Hz/s)
V_drop = 0.05 * sqrt(2) * V_LL; % 5% Voltage Droop (V)

%% Fictitious Shunt Parameters (for stability augmentation)
damping_cs = 1;
wn_cs = 2 * pi * 200e3;      % Natural frequency of the dummy shunt capacitor (rad/s)
cs = 1 / (lg * wn_cs^2);     % Shunt capacitance (F)
rs = 2 * damping_cs * sqrt(lg / cs); % Shunt damping resistance (Ohms)
%% APC - Virtual Synchronous Generator (VSG) Control
h = T_RoCoF * (1 / (2 * mp * wn)); % Inertia emulation

%% Reactive Power Control (RPC) - PI with Feedforward
k_pq = V_drop / (2 * S_base); % Proportional gain for reactive power control
k_iq = 1e-3;                 % Integral gain for reactive power control

%% Droop Low-Pass Filter
w_cp = 0.5;                  % Power control LPF cutoff frequency (rad/s)

%% CG-VSG Parameters (Control Gain Virtual Synchronous Generator)
Kg = (3 * (V_LL/sqrt(3))^2) / (2 * pi * f_base * lg); % Control gain

Alpha_PC = T_RoCoF;
Beta_PC = (T_RoCoF^2) * (((Kg^2 * mp^2) / T_RoCoF) - 1)^(1/3);
Gamma_PC = 1 / (((Kg^2 * mp^2) / T_RoCoF) - 1)^(1/3);

a = Alpha_PC;
b = (Beta_PC * Gamma_PC) / (Beta_PC + Gamma_PC - Alpha_PC);
c = (Beta_PC + Gamma_PC - Alpha_PC) / mp;

%% Save Parameters for Simulink
save('Parameters.mat', 'f_base', 'f_sample','f_step', 'wn', 'w','V_LL', 'S_base', 'Zb', 'Vdc', 'Lb', ...
     'fsw', 'td', 'lf1', 'rf1', 'lf2', 'rf2', 'cf', 'rd', 'SCR', 'XR', 'rgpu', 'lgpu', 'rg', 'lg', 'cs', 'rs', 'k_pi', 'k_ii', ...
     'beta_v', 'wm', 'k_pv', 'k_iv', 'beta_i', 'mp', 'h', 'k_pq', 'k_iq', 'w_cp', 'a', 'b', 'c', 'P_inj', 'Q_inj');

clear all