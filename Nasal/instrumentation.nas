# Instrumentation scripts
# 
# Sergey "Mercenary_Mercury" Salow, Aug 2011

var cDC = 0; # current DC voltage
var cAC1 = 0; # current AC115 voltage
var cAC2 = 0; # current AC200 voltage

 var Instrumentation_voltage_handler = func {
  var cDC = getprop("/mig29/instrumentation/electrical/v27");
  var cAC1 = getprop("/mig29/instrumentation/electrical/v115");
  var cAC2 = getprop("/mig29/instrumentation/electrical/v200");
}

 var init_instrumentation = func {
  setlistener("/mig29/instrumentation/electrical/v27", Instrumentation_voltage_handler,0,0 );
  setlistener("/mig29/instrumentation/electrical/v200", Instrumentation_voltage_handler,0,0 );
  asserv();
  vsserv();
  alt();
  aic();
  inhg2mmhg();
  RV_21();
  RV_21_init();
  rifunc2();
  ARK_init();
  R862_init();
  UAP_g_max();
  IKGserv_init();
  IKZhserv_init();
  IPKserv_init();
  PNP_init();
  RPM_init();
  IP_52_init();
  ISTR_init();
  KPP_oZPUi();
  LTTsCounter();
  setprop("/mig29/controls/Biryuza/volna", 1);
  setprop("/mig29/controls/Biryuza/shifr", 1);
  setprop("/mig29/controls/Biryuza/raznos", 1);
  setprop("/mig29/instrumentation/UAP/pilot-g-max", 1);
  setprop("/mig29/instrumentation/UAP/serviceable", 1);
  setprop("/mig29/instrumentation/DA-200/serviceable", 1);
  setprop("/mig29/instrumentation/US-1600/serviceable", 1);
  setprop("/mig29/instrumentation/SPO-15LM/lockon", 0);
  setprop("/mig29/instrumentation/SPO-15LM/fire", 0);
  setprop("/mig29/instrumentation/PNP-72-12/course", 0);
  setprop("/mig29/instrumentation/KPP/altitude-director", 0);
  setprop("/mig29/instrumentation/KPP/course-director", 0);
}

# Altimetr UV-30-3
# Aug 2011

var bar_altitude_ft = 0;
var bar_altitude_m = 0;

 var alt = func {
  var bar_altitude_ft = getprop("/instrumentation/altimeter/indicated-altitude-ft");
  var bar_altitude_m = (bar_altitude_ft*0.3048);
  setprop("/mig29/instrumentation/UV-30-3/indicated-altitude-m", bar_altitude_m);
  settimer(alt, 0)
}

# Instrument airspeed serviceable

var air_speed = 0;

 var asserv = func{
  var air_speed = getprop("fdm/jsbsim/systems/SVS/airspeed-kmh");
  if (getprop("/mig29/instrumentation/US-1600/serviceable") == 1)
   { setprop("/mig29/instrumentation/US-1600/airspeed-kmh" , air_speed); }
  else { setprop("/mig29/instrumentation/US-1600/airspeed-kmh" , 0); }
  settimer(asserv, 0);
}

# Instrument vertical speed serviceable

var vertical_speed = 0;

 var vsserv = func{
  var vertical_speed = getprop("fdm/jsbsim/systems/SVS/vertical-speed-mps");
  if (getprop("/mig29/instrumentation/DA-200/serviceable") == 1)
   { setprop("/mig29/instrumentation/DA-200/vertical-speed" , vertical_speed); }
  else { setprop("/mig29/instrumentation/DA-200/vertical-speed" , 0); }
  settimer(vsserv, 0);
}

# Altitude in cockpit
# June 2011, Sergey "Mercenary_Mercury" Salov

var outer_altitude = 0;
var inner_altitude = 0;
var diff_altitude = 0;
var germ = 0;

 var aic = func {
  var outer_altitude = getprop("/position/altitude-ft");
  var germ = getprop("fdm/jsbsim/fcs/canopy-germ-norm");
  var outer_altitude = (outer_altitude * 0.304);
  if (outer_altitude > 2000) {var inner_altitude = outer_altitude/2;}
  else {var inner_altitude = outer_altitude;}
  if (germ == 0) {var inner_altitude = outer_altitude;}
  var diff_altitude = outer_altitude/inner_altitude;
  setprop("/mig29/instrumentation/IKZh/altitude", inner_altitude);
   setprop("/mig29/instrumentation/IKZh/altitudeaa", outer_altitude);
  setprop("/mig29/instrumentation/IKZh/P", diff_altitude);
  settimer(aic, 1);
}

# inhs to mmhg

var inhg = 0;
var mmhg = 0;
var mmhg_1 = 0;
var mmhg_2 = 0;
var mmhg_3 = 0;
var mmhg_3a = 0;
var tehg = 0;

var inhg2mmhg = func{
 var inhg = getprop("/instrumentation/altimeter/setting-inhg");
 var mmhg = (inhg * 25.4);
 setprop("/mig29/instrumentation/UV-30-3/raw-mmhg", mmhg);
 var tehg = ((mmhg*10)-int(mmhg*10));
 if (tehg > 0.5) {var mmhg = int(mmhg*10)+1;}
 else {var mmhg = int(mmhg*10);}
 var mmhg = mmhg/10;
 var mmhg_1 = int(mmhg/100);
 var tehg = mmhg-(mmhg_1*100);
 var mmhg_2 = int(tehg/10);
 var tehg = tehg-(mmhg_2*10);
 var mmhg_3a = tehg;
 var mmhg_3 = int(tehg);
 setprop("/instrumentation/altimeter/setting-mmhg", mmhg);
 setprop("/mig29/instrumentation/UV-30-3/setting-mmhg", mmhg);
 setprop("/mig29/instrumentation/UV-30-3/setting-mmhg-1", mmhg_1);
 setprop("/mig29/instrumentation/UV-30-3/setting-mmhg-2", mmhg_2);
 setprop("/mig29/instrumentation/UV-30-3/setting-mmhg-3", mmhg_3);
 setprop("/mig29/instrumentation/UV-30-3/setting-mmhg-3a", mmhg_3a);
 settimer(inhg2mmhg, 0.5)
}

