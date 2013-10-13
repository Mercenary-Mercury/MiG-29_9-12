# controls.nas
# Серегй "Mercenary_Mercury" Салов
# Сентябрь 2012

 var autostart = func {
  setprop("/mig29/switches/Akkum-Bort-Aerodrom", 1);
  setprop("/mig29/switches/generator-1", 1);
  setprop("/mig29/switches/generator-2", 1);
  setprop("/mig29/switches/PTO", 1);
  setprop("/mig29/switches/engine_systems", 1);
  setprop("/mig29/switches/fuel_pump", 1);
  setprop("/mig29/switches/SPP", 1);
  setprop("/mig29/switches/bortsyst", 1);
  setprop("/mig29/switches/navigation", 1);
  setprop("/mig29/switches/KVosn", 1);
  setprop("/mig29/switches/KVzap", 1);
  setprop("fdm/jsbsim/systems/IK-VK/KVosn-cmd-on", 1);
  setprop("fdm/jsbsim/systems/IK-VK/KVzap-cmd-on", 1);
  setprop("fdm/jsbsim/fcs/canopy-cmd-norm", 0);
  setprop("/controls/engines/engine[0]/throttle", 0.07);
  setprop("/controls/engines/engine[1]/throttle", 0.07);
  setprop("/mig29/systems/engines/SEC", 2);
  settimer(engines.StartEngine_CmdFunc, 0.4);
  setprop("/mig29/systems/engines/s", 1);
  settimer(autostart_SAU, 10);
}

 var autostart_SAU = func {
  setprop("/mig29/switches/SAU", 1);
}

var KVs = 0;

 KV_select = func {
  var KVs = getprop("/mig29/controls/SN/IKV");
  setprop("fdm/jsbsim/systems/IK-VK/KV_select", KVs);
}

var MRKb = 0;
var MRKbb = 0;
var MRKbs = 0;
var MRKbbs = 0;

 var MRKon_handler = func {
  var MRKb = getprop("/mig29/controls/MRK/MRK");
  var MRKbb = getprop("/mig29/controls/MRK/MRK_kontr");
  var MRKbs = getprop("/mig29/systems/MRK/MRK");
  var MRKbbs = getprop("/mig29/systems/MRK/MRK_kontr");
  if (MRKb == 1 and MRKbb == 1 and MRKbs == 1 and MRKbbs == 0)
   {
    setprop("/mig29/systems/MRK/MRK_kontr", 1);
    setprop("/mig29/controls/MRK/MRK_kontr", 1);
   }
  if (MRKb == 0 and MRKbb == 1)
   {
    setprop("/mig29/systems/MRK/MRK", 1);
    setprop("/mig29/controls/MRK/MRK", 1);
   }
  if (MRKb == 0 and MRKbb == 0)
   {
    setprop("/mig29/systems/MRK/MRK", 0);
    setprop("/mig29/systems/MRK/MRK_kontr", 0);
   }
  if (MRKb == 1 and MRKbb == 0)
   {
    setprop("/mig29/systems/MRK/MRK", 1);
    setprop("/mig29/systems/MRK/MRK_kontr", 0);
   }
  if (MRKb == 0 and MRKbb == 1 and MRKbs == 0 and MRKbbs == 0)
   {
    setprop("/mig29/systems/MRK/MRK", 0);
    setprop("/mig29/systems/MRK/MRK_kontr", 0);
    setprop("/mig29/controls/MRK/MRK", 0);
    setprop("/mig29/controls/MRK/MRK_kontr", 0);
   }
}

MRKsf = 0;

 var MRKon_thandler = func {
  var MRKsf = getprop("/mig29/systems/MRK/MRK");
  setprop("fdm/jsbsim/systems/gear/MRK", MRKsf);
}

 var MRK_init = func {
  setprop("/mig29/controls/MRK/MRK", 1);
  setprop("/mig29/controls/MRK/MRK_kontr", 1);
  setprop("/mig29/systems/MRK/MRK", 1);
  setprop("/mig29/systems/MRK/MRK_kontr", 1);
  setlistener("/mig29/controls/MRK/MRK", MRKon_handler);
  setlistener("/mig29/controls/MRK/MRK", MRKon_thandler);
  setlistener("/mig29/controls/MRK/MRK_kontr", MRKon_handler);
}

