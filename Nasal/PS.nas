# Пневматическая система. Nasal часть.
# Автор: Сергей "Mercenary_Mercury" Салов
# Июль 2012

var CL1a = 0;
var CL1b = 0;
var CL1c = 0;
var CL2a = 0;
var CL2b = 0;
var CL2c = 0;
var CL3a = 0;
var CL3b = 0;
var CL3c = 0;

 var CL1 = func {
  var CL1a = getprop("fdm/jsbsim/fcs/canopy-pos-norm");
  var CL1b = getprop("fdm/jsbsim/calculations/PS/CL1b");
  if (CL1a > CL1b) { var CL1c = (CL1a-CL1b); }
  if (CL1a < CL1b) { var CL1c = (CL1b-CL1a); }
  if (CL1a == 0) { var CL1c = 0; }
  if (CL1a == 1) { var CL1c = 0; }
  setprop("fdm/jsbsim/calculations/PS/CL1b", CL1a);
  setprop("fdm/jsbsim/calculations/PS/CL1", CL1c);
}


 var CL2 = func {
  var CL2a = getprop("fdm/jsbsim/fcs/parachute_reef_pos_norm");
  var CL2b = getprop("fdm/jsbsim/calculations/PS/CL2b");
  if (CL2a > CL2b) { var CL2c = (CL2a-CL2b); }
  if (CL2a < CL2b) { var CL2c = (CL2b-CL2a); }
  setprop("fdm/jsbsim/calculations/PS/CL2b", CL2a);
  setprop("fdm/jsbsim/calculations/PS/CL2", CL2c);
}

 var CL3 = func {
  var CL3a = getprop("fdm/jsbsim/calculations/PS/brake-norm");
  var CL3b = getprop("fdm/jsbsim/calculations/PS/CL3b");
  if (CL3a > CL3b) { var CL3c = (CL3a-CL3b); }
  if (CL3a < CL3b) { var CL3c = (CL3b-CL3a); }
  setprop("fdm/jsbsim/calculations/PS/CL3b", CL3a);
  setprop("fdm/jsbsim/calculations/PS/CL3", CL3c);
}

 var CL5 = func {
  var CL5a = getprop("fdm/jsbsim/calculations/PS/brake-norm");
  var CL5b = getprop("fdm/jsbsim/calculations/PS/CL5b");
  if (CL5a > CL5b) { var CL5c = (CL5a-CL5b); }
  if (CL5a < CL5b) { var CL5c = (CL5b-CL5a); }
  setprop("fdm/jsbsim/calculations/PS/CL5b", CL5a);
  setprop("fdm/jsbsim/calculations/PS/CL3", CL5c);
}

 var CLs = func {
   setprop("fdm/jsbsim/calculations/PS/CL1a", 0);
   setprop("fdm/jsbsim/calculations/PS/CL1b", 0);
   setprop("fdm/jsbsim/calculations/PS/CL2a", 0);
   setprop("fdm/jsbsim/calculations/PS/CL2b", 0);
   setprop("fdm/jsbsim/calculations/PS/CL3a", 0);
   setprop("fdm/jsbsim/calculations/PS/CL3b", 0);
   setprop("fdm/jsbsim/calculations/PS/CL4a", 0);
   setprop("fdm/jsbsim/calculations/PS/CL4b", 0);
   setprop("fdm/jsbsim/calculations/PS/CL5a", 0);
   setprop("fdm/jsbsim/calculations/PS/CL5b", 0);
   setlistener("fdm/jsbsim/fcs/canopy-pos-norm", CL1,0,0);
   setlistener("fdm/jsbsim/fcs/parachute_reef_pos_norm", CL2);
   setlistener("fdm/jsbsim/calculations/PS/brake-norm", CL3);
}

 var EGEfunc = func {
  print("546d");
  if (getprop("/mig29/controls/gear/emer_raise") == nil) {setprop("/mig29/controls/gear/emer_raise", 0);}
  if (getprop("/mig29/controls/gear/emer_raise") == 0 and getprop("/fdm/jsbsim/systems/PS/EGE") == 0)
   {interpolate("/mig29/controls/gear/emer_raise", 1, 2);}
  if (getprop("/mig29/controls/gear/emer_raise") == 1 and getprop("/fdm/jsbsim/systems/PS/EGE") == 0)
   {setprop("/fdm/jsbsim/systems/PS/EGE", 1);}
  if (getprop("/mig29/controls/gear/emer_raise") == 1 and getprop("/fdm/jsbsim/systems/PS/EGE") == 1)
   {
    interpolate("/mig29/controls/gear/emer_raise", 0, 2);
    return;
   }
  settimer(EGEfunc, 2);
}