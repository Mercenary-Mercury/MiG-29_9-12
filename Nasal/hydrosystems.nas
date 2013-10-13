#
#
# Hydro systems NASAL support
#
# MiG-29 (9-12)
#
# Author: Sergey "Mercenary_Mercury" Salov
#
# 30 August 2012
#
# Based on: Project Tupolev for FlightGear
#

var UPDATE_PERIOD = 0.1;
var hs_handler = func {
settimer( hs_handler, UPDATE_PERIOD );

# Freese aero surfaces & over hydro system consumers if hydrosystems are empty
var param = getprop("fdm/jsbsim/hs/busters-serviceable");
if (param == nil) {param = 0;}
if (param != 0) # if 0 - hydro power failure, surfaces are freese
    {
    # copy current position of surfaces if hydro power OK
#    param = getprop("fdm/jsbsim/fcs/pitch-sau-sum");
    param = getprop("fdm/jsbsim/fcs/pitch-sum");
    if (param == nil) {param = 0;}
    setprop("fdm/jsbsim/fcs/elevator-pos-static", param);
#    param = getprop("fdm/jsbsim/fcs/roll-sau-sum");
    param = getprop("fdm/jsbsim/fcs/roll-sum");
    if (param == nil) {param = 0;}
    setprop("fdm/jsbsim/fcs/aileron-pos-static", param);
    param = getprop("fdm/jsbsim/fcs/rudder-sum");
    if (param == nil) {param = 0;}
    setprop("fdm/jsbsim/fcs/rudder-pos-static", param);
    }
#flaps
    param = getprop("fdm/jsbsim/hs/flaps-serviceable");
    if (param == nil) {param = 0;}
    if (param != 0)
     {
      param = getprop("fdm/jsbsim/fcs/flap-cmd-norm");
      if (param == nil) {param = 0;}
      setprop("fdm/jsbsim/fcs/flap-cmd-static", param);
     }
#LERX
    param = getprop("fdm/jsbsim/hs/LERX-serviceable");
    if (param == nil) {param = 0;}
    if (param != 0)
     {
      param = getprop("fdm/jsbsim/fcs/LERX-cmd-norm");
      if (param == nil) {param = 0;}
      setprop("fdm/jsbsim/fcs/LERX-cmd-static", param);
     }
#Intake
    param = getprop("fdm/jsbsim/hs/intake1-serviceable");
    if (param == nil) {param = 0;}
    if (param != 0)
     {
      param = getprop("fdm/jsbsim/systems/ARV/command_left_norm");
      if (param == nil) {param = 0;}
      setprop("fdm/jsbsim/systems/ARV/command-left-static", param);
     }
    param = getprop("fdm/jsbsim/hs/intake2-serviceable");
    if (param == nil) {param = 0;}
    if (param != 0)
     {
      param = getprop("fdm/jsbsim/systems/ARV/command_right_norm");
      if (param == nil) {param = 0;}
      setprop("fdm/jsbsim/systems/ARV/command-right-static", param);
     }
#gear and speedbrake
    param = getprop("fdm/jsbsim/hs/hs1-busters-ok");
    if (param == nil) {param = 0;}
    if (param != 0)
     {
      param = getprop("fdm/jsbsim/fcs/speedbrake-cmd");
      if (param == nil) {param = 0;}
      setprop("fdm/jsbsim/fcs/speedbrake-cmd-static", param);
      param = getprop("fdm/jsbsim/gear/gear-pos-norm");
      if (param == nil) {param = 0;}
      setprop("fdm/jsbsim/gear/gear-cmd-static", param);
#	}
      param = getprop("fdm/jsbsim/fcs/steer-cmd-norm");
      if (param == nil) {param = 0;}
      setprop("fdm/jsbsim/fcs/steer-cmd-static", param);
     }
# delivery info about direct 27V electrical power into FDM property tree
# for correct operating of electrical switch 
    param = getprop("mig29/systems/electrical/buses/DC27-bus/volts");
    if (param == nil) {param = 0.0;}
    if (param > 13.0) {setprop("fdm/jsbsim/systems/electrical-ok", 1.0 );}
    else {setprop("fdm/jsbsim/systems/electrical-ok", 0.0 );}

    
}

hs_handler();

print("Hydro systems started");
