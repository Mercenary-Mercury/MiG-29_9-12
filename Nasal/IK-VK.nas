# Скрипты поддержки ИК-ВК
# Сергей "Mercenary_Mercury" Салов
# Сентябрь 2012

var heading = 0;
var pitch = 0;
var roll = 0;
var heading_it = 0;
var pitch_it = 0;
var roll_it = 0;

 var IKVK_IS = func {
  var heading = getprop("fdm/jsbsim/systems/IK-VK/heading-deg");
  var pitch = getprop("fdm/jsbsim/systems/IK-VK/pitch-deg");
  var roll = getprop("fdm/jsbsim/systems/IK-VK/roll-deg");
  if ( getprop("fdm/jsbsim/systems/IK-VK/IK-VK-on") == 0 )
   { settimer(IKVK_IS, 0.1); }
  if ( getprop("fdm/jsbsim/systems/IK-VK/IK-VK-on") == 1 and getprop("mig29/systems/IK-VK/fs") == 1 )
  {
   var pitch_it = 90/30;
   var roll_it = roll/45;
   var heading_it = heading/45;
   interpolate("mig29/instrumentation/PNP-72-12/heading-indicated-deg", heading, heading_it);
   interpolate("mig29/instrumentation/KPP/pitch-indicated-deg", pitch, pitch_it);
   interpolate("mig29/instrumentation/KPP/roll-indicated-deg", roll, roll_it);
   setprop("mig29/systems/IK-VK/fs", 0);
   settimer(IKVK_Heading, heading_it);
   settimer(IKVK_Pitch, pitch_it);
   settimer(IKVK_Roll, roll_it);
  }
}

var Heading = 0;

 var IKVK_Heading = func {
  var Heading = getprop("fdm/jsbsim/systems/IK-VK/heading-deg");
  setprop("mig29/instrumentation/PNP-72-12/heading-indicated-deg", Heading);
  settimer(IKVK_Heading, 0);
}

var Pitch = 0;

 var IKVK_Pitch = func {
  var Pitch = getprop("fdm/jsbsim/systems/IK-VK/pitch-deg");
  setprop("mig29/instrumentation/KPP/pitch-indicated-deg", Pitch);
  settimer(IKVK_Pitch, 0);
}

var Roll = 0;

 var IKVK_Roll = func {
  var Roll = getprop("fdm/jsbsim/systems/IK-VK/roll-deg");
  setprop("mig29/instrumentation/KPP/roll-indicated-deg", Roll);
  settimer(IKVK_Roll, 0);
}

 var KVs_handler = func {
  if ( getprop("mig29/instrumentation/electrical/v27") > 24 )
   {
    if ( getprop("mig29/switches/KVosn") == 1 and getprop("mig29/switches/navigation") == 1 )
     { setprop("fdm/jsbsim/systems/IK-VK/KVosn-cmd-on", 1); }
    else { setprop("fdm/jsbsim/systems/IK-VK/KVosn-cmd-on", 0); }
    if ( getprop("mig29/switches/KVzap") == 1 and getprop("mig29/switches/navigation") == 1 )
     { setprop("fdm/jsbsim/systems/IK-VK/KVzap-cmd-on", 1); }
    else { setprop("fdm/jsbsim/systems/IK-VK/KVzap-cmd-on", 0); }
   }
}

 var IKVK_init = func {
  setprop("mig29/instrumentation/PNP-72-12/heading-indicated-deg", 0);
  setprop("mig29/instrumentation/KPP/pitch-indicated-deg", -90);
  setprop("mig29/instrumentation/KPP/roll-indicated-deg", 0);
  setprop("mig29/systems/IK-VK/fs", 1);
  setlistener("mig29/switches/KVosn", KVs_handler);
  setlistener("mig29/switches/KVzap", KVs_handler);
  setlistener("mig29/switches/navigation", KVs_handler);
  print("Ik-VK support init");
  IKVK_IS();
}