var ANSb = 0;
var ANSbb = 0;
var ANSbs = 0;
var ANSbbs = 0;

 var ANSon_handler = func {
  var ANSb = getprop("/mig29/controls/HS/ANS");
  var ANSbb = getprop("/mig29/controls/HS/ANS_kontr");
  var ANSbs = getprop("/mig29/systems/HS/ANS");
  var ANSbbs = getprop("/mig29/systems/HS/ANS_kontr");
  if (ANSb == 1 and ANSbb == 1 and ANSbs == 1 and ANSbbs == 0)
   {
    setprop("/mig29/systems/HS/ANS_kontr", 1);
    setprop("/mig29/controls/HS/ANS_kontr", 1);
   }
  if (ANSb == 0 and ANSbb == 1)
   {
    setprop("/mig29/systems/HS/ANS", 1);
    setprop("/mig29/controls/HS/ANS", 1);
   }
  if (ANSb == 0 and ANSbb == 0)
   {
    setprop("/mig29/systems/HS/ANS", 0);
    setprop("/mig29/systems/HS/ANS_kontr", 0);
   }
  if (ANSb == 1 and ANSbb == 0)
   {
    setprop("/mig29/systems/HS/ANS", 1);
    setprop("/mig29/systems/HS/ANS_kontr", 0);
   }
  if (ANSb == 0 and ANSbb == 1 and ANSbs == 0 and ANSbbs == 0)
   {
    setprop("/mig29/systems/HS/ANS", 0);
    setprop("/mig29/systems/HS/ANS_kontr", 0);
    setprop("/mig29/controls/HS/ANS", 0);
    setprop("/mig29/controls/HS/ANS_kontr", 0);
   }
}

var ANSsf = 0;

 var ANSon_thandler = func {
  var ANSsf = getprop("/mig29/systems/HS/ANS");
  setprop("fdm/jsbsim/hs/ANS", ANSsf);
}

 var ANS_init = func {
  setprop("/mig29/controls/HS/ANS", 1);
  setprop("/mig29/controls/HS/ANS_kontr", 1);
  setprop("/mig29/systems/HS/ANS", 1);
  setprop("/mig29/systems/HS/ANS_kontr", 1);
  setlistener("/mig29/controls/HS/ANS", ANSon_handler);
  setlistener("/mig29/controls/HS/ANS", ANSon_thandler);
  setlistener("/mig29/controls/HS/ANS_kontr", ANSon_handler);
}

