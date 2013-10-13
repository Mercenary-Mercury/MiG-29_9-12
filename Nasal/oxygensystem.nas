# Кислородная система
# Сергей "Mercenary_Mercury" Салов
# Март 2013

var oxygen = 0;
var oxygen_emerg = 0;
var oxygen_feed = 0;
var oxygen_mix_100p_O2 = 0;
var oxygen_emerg_feed = 0;
var oxygen_VDH = 0;

 var OxygenSystem = func {
  var oxygen = getprop("/mig29/systems/oxygensystem/reserve");
  var oxygen_mix_100p_O2 = getprop("/mig29/controls/oxygensystem/mix-100p_O2");
  var oxygen_emerg_feed = getprop("/mig29/controls/oxygensystem/emerg_feed");
  var oxygen_VDH = getprop("/mig29/controls/oxygensystem/VDH");
  if (getprop("/mig29/controls/oxygensystem/on") == 1)
   {
    if (oxygen > 0)
     {
      if (oxygen_mix_100p_O2 == 0) {var oxygen_mix_100p_O2 = 0.4;}
      var oxygen_feed = oxygen_mix_100p_O2+(oxygen_VDH*0.1);
     }
    if (oxygen_feed > 0) {var oxygen = oxygen-(oxygen_feed/72000);}
    setprop("/mig29/systems/oxygensystem/reserve", oxygen);
    if (oxygen_emerg_feed == 1)
     {
      var oxygen_emerg = oxygen_emerg-(oxygen_emerg_feed/36000);
      setprop("/mig29/systems/oxygensystem/emerg_reserve", oxygen_emerg);
      var oxygen_feed = oxygen_feed+0.1;
     }
    if (oxygen_feed < 0.6) {var oxygen_feed = oxygen_feed+0.6;}
    setprop("/mig29/systems/oxygensystem/feed", oxygen_feed);
   }
  else {setprop("/mig29/systems/oxygensystem/feed", 0);}
  settimer(OxygenSystem, 0.1);
}

 var OxygenSystemInit = func {
  setprop("/mig29/controls/oxygensystem/on", 0);
  setprop("/mig29/controls/oxygensystem/mix-100p_O2", 0);
  setprop("/mig29/controls/oxygensystem/emerg_feed", 0);
  setprop("/mig29/controls/oxygensystem/VDH", 0);
  setprop("/mig29/systems/oxygensystem/reserve", 100);
  setprop("/mig29/systems/oxygensystem/emerg_reserve", 100);
  setprop("/mig29/systems/oxygensystem/feed", 0);
  OxygenSystem();
  print("Oxygen system init");
}