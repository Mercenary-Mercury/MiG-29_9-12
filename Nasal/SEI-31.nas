# Скрипт поддержки ИЛС-31
# Январь 2012, Сергей "Mercenary_Mercury" Салов

var heading = 0;	# Курс
var heading_int = 0;	# Курс (целое значение, с точностью то демяти градусов)
var heading1 = 0;	# Смещение 1 отметки (центральная)
var heading2 = 0;	# Смещение 2 отметки (левая)
var heading3 = 0;	# Смещение 3 отметки (правая)
var heading1_num = 0;	# Числовое значение 1 отметки (центральная)
var heading2_num = 0;	# Числовое значение 2 отметки (левая)
var heading3_num = 0;	# Числовое значение 3 отметки (правая)

 var SEI_31_gyro = func {
  heading = getprop("/mig29/instrumentation/PNP-72-12/heading-indicated-deg");		# Получаем текущий курс
  heading_int = int(heading/10);				# Делим на 10, и получаем целую часть
  heading1_num = heading_int;					# Полученое значение будет первым значением курса для отображения
  heading_int = (heading_int*10);				# Востанавливаем значение курса до полного вида
  heading1 = (heading-heading_int);				# Получаем смещение первой отметки
  heading2 = (heading1+10);					# Получаем смещение второй отметки
  heading3 = (heading1-10);					# Получаем смещение третьей отметки
  if ( heading_int < 10 ) { heading2_num=35; }			# Получаем отображаемое значение курса для второй отметки
   else { heading2_num=(heading1_num-1); }
  if ( heading_int >= 350 ) { heading3_num=0; }		# Получаем отображаемое значение курса для третьей отметки
   else { heading3_num=(heading1_num+1); }
  setprop("/mig29/systems/SEI-31/heading1", heading1);
  setprop("/mig29/systems/SEI-31/heading2", heading2);
  setprop("/mig29/systems/SEI-31/heading3", heading3);
  setprop("/mig29/systems/SEI-31/heading1_num", heading1_num);
  setprop("/mig29/systems/SEI-31/heading2_num", heading2_num);
  setprop("/mig29/systems/SEI-31/heading3_num", heading3_num);
  settimer(SEI_31_gyro,0);
}

# Вывод значения скорости

var ind_speed = 0;

 var ind_speed_31 = func {
  if (getprop("/mig29/systems/SEI-31/on") == 1)
   {
    var ind_speed = getprop("/mig29/instrumentation/US-1600/airspeed-kmh");
    var ind_speed = (ind_speed/10);
    var ind_speed = int(ind_speed);
    var ind_speed = (ind_speed*10);
    setprop("/mig29/instrumentation/SEI-31/indicated_airspeed", ind_speed);
   }
  settimer(ind_speed_31, 0);
}

# Вывод значения высоты

var ind_baro_altitude = 0;
var ind_radio_altitude = 0;
var ind_altitude = 0;

 var ind_altitude_31 = func {
  if (getprop("/mig29/systems/SEI-31/on") == 1)
   {
    var ind_baro_altitude = getprop("/mig29/instrumentation/UV-30-3/indicated-altitude-m");
    var ind_radio_altitude = getprop("/mig29/instrumentation/RV-21/indicated-altitude-m");
    if (ind_baro_altitude > 0)
     {
      var ind_baro_altitude = (ind_baro_altitude/10);
      var ind_baro_altitude = int(ind_baro_altitude);
      var ind_baro_altitude = (ind_baro_altitude*10);
    }
     else {var ind_baro_altitude = 0;}
    if (getprop("/mig29/instrumentation/SEI-31/R") == 1) {var ind_altitude = ind_radio_altitude;}
     else {var ind_altitude = ind_baro_altitude;}
    setprop("/mig29/instrumentation/SEI-31/indicated_altitude", ind_altitude);
   }
  settimer(ind_altitude_31, 0);
}

 var ind_LT_31 = func {
  if (getprop("/mig29/systems/SEI-31/on") == 1)
   {
    if (getprop("/mig29/instrumentation/KPP/pitch-indicated-deg") > -20 and getprop("/mig29/instrumentation/KPP/pitch-indicated-deg") < 20)
     {setprop("/mig29/instrumentation/SEI-31/indicated_tangage_L", getprop("/mig29/instrumentation/KPP/pitch-indicated-deg"));}
    if (getprop("/mig29/instrumentation/KPP/pitch-indicated-deg") > 20) {setprop("/mig29/instrumentation/SEI-31/indicated_tangage_L", 20);}
    if (getprop("/mig29/instrumentation/KPP/pitch-indicated-deg") < -20) {setprop("/mig29/instrumentation/SEI-31/indicated_tangage_L", -20);}
   }
  settimer(ind_LT_31, 0);
}

