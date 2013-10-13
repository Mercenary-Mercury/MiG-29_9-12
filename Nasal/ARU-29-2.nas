# Автомат Регулировки Управления
# Сергей "Mercenary_Mercury" Салов
# Сентябрь 2012

var OATLa = 0;
var OATLb = 0;
var OATLs = 0;
var OATLbs = 0;

 var OATL_handler = func {
  var OATLa = getprop("mig29/controls/ARU/ARU");
  var OATLb = getprop("mig29/controls/ARU/ARU_kontr");
  var OATLs = getprop("mig29/systems/ARU/ARU");
  var OATLbs = getprop("mig29/systems/ARU/ARU_kontr");
  if (OATLbs == 0)
   {
    if (OATLb == 0)
     {
      setprop("mig29/systems/ARU/ARU", OATLa);
      setprop("mig29/systems/ARU/ARU_kontr", 0);
     }
    if (OATLb == 1 and OATLa == 1)
     {
      setprop("mig29/systems/ARU/ARU", 1);
      setprop("mig29/systems/ARU/ARU_kontr", 1);
     }
    if (OATLb == 1 and OATLa == 0)
     {
      setprop("mig29/controls/ARU/ARU_kontr", 0);
      setprop("mig29/controls/ARU/ARU", OATLa);
     }
    if (OATLb == 1 and OATLa > 1)
     {
      setprop("mig29/controls/ARU/ARU_kontr", 0);
      setprop("mig29/controls/ARU/ARU", OATLa);
     }
   }
   if (OATLbs == 1)
   {
    if (OATLb == 0 and OATLa == 1)
     {
      setprop("mig29/systems/ARU/ARU", 1);
      setprop("mig29/systems/ARU/ARU_kontr", 0);
     }
    if (OATLb == 0 and OATLa == 0)
     {
      setprop("mig29/controls/ARU/ARU_kontr", 0);
      setprop("mig29/systems/ARU/ARU", 0);
     }
    if (OATLb == 0 and OATLa > 1)
     {
      setprop("mig29/controls/ARU/ARU_kontr", 0);
      setprop("mig29/systems/ARU/ARU", OATLa);
     }
    if (OATLb == 1 and OATLa == 1)
     {
      setprop("mig29/systems/ARU/ARU", 1);
      setprop("mig29/systems/ARU/ARU_kontr", 1);
     }
    if (OATLb == 1 and OATLa == 0)
     {
      setprop("mig29/controls/ARU/ARU_kontr", 1);
      setprop("mig29/controls/ARU/ARU", 1);
     }
    if (OATLb == 1 and OATLa > 1)
     {
      setprop("mig29/controls/ARU/ARU_kontr", 1);
      setprop("mig29/controls/ARU/ARU", 1);
     }
   }
}

 var OATL_t = func {
  if (getprop("mig29/systems/ARU/ARU") == 0) {setprop("fdm/jsbsim/systems/ARU/OALT", 0);}
  if (getprop("mig29/systems/ARU/ARU") == 1) {setprop("fdm/jsbsim/systems/ARU/OALT", 1);}
  if (getprop("mig29/systems/ARU/ARU") == 2) {setprop("fdm/jsbsim/systems/ARU/OALT", 2);}
  if (getprop("mig29/systems/ARU/ARU") == 3) {setprop("fdm/jsbsim/systems/ARU/OALT", 3);}
}

 var APUSet = func {
  if (getprop("mig29/systems/SAU/damp") == 0)
   {setprop("fdm/jsbsim/systems/ARU/damper", 0);}
  if (getprop("mig29/systems/SAU/damp") == 1)
   {setprop("fdm/jsbsim/systems/ARU/damper", 1);}
}

 var OATL_init = func {
  setprop("mig29/controls/ARU/ARU", 1);
  setprop("mig29/controls/ARU/ARU_kontr", 1);
  setprop("mig29/systems/ARU/ARU", 1);
  setprop("mig29/systems/ARU/ARU_kontr", 1);
  setlistener("mig29/controls/ARU/ARU", OATL_handler,0,0);
  setlistener("mig29/controls/ARU/ARU_kontr", OATL_handler,0,0);
  setlistener("mig29/systems/ARU/ARU", OATL_t);
  
  setlistener("mig29/systems/SAU/damp", APUSet);
}