# Weapons service script
# Sergey "Mercenary_Mercury" Salow, Aug 2011

 var APU_470_handler = func {
  if (getprop("mig29/weapons/podv/T1") == 1 or getprop("mig29/weapons/podv/T1") == 2)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[1]", 154.3235835294143);
    setprop("fdm/jsbsim/systems/podv/APU-470_1", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[1]", 0);
    setprop("fdm/jsbsim/systems/podv/APU-470_1", 0);
   }
  if (getprop("mig29/weapons/podv/T2") == 1 or getprop("mig29/weapons/podv/T2") == 2)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[2]", 154.3235835294143);
    setprop("fdm/jsbsim/systems/podv/APU-470_2", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[2]", 0);
    setprop("fdm/jsbsim/systems/podv/APU-470_2", 0);
   }
}

 var APU_60_handler = func {
  if (getprop("mig29/weapons/podv/T1") == 3 or getprop("mig29/weapons/podv/T1") == 4)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[3]", 70.54792389916082);
    setprop("fdm/jsbsim/systems/podv/APU-60_1", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[3]", 0);
    setprop("fdm/jsbsim/systems/podv/APU-60_1", 0);
   }
  if (getprop("mig29/weapons/podv/T2") == 3 or getprop("mig29/weapons/podv/T2") == 4)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[4]", 70.54792389916082);
    setprop("fdm/jsbsim/systems/podv/APU-60_2", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[4]", 0);
    setprop("fdm/jsbsim/systems/podv/APU-60_2", 0);
   }
  if (getprop("mig29/weapons/podv/T3") == 1 or getprop("mig29/weapons/podv/T3") == 2)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[5]", 70.54792389916082);
    setprop("fdm/jsbsim/systems/podv/APU-60_3", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[5]", 0);
    setprop("fdm/jsbsim/systems/podv/APU-60_3", 0);
   }
  if (getprop("mig29/weapons/podv/T4") == 1 or getprop("mig29/weapons/podv/T4") == 2)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[6]", 70.54792389916082);
    setprop("fdm/jsbsim/systems/podv/APU-60_4", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[6]", 0);
    setprop("fdm/jsbsim/systems/podv/APU-60_4", 0);
   }
  if (getprop("mig29/weapons/podv/T5") == 1 or getprop("mig29/weapons/podv/T5") == 2)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[7]", 70.54792389916082);
    setprop("fdm/jsbsim/systems/podv/APU-60_5", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[7]", 0);
    setprop("fdm/jsbsim/systems/podv/APU-60_5", 0);
   }
  if (getprop("mig29/weapons/podv/T6") == 1 or getprop("mig29/weapons/podv/T6") == 2)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[8]", 70.54792389916082);
    setprop("fdm/jsbsim/systems/podv/APU-60_6", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[8]", 0);
    setprop("fdm/jsbsim/systems/podv/APU-60_6", 0);
   }
}

 var APU_73_handler = func {
  if (getprop("mig29/weapons/podv/T1") == 5 or getprop("mig29/weapons/podv/T1") == 6)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[9]", 108.02650847059);
    setprop("fdm/jsbsim/systems/podv/APU-73_1", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[9]", 0);
    setprop("fdm/jsbsim/systems/podv/APU-73_1", 0);
   }
  if (getprop("mig29/weapons/podv/T2") == 5 or getprop("mig29/weapons/podv/T2") == 6)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[10]", 108.02650847059);
    setprop("fdm/jsbsim/systems/podv/APU-73_2", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[10]", 0);
    setprop("fdm/jsbsim/systems/podv/APU-73_2", 0);
   }
  if (getprop("mig29/weapons/podv/T3") == 3 or getprop("mig29/weapons/podv/T3") == 4)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[11]", 108.02650847059);
    setprop("fdm/jsbsim/systems/podv/APU-73_3", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[11]", 0);
    setprop("fdm/jsbsim/systems/podv/APU-73_3", 0);
   }
  if (getprop("mig29/weapons/podv/T4") == 3 or getprop("mig29/weapons/podv/T4") == 4)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[12]", 108.02650847059);
    setprop("fdm/jsbsim/systems/podv/APU-73_4", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[12]", 0);
    setprop("fdm/jsbsim/systems/podv/APU-73_4", 0);
   }
  if (getprop("mig29/weapons/podv/T5") == 3 or getprop("mig29/weapons/podv/T5") == 4)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[13]", 108.02650847059);
    setprop("fdm/jsbsim/systems/podv/APU-73_5", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[13]", 0);
    setprop("fdm/jsbsim/systems/podv/APU-73_5", 0);
   }
  if (getprop("mig29/weapons/podv/T6") == 3 or getprop("mig29/weapons/podv/T6") == 4)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[14]", 108.02650847059);
    setprop("fdm/jsbsim/systems/podv/APU-73_6", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[14]", 0);
    setprop("fdm/jsbsim/systems/podv/APU-73_6", 0);
   }
}

 var BD3_UMK_handler = func {
  if (getprop("mig29/weapons/podv/BD3-UMK_1") == 1)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[15]", 132.277357311);
    setprop("fdm/jsbsim/systems/podv/BD3-UMK_1", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[15]", 0);
    setprop("fdm/jsbsim/systems/podv/BD3-UMK_1", 0);
   }
  if (getprop("mig29/weapons/podv/BD3-UMK_2") == 1)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[16]", 132.277357311);
    setprop("fdm/jsbsim/systems/podv/BD3-UMK_2", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[16]", 0);
    setprop("fdm/jsbsim/systems/podv/BD3-UMK_2", 0);
   }
  if (getprop("mig29/weapons/podv/BD3-UMK_3") == 1)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[17]", 132.277357311);
    setprop("fdm/jsbsim/systems/podv/BD3-UMK_3", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[17]", 0);
    setprop("fdm/jsbsim/systems/podv/BD3-UMK_3", 0);
   }
  if (getprop("mig29/weapons/podv/BD3-UMK_4") == 1)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[18]", 132.277357311);
    setprop("fdm/jsbsim/systems/podv/BD3-UMK_4", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[18]", 0);
    setprop("fdm/jsbsim/systems/podv/BD3-UMK_4", 0);
   }
}

 var MBD3_U2T_handler = func {
  if (getprop("mig29/weapons/podv/MBD3-U2T_1") == 1)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[19]", 308.647167059);
    setprop("fdm/jsbsim/systems/podv/MBD3-U2T_1", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[19]", 0);
    setprop("fdm/jsbsim/systems/podv/MBD3-U2T_1", 0);
   }
  if (getprop("mig29/weapons/podv/MBD3-U2T_2") == 1)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[20]", 308.647167059);
    setprop("fdm/jsbsim/systems/podv/MBD3-U2T_2", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[20]", 0);
    setprop("fdm/jsbsim/systems/podv/MBD3-U2T_2", 0);
   }
  if (getprop("mig29/weapons/podv/MBD3-U2T_3") == 1)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[21]", 308.647167059);
    setprop("fdm/jsbsim/systems/podv/MBD3-U2T_3", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[21]", 0);
    setprop("fdm/jsbsim/systems/podv/MBD3-U2T_3", 0);
   }
  if (getprop("mig29/weapons/podv/MBD3-U2T_4") == 1)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[22]", 308.647167059);
    setprop("fdm/jsbsim/systems/podv/MBD3-U2T_4", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[22]", 0);
    setprop("fdm/jsbsim/systems/podv/MBD3-U2T_4", 0);
   }
}

 var APU_68_handler = func {
  if (getprop("mig29/weapons/podv/APU-68_1") == 1)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[23]", 88.184904874);
    setprop("fdm/jsbsim/systems/podv/APU-68_1", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[23]", 0);
    setprop("fdm/jsbsim/systems/podv/APU-68_1", 0);
   }
  if (getprop("mig29/weapons/podv/APU-68_2") == 1)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[24]", 88.184904874);
    setprop("fdm/jsbsim/systems/podv/APU-68_2", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[24]", 0);
    setprop("fdm/jsbsim/systems/podv/APU-68_2", 0);
   }
  if (getprop("mig29/weapons/podv/APU-68_3") == 1)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[25]", 88.184904874);
    setprop("fdm/jsbsim/systems/podv/APU-68_3", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[25]", 0);
    setprop("fdm/jsbsim/systems/podv/APU-68_3", 0);
   }
  if (getprop("mig29/weapons/podv/APU-68_4") == 1)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[26]", 88.184904874);
    setprop("fdm/jsbsim/systems/podv/APU-68_4", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[26]", 0);
    setprop("fdm/jsbsim/systems/podv/APU-68_4", 0);
   }
}

 var R_27R_handler = func {
  if (getprop("mig29/weapons/podv/T1") == 2)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[27]", 154.3235835294143);
    setprop("fdm/jsbsim/systems/podv/R-27R_1", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[27]", 0);
    setprop("fdm/jsbsim/systems/podv/R-27R_1", 0);
   }
  if (getprop("mig29/weapons/podv/T2") == 2)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[28]", 154.3235835294143);
    setprop("fdm/jsbsim/systems/podv/R-27R_2", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[28]", 0);
    setprop("fdm/jsbsim/systems/podv/R-27R_2", 0);
   }
}

 var R_60M_handler = func {
  if (getprop("mig29/weapons/podv/T1") == 4)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[29]", 70.54792389916082);
    setprop("fdm/jsbsim/systems/podv/R-60M_1", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[29]", 0);
    setprop("fdm/jsbsim/systems/podv/R-60M_1", 0);
   }
  if (getprop("mig29/weapons/podv/T2") == 4)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[30]", 70.54792389916082);
    setprop("fdm/jsbsim/systems/podv/R-60M_2", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[30]", 0);
    setprop("fdm/jsbsim/systems/podv/R-60M_2", 0);
   }
  if (getprop("mig29/weapons/podv/T3") == 2)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[31]", 70.54792389916082);
    setprop("fdm/jsbsim/systems/podv/R-60M_3", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[31]", 0);
    setprop("fdm/jsbsim/systems/podv/R-60M_3", 0);
   }
  if (getprop("mig29/weapons/podv/T4") == 2)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[32]", 70.54792389916082);
    setprop("fdm/jsbsim/systems/podv/R-60M_4", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[32]", 0);
    setprop("fdm/jsbsim/systems/podv/R-60M_4", 0);
   }
  if (getprop("mig29/weapons/podv/T5") == 2)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[33]", 70.54792389916082);
    setprop("fdm/jsbsim/systems/podv/R-60M_5", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[33]", 0);
    setprop("fdm/jsbsim/systems/podv/R-60M_5", 0);
   }
  if (getprop("mig29/weapons/podv/T6") == 2)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[34]", 70.54792389916082);
    setprop("fdm/jsbsim/systems/podv/R-60M_6", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[34]", 0);
    setprop("fdm/jsbsim/systems/podv/R-60M_6", 0);
   }
}

 var R_73_handler = func {
  if (getprop("mig29/weapons/podv/T1") == 6)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[35]", 108.02650847059);
    setprop("fdm/jsbsim/systems/podv/R-73_1", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[35]", 0);
    setprop("fdm/jsbsim/systems/podv/R-73_1", 0);
   }
  if (getprop("mig29/weapons/podv/T2") == 6)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[36]", 108.02650847059);
    setprop("fdm/jsbsim/systems/podv/R-73_2", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[36]", 0);
    setprop("fdm/jsbsim/systems/podv/R-73_2", 0);
   }
  if (getprop("mig29/weapons/podv/T3") == 4)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[37]", 108.02650847059);
    setprop("fdm/jsbsim/systems/podv/R-73_3", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[37]", 0);
    setprop("fdm/jsbsim/systems/podv/R-73_3", 0);
   }
  if (getprop("mig29/weapons/podv/T4") == 4)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[38]", 108.02650847059);
    setprop("fdm/jsbsim/systems/podv/R-73_4", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[38]", 0);
    setprop("fdm/jsbsim/systems/podv/R-73_4", 0);
   }
  if (getprop("mig29/weapons/podv/T5") == 4)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[39]", 108.02650847059);
    setprop("fdm/jsbsim/systems/podv/R-73_5", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[39]", 0);
    setprop("fdm/jsbsim/systems/podv/R-73_5", 0);
   }
  if (getprop("mig29/weapons/podv/T6") == 4)
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[40]", 108.02650847059);
    setprop("fdm/jsbsim/systems/podv/R-73_6", 1);
   }
  else
   {
    setprop("fdm/jsbsim/inertia/pointmass-weight-lbs[40]", 0);
    setprop("fdm/jsbsim/systems/podv/R-73_6", 0);
   }
}