# RV_21.nas
# June 2011, Sergey "Mercenary_Mercury" Salow

var current_altitude_ft = 0;
var current_altitude_m = 0;
var danger_altitude = 0;

 var RV_21 = func {
  if (getprop("/mig29/systems/RV-21/on") == 1 and getprop("/mig29/instrumentation/RV-21/serviceable") == 1)
   {
    var current_altitude_ft = getprop("/fdm/jsbsim/position/h-agl-ft");
    var current_altitude_m = (current_altitude_ft * 0.3048);
    var danger_altitude = getprop("/mig29/instrumentation/RV-21/DAMarker");
    if (getprop("/mig29/systems/RV-21/test") == 0)
     {
      if ( current_altitude_m <= danger_altitude )  { setprop("/mig29/instrumentation/RV-21/danger_altitude", 1); }
      else { setprop("/mig29/instrumentation/RV-21/danger_altitude", 0); }
      if ( current_altitude_m > 1500 ) { setprop("/mig29/instrumentation/RV-21/indicated-altitude-m", 1510); }
      else { setprop("/mig29/instrumentation/RV-21/indicated-altitude-m", current_altitude_m);}
     }
    setprop("/mig29/instrumentation/RV-21/altitude", current_altitude_m);
   }
  settimer(RV_21, 0.0);
}

var RV_21_testt = 0;

 var RV_21_test = func {
  var current_altitude_m = getprop("/mig29/instrumentation/RV-21/altitude");
  var danger_altitude = getprop("/mig29/instrumentation/RV-21/DAMarker");
  if (getprop("/mig29/controls/RV-21/test") == 1 and getprop("/mig29/systems/RV-21/on") == 1 and getprop("/mig29/instrumentation/RV-21/serviceable") == 1)
   {
    if (getprop("/mig29/systems/RV-21/test") == 0) {RV_21_ttb(1);}
    if (current_altitude_m < danger_altitude)
     {
      var RV_21_testt = (danger_altitude-current_altitude_m)*0.002;
      interpolate("/mig29/instrumentation/RV-21/indicated-altitude-m", danger_altitude, RV_21_testt);
     }
    else
     {
      var RV_21_testt = (current_altitude_m-danger_altitude)*0.002;
      interpolate("/mig29/instrumentation/RV-21/indicated-altitude-m", danger_altitude, RV_21_testt);
     }
   }
   if (getprop("/mig29/controls/RV-21/test") == 0 and getprop("/mig29/systems/RV-21/on") == 1 and getprop("/mig29/instrumentation/RV-21/serviceable") == 1)
   {
    if (current_altitude_m < danger_altitude)
     {
      var RV_21_testt = (danger_altitude-current_altitude_m)*0.002;
      interpolate("/mig29/instrumentation/RV-21/indicated-altitude-m", current_altitude_m, RV_21_testt);
      settimer(RV_21_ttb2, RV_21_testt);
     }
    else
     {
      var RV_21_testt = (current_altitude_m-danger_altitude)*0.002;
      interpolate("/mig29/instrumentation/RV-21/indicated-altitude-m", current_altitude_m, RV_21_testt);
      settimer(RV_21_ttb2, RV_21_testt);
     }
   }
}

 var RV_21_ttb = func {
   setprop("/mig29/systems/RV-21/test", 1);
}

 var RV_21_ttb2 = func {
   setprop("/mig29/systems/RV-21/test", 0);
}

var RV_21_dav = 0;

 var RV_21_da = func {
  var RV_21_dav = getprop("/mig29/controls/RV-21/DAMarker");
  if (RV_21_dav <= 150) {setprop("/mig29/instrumentation/RV-21/DAMarker", RV_21_dav);}
  if (RV_21_dav > 150 and RV_21_dav <= 164)       # 150 -> 175
   {
    var RV_21_dav = RV_21_dav-150;
    var RV_21_dav = RV_21_dav*1.785714286;
    setprop("/mig29/instrumentation/RV-21/DAMarker", RV_21_dav+150);
   }
   if (RV_21_dav > 164 and RV_21_dav <= 177)       # 175 -> 200
   {
    var RV_21_dav = RV_21_dav-164;
    var RV_21_dav = RV_21_dav*1.923076923;
    setprop("/mig29/instrumentation/RV-21/DAMarker", RV_21_dav+175);
   }
   if (RV_21_dav > 177 and RV_21_dav <= 194)       # 200 -> 250
   {
    var RV_21_dav = RV_21_dav-177;
    var RV_21_dav = RV_21_dav*2.941176471;
    setprop("/mig29/instrumentation/RV-21/DAMarker", RV_21_dav+200);
   }
   if (RV_21_dav > 194 and RV_21_dav <= 208)       # 250 -> 300
   {
    var RV_21_dav = RV_21_dav-194;
    var RV_21_dav = RV_21_dav*3.571428571;
    setprop("/mig29/instrumentation/RV-21/DAMarker", RV_21_dav+250);
   }
   if (RV_21_dav > 208 and RV_21_dav <= 228)       # 300 -> 400
   {
    var RV_21_dav = RV_21_dav-208;
    var RV_21_dav = RV_21_dav*5;
    setprop("/mig29/instrumentation/RV-21/DAMarker", RV_21_dav+300);
   }
   if (RV_21_dav > 228 and RV_21_dav <= 247)       # 400 -> 500
   {
    var RV_21_dav = RV_21_dav-228;
    var RV_21_dav = RV_21_dav*5.263157895;
    setprop("/mig29/instrumentation/RV-21/DAMarker", RV_21_dav+400);
   }
   if (RV_21_dav > 247 and RV_21_dav <= 253)       # 500 -> 600
   {
    var RV_21_dav = RV_21_dav-247;
    var RV_21_dav = RV_21_dav*16.666666667;
    setprop("/mig29/instrumentation/RV-21/DAMarker", RV_21_dav+500);
   }
   if (RV_21_dav > 253 and RV_21_dav <= 262)       # 600 -> 700
   {
    var RV_21_dav = RV_21_dav-253;
    var RV_21_dav = RV_21_dav*11.111111111;
    setprop("/mig29/instrumentation/RV-21/DAMarker", RV_21_dav+600);
   }
   if (RV_21_dav > 262 and RV_21_dav <= 268)       # 700 -> 800
   {
    var RV_21_dav = RV_21_dav-262;
    var RV_21_dav = RV_21_dav*16.666666667;
    setprop("/mig29/instrumentation/RV-21/DAMarker", RV_21_dav+700);
   }
   if (RV_21_dav > 268 and RV_21_dav <= 273)       # 800 -> 900
   {
    var RV_21_dav = RV_21_dav-268;
    var RV_21_dav = RV_21_dav*20;
    setprop("/mig29/instrumentation/RV-21/DAMarker", RV_21_dav+800);
   }
   if (RV_21_dav > 273 and RV_21_dav <= 278)       # 900 -> 1000
   {
    var RV_21_dav = RV_21_dav-273;
    var RV_21_dav = RV_21_dav*20;
    setprop("/mig29/instrumentation/RV-21/DAMarker", RV_21_dav+900);
   }
   if (RV_21_dav > 278 and RV_21_dav <= 286)       # 1000 -> 1250
   {
    var RV_21_dav = RV_21_dav-278;
    var RV_21_dav = RV_21_dav*31.25;
    setprop("/mig29/instrumentation/RV-21/DAMarker", RV_21_dav+1000);
   }
   if (RV_21_dav > 286 and RV_21_dav <= 291)       # 1250 -> 1500
   {
    var RV_21_dav = RV_21_dav-286;
    var RV_21_dav = RV_21_dav*50;
    setprop("/mig29/instrumentation/RV-21/DAMarker", RV_21_dav+1250);
   }
}

