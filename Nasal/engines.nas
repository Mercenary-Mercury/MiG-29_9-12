# engines.nas
# Engines support scripts
# May 2011, Sergey "Mercenary_Mercury" Salow

var Ln2 = 0;
var Rn2 = 0;
var GTDEn2 = 0;
var espz = 0;
var startbut = 0;
var ess = 0;    # Запускаемый двигатель, 0 - левый, 1 - оба, 2 - правый.

 var start_engine = func{
  var espz = getprop("mig29/controls/engines/espz");
  var ess = getprop("mig29/controls/engines/engine_start_select");
  var startbut = getprop("mig29/controls/engines/start");
  if (getprop("mig29/systems/electrical/buses/AC3x200-bus-engine-systems/volts") > 195)
   {
    if (espz == 0 and startbut == 1 and getprop("mig29/switches/engine_systems") == 1)
     { Start_GTDE(); print("GTDE start."); }
    if (espz == 1 and startbut == 1 and getprop("mig29/switches/engine_systems") == 1)
     {
      if (ess == 0) {setprop("/mig29/systems/engines/SEC", 1); StartEngine_CmdFunc();}
      if (ess == 1) {setprop("/mig29/systems/engines/SEC", 2); StartEngine_CmdFunc();}
      if (ess == 2) {setprop("/mig29/systems/engines/SEC", 3); StartEngine_CmdFunc();}
     }
    if (espz == 2 and startbut == 1 and getprop("mig29/switches/engine_systems") == 1)
     { GTDE_DryStarting(); }
    if (espz == 3 and startbut == 1 and getprop("mig29/switches/engine_systems") == 1)
     {
      if (ess == 0) { LeftEngineDryStarting(); }
      if (ess == 2) { RightEngineDryStarting(); }
      if (ess == 1)
      {
       settimer(StartLeftEngineOG, 0.3);
       StartRightEngineOG();
      }
     }
    if (startbut == 1 and getprop("mig29/systems/engines/s") == 0) {setprop("mig29/systems/engines/s", 1);}
    }
}

 var InitEngs = func {
  setlistener("mig29/controls/engines/start", start_engine,0,0);
  EFLeft();
  EFRight();
  espz_init();
  edafb_init();
  sia_init();
  throttlecmdhandler_init();
  erpm();
  ASLREIA_init();
  print("Engines systems init");
  setprop("mig29/systems/engines/s", 0);
  ESLeft_f();
  ESRight_f();
  ESGTDE_f();
  ESmLeft_f();
  ESmRight_f();
}

var SECF_cmd = 0;

 var StartEngine_CmdFunc = func {
  var SECF_cmd = getprop("/mig29/systems/engines/SEC");
  if (SECF_cmd == 1)
   {
    if (getprop("/engines/engine[2]/n2") < 0.01) {Start_GTDE();}
    if (getprop("/engines/engine[2]/n2") > 10 and getprop("/engines/engine[0]/n2") == 0) {StartLeftEngineOG();}
   }
  if (SECF_cmd == 2)
   {
    if (getprop("/engines/engine[2]/n2") < 0.01) {Start_GTDE();}
    if (getprop("/engines/engine[2]/n2") > 10 and getprop("/engines/engine[1]/n2") == 0) {StartRightEngineOG();}
    if (getprop("/engines/engine[0]/n2") == 0 and getprop("/engines/engine[1]/running") == 1) {StartLeftEngineOG();}
   }
  if (SECF_cmd == 3)
   {
    if (getprop("/engines/engine[2]/n2") < 0.01) {Start_GTDE();}
    if (getprop("/engines/engine[2]/n2") > 10 and getprop("/engines/engine[1]/n2") == 0) {StartRightEngineOG();}
   }
  if (getprop("/engines/engine[0]/running") == 1 and getprop("/engines/engine[1]/running") == 1 and getprop("/engines/engine[2]/running") == 1)
   {Stop_GTDE(); return;}
  settimer(StartEngine_CmdFunc, 0.2);
}