var RIS_a = 0;

 var ind_RIS_31 = func {
  var RIS_a = getprop("/mig29/systems/SEI-31/pAS");
  var RIS_a = getprop("/mig29/instrumentation/US-1600/airspeed-kmh")-RIS_a;
  setprop("/mig29/systems/SEI-31/pAS", getprop("/mig29/instrumentation/US-1600/airspeed-kmh"));
  if (getprop("/mig29/systems/SEI-31/on") == 1)
   {
    if (RIS_a > -0.5 and RIS_a < 0.5) {setprop("/mig29/instrumentation/SEI-31/RIS", 0);}
    if (RIS_a > 0.5) {setprop("/mig29/instrumentation/SEI-31/RIS", 1);}
    if (RIS_a < -0.5) {setprop("/mig29/instrumentation/SEI-31/RIS", -1);}
   }
  settimer(ind_RIS_31, 0.1, realtime=0);
}

# Переключатель - "День", "Ночь", "Сетка".

 var DNS31 = func {
  if (getprop("/mig29/controls/ILS-31/view-mode") == 0) {setprop("/mig29/systems/ILS-31/setka", 1);}
  if (getprop("/mig29/controls/ILS-31/view-mode") == 1) {setprop("/mig29/systems/SEI-31/texture", "ILS-31_night.png"); setprop("/mig29/systems/ILS-31/setka", 0);}
  if (getprop("/mig29/controls/ILS-31/view-mode") == 2) {setprop("/mig29/systems/SEI-31/texture", "ILS-31_day.png"); setprop("/mig29/systems/ILS-31/setka", 0);}
}

#
var navmode_a = 0;
var altb = 0;
var altr = 0;
var offset_digits = 0;

 var ILSaltchg = func {
  var navmode_a = getprop("/mig29/instrumentation/SEI-31/indicated-nav-mode");
  if (navmode_a == 2 or getprop("/controls/gear/gear-down") == 1)
   {setprop("/mig29/instrumentation/SEI-31/R", 1);}
  else {setprop("/mig29/instrumentation/SEI-31/R", 0);}
  settimer(ILSaltchg, 0);
}

 var Nav_mode_31 = func {
  if (getprop("/mig29/systems/SEI-31/on") == 1)
   {
    if ((getprop("/mig29/systems/TsVU/navigation")+getprop("/mig29/systems/TsVU/return")+getprop("/mig29/systems/TsVU/landing")) > 0)
     {
      if (getprop("/mig29/systems/TsVU/navigation") == 1 or getprop("/mig29/systems/TsVU/return") == 1)
       {setprop("/mig29/instrumentation/SEI-31/indicated-nav-mode", 1);}
      if (getprop("/mig29/systems/TsVU/landing") == 1) {setprop("/mig29/instrumentation/SEI-31/indicated-nav-mode", 2);}
     }
    else {setprop("/mig29/instrumentation/SEI-31/indicated-nav-mode", 0);}
   }
  settimer(Nav_mode_31, 0.1);
}

# Сдвиг цифр высоты
var sda = 0;

 var ILS_sda = func{
  var sda = getprop("/mig29/instrumentation/SEI-31/indicated_altitude");
  if (sda < 100)
   {
    setprop("/mig29/systems/SEI-31/sda100", 3);
    setprop("/mig29/systems/SEI-31/sda1000", 3);
    setprop("/mig29/systems/SEI-31/sda10000", 3);
   }
  if (sda > 100 and sda < 1000)
   {
    setprop("/mig29/systems/SEI-31/sda100", 2);
    setprop("/mig29/systems/SEI-31/sda1000", 2);
    setprop("/mig29/systems/SEI-31/sda10000", 2);
   }
  if (sda > 1000 and sda < 10000)
   {
    setprop("/mig29/systems/SEI-31/sda100", 1);
    setprop("/mig29/systems/SEI-31/sda1000", 1);
    setprop("/mig29/systems/SEI-31/sda10000", 1);
   }
  if (sda > 10000)
   {
    setprop("/mig29/systems/SEI-31/sda100", 0);
    setprop("/mig29/systems/SEI-31/sda1000", 0);
    setprop("/mig29/systems/SEI-31/sda10000", 0);
   }
  settimer(ILS_sda, 0.05);
}