var RV_21_tot = 0;

 var RV_21_t_h = func {
  var RV_21_tot = getprop("/mig29/systems/RV-21/on");
  if (getprop("/mig29/systems/electrical/buses/DC27-bus-bortsyst/volts") > 24 and getprop("/mig29/instrumentation/electrical/v115") > 105)
   {
    if (RV_21_tot == 1) {return;}
    if (RV_21_tot < 1)
     {var RV_21_tot = 1-RV_21_tot; interpolate("/mig29/systems/RV-21/on", 1, RV_21_tot*100);}
   }
  else
   {if (RV_21_tot == 0) {return;}
    if (RV_21_tot > 0)
     {interpolate("/mig29/systems/RV-21/on", 0, RV_21_tot*100);}
   }
}
   
 var RV_21_init = func {
  setprop("/mig29/controls/RV-21/DAMarker", 50);
  setprop("/mig29/controls/RV-21/test", 0);
  setprop("/mig29/instrumentation/RV-21/indicated-altitude-m", 0);
  setprop("/mig29/instrumentation/RV-21/indicated-serviceable", 0);
  setprop("/mig29/instrumentation/RV-21/serviceable", 1);
  setprop("/mig29/systems/RV-21/on", 0);
  setprop("/mig29/systems/RV-21/test", 0);
  setlistener("/mig29/switches/bortsyst", RV_21_t_h);
  setlistener("/mig29/instrumentation/electrical/v27", RV_21_t_h);
  setlistener("/mig29/instrumentation/electrical/v115", RV_21_t_h);
  setlistener("/mig29/controls/RV-21/DAMarker", RV_21_da);
  setlistener("/mig29/controls/RV-21/test", RV_21_test);
}

# Radar-imitation script for SPO-15
# Jule 2011, Sergey "Mercenary_Mercury"

var tower = 0;
var tower_d = 0;
var tower_sh = 0;
var rif_pos_d = 0;
var rif_pos_sh = 0;
var rif_head = 0;
var rif_roll = 0;
var rif_r_d = 0;
var rif_r_sh = 0;
var rif_range = 0;
var rif_azimut = 0;
var atw = 0;

 var rifunc2 = func {
  rif_azimut = getprop("/instrumentation/gps/wp/wp[1]/bearing-true-deg");
  rif_range = getprop("/instrumentation/gps/wp/wp[1]/distance-nm");
if (rif_range > 200) { rif_range = 200.0; }
else {rif_range = (200-rif_range);}
var rif_range = (rif_range/200);
setprop("/mig29/instrumentation/SPO-15LM/range_M-norm", rif_range);
setprop("/mig29/instrumentation/SPO-15LM/azimut_M-norm", rif_azimut);
settimer(rifunc2, 0.5);
}

 var rifunc = func {
if (tower == 0)
 {
  tower = getprop("/sim[0]/tower/airport-id");
  tower_d = getprop("/sim[0]/tower/longitude-deg");
  tower_sh = getprop("/sim[0]/tower/latitude-deg");
 }
var rif_pos_d = getprop("/postion/longitude-deg");
var rif_pos_sh = getprop("/postion/latitude-deg");
var rif_head = getprop("/orientation/heading-deg");
var rif_roll = getprop("/orientation/roll-deg");

if ( tower_d < rif_pos_d) {rif_r_d = (rif_pos_d-tower_d);}
 else {rif_r_d = (tower_d-rif_pos_d);}
var rif_range = (rif_r_d+rif_r_sh);
var rif_range = (rif_range*50);
setprop("/mig29/instrumentation/SPO-15LM/range_M-norm", rif_range);
settimer(rifunc, 0.5);
}

# ARK-19 scripts support

var komp_ant = 0;
var ramka = 0;
var tlg_tlf = 0;

