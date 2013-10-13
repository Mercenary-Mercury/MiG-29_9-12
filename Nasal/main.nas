# main.nas
# Main scripts for MiG-29 (9-12)
# June 2011, Sergey "Mercenary_Mercury" Salow

# Pre Ins
 var preins = func {
  chngtexdn();
  PTBi();
  PTBd();
  canopy_pos_anim();
  inlet_pos_anim();
  LERX_pos_anim();
  parachute_pos_anim();
  stabilator_pos_anim();
  WeightASF();
  pitot_heat();
}

# Canopy control
 var canopy_pos_switch = func {
  if (getprop("fdm/jsbsim/fcs/canopy-cmd-norm") == 0)
  {setprop("fdm/jsbsim/fcs/canopy-cmd-norm", 1);}
  else {setprop("fdm/jsbsim/fcs/canopy-cmd-norm", 0);}
}

 var canopy_pos_anim = func {
  if (getprop("fdm/jsbsim/fcs/canopy-pos-norm") != getprop("mig29/systems/CS/Canopy/pos-norm"))
   {setprop("mig29/systems/CS/Canopy/pos-norm", getprop("fdm/jsbsim/fcs/canopy-pos-norm"));}
  settimer(canopy_pos_anim, 0);
}

 var inlet_pos_anim = func {
  if (getprop("fdm/jsbsim/systems/intake/pos-left") != getprop("mig29/systems/CS/Inlet/left-pos-norm"))
   {setprop("mig29/systems/CS/Inlet/left-pos-norm", getprop("fdm/jsbsim/systems/intake/pos-left"));}
  if (getprop("fdm/jsbsim/systems/intake/pos-right") != getprop("mig29/systems/CS/Inlet/right-pos-norm"))
   {setprop("mig29/systems/CS/Inlet/right-pos-norm", getprop("fdm/jsbsim/systems/intake/pos-right"));}
  settimer(inlet_pos_anim, 0);
}

 var LERX_pos_anim = func {
  if (getprop("fdm/jsbsim/fcs/LERX-pos-norm") != getprop("mig29/systems/CS/LERX/pos-norm"))
   {setprop("mig29/systems/CS/LERX/pos-norm", getprop("fdm/jsbsim/fcs/LERX-pos-norm"));}
  settimer(LERX_pos_anim, 0);
}

 var parachute_pos_anim = func {
  if (getprop("fdm/jsbsim/fcs/parachute_reef_pos_norm") != getprop("mig29/systems/CS/Parachute/pos-norm"))
   {setprop("mig29/systems/CS/Parachute/pos-norm", getprop("fdm/jsbsim/fcs/parachute_reef_pos_norm"));}
  settimer(parachute_pos_anim, 0);
}

 var stabilator_pos_anim = func {
  if (getprop("fdm/jsbsim/fcs/left-stabilator-pos-norm") != getprop("mig29/systems/CS/Stabilator/left-pos-norm"))
   {setprop("mig29/systems/CS/Stabilator/left-pos-norm", getprop("fdm/jsbsim/fcs/left-stabilator-pos-norm"));}
  if (getprop("fdm/jsbsim/fcs/right-stabilator-pos-norm") != getprop("mig29/systems/CS/Stabilator/right-pos-norm"))
   {setprop("mig29/systems/CS/Stabilator/right-pos-norm", getprop("fdm/jsbsim/fcs/right-stabilator-pos-norm"));}
  settimer(stabilator_pos_anim, 0);
}

# 
 var chngtexdn = func {
 if (getprop("/sim/time/sun-angle-rad") > 1.6 and getprop("/sim/rendering/rembrandt/enabled") == 0)
  {
   setprop("mig29/systems/cockpitlighting/texture1", "cockpit_9-12_1N.png");
   setprop("mig29/systems/cockpitlighting/texture2", "cockpit_9-12_2N.png");
   setprop("mig29/systems/cockpitlighting/texture3", "cockpit_9-12_3N.png");
   setprop("mig29/systems/cockpitlighting/texture4", "cockpit_9-12_4N.png");
   setprop("mig29/systems/cockpitlighting/texture5", "cockpit_9-12_5N.png");
   setprop("mig29/systems/cockpitlighting/texture6", "ILS-31cN.png");
   setprop("mig29/systems/cockpitlighting/texturep", 1);
  }
 else
  {
   setprop("mig29/systems/cockpitlighting/texture1", "cockpit_9-12_1.png");
   setprop("mig29/systems/cockpitlighting/texture2", "cockpit_9-12_2.png");
   setprop("mig29/systems/cockpitlighting/texture3", "cockpit_9-12_3.png");
   setprop("mig29/systems/cockpitlighting/texture4", "cockpit_9-12_4.png");
   setprop("mig29/systems/cockpitlighting/texture5", "cockpit_9-12_5.png");
   setprop("mig29/systems/cockpitlighting/texture6", "ILS-31c.png");
   setprop("mig29/systems/cockpitlighting/texturep", 0);
  }
  settimer(chngtexdn, 0.1);
}

 var pitot_heat = func {
  if (getprop("/mig29/systems/electrical/buses/AC1x115-bus-glass-pito-heat/volts") > 100)
   {setprop("/fdm/jsbsim/systems/SVS/pitot-heating", 0.0275);}
  else {setprop("/fdm/jsbsim/systems/SVS/pitot-heating", 0);}
  settimer(pitot_heat, 1);
}

