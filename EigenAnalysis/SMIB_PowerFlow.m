function mpc = SMIB_PowerFlow(rg, lg)
%CASEFILE  Example MATPOWER case for a 690V, 1MVA inverter system
%   Bus 1: PQ bus (Injecting 0.6 MW, 0.2 MVAR)
%   Bus 2: Infinite Bus (Slack Bus)
rg=rg;lg=lg;
define_constants;  % Load MATPOWER constants

mpc.version = '2';  % MATPOWER format version
mpc.baseMVA = 1;    % Base power set to 1 MVA (per-unit system)

%% -------------------------
% Load System Parameters from "Parameters.mat"
% -------------------------
load('Parameters.mat', 'rf2', 'lf2', 'V_LL', 'P_inj', 'Q_inj');

% -------------------------
% Base Value Calculations
% -------------------------
Vbase_LL = V_LL/1e3;  % Line-to-line voltage base (kV)
Vbase_LN = Vbase_LL / sqrt(3);  % Line-to-neutral base voltage (kV)
Sbase = 1;  % Base power (MVA)
Zbase = (Vbase_LL^2) / Sbase;  % Base impedance (Ω)
Ibase = Sbase / (sqrt(3) * Vbase_LL);  % Base current (kA)

% Convert to per-unit
rtotal = (rf2 + rg) / Zbase;  % Resistance in per-unit
xtotal = (lf2 + lg) * (2 * pi * 50) / Zbase;  % Reactance in per-unit (assuming 50Hz system)

% -------------------------
% BUS DATA
% Columns: 
%  [bus_no, type, Pd, Qd, Gs, Bs, area, Vm, Va, baseKV, zone, Vmax, Vmin]
% -------------------------
mpc.bus = [
    1   1   -P_inj  -Q_inj  0   0   1   1.00  0   Vbase_LL   1   1.1  0.9; % PQ Bus (Inverter injecting power)
    2   3    0     0    0   0   1   1.00  0   Vbase_LL   1   1.1  0.9; % Infinite Bus (Slack)
];

% -------------------------
% GENERATOR DATA (Infinite Bus acts as a generator)
% Columns:
%  [bus, Pg, Qg, Qmax, Qmin, Vg, mBase, status, Pmax, Pmin]
% -------------------------
mpc.gen = [
    2   0   0   999  -999  1.00  1   1   999  -999;  % Infinite Bus Generator (Dummy Generator)
];

% -------------------------
% BRANCH DATA (LINE FROM INVERTER TO INFINITE BUS)
% Columns:
%  [from_bus, to_bus, r, x, b, rateA, rateB, rateC, ratio, angle, status, angmin, angmax]
% -------------------------
mpc.branch = [
    1  2  rtotal  xtotal  0   1  1  1  0  0  1 -360 360; % Connection between PQ bus and Infinite Bus
];

end