# Бортовой номер
var BNv = 0;
var BNv2 = 0;

 var BNh = func {
  var BNv = getprop("/mig29/controls/BN/N");
  if (BNv < 10 and BNv > 0)
   {
   setprop("/mig29/systems/BN/N1", 0);
   setprop("/mig29/systems/BN/N2", BNv);
   }
  if (BNv > 9)
   {
    var BNv2 = int(BNv/10);
    setprop("/mig29/systems/BN/N1", BNv2);
    var BNv = BNv-(BNv2*10);
    setprop("/mig29/systems/BN/N2", BNv);
   }
}
var BNTv = 0;

 var BNTh = func {
  var BNTv = getprop("/mig29/controls/BN/T");
   if (BNTv == "1-Black") {setprop("/mig29/systems/BN/T", "BortNum1Black.png");}
   if (BNTv == "1-Blue") {setprop("/mig29/systems/BN/T", "BortNum1Blue.png");}
   if (BNTv == "1-Red") {setprop("/mig29/systems/BN/T", "BortNum1Red.png");}
   if (BNTv == "1-Yellow") {setprop("/mig29/systems/BN/T", "BortNum1Yellow.png");}
}

 var BN_init = func {
  setprop("/mig29/controls/BN/N", 01);
  setprop("/mig29/controls/BN/T", "1-Blue");
  setprop("/mig29/systems/BN/N1", 0);
  setprop("/mig29/systems/BN/N2", 1);
  setlistener("/mig29/controls/BN/N", BNh);
  setlistener("/mig29/controls/BN/T", BNTh);
}

 PU_189 = func {
# Демпфер
  if (getprop("/mig29/controls/PU-189/damp") == 1 and getprop("/mig29/systems/SAU/damp") == 0)
   {SAU.Damp_on();}
# Увод
  if (getprop("/mig29/controls/PU-189/uvod") == 1 and getprop("/mig29/systems/SAU/uvod") == 0)
   {SAU.Uvod_on();}
  if (getprop("/mig29/controls/PU-189/uvod") == 0 and getprop("/mig29/systems/SAU/uvod") == 1)
   {setprop("/mig29/instrumentation/PU-189/uvod", 0); SAU.Uvod_off();}
# Стабилизация высоты
  if (getprop("/mig29/controls/PU-189/stabvys") == 1 and getprop("/mig29/systems/SAU/stabvys") == 0 and getprop("/mig29/systems/SAU/ap") == 1)
   {SAU.StabVys_on();}
  if (getprop("/mig29/controls/PU-189/stabvys") == 0 and getprop("/mig29/systems/SAU/stabvys") == 1)
   {SAU.StabVys_off();}
# Стабилизация
  if (getprop("/mig29/controls/PU-189/ap") == 1 and getprop("/mig29/systems/SAU/ap") == 0)
   {SAU.Stab_on();}
  if (getprop("/mig29/controls/PU-189/ap") == 0 and getprop("/mig29/systems/SAU/ap") == 1)
   {SAU.Stab_off();}
# Траекторное управление
  if (getprop("/mig29/controls/PU-189/traek_upr") == 1 and getprop("/mig29/systems/SAU/traek_upr") == 0 and getprop("/mig29/switches/SAU") == 1)
   {SAU.Traek_Upr_on();}
  if (getprop("/mig29/controls/PU-189/traek_upr") == 0 and getprop("/mig29/systems/SAU/traek_upr") == 1 and getprop("/mig29/switches/SAU") == 1)
   {SAU.Traek_Upr_off();}
# Повторный заход
  if (getprop("/mig29/controls/PU-189/povt_zahod") == 1 and getprop("/mig29/systems/SAU/povt_zahod") == 0 and getprop("/mig29/switches/SAU") == 1)
   {setprop("/mig29/systems/SAU/povt_zahod", 1);}
  if (getprop("/mig29/controls/PU-189/povt_zahod") == 0 and getprop("/mig29/systems/SAU/povt_zahod") == 1 and getprop("/mig29/switches/SAU") == 1)
   {setprop("/mig29/systems/SAU/povt_zahod", 0);}
}

 PU_189_Ind = func {
  if (getprop("/mig29/systems/SAU/damp") == 0) {setprop("/mig29/instrumentation/PU-189/damp", 0);}
  else {setprop("/mig29/instrumentation/PU-189/damp", 1);}
  if (getprop("/mig29/systems/SAU/uvod") == 0) {setprop("/mig29/instrumentation/PU-189/uvod", 0);}
  else {setprop("/mig29/instrumentation/PU-189/uvod", 1);}
  if (getprop("/mig29/systems/SAU/stabvys") == 0) {setprop("/mig29/instrumentation/PU-189/stabvys", 0);}
  else {setprop("/mig29/instrumentation/PU-189/stabvys", 1);}
  if (getprop("/mig29/systems/SAU/ap") == 0) {setprop("/mig29/instrumentation/PU-189/ap", 0);}
  else {setprop("/mig29/instrumentation/PU-189/ap", 1);}
  if (getprop("/mig29/systems/SAU/traek_upr") == 0) {setprop("/mig29/instrumentation/PU-189/traek_upr", 0);}
  else {setprop("/mig29/instrumentation/PU-189/traek_upr", 1);}
  if (getprop("/mig29/systems/SAU/povt_zahod") == 0) {setprop("/mig29/instrumentation/PU-189/povt_zahod", 0);}
  else {setprop("/mig29/instrumentation/PU-189/povt_zahod", 1);}
}

 PU_189_init = func {
  setprop("/mig29/controls/PU-189/damp", 0);
  setprop("/mig29/controls/PU-189/uvod", 0);
  setprop("/mig29/controls/PU-189/stabvys", 0);
  setprop("/mig29/controls/PU-189/ap", 0);
  setprop("/mig29/controls/PU-189/traek_upr", 0);
  setprop("/mig29/controls/PU-189/povt_zahod", 0);
  setprop("/mig29/instrumentation/PU-189/damp", 0);
  setprop("/mig29/instrumentation/PU-189/uvod", 0);
  setprop("/mig29/instrumentation/PU-189/stabvys", 0);
  setprop("/mig29/instrumentation/PU-189/ap", 0);
  setprop("/mig29/instrumentation/PU-189/traek_upr", 0);
  setprop("/mig29/instrumentation/PU-189/povt_zahod", 0);
  setprop("/mig29/systems/SAU/damp", 0);
  setprop("/mig29/systems/SAU/uvod", 0);
  setprop("/mig29/systems/SAU/stabvys", 0);
  setprop("/mig29/systems/SAU/ap", 0);
  setprop("/mig29/systems/SAU/traek_upr", 0);
  setprop("/mig29/systems/SAU/povt_zahod", 0);
  setlistener("/mig29/controls/PU-189/damp", PU_189);
  setlistener("/mig29/controls/PU-189/uvod", PU_189);
  setlistener("/mig29/controls/PU-189/stabvys", PU_189);
  setlistener("/mig29/controls/PU-189/ap", PU_189);
  setlistener("/mig29/controls/PU-189/traek_upr", PU_189);
  setlistener("/mig29/controls/PU-189/povt_zahod", PU_189);
  setlistener("/mig29/systems/SAU/damp", PU_189_Ind);
  setlistener("/mig29/systems/SAU/uvod", PU_189_Ind);
  setlistener("/mig29/systems/SAU/stabvys", PU_189_Ind);
  setlistener("/mig29/systems/SAU/ap", PU_189_Ind);
  setlistener("/mig29/systems/SAU/traek_upr", PU_189_Ind);
  setlistener("/mig29/systems/SAU/povt_zahod", PU_189_Ind);
}

 var SVS = func {
  if (getprop("/mig29/controls/SVS/control") == 1) {setprop("fdm/jsbsim/systems/SVS/control", 1);}
  else {setprop("fdm/jsbsim/systems/SVS/control", 0);}
}