# Separate digits, not greater 1000.

var sd_tempvar = 0;
var sdi = 0;
var sdo1 = 0;
var sdo2 = 0;
var sdo3 = 0;

 var sepdigs = func(arg0) {

var sdi = arg[0];

  if (sd_tempvar > -1000 and sd_tempvar < 1000)
 {
  if (sd_tempvar > -100 and sd_tempvar < 100) { sdo1 = 0;}
  if (sd_tempvar > 100 and sd_tempvar < 200) { sdo1 = 1;}
  if (sd_tempvar > -200 and sd_tempvar < -100) { sdo1 = 1;}
  if (sd_tempvar > 200 and sd_tempvar < 300) { sdo1 = 2;}
  if (sd_tempvar > -300 and sd_tempvar < -200) { sdo1 = 2;}
  if (sd_tempvar > 300 and sd_tempvar < 400) { sdo1 = 3;}
  if (sd_tempvar > -400 and sd_tempvar < -300) { sdo1 = 3;}
  if (sd_tempvar > 400 and sd_tempvar < 500) { sdo1 = 4;}
  if (sd_tempvar > -500 and sd_tempvar < -400) { sdo1 = 4;}
  if (sd_tempvar > 500 and sd_tempvar < 600) { sdo1 = 5;}
  if (sd_tempvar > -600 and sd_tempvar < -500) { sdo1 = 5;}
  if (sd_tempvar > 600 and sd_tempvar < 700) { sdo1 = 6;}
  if (sd_tempvar > -700 and sd_tempvar < -600) { sdo1 = 6;}
  if (sd_tempvar > 700 and sd_tempvar < 800) { sdo1 = 7;}
  if (sd_tempvar > -800 and sd_tempvar < -700) { sdo1 = 7;}
  if (sd_tempvar > 800 and sd_tempvar < 900) { sdo1 = 8;}
  if (sd_tempvar > -900 and sd_tempvar < -800) { sdo1 = 8;}
  if (sd_tempvar > 900 and sd_tempvar < 1000) { sdo1 = 9;}
  if (sd_tempvar > -1000 and sd_tempvar < -900) { sdo1 = 9;}
  var sd_tempvar = sdi-(sdo1*100);
 }
  else {sd_tempvar = sdi}
  if (sd_tempvar > -100 and sd_tempvar < 100)
 {
  if (sd_tempvar > -10 and sd_tempvar < 10) { sdo2 = 0;}
  if (sd_tempvar > 10 and sd_tempvar < 20) { sdo2 = 1;}
  if (sd_tempvar > -20 and sd_tempvar < -10) { sdo2 = 1;}
  if (sd_tempvar > 20 and sd_tempvar < 30) { sdo2 = 2;}
  if (sd_tempvar > -30 and sd_tempvar < -20) { sdo2 = 2;}
  if (sd_tempvar > 30 and sd_tempvar < 40) { sdo2 = 3;}
  if (sd_tempvar > -40 and sd_tempvar < -30) { sdo2 = 3;}
  if (sd_tempvar > 40 and sd_tempvar < 50) { sdo2 = 4;}
  if (sd_tempvar > -50 and sd_tempvar < -40) { sdo2 = 4;}
  if (sd_tempvar > 50 and sd_tempvar < 60) { sdo2 = 5;}
  if (sd_tempvar > -60 and sd_tempvar < -50) { sdo2 = 5;}
  if (sd_tempvar > 60 and sd_tempvar < 70) { sdo2 = 6;}
  if (sd_tempvar > -70 and sd_tempvar < -60) { sdo2 = 6;}
  if (sd_tempvar > 70 and sd_tempvar < 80) { sdo2 = 7;}
  if (sd_tempvar > -80 and sd_tempvar < -70) { sdo2 = 7;}
  if (sd_tempvar > 80 and sd_tempvar < 90) { sdo2 = 8;}
  if (sd_tempvar > -90 and sd_tempvar < -80) { sdo2 = 8;}
  if (sd_tempvar > 90 and sd_tempvar < 100) { sdo2 = 9;}
  if (sd_tempvar > -100 and sd_tempvar < -90) { sdo2 = 9;}
  var sd_tempvar = sd_tempvar-(sdo2*10);
 }
  else {sd_tempvar = speed_m}
  if (sd_tempvar > -1 and sd_tempvar < 1) { sdo3 = 0;}
  if (sd_tempvar > 1 and sd_tempvar < 2) { sdo3 = 1;}
  if (sd_tempvar > -2 and sd_tempvar < -1) { sdo3 = 1;}
  if (sd_tempvar > 2 and sd_tempvar < 3) { sdo3 = 2;}
  if (sd_tempvar > -3 and sd_tempvar < -2) { sdo3 = 2;}
  if (sd_tempvar > 3 and sd_tempvar < 4) { sdo3 = 3;}
  if (sd_tempvar > -4 and sd_tempvar < -3) { sdo3 = 3;}
  if (sd_tempvar > 4 and sd_tempvar < 5) { sdo3 = 4;}
  if (sd_tempvar > -5 and sd_tempvar < -4) { sdo3 = 4;}
  if (sd_tempvar > 5 and sd_tempvar < 6) { sdo3 = 5;}
  if (sd_tempvar > -6 and sd_tempvar < -5) { sdo3 = 5;}
  if (sd_tempvar > 6 and sd_tempvar < 7) { sdo3 = 6;}
  if (sd_tempvar > -7 and sd_tempvar < -6) { sdo3 = 6;}
  if (sd_tempvar > 7 and sd_tempvar < 8) { sdo3 = 7;}
  if (sd_tempvar > -8 and sd_tempvar < -7) { sdo3 = 7;}
  if (sd_tempvar > 8 and sd_tempvar < 9) { sdo3 = 8;}
  if (sd_tempvar > -9 and sd_tempvar < -8) { sdo3 = 8;}
  if (sd_tempvar > 9 and sd_tempvar < 10) { sdo3 = 9;}
  if (sd_tempvar > -10 and sd_tempvar < -9) { sdo3 = 9;}
}

