# Блок управления аэронавигационными огнями (ленивый вариант)
# Автор: Сергей "Mercenary_Mercury" Салов
# Сентябрь 2012

var BUANOcontrol = 0;

 var BUANO = func {
  var BUANOcontrol = getprop("mig29/controls/lighting/ano");
  if ( BUANOcontrol == 0 ) { setprop("mig29/systems/lighting/ANOmode", 0); setprop("mig29/systems/lighting/ANObright", 0.0); }
  if ( BUANOcontrol == 1 ) { setprop("mig29/systems/lighting/ANOmode", 1); setprop("mig29/systems/lighting/ANObright", 0.2); }
  if ( BUANOcontrol == 2 ) { setprop("mig29/systems/lighting/ANOmode", 1); setprop("mig29/systems/lighting/ANObright", 1.0); }
  if ( BUANOcontrol == 3 ) { setprop("mig29/systems/lighting/ANOmode", 1); setprop("mig29/systems/lighting/ANObright", 1.0); }
}

 var BANOcycle = func {
  if ( getprop("mig29/controls/lighting/ano") == 3 )
   {
    if ( getprop("mig29/systems/lighting/ANO") == 1 ) { setprop("mig29/systems/lighting/ANO", 0); }
    else { setprop("mig29/systems/lighting/ANO", 1); }
   }
  if ( getprop("mig29/controls/lighting/ano") > 3 or getprop("mig29/controls/lighting/ano") < 3 and getprop("mig29/systems/lighting/ANO") == 0)
   { setprop("mig29/systems/lighting/ANO", 1); }
  settimer(BANOcycle, 1);
}

 var BUANO_init = func {
  setprop("mig29/controls/lighting/ano", 0);
  setprop("mig29/systems/lighting/ANOmode", 0);
  setprop("mig29/systems/lighting/ANObright", 0);
  setprop("mig29/systems/lighting/ANO", 0);
  setlistener("mig29/controls/lighting/ano", BUANO,0,0);
  BANOcycle();
}