var BCN = 0;

 var Brake_handler = func {
  var BCN = (getprop("/controls/gear/brake-left") + getprop("/controls/gear/brake-right"));
  var BCN = BCN/2;
  setprop("fdm/jsbsim/fcs/brake-cmd-norm", BCN);
}

 var ZahvatMRK = func {
  if (getprop("/mig29/controls/RUD/ZahvatMRK") == 0 and getprop("gear/gear[1]/wow") == 1)
   {setprop("fdm/jsbsim/systems/gear/vpr", 1);}
  if (getprop("/mig29/controls/RUD/ZahvatMRK") == 1 and getprop("gear/gear[1]/wow") == 1)
   {setprop("fdm/jsbsim/systems/gear/vpr", 0);}
  if (getprop("/mig29/controls/RUD/ZahvatMRK") == 0 and getprop("gear/gear[1]/wow") == 0)
   {setprop("/mig29/controls/SUV/lockon", 0);}
  if (getprop("/mig29/controls/RUD/ZahvatMRK") == 1 and getprop("gear/gear[1]/wow") == 0)
   {setprop("/mig29/controls/SUV/lockon", 1);}
}

 var KVRUS_handler = func {
  if (getprop("/mig29/controls/SAU/KVRUS") == 0)
   {
    setprop("fdm/jsbsim/ap/control/KVRUS", 0);
    var window = screen.window.new(-1, 12, 1, 2);
    window.fg = [1, 1, 1, 1];
    window.align = "right";
    window.write("KVRUS Off");
   }
  if (getprop("/mig29/controls/SAU/KVRUS") == 1)
   {
    setprop("fdm/jsbsim/ap/control/KVRUS", 1);
    var window = screen.window.new(-1, 12, 1, 2);
    window.fg = [1, 1, 1, 1];
    window.align = "right";
    window.write("KVRUS On");
   }
}

 var PrivGor_handler = func {
  if (getprop("/mig29/controls/SAU/PrivGor") == 1 and SAU.sau_powered() == 1) {SAU.PrivGor();}
}

 var VyklRezhSAU_handler = func {
  if (getprop("/mig29/controls/SAU/vrSAU") == 0 and SAU.sau_powered() == 1) {SAU.VyklRezhDamp(1);}
  if (getprop("/mig29/controls/SAU/vrSAU") == 1 and SAU.sau_powered() == 1) {SAU.VyklRezhSAU(); SAU.VyklRezhDamp(0);}
}