var ARK_volume = 0;

 var ARK_volume_handler = func{
  var ARK_volume = getprop("/mig29/instrumentation/ARK-19/volume");
  if ( getprop("/mig29/instrumentation/electrical/v27") > 24 and getprop("/mig29/instrumentation/electrical/v36") > 34 )
   {
    if ( getprop("/mig29/switches/bortsyst") == 1 ) { setprop("/instrumentation/adf/volume-norm", ARK_volume); }
    else { setprop("/instrumentation/adf/volume-norm", ARK_volume); }
   }
  else { setprop("/instrumentation/adf/volume-norm", ARK_volume); }
}

var ARK_channel = 0;
var ARK_channel_1 = 0;
var ARK_channel_2 = 0;
var ARK_channel_3 = 0;
var ARK_channel_4 = 0;

 var ARK_channel_handler = func{
  var ARK_channel = getprop("/mig29/instrumentation/ARK-19/channel");
  var ARK_channel_1 = getprop("/mig29/instrumentation/ARK-19/channel-1");
  var ARK_channel_2 = getprop("/mig29/instrumentation/ARK-19/channel-2");
  var ARK_channel_3 = getprop("/mig29/instrumentation/ARK-19/channel-3");
  var ARK_channel_4 = getprop("/mig29/instrumentation/ARK-19/channel-4");
  if (ARK_channel == 1) { setprop("/instrumentation/adf/frequencies/selected-khz", ARK_channel_1); }
  if (ARK_channel == 2) { setprop("/instrumentation/adf/frequencies/selected-khz", ARK_channel_2); }
  if (ARK_channel == 3) { setprop("/instrumentation/adf/frequencies/selected-khz", ARK_channel_3); }
  if (ARK_channel == 4) { setprop("/instrumentation/adf/frequencies/selected-khz", ARK_channel_4); }
  if (ARK_channel == 5) { print("P :)"); }
}

 var ARK_init = func{
  setprop("/mig29/instrumentation/ARK-19/channel", 1);
  setprop("/mig29/instrumentation/ARK-19/channel-1", 379);
  setprop("/mig29/instrumentation/ARK-19/channel-2", 341);
  setprop("/mig29/instrumentation/ARK-19/channel-3", 360);
  setprop("/mig29/instrumentation/ARK-19/channel-4", 350);
  setprop("/mig29/instrumentation/ARK-19/komp-ant", 1);
  setprop("/mig29/instrumentation/ARK-19/tlg-tlf", 1);
  setprop("/mig29/instrumentation/ARK-19/ramka", 0);
  setprop("/mig29/instrumentation/ARK-19/volume", 0.6);
  setlistener("/mig29/instrumentation/ARK-19/channel", ARK_channel_handler,0,0 );
  setlistener("/mig29/instrumentation/ARK-19/channel-1", ARK_channel_handler,0,0 );
  setlistener("/mig29/instrumentation/ARK-19/channel-2", ARK_channel_handler,0,0 );
  setlistener("/mig29/instrumentation/ARK-19/channel-3", ARK_channel_handler,0,0 );
  setlistener("/mig29/instrumentation/ARK-19/channel-4", ARK_channel_handler,0,0 );
  setlistener("/mig29/instrumentation/ARK-19/volume", ARK_volume_handler,0,0 );
  setlistener("/mig29/instrumentation/electrical/v27", ARK_volume_handler,0,0 );
}


# UAP g-max 
# September 2011

var cur_ga = 1;
var max_ga = 1;

 var UAP_g_max = func {
  if ( getprop("/mig29/instrumentation/UAP/serviceable") == 1 )
   {
    var cur_ga = getprop("/fdm/jsbsim/accelerations/Nz");
    var max_ga = getprop("/mig29/instrumentation/UAP/pilot-g-max");
    if (cur_ga > max_ga) {setprop("/mig29/instrumentation/UAP/pilot-g-max", cur_ga);}
   }
  settimer(UAP_g_max, 0);
}

# R-862 support scripts

var R862_volume = 0;

# Немного извращено, но работает по второй схеме.
 var R862_volume_handler = func{
  var R862_volume = getprop("/mig29/instrumentation/R-862/volume");
  if ( getprop("/mig29/instrumentation/electrical/v27") > 24 and getprop("/mig29/switches/radio") == 1  )
   {setprop("/instrumentation/comm/volume-norm", R862_volume);}
  else { setprop("/instrumentation/comm/volume-norm", 0); }
}

