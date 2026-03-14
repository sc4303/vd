This is a modified version of the SimScape FSAE car template by Steve Miller. 
Custom additions as of 3/13/2026 for Berkeley Formula Racing include a custom vehicle data script to represent B26's
front pullrod and rear pushrod suspension setup, and a configuration override file to represent approximate specs
derived from the LLTD spec sheet.

Essentially the only things done so far (3/13/26) are a frankenstein vehicle config script made out of the default pushrod and pullrod configs, and an override config file to replace parameters with rough approximations of those given in the "B26 LLTD (Pullrod front w/ARB + Pushrod rear w/ARB)" sheet from the Google drive.

The model currently has an electric motor powertrain and no transmission as provided in the base template. Theoretically this could be changed to a model of an ICE motor and geared transmission, but that will take further research and work.
The model also uses the default aerodynamic parameters. This could also theoretically be customized.


To run, open "sm_car.m" in matlab and initialize the project. A window should open in matlab with the title "Simscape Vehicle Templates for Formula Student". This gives a good overview of what the model does, but for specifically the custom additions most of it can be ignored. Click the "Open model sm_car" hyperlink. This should open a Simulink window with more hyperlinks as shown in the previous window, but with the addition of custom configuration hyperlinks. These hyperlinks automatically run the configuration scripts "Vehicle_data_dwishbone_custom.m" and "vehicle_data_custom_b26override.m" and then a pre-programmed maneuver. After this maneuver is executed, you can replay the 3D visualization and inspect the generated data. 

The model has multiple rollbar configurations available. 
To change the rollbar configuration, open "vehicle_data_custom_b26override.m" and scroll to the line containing "rearARB_setting =". There are a few configurations available: "Short_MR2", "Med_MR2", "Long_MR2", "Short_MR1", "Med_MR1", "Long_MR1", "Off". These each correspond to a different setting defined below the "rearARB_setting =" line. Because the car has no front rollbar, there is only such configurations for the rear.
