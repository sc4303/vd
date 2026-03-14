%% =========================
%  SPEC SHEET OVERRIDE - B26 Approximate
% =========================

% Unit conversions 
lb_to_kg   = 0.45359237;
in_to_m    = 0.0254;
lbpin_to_Npm = 4.4482216152605 / 0.0254;    % 175.1268 N/m
inlb_to_Nm = 0.112984829;                  % in*lb -> N*m

% Spec sheet inputs
W_total_lb      = 530;        % lb (with driver)
rear_frac       = 0.51;       % fraction on rear axle
CGh_in          = 11.8;       % in
trackF_in       = 47;         % in
trackR_in       = 47;         % in
wheelbase_in    = 62;         % in  (front RC to rear RC)

kSpringF_lbpin  = 275;        % lb/in (spring rate at the spring)
kSpringR_lbpin  = 250;        % lb/in

% Apply total mass (kg) 
Vehicle.Chassis.Body.m.Value = W_total_lb * lb_to_kg;

% Apply wheelbase / axle position (m) 
L = wheelbase_in * in_to_m;
Vehicle.Chassis.Body.sAxle2.Value(1) = -L;   % front axle at x=0, rear axle at x=-L

% Apply CG x from static distribution
% Rear fraction = distance from front axle / L
xCG = -(rear_frac)*L;
Vehicle.Chassis.Body.sCG.Value(1) = xCG;

% Apply CG height (m) 
Vehicle.Chassis.Body.sCG.Value(3) = CGh_in * in_to_m;

% Apply track widths by setting wheel-center Y (m)
Vehicle.Chassis.SuspA1.Linkage.Upright.sWheelCentre.Value(2) = 0.5*trackF_in*in_to_m;
Vehicle.Chassis.SuspA2.Linkage.Upright.sWheelCentre.Value(2) = 0.5*trackR_in*in_to_m;

% Optional: keep body width display roughly consistent
Vehicle.Chassis.Body.Width.Value = (trackF_in*in_to_m) + 0.2;

% Apply spring stiffnesses (N/m)
Vehicle.Chassis.Spring.Axle1.K.Value = kSpringF_lbpin * lbpin_to_Npm;
Vehicle.Chassis.Spring.Axle2.K.Value = kSpringR_lbpin * lbpin_to_Npm;

% Rear ARB setting: choose one of the following
% "Short_MR2", "Med_MR2", "Long_MR2", "Short_MR1", "Med_MR1", "Long_MR1", "Off"
rearARB_setting = "Short_MR2";

% Convert (in*lb/deg) -> (N*m/deg)
inlb_to_Nm = 0.112984829;

switch rearARB_setting
    case "Short_MR2"
        rearARB_inlb_per_deg = 4839;
    case "Med_MR2"
        rearARB_inlb_per_deg = 3194;
    case "Long_MR2"
        rearARB_inlb_per_deg = 2265;
    case "Short_MR1"
        rearARB_inlb_per_deg = 1493;
    case "Med_MR1"
        rearARB_inlb_per_deg = 986;
    case "Long_MR1"
        rearARB_inlb_per_deg = 699;
    case "Off"
        rearARB_inlb_per_deg = 0;
    otherwise
        error("Unknown rearARB_setting: %s", rearARB_setting);
end

Vehicle.Chassis.SuspA2.AntiRollBar.k.Value = rearARB_inlb_per_deg * inlb_to_Nm;

% Delete front ARB
Vehicle.Chassis.SuspA1.AntiRollBar.k.Value = 0;

% This is obviously not great and very approximate
% but it's a start