# Запуск левого двигателя на земле
 var StartLeftEngineOG = func {
  if ( getprop("fdm/jsbsim/fcs/throttle-cmd-norm[0]") > 0.0685 )
   {
    var Ln2 = getprop("/engines/engine/n2");
    if (getprop("/controls/engines/engine/cutoff") == 0 and Ln2 < 25) {setprop("/controls/engines/engine/cutoff", 1);}
    if (getprop("/controls/engines/engine/cutoff") == 1 and Ln2 > 25) {setprop("/controls/engines/engine/cutoff", 0);}
    if (Ln2 < 0.1) {setprop("/controls/engines/engine/starter", 1);}
    if (Ln2 < 36 and getprop("/controls/engines/engine/starter") == 1) {setprop("mig29/systems/engines/start_left", 1);}
    else {setprop("mig29/systems/engines/start_left", 0);}
    if (getprop("fdm/jsbsim/propulsion/engine[0]/set-running") == 1) {print("Left engine is running."); return;}
    settimer(StartLeftEngineOG, 0);
   }
}

# Запуск правого двигателя на земле
 var StartRightEngineOG = func {
  if ( getprop("fdm/jsbsim/fcs/throttle-cmd-norm[1]") > 0.0685 )
   {
    var Rn2 = getprop("/engines/engine[1]/n2");
    if (getprop("/controls/engines/engine[1]/cutoff") == 0 and Rn2 < 25) {setprop("/controls/engines/engine[1]/cutoff", 1);}
    if (getprop("/controls/engines/engine[1]/cutoff") == 1 and Rn2 > 25) {setprop("/controls/engines/engine[1]/cutoff", 0);}
    if (Rn2 < 0.1) { setprop("/controls/engines/engine[1]/starter", 1);}
    if (Rn2 < 36 and getprop("/controls/engines/engine[1]/starter") == 1) {setprop("mig29/systems/engines/start_right", 1);}
    else {setprop("mig29/systems/engines/start_right", 0);}
    if (getprop("fdm/jsbsim/propulsion/engine[1]/set-running") == 1) { print("Right engine is running."); return;}
    settimer(StartRightEngineOG, 0);
   }
}

# Запуск ГТДЭ
 var Start_GTDE = func {
  var GTDEn2 = getprop("/engines/engine[2]/n2");
  if (getprop("/controls/engines/engine[2]/cutoff") == 0 and GTDEn2 < 25) {setprop("/controls/engines/engine[2]/cutoff", 1);}
  if (getprop("/controls/engines/engine[2]/cutoff") == 1 and GTDEn2 > 25) {setprop("/controls/engines/engine[2]/cutoff", 0);}
  if (GTDEn2 < 0.1) {setprop("/controls/engines/engine[2]/starter", 1);}
  if (getprop("fdm/jsbsim/propulsion/engine[2]/set-running") == 1) {print("GTDE is running."); return;}
  settimer(Start_GTDE, 0);
}

# Запуск левого двигателя в воздухе
 var StartLeftEngineIA = func {
  if (getprop("fdm/jsbsim/fcs/throttle-cmd-norm[0]") > 0.0685 and getprop("/engines/engine[0]/n2") < 50)
   {
    if (getprop("/controls/engines/engine/cutoff") == 1) {setprop("/controls/engines/engine[0]/cutoff", 0);}
   }
  if (getprop("/controls/engines/engine/cutoff") == 0 and getprop("/engines/engine[0]/n2") < 67.5) {setprop("mig29/systems/engines/start_left", 1);}
  if (getprop("/engines/engine[0]/n2") > 67.45) {setprop("mig29/systems/engines/start_left", 0); return;}
  settimer(StartLeftEngineIA, 0);
}

