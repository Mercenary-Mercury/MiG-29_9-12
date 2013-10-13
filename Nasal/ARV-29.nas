# Скрипты проверки работоспособности АРВ-29
# Сергей "Mercenary_Mercury" Салов
# 8 Августа 2012

var Ln2 = 0;
var Lsa = 0;
var Ltime = 0;
var TL1 = 0;
var TL2 = 0;
var TL3 = 0;
var TL4 = 0;
var Rn2 = 0;
var Rsa = 0;
var Rtime = 0;
var TR1 = 0;
var TR2 = 0;
var TR3 = 0;
var TR4 = 0;

 var ARVTinit = func {
  setprop("mig29/systems/ARV/TL1", 0);
  setprop("mig29/systems/ARV/TL2", 0);
  setprop("mig29/systems/ARV/TL3", 0);
  setprop("mig29/systems/ARV/TL4", 0);
  setprop("mig29/systems/ARV/TR1", 0);
  setprop("mig29/systems/ARV/TR2", 0);
  setprop("mig29/systems/ARV/TR3", 0);
  setprop("mig29/systems/ARV/TR4", 0);
  ARVTL();
  ARVTR();
}

 var ARVTL = func {
  var Ln2 = getprop("engines/engine[0]/n2");
  var Lsa = getprop("/fdm/jsbsim/systems/ARV/left-serviceable");
  var Ltime = getprop("/sim/time/elapsed-sec");
  var TL1 = getprop("mig29/systems/ARV/TL1");
  var TL2 = getprop("mig29/systems/ARV/TL2");
  var TL3 = getprop("mig29/systems/ARV/TL3");
  var TL4 = getprop("mig29/systems/ARV/TL4");
  if ( getprop("/engines/engine[0]/running") == 1 )
   {
    if (Ln2 < 68 and TL1 == 0)
     { setprop("mig29/systems/ARV/TL1", 1); setprop("mig29/systems/ARV/TL1t", Ltime); }
    if (Ln2 > 79.9 and Ln2 < 90.1 and TL2 == 0 and Lsa == 1)
     { setprop("mig29/systems/ARV/TL2", 1); setprop("mig29/systems/ARV/TL2t", Ltime); setprop("mig29/systems/ARV/TL", 1); }
    if (Ln2 < 80 and TL2 == 1 and TL3 == 0)
     { setprop("mig29/systems/ARV/TL3", 1); setprop("mig29/systems/ARV/TL3t", Ltime); }
    if (Ln2 < 68 and TL3 == 1 and TL4 == 0)
     { setprop("mig29/systems/ARV/TL4", 1); setprop("mig29/systems/ARV/TL4t", Ltime); }
   }
  if (TL1 == 1 and TL2 == 1 and TL3 == 1 and TL4 == 1)
   { setprop("mig29/systems/ARV/TL", 0); return; }
   settimer(ARVTL, 0);
}

 var ARVTR = func {
  var Rn2 = getprop("engines/engine[1]/n2");
  var Rsa = getprop("/fdm/jsbsim/systems/ARV/right-serviceable");
  var Rtime = getprop("/sim/time/elapsed-sec");
  var TR1 = getprop("mig29/systems/ARV/TR1");
  var TR2 = getprop("mig29/systems/ARV/TR2");
  var TR3 = getprop("mig29/systems/ARV/TR3");
  var TR4 = getprop("mig29/systems/ARV/TR4");
  if ( getprop("/engines/engine[1]/running") == 1 )
   {
    if (Rn2 < 68 and TR1 == 0)
     { setprop("mig29/systems/ARV/TR1", 1); setprop("mig29/systems/ARV/TR1t", Rtime); }
    if (Rn2 > 79.9 and Rn2 < 90.1 and TR2 == 0 and Rsa == 1)
     { setprop("mig29/systems/ARV/TR2", 1); setprop("mig29/systems/ARV/TR2t", Rtime); setprop("mig29/systems/ARV/TR", 1); }
    if (Rn2 < 80 and TR2 == 1 and TR3 == 0)
     { setprop("mig29/systems/ARV/TR3", 1); setprop("mig29/systems/ARV/TR3t", Rtime); }
    if (Rn2 < 68 and TR3 == 1 and TR4 == 0)
     { setprop("mig29/systems/ARV/TR4", 1); setprop("mig29/systems/ARV/TR4t", Rtime); }
   }
  if (TR1 == 1 and TR2 == 1 and TR3 == 1 and TR4 == 1)
   { setprop("mig29/systems/ARV/TR", 0); return; }
   settimer(ARVTR, 0);
}