# Обработчики выборпа оружия на точках подвесок
var Pylon_none             = "none";
var Pylon_PTB              = "PTB";
var Pylon_R_27R            = "R-27R";
var Pylon_R_60M            = "R-60M";
var Pylon_R_73             = "R-73";
var Pylon_BetAB_500        = "BetAB-500";
var Pylon_BetAB_500ShP     = "BetAB-500ShP";
var Pylon_FAB_250_M_62     = "FAB-250 M-62";
var Pylon_FAB_250TS        = "FAB-250TS";
var Pylon_FAB_250ShL       = "FAB-250ShL";
var Pylon_FAB_500_M_62     = "FAB-500 M-62";
var Pylon_FAB_500ShL       = "FAB-500ShL";
var Pylon_FAB_500ShN       = "FAB-500ShN";
var Pylon_ODAB_500PM       = "ODAB-500PM";
var Pylon_OFAB_100_120     = "OFAB-100-120";
var Pylon_OFAB_250_270     = "OFAB-250-270";
var Pylon_OFAB_250ShL      = "OFAB-250ShL";
var Pylon_OFAB_250ShN      = "OFAB-250ShN";
var Pylon_OFAB_500U        = "OFAB-500U";
var Pylon_OFAB_500ShR      = "OFAB-500ShR";
var Pylon_OFZAB_500        = "OFZAB-500";
var Pylon_KMGU_2           = "KMGU-2";
var Pylon_RBK_250_AO_1     = "RBK-250 AO-1";
var Pylon_RBK_250_PTAB_2_5 = "RBK-250 PTAB-2.5";
var Pylon_RBK_500_AO_2_5RT = "RBK-500 AO-2.5RT";
var Pylon_RBK_500_PTAB_1M  = "RBK-500 PTAB-1M";
var Pylon_ZB_500ASM        = "ZB-500ASM";
var Pylon_ZB_500GD         = "ZB-500GD";
var Pylon_ZB_500ShM        = "ZB-500ShM";
var Pylon_S_8BM            = "S-8BM";
var Pylon_S_8DM            = "S-8DM";
var Pylon_S_8KOM           = "S-8KOM";
var Pylon_S_8OM            = "S-8OM";
var Pylon_S_8PM            = "S-8PM";
var Pylon_S_24B            = "S-24B";

 var PylonPTB_handler = func {
  if (getprop("/gear/gear[1]/wow") == 1)
   {
    if (getprop("mig29/controls/Weapons/podv/PTB") == Pylon_none)
     {setprop("mig29/weapons/podv/PTB", 0);}
    if (getprop("mig29/controls/Weapons/podv/PTB") == Pylon_PTB)
     {setprop("mig29/weapons/podv/PTB", 1);}
   }
}

 var Pylon1_handler = func {
  if (getprop("/gear/gear[1]/wow") == 1)
   {
    if (getprop("mig29/controls/Weapons/podv/pylon1") == Pylon_none)
     {setprop("mig29/weapons/podv/T1", 0);}
    if (getprop("mig29/controls/Weapons/podv/pylon1") == Pylon_R_27R)
     {setprop("mig29/weapons/podv/T1", 2);}
    if (getprop("mig29/controls/Weapons/podv/pylon1") == Pylon_R_60M)
     {setprop("mig29/weapons/podv/T1", 4);}
    if (getprop("mig29/controls/Weapons/podv/pylon1") == Pylon_R_73)
     {setprop("mig29/weapons/podv/T1", 6);}
    
    if (getprop("mig29/controls/Weapons/podv/pylon1") == Pylon_FAB_500_M_62)
     {setprop("mig29/weapons/podv/T1", 13);}
    if (getprop("mig29/controls/Weapons/podv/pylon1") == Pylon_OFAB_250_270)
     {setprop("mig29/weapons/podv/T1", 19);}
   }
}

 var Pylon2_handler = func {
  if (getprop("/gear/gear[1]/wow") == 1)
   {
    if (getprop("mig29/controls/Weapons/podv/pylon2") == Pylon_none)
     {setprop("mig29/weapons/podv/T2", 0);}
    if (getprop("mig29/controls/Weapons/podv/pylon2") == Pylon_R_27R)
     {setprop("mig29/weapons/podv/T2", 2);}
    if (getprop("mig29/controls/Weapons/podv/pylon2") == Pylon_R_60M)
     {setprop("mig29/weapons/podv/T2", 4);}
    if (getprop("mig29/controls/Weapons/podv/pylon2") == Pylon_R_73)
     {setprop("mig29/weapons/podv/T2", 6);}
    
    if (getprop("mig29/controls/Weapons/podv/pylon2") == Pylon_FAB_500_M_62)
     {setprop("mig29/weapons/podv/T2", 13);}
    if (getprop("mig29/controls/Weapons/podv/pylon2") == Pylon_OFAB_250_270)
     {setprop("mig29/weapons/podv/T2", 19);}
   }
}

 var Pylon3_handler = func {
  if (getprop("/gear/gear[1]/wow") == 1)
   {
    if (getprop("mig29/controls/Weapons/podv/pylon3") == Pylon_none)
     {setprop("mig29/weapons/podv/T3", 0);}
    if (getprop("mig29/controls/Weapons/podv/pylon3") == Pylon_R_60M)
     {setprop("mig29/weapons/podv/T3", 2);}
    if (getprop("mig29/controls/Weapons/podv/pylon3") == Pylon_R_73)
     {setprop("mig29/weapons/podv/T3", 4);}
    
    if (getprop("mig29/controls/Weapons/podv/pylon3") == Pylon_FAB_500_M_62)
     {setprop("mig29/weapons/podv/T3", 13);}
    if (getprop("mig29/controls/Weapons/podv/pylon3") == Pylon_OFAB_250_270)
     {setprop("mig29/weapons/podv/T3", 17);}
   }
}

 var Pylon4_handler = func {
  if (getprop("/gear/gear[1]/wow") == 1)
   {
    if (getprop("mig29/controls/Weapons/podv/pylon4") == Pylon_none)
     {setprop("mig29/weapons/podv/T4", 0);}
    if (getprop("mig29/controls/Weapons/podv/pylon4") == Pylon_R_60M)
     {setprop("mig29/weapons/podv/T4", 2);}
    if (getprop("mig29/controls/Weapons/podv/pylon4") == Pylon_R_73)
     {setprop("mig29/weapons/podv/T4", 4);}
    
    if (getprop("mig29/controls/Weapons/podv/pylon4") == Pylon_FAB_500_M_62)
     {setprop("mig29/weapons/podv/T4", 13);}
    if (getprop("mig29/controls/Weapons/podv/pylon4") == Pylon_OFAB_250_270)
     {setprop("mig29/weapons/podv/T4", 17);}
   }
}

 var Pylon5_handler = func {
  if (getprop("/gear/gear[1]/wow") == 1)
   {
    if (getprop("mig29/controls/Weapons/podv/pylon5") == Pylon_none)
     {setprop("mig29/weapons/podv/T5", 0);}
    if (getprop("mig29/controls/Weapons/podv/pylon5") == Pylon_R_60M)
     {setprop("mig29/weapons/podv/T5", 2);}
    if (getprop("mig29/controls/Weapons/podv/pylon5") == Pylon_R_73)
     {setprop("mig29/weapons/podv/T5", 4);}
   }
}

 var Pylon6_handler = func {
  if (getprop("/gear/gear[1]/wow") == 1)
   {
    if (getprop("mig29/controls/Weapons/podv/pylon6") == Pylon_none)
     {setprop("mig29/weapons/podv/T6", 0);}
    if (getprop("mig29/controls/Weapons/podv/pylon6") == Pylon_R_60M)
     {setprop("mig29/weapons/podv/T6", 2);}
    if (getprop("mig29/controls/Weapons/podv/pylon6") == Pylon_R_73)
     {setprop("mig29/weapons/podv/T6", 4);}
   }
}

 var Weapon_init = func {
  LTTs_Control();
  setlistener("mig29/weapons/podv/T1", APU_470_handler);
  setlistener("mig29/weapons/podv/T2", APU_470_handler);
  setlistener("mig29/weapons/podv/T1", APU_60_handler);
  setlistener("mig29/weapons/podv/T2", APU_60_handler);
  setlistener("mig29/weapons/podv/T3", APU_60_handler);
  setlistener("mig29/weapons/podv/T4", APU_60_handler);
  setlistener("mig29/weapons/podv/T5", APU_60_handler);
  setlistener("mig29/weapons/podv/T6", APU_60_handler);
  setlistener("mig29/weapons/podv/T1", APU_73_handler);
  setlistener("mig29/weapons/podv/T2", APU_73_handler);
  setlistener("mig29/weapons/podv/t3", APU_73_handler);
  setlistener("mig29/weapons/podv/T4", APU_73_handler);
  setlistener("mig29/weapons/podv/T5", APU_73_handler);
  setlistener("mig29/weapons/podv/T6", APU_73_handler);
  setlistener("mig29/weapons/podv/BD3-UMK_1", BD3_UMK_handler);
  setlistener("mig29/weapons/podv/BD3-UMK_2", BD3_UMK_handler);
  setlistener("mig29/weapons/podv/BD3-UMK_3", BD3_UMK_handler);
  setlistener("mig29/weapons/podv/BD3-UMK_4", BD3_UMK_handler);
  setlistener("mig29/weapons/podv/MBD3-U2T_1", MBD3_U2T_handler);
  setlistener("mig29/weapons/podv/MBD3-U2T_2", MBD3_U2T_handler);
  setlistener("mig29/weapons/podv/MBD3-U2T_3", MBD3_U2T_handler);
  setlistener("mig29/weapons/podv/MBD3-U2T_4", MBD3_U2T_handler);
  setlistener("mig29/weapons/podv/APU-68_1", APU_68_handler);
  setlistener("mig29/weapons/podv/APU-68_2", APU_68_handler);
  setlistener("mig29/weapons/podv/APU-68_3", APU_68_handler);
  setlistener("mig29/weapons/podv/APU-68_4", APU_68_handler);
  setlistener("mig29/weapons/podv/T1", R_27R_handler);
  setlistener("mig29/weapons/podv/T2", R_27R_handler);
  setlistener("mig29/weapons/podv/T1", R_60M_handler);
  setlistener("mig29/weapons/podv/T2", R_60M_handler);
  setlistener("mig29/weapons/podv/T3", R_60M_handler);
  setlistener("mig29/weapons/podv/T4", R_60M_handler);
  setlistener("mig29/weapons/podv/T5", R_60M_handler);
  setlistener("mig29/weapons/podv/T6", R_60M_handler);
  setlistener("mig29/weapons/podv/T1", R_73_handler);
  setlistener("mig29/weapons/podv/T2", R_73_handler);
  setlistener("mig29/weapons/podv/T3", R_73_handler);
  setlistener("mig29/weapons/podv/T4", R_73_handler);
  setlistener("mig29/weapons/podv/T5", R_73_handler);
  setlistener("mig29/weapons/podv/T6", R_73_handler);
  setlistener("mig29/controls/Weapons/podv/PTB", PylonPTB_handler);
  setlistener("mig29/controls/Weapons/podv/pylon1", Pylon1_handler);
  setlistener("mig29/controls/Weapons/podv/pylon2", Pylon2_handler);
  setlistener("mig29/controls/Weapons/podv/pylon3", Pylon3_handler);
  setlistener("mig29/controls/Weapons/podv/pylon4", Pylon4_handler);
  setlistener("mig29/controls/Weapons/podv/pylon5", Pylon5_handler);
  setlistener("mig29/controls/Weapons/podv/pylon6", Pylon6_handler);
}

 var press_fire = func {
  if (getprop("/gear/gear[1]/compression-norm") == 0)
   { if (getprop("/ai/submodels/submodel[0]/count") > 0)
   {setprop("/controls/armament/trigger", 1);}
  }
}

 var unpress_fire = func {
  setprop("/controls/armament/trigger", 0);
}

 var PTB_jettison = func {
  setprop("mig29/systems/fuelsystem/PTBjv", getprop("fdm/jsbsim/propulsion/tank[7]/contents-lbs"));
  setprop("consumables/fuel/tank[7]/level-lbs", 0);
  setprop("controls/armament/station[0]/jettison-all", 1);
  setprop("mig29/weapons/podv/PTB", 0);
}

 var LTTs_Control = func {
  if (getprop("mig29/instrumentation/electrical/v27") > 24)
   {
    if (getprop("mig29/controls/BVP/emerg_release") == 1 and getprop("/ai/submodels/submodel[2]/count") > 0) {setprop("mig29/systems/BVP/release", 1);}
    if (getprop("mig29/controls/BVP/emerg_release") == 1 and getprop("/ai/submodels/submodel[2]/count") == 0) {setprop("mig29/systems/BVP/release", 0);}
   }
  settimer(LTTs_Control, 0);
}

 var cannon_rearm = func {
  if (getprop("/gear/gear[0]/wow") == 1)
   {
    setprop("/ai/submodels/submodel[0]/count", 150);
   }
}