# Запуск правого двигателя в воздухе
 var StartRightEngineIA = func {
  if (getprop("fdm/jsbsim/fcs/throttle-cmd-norm[1]") > 0.0685 and getprop("/engines/engine[1]/n2") < 50)
   {
    if (getprop("/controls/engines/engine[1]/cutoff") == 1) {setprop("/controls/engines/engine[1]/cutoff", 0);}
   }
  if (getprop("/controls/engines/engine[1]/cutoff") == 0 and getprop("/engines/engine[1]/n2") < 67.5) {setprop("mig29/systems/engines/start_right", 1);}
  if (getprop("/engines/engine[1]/n2") > 67.45) {setprop("mig29/systems/engines/start_right", 0); return;}
  settimer(StartRightEngineIA, 0);
}

# Автоматический запуск в воздухе

 var ASLEIA = func {
  if (getprop("/engines/engine[0]/n2") < 70 and getprop("/gear/gear[1]/wow") == 0 and getprop("mig29/systems/engines/start_left") == 0)
   {StartLeftEngineIA();}
}

 var ASREIA = func {
  if (getprop("/engines/engine[1]/n2") < 70 and getprop("/gear/gear[2]/wow") == 0 and getprop("mig29/systems/engines/start_right") == 0)
   {StartRightEngineIA();}
}

 var ASLREIA_init = func {
  setprop("mig29/systems/engines/start_left", 0);
  setprop("mig29/systems/engines/start_right", 0);
  setlistener("/engines/engine[0]/n2", ASLEIA);
  setlistener("/engines/engine[1]/n2", ASREIA);
}

 var LeftEngineDryStarting = func {
  var Ln2 = getprop("/engines/engine/n2");
  setprop("/controls/engines/engine/cutoff", 1);
  if ( Ln2 == 0 ) { setprop("/controls/engines/engine/starter", 1); }
  else { setprop("/controls/engines/engine/starter", 0); return; }
  settimer(LeftEngineDryStarting, 15);
}

 var RightEngineDryStarting = func {
  var Rn2 = getprop("/engines/engine[1]/n2");
  setprop("/controls/engines/engine[1]/cutoff", 1);
  if ( Rn2 == 0 ) { setprop("/controls/engines/engine[1]/starter", 1); }
  else { setprop("/controls/engines/engine[1]/starter", 0); return; }
  settimer(RightEngineDryStarting, 15);
}

 var GTDE_DryStarting = func {
  var GTDEn2 = getprop("/engines/engine[2]/n2");
  setprop("/controls/engines/engine[2]/cutoff", 1);
  if ( GTDEn2 == 0 ) { setprop("/controls/engines/engine[2]/starter", 1); }
  else { setprop("/controls/engines/engine[2]/starter", 0); return; }
  settimer(GTDE_DryStarting, 15);
}

 var Stop_LeftEngine = func {
  if (getprop("mig29/systems/engines/Lpos") == 1)
  {setprop("/controls/engines/engine[0]/cutoff", 1);}
}

 var Stop_RightEngine = func {
  setprop("/controls/engines/engine[1]/cutoff", 1);
}

 var Stop_GTDE = func {
  setprop("/controls/engines/engine[2]/cutoff", 1);
}

var rpmL = 0;
var rpmR = 0;
var rpmG = 0;

 var erpm = func {
  var rpmL = getprop("/engines/engine[0]/n2");
  var rpmR = getprop("/engines/engine[1]/n2");
  var rpmG = getprop("/engines/engine[2]/n2");
  if ( rpmL > rpmR and rpmL > rpmG ) { setprop("mig29/systems/engines/n2", rpmL); }
  if ( rpmR > rpmL and rpmR > rpmG ) { setprop("mig29/systems/engines/n2", rpmR); }
  if ( rpmG > rpmL and rpmG > rpmR ) { setprop("mig29/systems/engines/n2", rpmG); }
  settimer(erpm, 0.0);
}

#engines/engine[0]/fuel-flow-pph
#engines/engine[0]/n2
#engines/engine[0]/augmentation