var R862_channel = 0;
var R862_channel_1 = 0;
var R862_channel_2 = 0;
var R862_channel_3 = 0;
var R862_channel_4 = 0;
var R862_channel_5 = 0;
var R862_channel_6 = 0;
var R862_channel_7 = 0;
var R862_channel_8 = 0;
var R862_channel_9 = 0;
var R862_channel_10 = 0;
var R862_channel_11 = 0;
var R862_channel_12 = 0;
var R862_channel_13 = 0;
var R862_channel_14 = 0;
var R862_channel_15 = 0;
var R862_channel_16 = 0;
var R862_channel_17 = 0;
var R862_channel_18 = 0;
var R862_channel_19 = 0;
var R862_channel_20 = 0;

 var R862_channel_handler = func{
  var R862_channel = getprop("/mig29/instrumentation/R-862/channel");
  var R862_channel_1 = getprop("/mig29/instrumentation/R-862/channel-1");
  var R862_channel_2 = getprop("/mig29/instrumentation/R-862/channel-2");
  var R862_channel_3 = getprop("/mig29/instrumentation/R-862/channel-3");
  var R862_channel_4 = getprop("/mig29/instrumentation/R-862/channel-4");
  var R862_channel_5 = getprop("/mig29/instrumentation/R-862/channel-5");
  var R862_channel_6 = getprop("/mig29/instrumentation/R-862/channel-6");
  var R862_channel_7 = getprop("/mig29/instrumentation/R-862/channel-7");
  var R862_channel_8 = getprop("/mig29/instrumentation/R-862/channel-8");
  var R862_channel_9 = getprop("/mig29/instrumentation/R-862/channel-9");
  var R862_channel_10 = getprop("/mig29/instrumentation/R-862/channel-10");
  var R862_channel_11 = getprop("/mig29/instrumentation/R-862/channel-11");
  var R862_channel_12 = getprop("/mig29/instrumentation/R-862/channel-12");
  var R862_channel_13 = getprop("/mig29/instrumentation/R-862/channel-13");
  var R862_channel_14 = getprop("/mig29/instrumentation/R-862/channel-14");
  var R862_channel_15 = getprop("/mig29/instrumentation/R-862/channel-15");
  var R862_channel_16 = getprop("/mig29/instrumentation/R-862/channel-16");
  var R862_channel_17 = getprop("/mig29/instrumentation/R-862/channel-17");
  var R862_channel_18 = getprop("/mig29/instrumentation/R-862/channel-18");
  var R862_channel_19 = getprop("/mig29/instrumentation/R-862/channel-19");
  var R862_channel_20 = getprop("/mig29/instrumentation/R-862/channel-20");
  if (R862_channel == 1) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_1); }
  if (R862_channel == 2) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_2); }
  if (R862_channel == 3) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_3); }
  if (R862_channel == 4) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_4); }
  if (R862_channel == 5) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_5); }
  if (R862_channel == 6) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_6); }
  if (R862_channel == 7) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_7); }
  if (R862_channel == 8) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_8); }
  if (R862_channel == 9) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_9); }
  if (R862_channel == 10) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_10); }
  if (R862_channel == 11) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_11); }
  if (R862_channel == 12) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_12); }
  if (R862_channel == 13) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_13); }
  if (R862_channel == 14) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_14); }
  if (R862_channel == 15) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_15); }
  if (R862_channel == 16) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_16); }
  if (R862_channel == 17) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_17); }
  if (R862_channel == 18) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_18); }
  if (R862_channel == 19) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_19); }
  if (R862_channel == 20) { setprop("/instrumentation/comm/frequencies/selected-mhz", R862_channel_20); }
}

 var R862_init = func{
  setprop("/mig29/instrumentation/R-862/channel", 1);
  setprop("/mig29/instrumentation/R-862/channel-1", 120.50);
  setprop("/mig29/instrumentation/R-862/channel-2", 118.85);
  setprop("/mig29/instrumentation/R-862/channel-3", 118.30);
  setprop("/mig29/instrumentation/R-862/channel-4", 133.775);
  setprop("/mig29/instrumentation/R-862/channel-5", 120);
  setprop("/mig29/instrumentation/R-862/channel-6", 120);
  setprop("/mig29/instrumentation/R-862/channel-7", 120);
  setprop("/mig29/instrumentation/R-862/channel-8", 120);
  setprop("/mig29/instrumentation/R-862/channel-9", 120);
  setprop("/mig29/instrumentation/R-862/channel-10", 120);
  setprop("/mig29/instrumentation/R-862/channel-11", 120);
  setprop("/mig29/instrumentation/R-862/channel-12", 120);
  setprop("/mig29/instrumentation/R-862/channel-13", 120);
  setprop("/mig29/instrumentation/R-862/channel-14", 120);
  setprop("/mig29/instrumentation/R-862/channel-15", 120);
  setprop("/mig29/instrumentation/R-862/channel-16", 120);
  setprop("/mig29/instrumentation/R-862/channel-17", 130);
  setprop("/mig29/instrumentation/R-862/channel-18", 130);
  setprop("/mig29/instrumentation/R-862/channel-19", 130);
  setprop("/mig29/instrumentation/R-862/channel-20", 130);
  setprop("/mig29/instrumentation/R-862/PSh", 1);
  setprop("/mig29/instrumentation/R-862/AP", 0);
  setprop("/mig29/instrumentation/R-862/RK", 0);
  setprop("/mig29/instrumentation/R-862/AMFM", 0);
  setprop("/mig29/instrumentation/R-862/volume", 0.6);
  setlistener("/mig29/instrumentation/R-862/channel", R862_channel_handler,0,0 );
  setlistener("/mig29/instrumentation/R-862/volume", R862_volume_handler,0,0 );
}

# ИП-52

var gear1midpos = 0;
var gear2midpos = 0;
var gear3midpos = 0;

 var IP_52_handler = func {
  if (getprop("/gear/gear[0]/position-norm") > 0 and getprop("/gear/gear[0]/position-norm") < 1)
   { setprop("/mig29/instrumentation/IP-52/rl", 1); }
  else { setprop("/mig29/instrumentation/IP-52/rl", 0); }
  if (getprop("/gear/gear[1]/position-norm") > 0 and getprop("/gear/gear[1]/position-norm") < 1)
   { setprop("/mig29/instrumentation/IP-52/rl", 1); }
  else { setprop("/mig29/instrumentation/IP-52/rl", 0); }
  if (getprop("/gear/gear[2]/position-norm") > 0 and getprop("/gear/gear[2]/position-norm") < 1)
   { setprop("/mig29/instrumentation/IP-52/rl", 1); }
  else { setprop("/mig29/instrumentation/IP-52/rl", 0); }
}

 var IP_52_init = func {
  setprop("/mig29/instrumentation/IP-52/rl", 0);
  setlistener("/gear/gear[0]/position-norm", IP_52_handler,0,0 );
  setlistener("/gear/gear[1]/position-norm", IP_52_handler,0,0 );
  setlistener("/gear/gear[2]/position-norm", IP_52_handler,0,0 );
}

# ИКГ-1

