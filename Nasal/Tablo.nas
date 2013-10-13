# Табло - скрипт поддержки.
# Сергей "Mercenary_Mercury" Салов.
# Январь 2013.

 var Tablo = func {
  if (getprop("mig29/controls/lighting/kontr_lamp") == 0 and getprop("mig29/systems/engines/s") == 1)
   {
    # Запри фонарь
    if (getprop("mig29/systems/Ekran/CanopyOpen") == 1) {setprop("mig29/instrumentation/Tablo/LockCanopy", 1);}
    else {setprop("mig29/instrumentation/Tablo/LockCanopy", 0);}
    # Отказ двух гидросистем
    if (getprop("mig29/systems/Ekran/MainHydro") == 1 and getprop("mig29/systems/Ekran/BusterHydro") == 1)
     {setprop("mig29/instrumentation/Tablo/BothHydroFault", 1);}
    else {setprop("mig29/instrumentation/Tablo/BothHydroFault", 0);}
    #  Осталось 550 кг
    if (getprop("mig29/systems/Ekran/R500") == 1) {setprop("mig29/instrumentation/Tablo/R550", 1);}
    else {setprop("mig29/instrumentation/Tablo/R550", 0);}
    # Сбрось обороты левого двигателя
    if (getprop("mig29/systems/Ekran/Overheat_Left") == 1) {setprop("mig29/instrumentation/Tablo/ReduceLeft", 1);}
    else {setprop("mig29/instrumentation/Tablo/ReduceLeft", 0);}
    # Сбрось обороты правого двигателя
    if (getprop("mig29/systems/Ekran/Overheat_Right") == 1) {setprop("mig29/instrumentation/Tablo/ReduceRight", 1);}
    else {setprop("mig29/instrumentation/Tablo/ReduceRight", 0);}
    # Запуск левого двигателя
    if (getprop("mig29/systems/engines/start_left") == 1) {setprop("mig29/instrumentation/Tablo/StartLeft", 1);}
    else {setprop("mig29/instrumentation/Tablo/StartLeft", 0);}
    # Запуск правого двигателя
    if (getprop("mig29/systems/engines/start_right") == 1) {setprop("mig29/instrumentation/Tablo/StartRight", 1);}
    else {setprop("mig29/instrumentation/Tablo/StartRight", 0);}
    # Форсаж левого двигателя
    if (getprop("/engines/engine[0]/augmentation") == 1) {setprop("mig29/instrumentation/Tablo/AugLeft", 1);}
    else {setprop("mig29/instrumentation/Tablo/AugLeft", 0);}
    # Форсаж правого двигателя
    if (getprop("/engines/engine[1]/augmentation") == 1) {setprop("mig29/instrumentation/Tablo/AugRight", 1);}
    else {setprop("mig29/instrumentation/Tablo/AugRight", 0);}
    #  Триммер РП
    if (getprop("/controls/flight/rudder-trim") == 0) {setprop("mig29/instrumentation/Tablo/TrimRP", 1);}
    else {setprop("mig29/instrumentation/Tablo/TrimRP", 0);}
    #  Триммер стабилизатора
    if (getprop("/controls/flight/elevator-trim") == 0) {setprop("mig29/instrumentation/Tablo/TrimStabil", 1);}
    else {setprop("mig29/instrumentation/Tablo/TrimStabil", 0);}
    #  Триммер элеронов
    if (getprop("/controls/flight/aileron-trim") == 0) {setprop("mig29/instrumentation/Tablo/TrimAileron", 1);}
    else {setprop("mig29/instrumentation/Tablo/TrimAileron", 0);}
    #  АРУ Взлет-Посадка
    if (getprop("fdm/jsbsim/systems/ARU/Knum") == 1) {setprop("mig29/instrumentation/Tablo/ARU", 1);}
    else {setprop("mig29/instrumentation/Tablo/ARU", 0);}
    # Аварийная насосная станция
    if (getprop("fdm/jsbsim/hs/ns58-1-n") > 0.1 and getprop("fdm/jsbsim/hs/ns58-1-n") > 0.1)
     {setprop("mig29/instrumentation/Tablo/EmergPumpStation", 1);}
    else {setprop("mig29/instrumentation/Tablo/EmergPumpStation", 0);}
    # Давление масла левого двигателя
    if (getprop("mig29/systems/Ekran/OilLeft") == 1) {setprop("mig29/instrumentation/Tablo/OilLeft", 1);}
    else {setprop("mig29/instrumentation/Tablo/OilLeft", 0);}
    # Давление масла правого двигателя
    if (getprop("mig29/systems/Ekran/OilRight") == 1) {setprop("mig29/instrumentation/Tablo/OilRight", 1);}
    else {setprop("mig29/instrumentation/Tablo/OilRight", 0);}
    # Давление масла КСА
    if (getprop("mig29/systems/Ekran/OilKSA") == 1) {setprop("mig29/instrumentation/Tablo/OilKSA", 1);}
    else {setprop("mig29/instrumentation/Tablo/OilKSA", 0);}
    # Опасная высота
    if (getprop("mig29/systems/Ekran/DangerAltitude") == 1) {setprop("mig29/instrumentation/Tablo/DangerAltitude", 1);}
    else {setprop("mig29/instrumentation/Tablo/DangerAltitude", 0);}
    # Навиг готов
    if (getprop("mig29/instrumentation/SN/navig_gotov") == 1) {setprop("mig29/instrumentation/Tablo/NavigReady", 1);}
    else {setprop("mig29/instrumentation/Tablo/NavigReady", 0);}
    # Ускор готов
    if (getprop("mig29/instrumentation/SN/uskor_gotov") == 1) {setprop("mig29/instrumentation/Tablo/AccelReady", 1);}
    else {setprop("mig29/instrumentation/Tablo/AccelReady", 0);}
    # Пожар левого двигателя
    if (getprop("mig29/systems/Ekran/FireLeft") == 1) {setprop("mig29/instrumentation/Tablo/FireLeft", 1);}
    else {setprop("mig29/instrumentation/Tablo/FireLeft", 0);}
    # Пожар правого двигателя
    if (getprop("mig29/systems/Ekran/FireRight") == 1) {setprop("mig29/instrumentation/Tablo/FireRight", 1);}
    else {setprop("mig29/instrumentation/Tablo/FireRight", 0);}
    # Пожар КСА
    if (getprop("mig29/systems/Ekran/FireKSA") == 1) {setprop("mig29/instrumentation/Tablo/FireKSA", 1);}
    else {setprop("mig29/instrumentation/Tablo/FireKSA", 0);}
    # Отказ СОС
    if (getprop("mig29/systems/Ekran/COC_Failure") == 1) {setprop("mig29/instrumentation/Tablo/COCFailure", 1);}
    else {setprop("mig29/instrumentation/Tablo/COCFailure", 0);}
    # Нет резерва СОС
    if (getprop("mig29/systems/Ekran/COC_Not_Reserve") == 1) {setprop("mig29/instrumentation/Tablo/COCNotReserve", 1);}
    else {setprop("mig29/instrumentation/Tablo/COCNotReserve", 0);}
    # Отказ СРО
    if (getprop("mig29/systems/SRO/on") != 1) {setprop("mig29/instrumentation/Tablo/SROFailure", 1);}
    else {setprop("mig29/instrumentation/Tablo/SROFailure", 0);}
    # СРО: Включи резервный код
    if (getprop("mig29/instrumentation/SRO/Reserve") == 1) {setprop("mig29/instrumentation/Tablo/SROReserve", 1);}
    else {setprop("mig29/instrumentation/Tablo/SROReserve", 0);}
    # Контроль левого воздухозаборника
    if (getprop("mig29/systems/ARV/TL") == 1) {setprop("mig29/instrumentation/Tablo/ControlIntakeLeft", 1);}
    else {setprop("mig29/instrumentation/Tablo/ControlIntakeLeft", 0);}
    # Контроль правого воздухозаборника
    if (getprop("mig29/systems/ARV/TR") == 1) {setprop("mig29/instrumentation/Tablo/ControlIntakeRight", 1);}
    else {setprop("mig29/instrumentation/Tablo/ControlIntakeRight", 0);}
    # Отказ трансформатора
    if (getprop("mig29/systems/electrical/buses/AC3x200-bus-1/volts") > 200 and getprop("mig29/systems/electrical/suppliers/TSZZOSS4B-1/volts") < 25)
     {setprop("mig29/instrumentation/Tablo/TransformerFailure", 1);}
    else {setprop("mig29/instrumentation/Tablo/TransformerFailure", 0);}
    # Отказ АПУС
    if (getprop("fdm/jsbsim/systems/ARU/APUS-serviceable") != 1) {setprop("mig29/instrumentation/Tablo/APUSFaulure", 1);}
    else {setprop("mig29/instrumentation/Tablo/APUSFaulure", 0);}
    # Демпфер выключен
    if (getprop("mig29/instrumentation/PU-189/damp") != 1) {setprop("mig29/instrumentation/Tablo/DamperOff", 1);}
    else {setprop("mig29/instrumentation/Tablo/DamperOff", 0);}
    
    
   }
  if (getprop("mig29/controls/lighting/kontr_lamp") == 0 and getprop("mig29/systems/engines/s") == 0)
   {
    setprop("mig29/instrumentation/Tablo/APUSFaulure", 0);
    setprop("mig29/instrumentation/Tablo/AccelReady", 0);
    setprop("mig29/instrumentation/Tablo/ARU", 0);
    setprop("mig29/instrumentation/Tablo/AugLeft", 0);
    setprop("mig29/instrumentation/Tablo/AugRight", 0);
    setprop("mig29/instrumentation/Tablo/BothHydroFault", 0);
    setprop("mig29/instrumentation/Tablo/COCFailure", 0);
    setprop("mig29/instrumentation/Tablo/COCNotReserve", 0);
    setprop("mig29/instrumentation/Tablo/ControlIntakeLeft", 0);
    setprop("mig29/instrumentation/Tablo/ControlIntakeRight", 0);
    setprop("mig29/instrumentation/Tablo/DamperOff", 0);
    setprop("mig29/instrumentation/Tablo/DangerAltitude", 0);
    setprop("mig29/instrumentation/Tablo/EmergPumpStation", 0);
    setprop("mig29/instrumentation/Tablo/FireKSA", 0);
    setprop("mig29/instrumentation/Tablo/FireLeft", 0);
    setprop("mig29/instrumentation/Tablo/FireRight", 0);
    setprop("mig29/instrumentation/Tablo/LockCanopy", 0);
    setprop("mig29/instrumentation/Tablo/NavigReady", 0);
    setprop("mig29/instrumentation/Tablo/OilKSA", 0);
    setprop("mig29/instrumentation/Tablo/OilLeft", 0);
    setprop("mig29/instrumentation/Tablo/OilRight", 0);
    setprop("mig29/instrumentation/Tablo/R550", 0);
    setprop("mig29/instrumentation/Tablo/ReduceLeft", 0);
    setprop("mig29/instrumentation/Tablo/ReduceRight", 0);
    setprop("mig29/instrumentation/Tablo/SROFailure", 0);
    setprop("mig29/instrumentation/Tablo/SROReserve", 0);
    setprop("mig29/instrumentation/Tablo/StartLeft", 0);
    setprop("mig29/instrumentation/Tablo/StartRight", 0);
    setprop("mig29/instrumentation/Tablo/TransformerFailure", 0);
    setprop("mig29/instrumentation/Tablo/TrimAileron", 0);
    setprop("mig29/instrumentation/Tablo/TrimRP", 0);
    setprop("mig29/instrumentation/Tablo/TrimStabil", 0);
   }
  if (getprop("mig29/controls/lighting/kontr_lamp") == 1)
   {
    setprop("mig29/instrumentation/Tablo/AccelReady", 1);
    setprop("mig29/instrumentation/Tablo/APUSFaulure", 1);
    setprop("mig29/instrumentation/Tablo/ARU", 1);
    setprop("mig29/instrumentation/Tablo/AugLeft", 1);
    setprop("mig29/instrumentation/Tablo/AugRight", 1);
    setprop("mig29/instrumentation/Tablo/BothHydroFault", 1);
    setprop("mig29/instrumentation/Tablo/COCFailure", 1);
    setprop("mig29/instrumentation/Tablo/COCNotReserve", 1);
    setprop("mig29/instrumentation/Tablo/ControlIntakeLeft", 1);
    setprop("mig29/instrumentation/Tablo/ControlIntakeRight", 1);
    setprop("mig29/instrumentation/Tablo/DamperOff", 1);
    setprop("mig29/instrumentation/Tablo/DangerAltitude", 1);
    setprop("mig29/instrumentation/Tablo/EmergPumpStation", 1);
    setprop("mig29/instrumentation/Tablo/FireKSA", 1);
    setprop("mig29/instrumentation/Tablo/FireLeft", 1);
    setprop("mig29/instrumentation/Tablo/FireRight", 1);
    setprop("mig29/instrumentation/Tablo/LockCanopy", 1);
    setprop("mig29/instrumentation/Tablo/NavigReady", 1);
    setprop("mig29/instrumentation/Tablo/OilKSA", 1);
    setprop("mig29/instrumentation/Tablo/OilLeft", 1);
    setprop("mig29/instrumentation/Tablo/OilRight", 1);
    setprop("mig29/instrumentation/Tablo/R550", 1);
    setprop("mig29/instrumentation/Tablo/ReduceLeft", 1);
    setprop("mig29/instrumentation/Tablo/ReduceRight", 1);
    setprop("mig29/instrumentation/Tablo/SROFailure", 1);
    setprop("mig29/instrumentation/Tablo/SROReserve", 1);
    setprop("mig29/instrumentation/Tablo/StartLeft", 1);
    setprop("mig29/instrumentation/Tablo/StartRight", 1);
    setprop("mig29/instrumentation/Tablo/TransformerFailure", 1);
    setprop("mig29/instrumentation/Tablo/TrimAileron", 1);
    setprop("mig29/instrumentation/Tablo/TrimRP", 1);
    setprop("mig29/instrumentation/Tablo/TrimStabil", 1);
   }
  settimer(Tablo, 0);
}

 Tablo_init = func {

  Tablo();
}