var EFLeftn2 = 0;
var EFLeftFF = 0;
var EFLeftAug = 0;
var EFLeftNozzle = 0;
var EFLeftJF_pos = 0;
var EFRightn2 = 0;
var EFRightFF = 0;
var EFRightAug = 0;
var EFRightJF_pos = 0;

 var EFLeft = func {
  var EFLeftn2 = getprop("engines/engine[0]/n2");
  var EFLeftAug = getprop("engines/engine[0]/augmentation");
  var EFLeftNozzle = getprop("engines/engine[0]/nozzle-pos-norm");
   if (EFLeftAug == 1) { EFLeftJF_pos = EFLeftNozzle; }
    else { EFLeftJF_pos = 0; }
  setprop("mig29/systems/engines/jetflameleft-pos", EFLeftJF_pos);
  settimer(EFLeft, 0.1);
}

 var EFRight = func {
  var EFRightn2 = getprop("engines/engine[1]/n2");
  var EFRightAug = getprop("engines/engine[1]/augmentation");
  var EFRightNozzle = getprop("engines/engine[1]/nozzle-pos-norm");
  if (EFRightAug == 1) { EFRightJF_pos = EFRightNozzle; }
   else { EFRightJF_pos = 0; }
  setprop("mig29/systems/engines/jetflameright-pos", EFRightJF_pos);
  settimer(EFRight, 0.1);
}

# Обработчики положения РУДов