var SPO_15LM_bright = 0;

 var SPO_15LM_bright_handler = func {
  var SPO_15LM_bright = getprop("/mig29/controls/SPO-15LM/bright");
  if (getprop("/mig29/systems/SPO-15LM/on") == 1) {setprop("/mig29/systems/SPO-15LM/bright", SPO_15LM_bright);}
  else {setprop("/mig29/systems/SPO-15LM/bright", 0);}
}

 var Fary_handler = func {
  if (getprop("/mig29/systems/electrical/buses/DC27-bus/volts") < 20)
   {
    setprop("/mig29/systems/lighting/taxi", 0);
    setprop("/mig29/systems/lighting/landing", 0);
    return;
   }
  if (getprop("/controls/gear/gear-down") == 0)
   {
    setprop("/mig29/systems/lighting/taxi", 0);
    setprop("/mig29/systems/lighting/landing", 0);
    return;
   }
  if (getprop("/mig29/controls/lighting/fary") == 0 and getprop("/mig29/systems/electrical/buses/DC27-bus/volts") > 20)
   {
    setprop("/mig29/systems/lighting/taxi", 0);
    setprop("/mig29/systems/lighting/landing", 0);
    return;
   }
  if (getprop("/mig29/controls/lighting/fary") == 1 and getprop("/mig29/systems/electrical/buses/DC27-bus/volts") > 20)
   {
    setprop("/mig29/systems/lighting/taxi", 1);
    setprop("/mig29/systems/lighting/landing", 0);
    return;
   }
  if (getprop("/mig29/controls/lighting/fary") == 2 and getprop("/mig29/systems/electrical/buses/DC27-bus/volts") > 20)
   {
    setprop("/mig29/systems/lighting/taxi", 0);
    setprop("/mig29/systems/lighting/landing", 1);
    return;
   }
}

#
var IPLightv27 = 0;
var IPLightvnorm = 0;
var IPLightA = 0;
var IPLightF = 0;
var IPLightI = 0;
var IPLightM = 0;
var IPLightP = 0;
var IPLightT = 0;
var IPLightRem = 0;

 var IPLight = func {
  var IPLightv27 = getprop("/mig29/instrumentation/electrical/v27");
  var IPLightRem = getprop("/sim/rendering/rembrandt/enabled");
  if (IPLightv27 > 12)
   {
    var IPLightvnorm = (IPLightv27/28.5);
    var IPLightA = getprop("/mig29/controls/lighting/annunciators-norm");
    var IPLightF = getprop("/mig29/controls/lighting/floodlight-norm");
    var IPLightI = getprop("/mig29/controls/lighting/instruments-norm");
    var IPLightM = getprop("/mig29/controls/lighting/map-norm");
    var IPLightP = getprop("/mig29/controls/lighting/panel-norm");
    var IPLightT = getprop("/mig29/controls/lighting/tablo-norm");
    var IPLightA = ((IPLightA*IPLightvnorm)/2+0.5);
    var IPLightF = (IPLightF*IPLightvnorm);
    var IPLightI = (IPLightI*IPLightvnorm);
    var IPLightM = (IPLightM*IPLightvnorm);
    var IPLightP = (IPLightP*IPLightvnorm);
    if (IPLightRem == 1) {var IPLightT = ((IPLightT*IPLightvnorm)*0.32)+0.35;}
    else {var IPLightT = ((IPLightT*IPLightvnorm)*0.685)+0.35;}
    setprop("/mig29/systems/cockpitlighting/annunciators-norm", IPLightA);
    setprop("/mig29/systems/cockpitlighting/floodlight-norm", IPLightF);
    setprop("/mig29/systems/cockpitlighting/instruments-norm", IPLightI);
    setprop("/mig29/systems/cockpitlighting/map-norm", IPLightM);
    if (IPLightRem == 1)
     {setprop("/mig29/systems/cockpitlighting/panel-norm", IPLightP*0.1);}
    else {setprop("/mig29/systems/cockpitlighting/panel-norm", IPLightP);}
    setprop("/mig29/systems/cockpitlighting/panel-R-norm", IPLightP);
    setprop("/mig29/systems/cockpitlighting/tablo-norm", IPLightT);
   }
  else
  {
   setprop("/mig29/systems/cockpitlighting/annunciators-norm", 0.0);
   setprop("/mig29/systems/cockpitlighting/floodlight-norm", 0.0);
   setprop("/mig29/systems/cockpitlighting/instruments-norm", 0.0);
   setprop("/mig29/systems/cockpitlighting/map-norm", 0.0);
   setprop("/mig29/systems/cockpitlighting/panel-norm", 0.0);
   setprop("/mig29/systems/cockpitlighting/panel-R-norm", 0.0);
   setprop("/mig29/systems/cockpitlighting/tablo-norm", 0.0);
  }
  settimer(IPLight, 0.1);
}