# Временно размещено здесь
# Функция выдачи периодического сигнала с частотой 2,5 Гц.

 var IG2Hz5 = func {
  if (getprop("mig29/systems/IG2Hz5") == 0) { setprop("mig29/systems/IG2Hz5", 1);}
  else { setprop("mig29/systems/IG2Hz5", 0);}
  settimer(IG2Hz5, 0.2);
}

# 34.612575163

 var PTBd = func {
  if ( getprop("/gear/gear[1]/wow") == 1 )
   {
    if (getprop("mig29/weapons/podv/PTB") == 1)
     {
      setprop("mig29/systems/fuelsystem/PTBenable", 1);
      setprop("/consumables/fuel/tank[7]/level-lbs", 2630.555712389959);
      setprop("fdm/jsbsim/systems/podv/PTB", 1);
     }
    if (getprop("mig29/weapons/podv/PTB") == 0)
     {
      setprop("mig29/systems/fuelsystem/PTBenable", 0);
      setprop("/consumables/fuel/tank[7]/level-lbs", 0);
      setprop("fdm/jsbsim/systems/podv/PTB", 0);
     }
   }
 }
 
 var PTBi = func {
 setlistener("mig29/weapons/podv/PTB", PTBd);
 }

 var refuel_aircraft = func {
  if (getprop("/gear/gear[0]/wow") == 1)
   {
    setprop("/consumables/fuel/tank[0]/level-m3", getprop("/consumables/fuel/tank[0]/capacity-m3"));
    setprop("/consumables/fuel/tank[1]/level-m3", getprop("/consumables/fuel/tank[1]/capacity-m3"));
    setprop("/consumables/fuel/tank[2]/level-m3", getprop("/consumables/fuel/tank[2]/capacity-m3"));
    setprop("/consumables/fuel/tank[3]/level-m3", getprop("/consumables/fuel/tank[3]/capacity-m3"));
    setprop("/consumables/fuel/tank[4]/level-m3", getprop("/consumables/fuel/tank[4]/capacity-m3"));
    setprop("/consumables/fuel/tank[5]/level-m3", getprop("/consumables/fuel/tank[5]/capacity-m3"));
    setprop("/consumables/fuel/tank[6]/level-m3", getprop("/consumables/fuel/tank[6]/capacity-m3"));
    setprop("/consumables/fuel/tank[7]/level-m3", getprop("/consumables/fuel/tank[7]/capacity-m3"));
   }
}