var t1cmd = 0;
var t1cmd2 = 0;
var t2cmd = 0;
var t2cmd2 = 0;

 var throttle1cmd_handler = func {
  var t1cmd = getprop("fdm/jsbsim/fcs/throttle-cmd-norm[0]");
  var t1cmd2 = getprop("mig29/systems/engines/Lpos");
  if (t1cmd == 0.0)
   {
    if (t1cmd2 < 1 or t1cmd2 > 1) {setprop("mig29/systems/engines/Lpos", 1); Stop_LeftEngine();}
   }
  if (t1cmd > 0.0 and t1cmd < 0.0685) {setprop("mig29/systems/engines/Lpos", 0);}
  if (t1cmd > 0.0685 and t1cmd < 0.072)
   {
    if (t1cmd2 < 2 or t1cmd2 > 2) {setprop("mig29/systems/engines/Lpos", 2);}
   }
  if (t1cmd > 0.072 and t1cmd < 0.829) {setprop("mig29/systems/engines/Lpos", 0);}
  if (t1cmd > 0.829 and t1cmd < 0.831)
   {
    if (t1cmd2 < 3 or t1cmd2 > 3) {setprop("mig29/systems/engines/Lpos", 3);}
   }
  if (t1cmd > 0.831 and t1cmd < 0.85) {setprop("mig29/systems/engines/Lpos", 0);}
  if (t1cmd > 0.875 and t1cmd < 0.885)
   {
    if (t1cmd2 < 4 or t1cmd2 > 4) {setprop("mig29/systems/engines/Lpos", 4);}
   }
  if (t1cmd > 0.885 and t1cmd < 1.0) {setprop("mig29/systems/engines/Lpos", 0);}
  if (t1cmd == 1.0)
   {
    if (t1cmd2 < 5 or t1cmd2 > 5) {setprop("mig29/systems/engines/Lpos", 5);}
   }
  settimer(throttle1cmd_handler, 0);
}
 var throttle2cmd_handler = func {
  var t2cmd = getprop("fdm/jsbsim/fcs/throttle-cmd-norm[1]");
  var t2cmd2 = getprop("mig29/systems/engines/Rpos");
  if (t2cmd == 0.0)
   {
    if (t2cmd2 < 1 or t2cmd2 > 1) {setprop("mig29/systems/engines/Rpos", 1); Stop_RightEngine();}
   }
  if (t2cmd > 0.0 and t2cmd < 0.0685) {setprop("mig29/systems/engines/Rpos", 0);}
  if (t2cmd > 0.0685 and t2cmd < 0.072)
   {
    if (t2cmd2 < 2 or t2cmd2 > 2) {setprop("mig29/systems/engines/Rpos", 2);}
   }
  if (t2cmd > 0.072 and t2cmd < 0.829) {setprop("mig29/systems/engines/Rpos", 0);}
  if (t2cmd > 0.829 and t2cmd < 0.831)
   {
    if (t2cmd2 < 3 or t2cmd2 > 3) {setprop("mig29/systems/engines/Rpos", 3);}
   }
  if (t2cmd > 0.831 and t2cmd < 0.85) {setprop("mig29/systems/engines/Rpos", 0);}
  if (t2cmd > 0.875 and t2cmd < 0.885)
   {
    if (t2cmd2 < 4 or t2cmd2 > 4) {setprop("mig29/systems/engines/Rpos", 4);}
   }
  if (t2cmd > 0.885 and t2cmd < 1.0) {setprop("mig29/systems/engines/Rpos", 0);}
  if (t2cmd == 1.0)
   {
    if (t2cmd2 < 5 or t2cmd2 > 5) {setprop("mig29/systems/engines/Rpos", 5);}
   }
  settimer(throttle2cmd_handler, 0);
}

 var tstL = func {
  var window = screen.window.new(0, 12, 1, 2);
  window.align = "left";

  var tstLMA = "A";

  if (getprop("mig29/systems/engines/Lpos") == 1) {
   var tstLMA = "Stop";
   window.fg = [1, 1, 1, 1];
   window.write(sprintf("Throttle 1: %s", tstLMA));
  }
  if (getprop("mig29/systems/engines/Lpos") == 2) {
   var tstLMA = "Idle";
   window.fg = [0, 1, 0, 1];
   window.write(sprintf("Throttle 1: %s", tstLMA));
  }
  if (getprop("mig29/systems/engines/Lpos") == 3) {
   var tstLMA = "Max";
   window.fg = [1, 1, 0, 1];
   window.write(sprintf("Throttle 1: %s", tstLMA));
  }
  if (getprop("mig29/systems/engines/Lpos") == 4) {
   var tstLMA = "Min Afb";
   window.fg = [1, 0.5, 0.3, 1];
   window.write(sprintf("Throttle 1: %s", tstLMA));
  }
  if (getprop("mig29/systems/engines/Lpos") == 5) {
   var tstLMA = "Full Afb";
   window.fg = [1, 0, 0, 1];
   window.write(sprintf("Throttle 1: %s", tstLMA));
  }
}

 var tstR = func {
  var window = screen.window.new(0, 0, 1, 2);
  window.fg = [1, 1, 1, 1];
  window.align = "left";
  if (getprop("mig29/systems/engines/Rpos") == 1) {window.write("Throttle 2: Stop");}
  if (getprop("mig29/systems/engines/Rpos") == 2) {window.fg = [0, 1, 0, 1]; window.write("Throttle 2: Idle");}
  if (getprop("mig29/systems/engines/Rpos") == 3) {window.fg = [1, 1, 0, 1]; window.write("Throttle 2: Max");}
  if (getprop("mig29/systems/engines/Rpos") == 4) {window.fg = [1, 0.5, 0.3, 1]; window.write("Throttle 2: Min Afb");}
  if (getprop("mig29/systems/engines/Rpos") == 5) {window.fg = [1, 0, 0, 1]; window.write("Throttle 2: Full Afb");}
}

 var throttlecmdhandler_init = func {
  setprop("mig29/systems/engines/Lpos", 0);
  setprop("mig29/systems/engines/Rpos", 0);
  throttle1cmd_handler();
  throttle2cmd_handler();
  setlistener("mig29/systems/engines/Lpos", tstL);
  setlistener("mig29/systems/engines/Rpos", tstR);
}