var vZPU_input = 0;
var vZPU_c = 0;

 var ZPU_input = func {
  var vZPU_input = getprop("/mig29/controls/PNP-72-12/ZPU");
  var vZPU_c = int(vZPU_input/360);
  var vZPU_input = vZPU_input-(vZPU_c*360);
  if (vZPU_input < 0) {var vZPU_input = vZPU_input+360;}
  setprop("/mig29/systems/PNP-72-12/ZPU", vZPU_input);
}

# Canopy emergency control
 var canopy_emerg_switch = func {
  if (getprop("/mig29/controls/Canopy/ASF") == 1 and getprop("/mig29/controls/Canopy/ASF-a") == 0)
  {interpolate("/mig29/controls/Canopy/ASF-a", 1, 0.5); settimer(canopy_emerg_switch, 0.5);}
  if (getprop("/mig29/controls/Canopy/ASF") == 1 and getprop("/mig29/controls/Canopy/ASF-a") == 1)
  {setprop("fdm/jsbsim/fcs/canopy-emerg-cmd", 1);}
}

# Аварийная расгерметизация кабины
 var cockpit_emerg_depress = func {
  if (getprop("/mig29/controls/pneumosys/ced") == 0) {setprop("/fdm/jsbsim/systems/pneumo/emerg-depress", 0);}
  if (getprop("/mig29/controls/pneumosys/ced") == 1) {setprop("/fdm/jsbsim/systems/pneumo/emerg-depress", 1);}
}

 var ControlInit = func {
  MRK_init();
  ANS_init();
  setlistener("/mig29/controls/SN/IKV", KV_select);
  BN_init();
  PU_189_init();
  setprop("/mig29/controls/SVS/control", 0);
  setlistener("/mig29/controls/SVS/control", SVS);
   setprop("fdm/jsbsim/fcs/brake-cmd-norm", 0);
  setlistener("/controls/gear/brake-left", Brake_handler);
  setlistener("/controls/gear/brake-right", Brake_handler);
  setlistener("/mig29/controls/RUD/ZahvatMRK", ZahvatMRK);
  setprop("/mig29/controls/SAU/KVRUS", 0);
  setlistener("/mig29/controls/SAU/KVRUS", KVRUS_handler);
  setlistener("/mig29/controls/SAU/PrivGor", PrivGor_handler);
  setlistener("/mig29/controls/SAU/vrSAU", VyklRezhSAU_handler);
  setprop("/mig29/systems/SPO-15LM/bright", 0);
   setprop("/mig29/systems/SPO-15LM/on", 0);
  setlistener("/mig29/controls/SPO-15LM/bright", SPO_15LM_bright_handler);
  setlistener("/mig29/systems/SPO-15LM/on", SPO_15LM_bright_handler);
  setprop("/mig29/controls/lighting/fary", 0);
  setlistener("/mig29/systems/electrical/buses/DC27-bus/volts", Fary_handler);
  setlistener("/mig29/controls/lighting/fary", Fary_handler);
  IPLight();
  setprop("/mig29/controls/IPV/bright-norm", 1);
  setprop("/mig29/controls/IPV/metka-trassa", 0);
  setprop("/mig29/controls/IPV/takt-dubl", 0);
  setprop("/mig29/systems/PNP-72-12/ZPU", 0);
  setlistener("/mig29/controls/PNP-72-12/ZPU", ZPU_input);
  setlistener("/mig29/controls/Canopy/ASF", canopy_emerg_switch);
  setlistener("/mig29/controls/pneumosys/ced", cockpit_emerg_depress);
}