var SEI_31_distance = 0;
var SEI_31_distance_100 = 0;
var SEI_31_distance_10 = 0;
var SEI_31_distance_1 = 0;
var SEI_31_distance_0 = 0;

 var SEI_31_dist = func {
  if (getprop("/mig29/systems/SEI-31/on") == 0) {return;}
  if (getprop("/mig29/systems/TsVU/landing") == 0) {var SEI_31_distance = getprop("/mig29/systems/TsVU/distance");}
  else {var SEI_31_distance = getprop("/mig29/systems/TsVU/Ldist");}
  if (SEI_31_distance < 1000)
   {
    var SEI_31_distance_100 = int((SEI_31_distance/100));
    var SEI_31_distance_10 = (int((SEI_31_distance/10))-(SEI_31_distance_100*10));
    var SEI_31_distance_1 = (int(SEI_31_distance)-((SEI_31_distance_100*100)+(SEI_31_distance_10*10)));
    var SEI_31_distance_0 = (SEI_31_distance-int(SEI_31_distance))*10;
   }
  else
   {
    var SEI_31_distance_100 = 9;
    var SEI_31_distance_10 = 9;
    var SEI_31_distance_1 = 9;
    var SEI_31_distance_0 = 9;
   }
  setprop("/mig29/instrumentation/SEI-31/PPM_Aer_dist", SEI_31_distance);
  setprop("/mig29/instrumentation/SEI-31/PPM_Aer_dist_100", SEI_31_distance_100);
  setprop("/mig29/instrumentation/SEI-31/PPM_Aer_dist_10", SEI_31_distance_10);
  setprop("/mig29/instrumentation/SEI-31/PPM_Aer_dist_1", SEI_31_distance_1);
  setprop("/mig29/instrumentation/SEI-31/PPM_Aer_dist_0", SEI_31_distance_0);
}

var SEI_31_tH = 0;
var SEI_31_oZPU = 0;

 var SEI_31_oZPUi = func {
  if (getprop("/mig29/systems/SEI-31/on") == 1)
   {
    var SEI_31_Th = getprop("/mig29/instrumentation/PNP-72-12/heading-indicated-deg");
    if (getprop("/mig29/controls/SN/kurs_zadan") == 0) {var SEI_31_oZPU = getprop("/mig29/systems/PNP-72-12/ZPU");}
    if (getprop("/mig29/controls/SN/kurs_zadan") == 1 and getprop("/mig29/systems/TsVU/landing") == 0)
     {var SEI_31_oZPU = getprop("/mig29/systems/TsVU/OPU");}
    if (getprop("/mig29/controls/SN/kurs_zadan") == 1 and getprop("/mig29/systems/TsVU/landing") == 1)
     {var SEI_31_oZPU = getprop("/instrumentation/nav/heading-deg");}
    var SEI_31_oZPU = SEI_31_oZPU-SEI_31_Th;
    if (SEI_31_oZPU > 180) {var SEI_31_oZPU = 360-SEI_31_oZPU;}
    if (SEI_31_oZPU < -180) {var SEI_31_oZPU = 360+SEI_31_oZPU;}
    if (SEI_31_oZPU < -5) {var SEI_31_oZPU = -5;}
    if (SEI_31_oZPU > 5) {var SEI_31_oZPU = 5;}
    var SEI_31_oZPU = SEI_31_oZPU/5;
    setprop("/mig29/instrumentation/SEI-31/VisorMetkaG", SEI_31_oZPU);
   }
  settimer(SEI_31_oZPUi, 0);
}

var SEI_31_oK = 0;
var SEI_31_oG = 0;

 var SEI_31_oKGi = func {
  if (getprop("/mig29/systems/SEI-31/on") == 1)
   {
    if (getprop("/mig29/systems/TsVU/landing") == 1)
     {
      var SEI_31_oG = getprop("fdm/jsbsim/ap/gs-needle-deflection");
      var SEI_31_oK = getprop("fdm/jsbsim/ap/heading-needle-deflection-ils");
      if (getprop("/mig29/systems/SAU/traek_upr") == 1)
       {
        setprop("/mig29/instrumentation/SEI-31/MetkaK", SEI_31_oK);
        setprop("/mig29/instrumentation/SEI-31/MetkaG", SEI_31_oG);
       }
      else
       {
        setprop("/mig29/instrumentation/SEI-31/MetkaK", 0);
        setprop("/mig29/instrumentation/SEI-31/MetkaG", 0);
       }
      if (getprop("/instrumentation/nav/gs-in-range") == 1)
       {setprop("/mig29/instrumentation/SEI-31/K", 1); setprop("/mig29/instrumentation/SEI-31/G", 1);}
      else {setprop("/mig29/instrumentation/SEI-31/K", 0); setprop("/mig29/instrumentation/SEI-31/G", 0);}
     }
   }
  settimer(SEI_31_oKGi, 0);
}