#
var espzv = 0;
var msbv = 0;

 var espz_handler = func {
  var espzv = getprop("mig29/controls/engines/espz");
  var msbv = getprop("mig29/controls/engines/msb");
  if (espzv == 1) { setprop("mig29/systems/engines/msb", msbv); }
  else { setprop("mig29/systems/engines/msb", 1); }
  if (getprop("mig29/systems/engines/msb") == 0) { setprop("mig29/systems/engines/espz", 1); }
  else { setprop("mig29/systems/engines/espz", espzv); }
}

 var espz_init = func {
  setprop("mig29/systems/engines/espz", 1);
  setprop("mig29/systems/engines/msb", 0);
  setlistener("mig29/controls/engines/espz", espz_handler,0,0);
  setlistener("mig29/controls/engines/msb", espz_handler,0,0);
}

var edafb = 0;
var edafbb = 0;
var edafbs = 0;
var edafbbs = 0;

 var edafb_handler = func {
  var edafb = getprop("mig29/controls/engines/emerdisable_afterburning");
  var edafbb = getprop("mig29/controls/engines/emerdisable_afterburning_block");
  var edafbs = getprop("mig29/systems/engines/emerdisable_afterburning");
  var edafbbs = getprop("mig29/systems/engines/emerdisable_afterburning_block");
  if (edafb == 0 and edafbb == 0 and edafbs == 0 and edafbbs == 1)
   {
    setprop("mig29/systems/engines/emerdisable_afterburning_block", 0);
    setprop("mig29/controls/engines/emerdisable_afterburning_block", 0);
   }
  if (edafb == 1 and edafbb == 0)
   {
    setprop("mig29/systems/engines/emerdisable_afterburning", 0);
    setprop("mig29/controls/engines/emerdisable_afterburning", 0);
   }
  if (edafb == 1 and edafbb == 1)
   {
    setprop("mig29/systems/engines/emerdisable_afterburning", 1);
    setprop("mig29/systems/engines/emerdisable_afterburning_block", 1);
   }
  if (edafb == 0 and edafbb == 1)
   {
    setprop("mig29/systems/engines/emerdisable_afterburning", 0);
    setprop("mig29/systems/engines/emerdisable_afterburning_block", 1);
   }
  if (edafb == 1 and edafbb == 0 and edafbs == 1 and edafbbs == 1)
   {
    setprop("mig29/systems/engines/emerdisable_afterburning", 1);
    setprop("mig29/systems/engines/emerdisable_afterburning_block", 1);
    setprop("mig29/controls/engines/emerdisable_afterburning", 1);
    setprop("mig29/controls/engines/emerdisable_afterburning_block", 1);
   }
}

edafbsf = 0;

 var edafb_thandler = func {
  var edafbsf = getprop("mig29/systems/engines/emerdisable_afterburning");
  setprop("fdm/jsbsim/systems/engines/emerdisable_afterburning", edafbsf);
}

 var edafb_init = func {
  setprop("mig29/controls/engines/emerdisable_afterburning", 0);
  setprop("mig29/controls/engines/emerdisable_afterburning_block", 0);
  setprop("mig29/systems/engines/emerdisable_afterburning", 0);
  setprop("mig29/systems/engines/emerdisable_afterburning_block", 0);
  setlistener("mig29/controls/engines/emerdisable_afterburning", edafb_handler,0,0);
  setlistener("mig29/controls/engines/emerdisable_afterburning", edafb_thandler,0,0);
  setlistener("mig29/controls/engines/emerdisable_afterburning_block", edafb_handler,0,0);
}