var IKGserv1 = 0;
var IKGserv2 = 0;
var IKGserv3 = 0;
var IKGserv4 = 0;

 var IKGserv = func {
  var IKGserv3 = getprop("fdm/jsbsim/systems/PS/OVS_cap");
  var IKGserv4 = getprop("fdm/jsbsim/systems/PS/AVS_cap");
  setprop("/mig29/instrumentation/IKG/main", (IKGserv3*7.5));
  setprop("/mig29/instrumentation/IKG/emergency", (IKGserv4*1.5));
}

 var IKGserv_init = func {
  setprop("/mig29/instrumentation/IKG/main", 150);
  setprop("/mig29/instrumentation/IKG/emergency", 150);
  setlistener("fdm/jsbsim/systems/PS/OVS_cap", IKGserv,0,0 );
  setlistener("fdm/jsbsim/systems/PS/AVS_cap", IKGserv,0,0 );
}

# ИКЖ-1

var IKZhserv1 = 0;

 var IKZhserv = func {
  if (getprop("/mig29/instrumentation/electrical/v115") > 100)
   {
    var IKZhserv1 = getprop("/mig29/systems/oxygensystem/reserve")+(getprop("/mig29/systems/oxygensystem/emerg_reserve")*0.1);
    setprop("/mig29/instrumentation/IKZh/o2_reserve", IKZhserv1);
    setprop("/mig29/instrumentation/IKZh/o2_feed", getprop("/mig29/systems/oxygensystem/feed"));
   }
}

 var IKZhserv_init = func {
  setprop("/mig29/instrumentation/IKZh/o2_reserve", 110);
  setprop("/mig29/instrumentation/IKZh/o2_feed", 0);
  setlistener("/mig29/systems/oxygensystem/reserve", IKZhserv,0,0 );
  setlistener("/mig29/systems/oxygensystem/emerg_reserve", IKZhserv,0,0 );
  setlistener("/mig29/systems/oxygensystem/feed", IKZhserv,0,0 );
}

# ИПК
# Хвост :) <!-- 0-  5, 100 - +105 (110) , ВП - +14 (124) -->1.438679245 0,695081967 0.787759563 0.303942652

var IPKL = 0;
var IPKR = 0;
var IPKLs = 0;
var IPKRs = 0;

 var IPKserv = func {
  var IPKL = getprop("fdm/jsbsim/systems/intake/pos-left");
  var IPKR = getprop("fdm/jsbsim/systems/intake/pos-right");
  if (IPKL > 1)
   {
    var IPKLs = IPKL-1.0;
    var IPKLs = ((IPKLs*0.29)+0.859375);
   }
  else { var IPKLs = ((IPKL*0.8203125)+0.0390625) }
  if (IPKR > 1)
   {
    var IPKRs = IPKR-1.0;
    var IPKRs = ((IPKRs*0.29)+0.859375);
   }
  else { var IPKRs = ((IPKR*0.8203125)+0.0390625) }
  setprop("/mig29/instrumentation/IPK/pos-left", IPKLs);
  setprop("/mig29/instrumentation/IPK/pos-right", IPKRs);
}

 var IPKserv_init = func {
  setprop("/mig29/instrumentation/IPK/pos-left", 0.0390625);
  setprop("/mig29/instrumentation/IPK/pos-right", 0.0390625);
  setlistener("fdm/jsbsim/systems/intake/pos-left", IPKserv,0,0 );
  setlistener("fdm/jsbsim/systems/intake/pos-right", IPKserv,0,0 );
}

# ПНП-72-12

# АРК -> ПНП :)

var ARK_bearing = 0;
var PNP_heading = 0;
var RC_bearing = 0;
var RSBN_bearing = 0;

 var PNP_bearing = func {
  if ( getprop("/mig29/systems/PNP-72-12/on") == 1 and getprop("/mig29/instrumentation/PNP-72-12/serviceable") == 1)
   {
    var PNP_heading = getprop("/mig29/instrumentation/PNP-72-12/heading-indicated-deg");
    var ARK_bearing = getprop("/instrumentation/adf/indicated-bearing-deg");
    var RSBN_bearing = getprop("/instrumentation/nav/heading-deg");
    if (getprop("/mig29/systems/TsVU/kur") == 1 and getprop("/mig29/systems/TsVU/landing") == 0)
     {var RC_bearing = RSBN_bearing-PNP_heading;}
    else {var RC_bearing = ARK_bearing-PNP_heading;}
    setprop("/mig29/instrumentation/PNP-72-12/bearing-indicated-deg", RC_bearing);
   }
  settimer(PNP_bearing, 0);
}

var PNP_SC = 0;
var PNP_SCc = 0;

 var PNP_SCf = func {
  if ( getprop("/mig29/systems/PNP-72-12/on") == 1 and getprop("/mig29/instrumentation/PNP-72-12/serviceable") == 1)
   {
    var PNP_heading = getprop("/mig29/instrumentation/PNP-72-12/heading-indicated-deg");
    var PNP_SCc = getprop("/mig29/instrumentation/PNP-72-12/ZPU");
    var PNP_SC = PNP_heading-PNP_SCc;
    setprop("/mig29/instrumentation/PNP-72-12/course", PNP_SC);
   }
  settimer(PNP_SCf, 0);
}

var PNP_distance = 0;
var PNP_distance_100 = 0;
var PNP_distance_10 = 0;
var PNP_distance_1 = 0;

 var PNP_dist = func {
  if (getprop("/mig29/systems/PNP-72-12/on") == 0) {return;}
  if (getprop("/mig29/systems/TsVU/landing") == 0) {var PNP_distance = getprop("/mig29/systems/TsVU/distance");}
  else {var PNP_distance = getprop("/mig29/systems/TsVU/Ldist");}
  if (PNP_distance < 1000)
   {
    if (PNP_distance < 100) {var PNP_distance_100 = 0;}
    else {var PNP_distance_100 = int((PNP_distance/100))}
    if (PNP_distance < 10) {var PNP_distance_10 = 0;}
    else {var PNP_distance_10 = (int((PNP_distance/10))-(PNP_distance_100*10))}
    if (PNP_distance < 1) {var PNP_distance_1 = 0;}
    else {var PNP_distance_1 = (int(PNP_distance)-((PNP_distance_100*100)+(PNP_distance_10*10)))}
   }
  else
   {
    var PNP_distance_100 = 9;
    var PNP_distance_10 = 9;
    var PNP_distance_1 = 9;
   }
  setprop("/mig29/instrumentation/PNP-72-12/dist_100", PNP_distance_100);
  setprop("/mig29/instrumentation/PNP-72-12/dist_10", PNP_distance_10);
  setprop("/mig29/instrumentation/PNP-72-12/dist_1", PNP_distance_1);
}