var SEI_31_tot = 0;

 var SEI_31_t_h = func {
  if (getprop("/mig29/systems/electrical/buses/DC27-bus/volts") > 24 and getprop("/mig29/instrumentation/electrical/v115") > 105)
   {
    if (getprop("/mig29/systems/SEI-31/serviceable") == 1) {SEI_31_t1_h();}
    else {SEI_31_t2_h();}
   }
  else
   {
    SEI_31_t2_h();
   }
}

 var SEI_31_t1_h = func {
  var SEI_31_tot = getprop("/mig29/systems/SEI-31/on");
  if (SEI_31_tot == 1) {return;}
  if (SEI_31_tot < 1)
   {
    var SEI_31_tot = 1-SEI_31_tot;
    interpolate("/mig29/systems/SEI-31/on", 1, SEI_31_tot*30);
#    if (getprop("/mig29/systems/SEI-31/ind-serviceable") == 1 and getprop("/mig29/systems/SEI-31/ind-on") < 1)
#     {interpolate("/mig29/systems/SEI-31/ind-on", 1, SEI_31_tot*30);}
#    if (getprop("/mig29/systems/SEI-31/ind-serviceable") == 1 and getprop("/mig29/systems/SEI-31/ind-on") == 1)
   }
}

 var SEI_31_t2_h = func {
  var SEI_31_tot = getprop("/mig29/systems/SEI-31/on");
  if (SEI_31_tot == 0) {return;}
  if (SEI_31_tot > 0) {interpolate("/mig29/systems/SEI-31/on", 0, SEI_31_tot*30);}
}

 var SEI_31_t3_h = func {
  var SEI_31_tot = getprop("/mig29/systems/SEI-31/on");
  if (getprop("/mig29/systems/SEI-31/ind-serviceable") == 1)
   {setprop("/mig29/systems/SEI-31/ind-on", SEI_31_tot)}
  else {setprop("/mig29/systems/SEI-31/ind-on", 0)}
}

 var SEI_31_init = func {
  setprop("/mig29/instrumentation/SEI-31/RIS", 0);
  setprop("/mig29/instrumentation/SEI-31/indicated_airspeed", 0);
  setprop("/mig29/instrumentation/SEI-31/indicated_altitude", 0);
  setprop("/mig29/instrumentation/SEI-31/R", 0);
  setprop("/mig29/instrumentation/SEI-31/K", 0);
  setprop("/mig29/instrumentation/SEI-31/G", 0);
  setprop("/mig29/instrumentation/SEI-31/MetkaG", 0);
  setprop("/mig29/instrumentation/SEI-31/MetkaK", 0);
  setprop("/mig29/instrumentation/SEI-31/VisorMetkaG", 0);
  setprop("/mig29/instrumentation/SEI-31/VisorMetkaV", 0);
  setprop("/mig29/instrumentation/SEI-31/PPM_Aer_dist", 0);
  setprop("/mig29/instrumentation/SEI-31/PPM_Aer_dist_0", 0);
  setprop("/mig29/instrumentation/SEI-31/PPM_Aer_dist_1", 0);
  setprop("/mig29/instrumentation/SEI-31/PPM_Aer_dist_10", 0);
  setprop("/mig29/instrumentation/SEI-31/PPM_Aer_dist_100", 0);
  setprop("/mig29/instrumentation/SEI-31/indicated-mode", 0);
  setprop("/mig29/instrumentation/SEI-31/indicated-nav-mode", 0);
  setprop("/mig29/instrumentation/SEI-31/indicated_tangage_L", 0);
  setprop("/mig29/systems/SEI-31/pAS", 0);
  setprop("/mig29/systems/SEI-31/ind-on", 0);
  setprop("/mig29/systems/SEI-31/ind-serviceable", 1);
  setprop("/mig29/systems/SEI-31/serviceable", 1);
  setprop("/mig29/systems/SEI-31/on", 0);
  SEI_31_gyro();
  ind_speed_31();
  ind_altitude_31();
  ind_LT_31();
  ind_RIS_31();
  Nav_mode_31();
  DNS31();
  ILSaltchg();
  ILS_sda();
  setlistener("/mig29/systems/TsVU/distance", SEI_31_dist);
  setlistener("/mig29/systems/TsVU/Ldist", SEI_31_dist);
  SEI_31_oZPUi();
  SEI_31_oKGi();
  setlistener("/mig29/controls/ILS-31/view-mode", DNS31);
  setlistener("/mig29/instrumentation/electrical/v27", SEI_31_t_h);
  setlistener("/mig29/instrumentation/electrical/v115", SEI_31_t_h);
  setlistener("/mig29/systems/SEI-31/serviceable", SEI_31_t_h);
  setlistener("/mig29/systems/SEI-31/ind-serviceable", SEI_31_t3_h);
  setlistener("/mig29/systems/SEI-31/on", SEI_31_t3_h);
}