var siaL = 0;
var siaLb = 0;
var siaR = 0;
var siaRb = 0;
var siaLs = 0;
var siaLbs = 0;
var siaRs = 0;
var siaRbs = 0;

 var sia_handler = func {
  var siaL = getprop("mig29/controls/engines/start_in_air_left");
  var siaLb = getprop("mig29/controls/engines/start_in_air_left_block");
  var siaR = getprop("mig29/controls/engines/start_in_air_right");
  var siaRb = getprop("mig29/controls/engines/start_in_air_right_block");
  var siaLs = getprop("mig29/systems/engines/start_in_air_left");
  var siaLbs = getprop("mig29/systems/engines/start_in_air_left_block");
  var siaRs = getprop("mig29/systems/engines/start_in_air_right");
  var siaRbs = getprop("mig29/systems/engines/start_in_air_right_block");
  if (siaL == 0 and siaLb == 0 and siaLs == 0 and siaLbs == 1)
   {
    setprop("mig29/systems/engines/start_in_air_left_block", 0);
    setprop("mig29/controls/engines/start_in_air_left_block", 0);
   }
  if (siaL == 1 and siaLb == 0)
   {
    setprop("mig29/systems/engines/start_in_air_left", 0);
    setprop("mig29/controls/engines/start_in_air_left", 0);
   }
  if (siaL == 1 and siaLb == 1)
   {
    setprop("mig29/systems/engines/start_in_air_left", 1);
    setprop("mig29/systems/engines/start_in_air_left_block", 1);
   }
  if (siaL == 0 and siaLb == 1)
   {
    setprop("mig29/systems/engines/start_in_air_left", 0);
    setprop("mig29/systems/engines/start_in_air_left_block", 1);
   }
  if (siaL == 1 and siaLb == 0 and siaLs == 1 and siaLbs == 1)
   {
    setprop("mig29/systems/engines/start_in_air_left", 1);
    setprop("mig29/systems/engines/start_in_air_left_block", 1);
    setprop("mig29/controls/engines/start_in_air_left", 1);
    setprop("mig29/controls/engines/start_in_air_left_block", 1);
   }
  if (siaR == 0 and siaRb == 0 and siaRs == 0 and siaRbs == 1)
   {
    setprop("mig29/systems/engines/start_in_air_right_block", 0);
    setprop("mig29/controls/engines/start_in_air_right_block", 0);
   }
  if (siaR == 1 and siaRb == 0)
   {
    setprop("mig29/systems/engines/start_in_air_right", 0);
    setprop("mig29/controls/engines/start_in_air_right", 0);
   }
  if (siaR == 1 and siaRb == 1)
   {
    setprop("mig29/systems/engines/start_in_air_right", 1);
    setprop("mig29/systems/engines/start_in_air_right_block", 1);
   }
  if (siaR == 0 and siaRb == 1)
   {
    setprop("mig29/systems/engines/start_in_air_right", 0);
    setprop("mig29/systems/engines/start_in_air_right_block", 1);
   }
  if (siaR == 1 and siaRb == 0 and siaRs == 1 and siaRbs == 1)
   {
    setprop("mig29/systems/engines/start_in_air_right", 1);
    setprop("mig29/systems/engines/start_in_air_right_block", 1);
    setprop("mig29/controls/engines/start_in_air_right", 1);
    setprop("mig29/controls/engines/start_in_air_right_block", 1);
   }
}

 var sia_init = func {
  setprop("mig29/controls/engines/start_in_air_left", 0);
  setprop("mig29/controls/engines/start_in_air_left_block", 0);
  setprop("mig29/controls/engines/start_in_air_right", 0);
  setprop("mig29/controls/engines/start_in_air_right_block", 0);
  setprop("mig29/systems/engines/start_in_air_left", 0);
  setprop("mig29/systems/engines/start_in_air_left_block", 0);
  setprop("mig29/systems/engines/start_in_air_right", 0);
  setprop("mig29/systems/engines/start_in_air_right_block", 0);
  setlistener("mig29/controls/engines/start_in_air_left", sia_handler,0,0);
  setlistener("mig29/controls/engines/start_in_air_left_block", sia_handler,0,0);
  setlistener("mig29/controls/engines/start_in_air_right", sia_handler,0,0);
  setlistener("mig29/controls/engines/start_in_air_right_block", sia_handler,0,0);
}

# 