var PNP_ZPU = 0;
var PNP_ZPU_100 = 0;
var PNP_ZPU_10 = 0;
var PNP_ZPU_1 = 0;

 var PNP_ZPUi = func {
  if (getprop("/mig29/systems/PNP-72-12/on") == 1)
   {
    if (getprop("/mig29/controls/SN/kurs_zadan") == 0) {var PNP_ZPU = getprop("/mig29/systems/PNP-72-12/ZPU");}
    if (getprop("/mig29/controls/SN/kurs_zadan") == 1) {var PNP_ZPU = getprop("/mig29/systems/TsVU/OPU");}
    if (PNP_ZPU < 100) {var PNP_ZPU_100 = 0;}
    else {var PNP_ZPU_100 = int((PNP_ZPU/100))}
    if (PNP_ZPU < 10) {var PNP_ZPU_10 = 0;}
    else {var PNP_ZPU_10 = (int((PNP_ZPU/10))-(PNP_ZPU_100*10))}
    if (PNP_ZPU < 1) {var PNP_ZPU_1 = 0;}
    else {var PNP_ZPU_1 = (int(PNP_ZPU)-((PNP_ZPU_100*100)+(PNP_ZPU_10*10)))}
    setprop("/mig29/instrumentation/PNP-72-12/ZPU_100", PNP_ZPU_100);
    setprop("/mig29/instrumentation/PNP-72-12/ZPU_10", PNP_ZPU_10);
    setprop("/mig29/instrumentation/PNP-72-12/ZPU_1", PNP_ZPU_1);
    setprop("/mig29/instrumentation/PNP-72-12/ZPU", PNP_ZPU);
   }
  settimer(PNP_ZPUi, 0);
}

 var PNP_oKGRMi = func {
  if (getprop("/mig29/systems/PNP-72-12/on") == 1 and getprop("/mig29/systems/TsVU/landing") == 1)
   {
    if (getprop("/mig29/systems/SAU/traek_upr") != 0)
     {
      setprop("/mig29/instrumentation/PNP-72-12/oKRM", getprop("fdm/jsbsim/ap/heading-needle-deflection-ils"));
      setprop("/mig29/instrumentation/PNP-72-12/oGRM", getprop("fdm/jsbsim/ap/gs-needle-deflection"));
     }
    else
     {
      setprop("/mig29/instrumentation/PNP-72-12/oKRM", 0);
      setprop("/mig29/instrumentation/PNP-72-12/oGRM", 0);
     }
   }
}

 var PNP_on = func {
  if ( getprop("/mig29/instrumentation/electrical/v27") > 24 and getprop("/mig29/instrumentation/electrical/v36") > 34 )
  { setprop("/mig29/systems/PNP-72-12/on", 1); }
  else { setprop("/mig29/systems/PNP-72-12/on", 0); }
}

 var PNP_init = func {
  setprop("/mig29/instrumentation/PNP-72-12/ZPU", 0);
  setprop("/mig29/controls/PNP-72-12/test", 0);
  setprop("/mig29/controls/PNP-72-12/ZPU", 0);
  setprop("/mig29/instrumentation/PNP-72-12/course", 0);
  setprop("/mig29/instrumentation/PNP-72-12/bearing-indicated-deg", 0);
  setprop("/mig29/instrumentation/PNP-72-12/serviceable", 1);
  setprop("/mig29/systems/PNP-72-12/on", 0);
  setlistener("/mig29/instrumentation/electrical/v27", PNP_on);
  setlistener("/mig29/instrumentation/electrical/v36", PNP_on);
  PNP_SCf();
  PNP_bearing();
  setlistener("/mig29/systems/TsVU/distance", PNP_dist);
  setlistener("/mig29/systems/TsVU/Ldist", PNP_dist);
  PNP_ZPUi();
}

# Маркерный радиоприёмник

 var RPM_sa_handler = func {
  if (getprop("/mig29/instrumentation/RPM/serviceable") == 1)
   {setprop("/instrumentation/marker-beacon/serviceable", 1);}
  else {setprop("/instrumentation/marker-beacon/serviceable", 0);}
}

 var RPM_on_handler = func {
  if (getprop("/mig29/systems/RPM/on") == 1)
   {setprop("/instrumentation/marker-beacon/power-btn", 1);}
  else {setprop("/instrumentation/marker-beacon/power-btn", 0);}
}

 var RPM_beacon_handler = func {
  print("45hdf");
  if (getprop("/mig29/systems/RPM/on") == 1 and getprop("/mig29/instrumentation/RPM/serviceable") == 1)
  {
   if (getprop("/instrumentation/marker-beacon/middle") == 1 ) {setprop("/mig29/instrumentation/RPM/BPRM", 1); setprop("/mig29/instrumentation/RPM/marker", 1);}
   else {setprop("/mig29/instrumentation/RPM/BPRM", 0); setprop("/mig29/instrumentation/RPM/marker", 0);}
   if (getprop("/instrumentation/marker-beacon/outer") == 1 ) {setprop("/mig29/instrumentation/RPM/DPRM", 1); setprop("/mig29/instrumentation/RPM/marker", 1);}
   else {setprop("/mig29/instrumentation/RPM/DPRM", 0); setprop("/mig29/instrumentation/RPM/marker", 0);}
  }
  else { setprop("/mig29/instrumentation/RPM/DPRM", 0); setprop("/mig29/instrumentation/RPM/BPRM", 0); setprop("/mig29/instrumentation/RPM/marker", 0); }
}

 var RPM_saon = func {
  if (getprop("/mig29/instrumentation/electrical/v27") > 24 and getprop("/mig29/instrumentation/electrical/v115") > 110 and getprop("/mig29/switches/bortsyst") == 1)
  {setprop("/mig29/systems/RPM/on", 1); setprop("/mig29/instrumentation/RPM/serviceable", 1);}
  else {setprop("/mig29/systems/RPM/on", 0); setprop("/mig29/instrumentation/RPM/serviceable", 0);}
}

 var RPM_init = func {
  setprop("/mig29/systems/RPM/on", 0);
  setprop("/mig29/instrumentation/RPM/serviceable", 1);
  setprop("/mig29/instrumentation/RPM/DPRM", 0);
  setprop("/mig29/instrumentation/RPM/BPRM", 0);
  setprop("/mig29/instrumentation/RPM/marker", 0);
  setlistener("/mig29/systems/RPM/on", RPM_on_handler);
  setlistener("/mig29/instrumentation/RPM/serviceable", RPM_sa_handler);
  setlistener("/instrumentation/marker-beacon/middle", RPM_beacon_handler);
  setlistener("/instrumentation/marker-beacon/outer", RPM_beacon_handler);
  setlistener("/mig29/instrumentation/electrical/v27", RPM_saon);
  setlistener("/mig29/instrumentation/electrical/v115", RPM_saon);
  setlistener("/mig29/switches/bortsyst", RPM_saon);
}