#
var WeightvarASF = 0;
var WeightvarASG = 0;

 var WeightASF = func {
# Топливо
 # В процентах
  var WeightvarASF = getprop("/consumables/fuel/tank[0]/level-norm");
  var WeightvarASF = WeightvarASF+getprop("/consumables/fuel/tank[1]/level-norm");
  var WeightvarASF = WeightvarASF+getprop("/consumables/fuel/tank[2]/level-norm");
  var WeightvarASF = WeightvarASF+getprop("/consumables/fuel/tank[3]/level-norm");
  var WeightvarASF = WeightvarASF+getprop("/consumables/fuel/tank[4]/level-norm");
  var WeightvarASF = WeightvarASF+getprop("/consumables/fuel/tank[5]/level-norm");
  var WeightvarASF = WeightvarASF+getprop("/consumables/fuel/tank[6]/level-norm");
  var WeightvarASF = WeightvarASF/0.07;
  setprop("mig29/systems/weight/internal_tanks_level-ip", WeightvarASF);
  var WeightvarASF = WeightvarASF+(getprop("/consumables/fuel/tank[7]/level-norm")*35.7142857);
  setprop("mig29/systems/weight/all_tanks_level-ip", WeightvarASF);
 # В килограммах
  setprop("mig29/systems/weight/tank_3A-level-kg", getprop("/consumables/fuel/tank[3]/level-kg")+getprop("/consumables/fuel/tank[4]/level-kg"));
  setprop("mig29/systems/weight/wing_tanks-level-kg", getprop("/consumables/fuel/tank[5]/level-kg")+getprop("/consumables/fuel/tank[6]/level-kg"));
  var WeightvarASF = getprop("/consumables/fuel/tank[0]/level-kg");
  var WeightvarASF = WeightvarASF+getprop("/consumables/fuel/tank[1]/level-kg");
  var WeightvarASF = WeightvarASF+getprop("/consumables/fuel/tank[2]/level-kg");
  var WeightvarASF = WeightvarASF+getprop("/consumables/fuel/tank[3]/level-kg");
  var WeightvarASF = WeightvarASF+getprop("/consumables/fuel/tank[4]/level-kg");
  var WeightvarASF = WeightvarASF+getprop("/consumables/fuel/tank[5]/level-kg");
  var WeightvarASF = WeightvarASF+getprop("/consumables/fuel/tank[6]/level-kg");
  setprop("mig29/systems/weight/internal_tanks_level-kg", WeightvarASF);
  setprop("mig29/systems/weight/total_weight-kg", getprop("/fdm/jsbsim/inertia/weight-lbs")*0.45359237);
# Боевая нагрузка
  var WeightvarASF = 0;
 # АПУ и БД
  if (getprop("mig29/weapons/podv/T1") == 1 or getprop("mig29/weapons/podv/T1") == 2)
   {var WeightvarASF = WeightvarASF+70;}
  if (getprop("mig29/weapons/podv/T1") == 3 or getprop("mig29/weapons/podv/T1") == 4)
   {var WeightvarASF = WeightvarASF+32;}
  if (getprop("mig29/weapons/podv/T1") == 5 or getprop("mig29/weapons/podv/T1") == 6)
   {var WeightvarASF = WeightvarASF+49;}
  
  if (getprop("mig29/weapons/podv/T2") == 1 or getprop("mig29/weapons/podv/T2") == 2)
   {var WeightvarASF = WeightvarASF+70;}
  if (getprop("mig29/weapons/podv/T2") == 3 or getprop("mig29/weapons/podv/T2") == 4)
   {var WeightvarASF = WeightvarASF+32;}
  if (getprop("mig29/weapons/podv/T2") == 5 or getprop("mig29/weapons/podv/T2") == 6)
   {var WeightvarASF = WeightvarASF+49;}
  
  if (getprop("mig29/weapons/podv/T3") == 1 or getprop("mig29/weapons/podv/T3") == 2)
   {var WeightvarASF = WeightvarASF+32;}
  if (getprop("mig29/weapons/podv/T3") == 3 or getprop("mig29/weapons/podv/T3") == 4)
   {var WeightvarASF = WeightvarASF+49;}
  
  if (getprop("mig29/weapons/podv/T4") == 1 or getprop("mig29/weapons/podv/T4") == 2)
   {var WeightvarASF = WeightvarASF+32;}
  if (getprop("mig29/weapons/podv/T4") == 3 or getprop("mig29/weapons/podv/T4") == 4)
   {var WeightvarASF = WeightvarASF+49;}
  
  if (getprop("mig29/weapons/podv/T5") == 1 or getprop("mig29/weapons/podv/T5") == 2)
   {var WeightvarASF = WeightvarASF+32;}
  if (getprop("mig29/weapons/podv/T5") == 3 or getprop("mig29/weapons/podv/T5") == 4)
   {var WeightvarASF = WeightvarASF+49;}
  
  if (getprop("mig29/weapons/podv/T6") == 1 or getprop("mig29/weapons/podv/T6") == 2)
   {var WeightvarASF = WeightvarASF+32;}
  if (getprop("mig29/weapons/podv/T6") == 3 or getprop("mig29/weapons/podv/T6") == 4)
   {var WeightvarASF = WeightvarASF+49;}
  
#  var WeightvarASF = getprop("mig29/weapons/podv/APU-68_1");
#  var WeightvarASF = WeightvarASF+getprop("mig29/weapons/podv/APU-68_2");
#  var WeightvarASF = WeightvarASF+getprop("mig29/weapons/podv/APU-68_3");
#  var WeightvarASF = WeightvarASF+getprop("mig29/weapons/podv/APU-68_4");
#  var WeightvarASG = WeightvarASG+(WeightvarASF*40);
#  var WeightvarASF = getprop("mig29/weapons/podv/BD3-UMK_1");
#  var WeightvarASF = WeightvarASF+getprop("mig29/weapons/podv/BD3-UMK_2");
#  var WeightvarASF = WeightvarASF+getprop("mig29/weapons/podv/BD3-UMK_3");
#  var WeightvarASF = WeightvarASF+getprop("mig29/weapons/podv/BD3-UMK_4");
#  var WeightvarASG = WeightvarASG+(WeightvarASF*60);
#  var WeightvarASF = getprop("mig29/weapons/podv/MBD3-U2T_1");
#  var WeightvarASF = WeightvarASF+getprop("mig29/weapons/podv/MBD3-U2T_2");
#  var WeightvarASF = WeightvarASF+getprop("mig29/weapons/podv/MBD3-U2T_3");
#  var WeightvarASF = WeightvarASF+getprop("mig29/weapons/podv/MBD3-U2T_4");
  
 # Ракеты "воздух-воздух"
  if (getprop("mig29/weapons/podv/T1") == 2)
   {var WeightvarASF = WeightvarASF+253;}
  if (getprop("mig29/weapons/podv/T1") == 4)
   {var WeightvarASF = WeightvarASF+44;}
  if (getprop("mig29/weapons/podv/T1") == 6)
   {var WeightvarASF = WeightvarASF+105;}
  if (getprop("mig29/weapons/podv/T2") == 2)
   {var WeightvarASF = WeightvarASF+253;}
  if (getprop("mig29/weapons/podv/T2") == 4)
   {var WeightvarASF = WeightvarASF+44;}
  if (getprop("mig29/weapons/podv/T2") == 6)
   {var WeightvarASF = WeightvarASF+105;}
  if (getprop("mig29/weapons/podv/T3") == 2)
   {var WeightvarASF = WeightvarASF+44;}
  if (getprop("mig29/weapons/podv/T3") == 4)
   {var WeightvarASF = WeightvarASF+105;}
  if (getprop("mig29/weapons/podv/T4") == 2)
   {var WeightvarASF = WeightvarASF+44;}
  if (getprop("mig29/weapons/podv/T4") == 4)
   {var WeightvarASF = WeightvarASF+105;}
  if (getprop("mig29/weapons/podv/T5") == 2)
   {var WeightvarASF = WeightvarASF+44;}
  if (getprop("mig29/weapons/podv/T5") == 4)
   {var WeightvarASF = WeightvarASF+105;}
  if (getprop("mig29/weapons/podv/T6") == 2)
   {var WeightvarASF = WeightvarASF+44;}
  if (getprop("mig29/weapons/podv/T6") == 4)
   {var WeightvarASF = WeightvarASF+105;}
  
  setprop("mig29/systems/weight/weapon-kg", WeightvarASF);
  settimer(WeightASF, 0.2);
}