var ESLeft = 0;
var ESRight = 0;
var ESGTDE = 0;

 var ESLeft_f = func {
  var ESLeft = getprop("/engines/engine[0]/n2");
  if (getprop("/engines/engine[0]/running") == 1 and getprop("/engines/engine[0]/augmentation") == 0)
   {
    if (ESLeft >= 67.5) {setprop("mig29/systems/engines/Sn2_Left", ESLeft);}
    else  {setprop("mig29/systems/engines/Sn2_Left", 67.5);}
   }
  if (getprop("/engines/engine[0]/running") == 1 and getprop("/engines/engine[0]/augmentation") == 1)
   {
    setprop("mig29/systems/engines/Sn2_Left", 150.0);
   }
  if (getprop("/engines/engine[0]/running") == 0 and getprop("/engines/engine[0]/starter") == 0)
   {
    if (ESLeft > 25) {setprop("mig29/systems/engines/Sn2_Left", 67.5);}
    else {setprop("mig29/systems/engines/Sn2_Left", 0.0);}
   }
  if (getprop("/engines/engine[0]/running") == 0 and getprop("/engines/engine[0]/starter") == 1)
   {setprop("mig29/systems/engines/Sn2_Left", 67.5);}
  settimer(ESLeft_f, 0);
}

 var ESRight_f = func {
  var ESRight = getprop("/engines/engine[1]/n2");
  if (getprop("/engines/engine[1]/running") == 1 and getprop("/engines/engine[1]/augmentation") == 0)
   {
    if (ESRight >= 67.5) {setprop("mig29/systems/engines/Sn2_Right", ESRight);}
    else  {setprop("mig29/systems/engines/Sn2_Right", 67.5);}
   }
  if (getprop("/engines/engine[1]/running") == 1 and getprop("/engines/engine[1]/augmentation") == 1)
   {
    setprop("mig29/systems/engines/Sn2_Right", 150.0);
   }
  if (getprop("/engines/engine[1]/running") == 0 and getprop("/engines/engine[1]/starter") == 0)
   {
    if (ESRight > 25) {setprop("mig29/systems/engines/Sn2_Right", 67.5);}
    else {setprop("mig29/systems/engines/Sn2_Right", 0.0);}
   }
  if (getprop("/engines/engine[1]/running") == 0 and getprop("/engines/engine[1]/starter") == 1)
   {setprop("mig29/systems/engines/Sn2_Right", 67.5);}
  settimer(ESRight_f, 0);
}

 var ESGTDE_f = func {
  if (getprop("/engines/engine[2]/running") == 1)
   {
    var ESGTDE = getprop("/engines/engine[2]/n2");
    if (ESGTDE >= 60.0) {setprop("mig29/systems/engines/Sn2_GTDE", ESGTDE);}
    else  {setprop("mig29/systems/engines/Sn2_GTDE", 60.0);}
   }
  if (getprop("/engines/engine[2]/running") == 0 and getprop("/engines/engine[2]/starter") == 0)
   {setprop("mig29/systems/engines/Sn2_GTDE", 0.0);}
  if (getprop("/engines/engine[2]/running") == 0 and getprop("/engines/engine[2]/starter") == 1)
   {setprop("mig29/systems/engines/Sn2_GTDE", 60.0);}
  settimer(ESGTDE_f, 0);
}

# 

var ESmLeft = 0;
var ESmRight = 0;

 var ESmLeft_f = func {
  var ESmLeft = getprop("/engines/engine[0]/n2");
  var ESmLeft = int(ESmLeft/4);
  setprop("mig29/systems/engines/Sm_n2_Left", ESmLeft);
  settimer(ESmLeft_f, 0);
}

 var ESmRight_f = func {
  var ESmRight = getprop("/engines/engine[1]/n2");
  var ESmRight = int(ESmRight/4);
  setprop("mig29/systems/engines/Sm_n2_Right", ESmRight);
  settimer(ESmRight_f, 0);
}