# ИСТР

var ISTRv = 0;

 var ISTR = func {
  var ISTRv = getprop("/fdm/jsbsim/systems/fuel/total-fuel-kg");
  setprop("/mig29/instrumentation/ISTR4-2/total-fuel-kg", ISTRv);
  if (ISTRv > 4000) {setprop("/mig29/instrumentation/ISTR4-2/total-fuel-kg-t", 4000);}
  else {setprop("/mig29/instrumentation/ISTR4-2/total-fuel-kg-t", ISTRv);}
  var ISTRv = getprop("/consumables/fuel/tank[1]/level-kg");
  if (ISTRv > 550)
   {setprop("/mig29/instrumentation/ISTR4-2/tank-2-kg", 550);}
  else {setprop("/mig29/instrumentation/ISTR4-2/tank-2-kg", ISTRv);}
  settimer(ISTR, 0.1);
}

 var ISTR_init = func {
  setprop("/mig29/instrumentation/ISTR4-2/total-fuel-kg", 0);
  setprop("/mig29/instrumentation/ISTR4-2/total-fuel-kg-t", 0);
  ISTR();
}

var KPP_tH = 0;
var KPP_oZPU = 0;

 var KPP_oZPUi = func {
  if (getprop("/mig29/systems/SEI-31/on") == 1)
   {
    if ((getprop("/mig29/systems/TsVU/navigation")+getprop("/mig29/systems/TsVU/return")+getprop("/mig29/systems/TsVU/landing")) > 0)
     {
      var KPP_Th = getprop("/mig29/instrumentation/PNP-72-12/heading-indicated-deg");
      if (getprop("/mig29/controls/SN/kurs_zadan") == 0) {var KPP_oZPU = getprop("/mig29/systems/PNP-72-12/ZPU");}
      if (getprop("/mig29/controls/SN/kurs_zadan") == 1 and getprop("/mig29/systems/TsVU/landing") == 0)
       {var KPP_oZPU = getprop("/mig29/systems/TsVU/OPU");}
      if (getprop("/mig29/controls/SN/kurs_zadan") == 1 and getprop("/mig29/systems/TsVU/landing") == 1)
       {var KPP_oZPU = getprop("/instrumentation/nav/heading-deg");}
      var KPP_oZPU = KPP_oZPU-KPP_Th;
      if (KPP_oZPU > 180) {var KPP_oZPU = 360-KPP_oZPU;}
      if (KPP_oZPU < -180) {var KPP_oZPU = 360+KPP_oZPU;}
      if (KPP_oZPU < -5) {var KPP_oZPU = -5;}
      if (KPP_oZPU > 5) {var KPP_oZPU = 5;}
      var KPP_oZPU = KPP_oZPU/5;
      setprop("/mig29/instrumentation/KPP/course-director", KPP_oZPU);
     } 
    else {setprop("/mig29/instrumentation/KPP/course-director", 0);}
   }
  settimer(KPP_oZPUi, 0);
}

#

var LTTsC = 0;
var LTTsC1 = 0;
var LTTsC2 = 0;
 
 var LTTsCounter = func {
  var LTTsC = getprop("/ai/submodels/submodel[2]/count")+getprop("/ai/submodels/submodel[2]/count");
  var LTTsC1 = int((LTTsC/10));
  var LTTsC2 = LTTsC-(LTTsC1*10);
  setprop("/mig29/instrumentation/LTTs/count1", LTTsC1);
  setprop("/mig29/instrumentation/LTTs/count2", LTTsC2);
  settimer(LTTsCounter, 0);
}

# Часы АЧС-1М(Н)

 var LGCh = func {
  if (getprop("/mig29/controls/AChS-1/FL1") == 0)
   {
    if (getprop("/mig29/controls/AChS-1/FL2") == 1 and getprop("/mig29/instrumentation/AChS-1/FL2") == 0)
     {setprop("/mig29/instrumentation/AChS-1/FL2", 1);}
    else if (getprop("/mig29/controls/AChS-1/FL2") == 1 and getprop("/mig29/instrumentation/AChS-1/FL2") == 1)
     {setprop("/mig29/instrumentation/AChS-1/FL2", 2);}
    else if (getprop("/mig29/controls/AChS-1/FL2") == 1 and getprop("/mig29/instrumentation/AChS-1/FL2") == 2)
     {setprop("/mig29/instrumentation/AChS-1/FL2", 0);}
   }
#  else {}
}
