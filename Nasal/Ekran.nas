# Система "Экран". Упрощенный вариант.
# Автор: Сергей "Mercenary_Mercury" Салов
# Сентябрь 2012

var BLUa = 0;
var BLUcontrol = 0;
var BLUcall = 0;
var BLUlc = 0;
var BLUnc = 0;
var BLUp = [];

 var BLU = func {
  var BLUcontrol = getprop("mig29/controls/Ekran/control");
  var BLUcall = getprop("mig29/controls/Ekran/call");
  var BLUorder = getprop("mig29/instrumentation/Ekran/order");
  var BLUmemory = getprop("mig29/instrumentation/Ekran/memory");
  var BLUp = [];
  if ( getprop("mig29/instrumentation/electrical/v27") > 24 and getprop("mig29/systems/Ekran/on") == 1 )
   {
# Приоритет 50
    if ( getprop("fdm/jsbsim/systems/COC/LERXFailure") == 1 ) { var BLUlc = 057; append(BLUp, 057); }
# Приоритет 49
    if ( getprop("fdm/jsbsim/systems/COC/LERXFailure") == 1 ) { var BLUlc = 056; append(BLUp, 056); }
# Приоритет 41
    if ( getprop("fdm/jsbsim/systems/ARU/Knum") > 1 and getprop("fdm/jsbsim/gear/gear-cmd-switched") == 1 ) { var BLUlc = 046; append(BLUp, 046); }
# Приоритет 40
    if ( getprop("fdm/jsbsim/systems/ARU/serviceable") == 0 ) { var BLUlc = 045; append(BLUp, 045); }
# Приоритет 39
    if ( getprop("fdm/jsbsim/systems/SVS/serviceable") == 0 ) { var BLUlc = 044; append(BLUp, 044); }
# Приоритет 36
    if ( getprop("fdm/jsbsim/fcs/canopy-germ-norm") < 1 )
     { var BLUlc = 041; append(BLUp, 041); setprop("mig29/systems/Ekran/CanopyOpen", 1); }
    else {setprop("mig29/systems/Ekran/CanopyOpen", 0);}
# Приоритет 35
    if ( getprop("mig29/instrumentation/US-1600/airspeed-kmh") > 200 )
     {
      if ( getprop("fdm/jsbsim/systems/intake/pos_left") == 1.438679245 or getprop("fdm/jsbsim/systems/intake/pos_right") == 1.438679245 )
       { var BLUlc = 040; append(BLUp, 040); }
     }
# Приоритет 34
    if ( getprop("fdm/jsbsim/systems/ARV/right-serviceable") == 0 ) { var BLUlc = 039; append(BLUp, 039); }
# Приоритет 33
    if ( getprop("fdm/jsbsim/systems/ARV/left-serviceable") == 0 ) { var BLUlc = 038; append(BLUp, 038); }
# Приоритет 31
    if ( getprop("mig29/systems/electrical/gen-2-failure") == 0 and getprop("mig29/systems/electrical/gen-2-failure") == 1 )
     { var BLUlc = 036; append(BLUp, 036); }
# Приоритет 30
    if ( getprop("mig29/systems/electrical/gen-1-failure") == 1 and getprop("mig29/f/gen-2-failure") == 0 )
     { var BLUlc = 035; append(BLUp, 035); }
# Приоритет 26
    if ( getprop("fdm/jsbsim/hs/hs1-pressure") < 100 )
     { var BLUlc = 031; append(BLUp, 031); setprop("mig29/systems/Ekran/MainHydro", 1); }
    else {setprop("mig29/systems/Ekran/MainHydro", 0);}
# Приоритет 25
    if ( getprop("fdm/jsbsim/hs/hs2-pressure") < 100 )
     { var BLUlc = 030; append(BLUp, 030); setprop("mig29/systems/Ekran/BusterHydro", 1); }
    else {setprop("mig29/systems/Ekran/BusterHydro", 0);}
# Приоритет 22
    if ( getprop("fdm/jsbsim/systems/fuel/t550kg") == 1 )
     { var BLUlc = 027; append(BLUp, 027); setprop("mig29/systems/Ekran/R550", 1); }
    else {setprop("mig29/systems/Ekran/R550", 0);}
# Приоритет 21
    if ( getprop("/engines/engine[0]/running") == 1 or getprop("/engines/engine[1]/running") == 1 )
     {
      if ( getprop("/fdm/jsbsim/propulsion/engine/fuel-flow-rate-pps") < 0.1 or getprop("/fdm/jsbsim/propulsion/engine/fuel-flow-rate-pps") < 0.1 )
       { var BLUlc = 026; append(BLUp, 026); }
     }
# Приоритет 20
    if ( getprop("mig29/systems/electrical/gen-1-failure") == 1 and getprop("mig29/f/gen-2-failure") == 1 )
     { var BLUlc = 025; append(BLUp, 025); }
# Приоритет 18
    if ( getprop("/engines/engine[2]/oil-pressure-psi") < 30 and getprop("/engines/engine[2]/running") == 1 )
     { var BLUlc = 023; append(BLUp, 023); setprop("mig29/systems/Ekran/OilKSA", 1); }
    else {setprop("mig29/systems/Ekran/OilKSA", 0);}
# Приоритет 15
    if ( getprop("/engines/engine[1]/oil-pressure-psi") < 30 and getprop("/engines/engine[1]/running") == 1 )
     { var BLUlc = 018; append(BLUp, 018); setprop("mig29/systems/Ekran/OilRight", 1); }
    else {setprop("mig29/systems/Ekran/OilRight", 0);}
# Приоритет 11
    if ( getprop("/engines/engine[1]/egt-degf") > 1697 )
     { var BLUlc = 010; append(BLUp, 010); setprop("mig29/systems/Ekran/Overheat_Left", 1); }
    else {setprop("mig29/systems/Ekran/Overheat_Left", 0);}
# Приоритет 8
    if ( getprop("/engines/engine[0]/oil-pressure-psi") < 30 and getprop("/engines/engine[0]/running") == 1 )
     { var BLUlc = 017; append(BLUp, 017); setprop("mig29/systems/Ekran/OilLeft", 1); }
    else {setprop("mig29/systems/Ekran/OilLeft", 0);}
# Приоритет 4
    if ( getprop("/engines/engine[0]/egt-degf") > 1697 )
     { var BLUlc = 009; append(BLUp, 009); setprop("mig29/systems/Ekran/Overheat_Right", 1); }
    else {setprop("mig29/systems/Ekran/Overheat_Right", 0);}
# Приоритет 3
    if ( getprop("mig29/instrumentation/RV-21/danger_altitude") == 1 and getprop("fdm/jsbsim/gear/gear-cmd-switched") == 0 )
     { var BLUlc = 008; append(BLUp, 008); setprop("mig29/systems/Ekran/DangerAltitude", 1); }
    else {setprop("mig29/systems/Ekran/DangerAltitude", 0);}
# Приоритет 2
    if ( getprop("fdm/jsbsim/fcs/flaps-cmd-switched") == 1 and getprop("fdm/jsbsim/gear/gear-cmd-switched") == 0 )
     { var BLUlc = 006; append(BLUp, 006); }

#------------- "Блок управления" -------------
    if ( BLUcontrol == 1 and getprop("mig29/systems/engines/s") == 0 and getprop("mig29/systems/Ekran/control") == 0 )
     { setprop("mig29/systems/Ekran/control", 1); settimer(BLUcontrolG, 1); }
     var BLUnc = size(BLUp);
     if (BLUnc > 1) {setprop("mig29/instrumentation/Ekran/order", 1); var BLUorder = 1}
     else {setprop("mig29/instrumentation/Ekran/order", 0); var BLUorder = 0}
    if (getprop("mig29/systems/engines/s") == 0) {setprop("mig29/instrumentation/Ekran/order", 0); setprop("mig29/instrumentation/Ekran/memory", 0);}
    if (getprop("mig29/systems/engines/s") == 1)
     {
# Секция - 1.
     if ( BLUnc == 0 ) { UST(000); }
# Секция - 2.
     if ( BLUnc == 1 )
      {
       if ( BLUcall == 0 and BLUmemory == 0 and BLUorder == 0 ) { UST(BLUlc); }
       if ( BLUcall == 1 and BLUmemory == 0 and BLUorder == 0 ) { setprop("mig29/instrumentation/Ekran/order", 1); UST(000); }
       if ( BLUcall == 1 and BLUmemory == 1 and BLUorder == 0 ) { setprop("/mig29/instrumentation/Ekran/order", 0); UST(BLUlc); }
      }
# Секция - 3.
     if ( BLUnc > 1 )
      {
       if ( BLUcall == 0 and BLUmemory == 0 and BLUorder == 1 ) { UST(BLUlc); }
       if ( BLUcall == 0 and BLUmemory == 1 and BLUorder == 0 ) { UST(BLUlc); }
       if ( BLUcall == 1 and BLUmemory == 0 and BLUorder == 1 ) { UST(000); }
      }
    }
   }
  settimer(BLU, 0.1);
}

 var BLUcontrolG = func {
  if (getprop("/mig29/systems/Ekran/control") == 1) { setprop("/mig29/systems/Ekran/control", 2); settimer(BLUcontrolG, 15); return; }
  if (getprop("/mig29/systems/Ekran/control") == 2)
   { UST(001); setprop("/mig29/systems/Ekran/control", 3); settimer(BLUcontrolG, 3); return; }
  if (getprop("/mig29/systems/Ekran/control") == 3 and getprop("/mig29/systems/Ekran/serviceable") == 0)
   { UST(002); setprop("/mig29/instrumentation/Ekran/otkaz", 1); setprop("/mig29/systems/Ekran/control", 0); return; }
  if (getprop("/mig29/systems/Ekran/control") == 3 and getprop("/mig29/systems/Ekran/serviceable") == 1)
   { UST(003); setprop("/mig29/systems/Ekran/control", 4); settimer(BLUcontrolG, 3); return; }
  if (getprop("/mig29/systems/Ekran/control") == 4)
   { UST(000); setprop("/mig29/systems/Ekran/control", 0); return; }
}

var msgarray = [];
var UST000 = ["00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00"];
var UST001 = ["00","00","00","00","00","00","00","00","18","01","13","15","11","15","14","19","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00"];
var UST002 = ["00","00","00","00","00","00","00","00","00","29","11","17","01","14","00","00","00","00","00","00","00","00","00","00","00","00","15","19","11","01","08","00"];
var UST003 = ["00","00","00","00","00","00","00","00","00","29","11","17","01","14","00","00","00","00","00","00","00","00","00","00","00","00","04","15","05","06","14","00"];
var UST004 = ["00","00","00","00","00","00","00","00","00","16","15","12","06","19","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00"];
var UST005 = ["00","19","20","17","02","15","00","00","18","19","01","17","19","06","17","00","00","15","16","01","18","14","27","10","00","00","17","06","07","09","13","00"];
var UST006 = ["00","00","00","00","00","00","00","00","03","27","16","20","18","19","09","00","00","00","00","00","00","00","00","00","00","00","25","01","18","18","09","00"];
var UST007 = ["00","00","00","00","00","00","00","00","00","00","25","01","18","18","09","00","00","00","00","00","00","00","00","00","00","09","14","05","09","11","01","23"];
var UST008 = ["00","00","00","00","00","00","00","00","00","03","27","18","15","19","01","00","00","00","00","00","00","00","00","00","00","15","16","01","18","14","01","31"];
var UST009 = ["00","00","00","00","00","00","00","00","16","06","17","06","04","17","06","03","00","00","00","00","00","00","00","00","00","00","00","12","06","03","00","00"];
var UST010 = ["00","00","00","00","00","00","00","00","16","06","17","06","04","17","06","03","00","00","00","00","00","00","00","00","00","00","16","17","01","03","00","00"];
var UST011 = ["15","02","15","17","15","19","27","00","00","00","00","12","06","03","00","00","00","00","03","27","25","06","00","00","00","00","00","05","15","16","00","00"];
var UST012 = ["15","02","15","17","15","19","27","00","00","00","16","17","01","03","00","00","00","00","03","27","25","06","00","00","00","00","00","05","15","16","00","00"];
var UST013 = ["03","09","02","17","01","23","09","31","00","00","00","12","06","03","00","00","00","00","03","27","25","06","00","00","00","00","00","05","15","16","00","00"];
var UST014 = ["03","09","02","17","01","23","09","31","00","00","16","17","01","03","00","00","00","00","03","27","25","06","00","00","00","00","00","05","15","16","00","00"];
var UST015 = ["05","01","03","12","06","14","09","06","19","15","16","12","09","03","01","00","00","00","00","12","06","03","00","00","03","27","25","06","00","05","15","16"];
var UST016 = ["05","01","03","12","06","14","09","06","19","15","16","12","09","03","01","00","00","00","16","17","01","03","00","00","03","27","25","06","00","05","15","16"];
var UST017 = ["00","00","13","01","12","15","00","00","05","01","03","12","06","14","09","06","00","00","13","01","18","12","01","00","00","00","00","12","06","03","00","00"];
var UST018 = ["00","00","13","01","12","15","00","00","05","01","03","12","06","14","09","06","00","00","13","01","18","12","01","00","00","00","16","17","01","03","00","00"];
var UST019 = ["00","19","06","13","16","06","17","00","00","00","13","01","18","12","01","00","00","00","00","12","06","03","00","00","03","27","25","06","00","05","15","16"];
var UST020 = ["00","19","06","13","16","06","17","00","00","00","13","01","18","12","01","00","00","00","16","17","01","03","00","00","03","27","25","06","00","05","15","16"];
var UST021 = ["18","19","17","20","07","11","01","00","00","00","00","03","00","00","00","00","00","00","13","01","18","12","06","00","00","00","00","12","06","03","00","00"];
var UST022 = ["18","19","17","20","07","11","01","00","00","00","00","03","00","00","00","00","00","00","13","01","18","12","06","00","00","00","16","17","01","03","00","00"];
var UST023 = ["00","00","13","01","12","15","00","00","05","01","03","12","06","14","09","06","00","00","13","01","18","12","01","00","00","00","11","18","01","00","00","00"];
var UST024 = ["03","09","02","17","01","23","09","31","00","00","11","18","01","00","00","00","00","00","03","27","25","06","00","00","00","00","00","05","15","16","00","00"];
var UST025 = ["00","00","05","03","01","00","00","00","00","00","04","06","14","06","17","00","00","00","18","12","06","05","09","00","00","00","03","17","06","13","31","00"];
var UST026 = ["00","00","14","06","19","00","00","00","16","15","05","11","01","24","11","09","00","19","15","16","12","09","03","01","00","00","00","00","00","00","00","00"];
var UST027 = ["03","15","08","03","17","01","19","00","00","00","00","16","15","00","00","00","00","19","15","16","12","09","03","20","00","00","00","00","00","00","00","00"];
var UST028 = ["16","17","15","03","06","17","28","00","00","08","01","16","01","18","00","00","00","19","15","16","12","09","03","01","00","00","00","00","00","00","00","00"];
var UST029 = ["00","03","27","18","15","19","01","00","03","00","11","01","02","09","14","06","00","16","17","06","05","06","12","00","18","14","09","07","01","10","18","31"];
var UST030 = ["00","00","00","00","00","00","00","00","00","02","20","18","19","06","17","14","00","00","00","00","00","00","00","00","00","00","04","09","05","17","15","00"];
var UST031 = ["00","00","00","00","00","00","00","00","00","15","02","26","01","31","00","00","00","00","00","00","00","00","00","00","00","00","04","09","05","17","15","00"];
var UST032 = ["00","00","05","03","06","00","00","00","00","00","11","20","17","18","15","00","00","03","06","17","19","09","11","00","00","00","00","00","00","00","00","00"];
var UST033 = ["00","15","18","14","15","03","14","00","00","00","11","20","17","18","15","00","00","03","06","17","19","09","11","00","00","00","00","00","00","00","00","00"];
var UST034 = ["00","08","01","16","01","18","14","00","00","00","11","20","17","18","15","00","00","03","06","17","19","09","11","00","00","00","00","00","00","00","00","00"];
var UST035 = ["00","00","04","06","14","06","17","00","00","00","16","15","18","19","00","00","00","00","18","12","06","05","09","00","00","00","03","17","06","13","31","00"];
var UST036 = ["00","00","00","00","00","00","00","00","00","00","04","06","14","06","17","00","00","00","00","00","00","00","00","00","00","16","06","17","06","13","06","14"];
var UST037 = ["00","03","11","12","30","24","09","00","08","01","16","01","18","14","15","10","00","00","00","11","15","05","00","00","00","00","15","16","15","08","14","00"];
var UST038 = ["00","00","00","00","00","00","00","00","03","15","08","05","08","01","02","00","00","00","00","00","00","00","00","00","00","00","00","12","06","03","00","00"];
var UST039 = ["00","00","00","00","00","00","00","00","03","15","08","05","08","01","02","00","00","00","00","00","00","00","00","00","00","00","16","17","01","03","00","00"];
var UST040 = ["03","06","17","22","14","09","10","00","00","00","03","22","15","05","00","00","00","15","19","11","17","27","19","00","00","00","00","00","00","00","00","00"];
var UST041 = ["00","00","00","00","00","00","00","00","00","08","01","16","17","09","00","00","00","00","00","00","00","00","00","00","00","21","15","14","01","17","28","00"];
var UST042 = ["00","00","00","12","06","03","00","00","00","05","03","09","04","00","14","01","00","17","06","08","06","17","03","00","00","00","18","09","18","19","00","00"];
var UST043 = ["00","00","16","17","01","03","00","00","00","05","03","09","04","00","14","01","00","17","06","08","06","17","03","00","00","00","18","09","18","19","00","00"];
var UST044 = ["00","00","00","00","00","00","00","00","00","00","18","03","18","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00"];
var UST045 = ["00","00","00","00","00","00","00","00","00","00","01","17","20","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00"];
var UST046 = ["00","00","01","17","20","00","00","00","20","18","19","01","14","15","03","09","00","00","12","06","04","11","15","00","00","00","00","00","00","00","00","00"];
var UST047 = ["00","00","14","06","19","00","00","00","00","15","22","12","01","07","05","00","00","15","19","18","06","11","15","03","00","00","00","00","00","00","00","00"];
var UST048 = ["00","00","18","20","03","00","00","00","00","00","00","14","06","00","00","00","00","03","11","12","30","24","06","14","00","00","00","00","00","00","00","00"];
var UST049 = ["00","00","25","19","15","11","00","00","00","00","00","18","15","18","00","00","00","03","27","16","20","26","06","14","00","00","00","00","00","00","00","00"];
var UST050 = ["00","08","01","16","01","18","00","00","11","09","18","12","15","17","15","05","00","00","01","03","01","17","00","00","00","00","00","00","00","00","00","00"];
var UST051 = ["00","00","00","00","00","00","00","00","00","03","11","12","30","24","09","00","00","00","00","00","00","00","00","00","11","09","18","12","15","17","15","05"];
var UST052 = ["00","00","00","00","00","00","00","00","00","00","18","17","15","00","00","00","00","00","00","00","00","00","00","00","15","19","03","06","19","24","09","11"];
var UST053 = ["00","00","14","06","19","00","00","00","00","03","27","17","01","02","00","00","21","30","08","00","02","01","11","01","00","00","00","00","00","00","00","00"];
var UST054 = ["00","00","14","06","19","00","00","00","00","14","01","05","05","20","03","01","00","16","15","05","03","00","11","17","00","00","02","01","11","15","03","00"];
var UST055 = ["00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00"];
var UST056 = ["00","00","00","00","00","00","00","00","08","01","11","17","27","12","11","09","00","00","00","00","00","00","00","00","00","03","27","16","20","18","19","09"];
var UST057 = ["00","00","00","00","00","00","00","00","00","14","15","18","11","09","00","00","00","00","00","00","00","00","00","00","14","06","00","03","27","25","12","09"];
var UST058 = ["00","00","00","00","00","00","00","00","03","27","24","09","18","12","09","19","00","00","00","00","00","00","00","00","00","14","01","03","09","04","01","23"];
var UST059 = ["00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00"];
var UST060 = ["00","00","00","00","00","00","00","00","00","16","20","25","11","01","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00","00"];

 var UST = func {
  if (arg[0] == 0) { var msgarray = UST000 };
  if (arg[0] == 1) { var msgarray = UST001 };
  if (arg[0] == 2) { var msgarray = UST002 };
  if (arg[0] == 3) { var msgarray = UST003 };
  if (arg[0] == 4) { var msgarray = UST004 };
  if (arg[0] == 5) { var msgarray = UST005 };
  if (arg[0] == 6) { var msgarray = UST006 };
  if (arg[0] == 7) { var msgarray = UST007 };
  if (arg[0] == 8) { var msgarray = UST008 };
  if (arg[0] == 9) { var msgarray = UST009 };
  if (arg[0] == 10) { var msgarray = UST010 };
  if (arg[0] == 11) { var msgarray = UST011 };
  if (arg[0] == 12) { var msgarray = UST012 };
  if (arg[0] == 13) { var msgarray = UST013 };
  if (arg[0] == 14) { var msgarray = UST014 };
  if (arg[0] == 15) { var msgarray = UST015 };
  if (arg[0] == 16) { var msgarray = UST016 };
  if (arg[0] == 17) { var msgarray = UST017 };
  if (arg[0] == 18) { var msgarray = UST018 };
  if (arg[0] == 19) { var msgarray = UST019 };
  if (arg[0] == 20) { var msgarray = UST020 };
  if (arg[0] == 21) { var msgarray = UST021 };
  if (arg[0] == 22) { var msgarray = UST022 };
  if (arg[0] == 23) { var msgarray = UST023 };
  if (arg[0] == 24) { var msgarray = UST024 };
  if (arg[0] == 25) { var msgarray = UST025 };
  if (arg[0] == 26) { var msgarray = UST026 };
  if (arg[0] == 27) { var msgarray = UST027 };
  if (arg[0] == 28) { var msgarray = UST028 };
  if (arg[0] == 29) { var msgarray = UST029 };
  if (arg[0] == 30) { var msgarray = UST030 };
  if (arg[0] == 31) { var msgarray = UST031 };
  if (arg[0] == 32) { var msgarray = UST032 };
  if (arg[0] == 33) { var msgarray = UST033 };
  if (arg[0] == 34) { var msgarray = UST034 };
  if (arg[0] == 35) { var msgarray = UST035 };
  if (arg[0] == 36) { var msgarray = UST036 };
  if (arg[0] == 37) { var msgarray = UST037 };
  if (arg[0] == 38) { var msgarray = UST038 };
  if (arg[0] == 39) { var msgarray = UST039 };
  if (arg[0] == 40) { var msgarray = UST040 };
  if (arg[0] == 41) { var msgarray = UST041 };
  if (arg[0] == 42) { var msgarray = UST042 };
  if (arg[0] == 43) { var msgarray = UST043 };
  if (arg[0] == 44) { var msgarray = UST044 };
  if (arg[0] == 45) { var msgarray = UST045 };
  if (arg[0] == 46) { var msgarray = UST046 };
  if (arg[0] == 47) { var msgarray = UST047 };
  if (arg[0] == 48) { var msgarray = UST048 };
  if (arg[0] == 49) { var msgarray = UST049 };
  if (arg[0] == 50) { var msgarray = UST050 };
  if (arg[0] == 51) { var msgarray = UST051 };
  if (arg[0] == 52) { var msgarray = UST052 };
  if (arg[0] == 53) { var msgarray = UST053 };
  if (arg[0] == 54) { var msgarray = UST054 };
  if (arg[0] == 55) { var msgarray = UST055 };
  if (arg[0] == 56) { var msgarray = UST056 };
  if (arg[0] == 57) { var msgarray = UST057 };
  if (arg[0] == 58) { var msgarray = UST058 };
  if (arg[0] == 59) { var msgarray = UST059 };
  if (arg[0] == 60) { var msgarray = UST060 };
  setprop("/mig29/instrumentation/Ekran/ZM01", msgarray[0]);
  setprop("/mig29/instrumentation/Ekran/ZM02", msgarray[1]);
  setprop("/mig29/instrumentation/Ekran/ZM03", msgarray[2]);
  setprop("/mig29/instrumentation/Ekran/ZM04", msgarray[3]);
  setprop("/mig29/instrumentation/Ekran/ZM05", msgarray[4]);
  setprop("/mig29/instrumentation/Ekran/ZM06", msgarray[5]);
  setprop("/mig29/instrumentation/Ekran/ZM07", msgarray[6]);
  setprop("/mig29/instrumentation/Ekran/ZM08", msgarray[7]);
  setprop("/mig29/instrumentation/Ekran/ZM09", msgarray[8]);
  setprop("/mig29/instrumentation/Ekran/ZM10", msgarray[9]);
  setprop("/mig29/instrumentation/Ekran/ZM11", msgarray[10]);
  setprop("/mig29/instrumentation/Ekran/ZM12", msgarray[11]);
  setprop("/mig29/instrumentation/Ekran/ZM13", msgarray[12]);
  setprop("/mig29/instrumentation/Ekran/ZM14", msgarray[13]);
  setprop("/mig29/instrumentation/Ekran/ZM15", msgarray[14]);
  setprop("/mig29/instrumentation/Ekran/ZM16", msgarray[15]);
  setprop("/mig29/instrumentation/Ekran/ZM17", msgarray[16]);
  setprop("/mig29/instrumentation/Ekran/ZM18", msgarray[17]);
  setprop("/mig29/instrumentation/Ekran/ZM19", msgarray[18]);
  setprop("/mig29/instrumentation/Ekran/ZM20", msgarray[19]);
  setprop("/mig29/instrumentation/Ekran/ZM21", msgarray[20]);
  setprop("/mig29/instrumentation/Ekran/ZM22", msgarray[21]);
  setprop("/mig29/instrumentation/Ekran/ZM23", msgarray[22]);
  setprop("/mig29/instrumentation/Ekran/ZM24", msgarray[23]);
  setprop("/mig29/instrumentation/Ekran/ZM25", msgarray[24]);
  setprop("/mig29/instrumentation/Ekran/ZM26", msgarray[25]);
  setprop("/mig29/instrumentation/Ekran/ZM27", msgarray[26]);
  setprop("/mig29/instrumentation/Ekran/ZM28", msgarray[27]);
  setprop("/mig29/instrumentation/Ekran/ZM29", msgarray[28]);
  setprop("/mig29/instrumentation/Ekran/ZM30", msgarray[29]);
  setprop("/mig29/instrumentation/Ekran/ZM31", msgarray[30]);
  setprop("/mig29/instrumentation/Ekran/ZM32", msgarray[31]);
}

 var Ekran_power_handler = func {
  if (getprop("/mig29/instrumentation/electrical/v27") > 24) {setprop("/mig29/systems/Ekran/on", 1);}
  else {setprop("/mig29/systems/Ekran/on", 0);}
}

 var Ekran_init = func {
  setprop("/mig29/controls/Ekran/control", 0);
  setprop("/mig29/controls/Ekran/call", 0);
  setprop("/mig29/instrumentation/Ekran/memory", 0);
  setprop("/mig29/instrumentation/Ekran/order", 0);
  setprop("/mig29/instrumentation/Ekran/otkaz", 0);
  setprop("/mig29/instrumentation/Ekran/ZM01", 0);
  setprop("/mig29/instrumentation/Ekran/ZM02", 0);
  setprop("/mig29/instrumentation/Ekran/ZM03", 0);
  setprop("/mig29/instrumentation/Ekran/ZM04", 0);
  setprop("/mig29/instrumentation/Ekran/ZM05", 0);
  setprop("/mig29/instrumentation/Ekran/ZM06", 0);
  setprop("/mig29/instrumentation/Ekran/ZM07", 0);
  setprop("/mig29/instrumentation/Ekran/ZM08", 0);
  setprop("/mig29/instrumentation/Ekran/ZM09", 0);
  setprop("/mig29/instrumentation/Ekran/ZM10", 0);
  setprop("/mig29/instrumentation/Ekran/ZM11", 0);
  setprop("/mig29/instrumentation/Ekran/ZM12", 0);
  setprop("/mig29/instrumentation/Ekran/ZM13", 0);
  setprop("/mig29/instrumentation/Ekran/ZM14", 0);
  setprop("/mig29/instrumentation/Ekran/ZM15", 0);
  setprop("/mig29/instrumentation/Ekran/ZM16", 0);
  setprop("/mig29/instrumentation/Ekran/ZM17", 0);
  setprop("/mig29/instrumentation/Ekran/ZM18", 0);
  setprop("/mig29/instrumentation/Ekran/ZM19", 0);
  setprop("/mig29/instrumentation/Ekran/ZM20", 0);
  setprop("/mig29/instrumentation/Ekran/ZM21", 0);
  setprop("/mig29/instrumentation/Ekran/ZM22", 0);
  setprop("/mig29/instrumentation/Ekran/ZM23", 0);
  setprop("/mig29/instrumentation/Ekran/ZM24", 0);
  setprop("/mig29/instrumentation/Ekran/ZM25", 0);
  setprop("/mig29/instrumentation/Ekran/ZM26", 0);
  setprop("/mig29/instrumentation/Ekran/ZM27", 0);
  setprop("/mig29/instrumentation/Ekran/ZM28", 0);
  setprop("/mig29/instrumentation/Ekran/ZM29", 0);
  setprop("/mig29/instrumentation/Ekran/ZM30", 0);
  setprop("/mig29/instrumentation/Ekran/ZM31", 0);
  setprop("/mig29/instrumentation/Ekran/ZM32", 0);
  setprop("/mig29/systems/Ekran/on", 0);
  setprop("/mig29/systems/Ekran/serviceable", 1);
  setprop("/mig29/systems/Ekran/control", 0);
  setlistener("/mig29/controls/Ekran/call", BLU,0,0);
  setlistener("/mig29/controls/Ekran/control", BLU,0,0);
  setlistener("/mig29/instrumentation/electrical/v27", Ekran_power_handler);
  BLU();
  print(" Ekran init");
}