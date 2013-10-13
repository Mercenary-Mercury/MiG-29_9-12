# ЦВУ-М (2205)
# Автор: Сергей "Mercenary_Mercury" Салов
# Ноябрь 2012

var lat1 = 0;
var lat2 = 0;
var lon1= 0;
var lon2 = 0;

var TCS_Lat = 0;
var TCS_Lon = 0;
var PPM_Lat = 0;
var PPM_Lon = 0;

var Dl = 0;
var Dla = 0;
var OPU = 0;

 var OPU_Dist = func {
  if (getprop("/mig29/systems/TsVU/OPU_Dist") == 1)
   {
    var TCS = geo.Coord.new();
    var PPM = geo.Coord.new();
    var TCS_Lat = getprop("/fdm/jsbsim/systems/TsVU/Coord/TCS_Lat");
    var TCS_Lon = getprop("/fdm/jsbsim/systems/TsVU/Coord/TCS_Lon");
    var PPM_Lat = getprop("/mig29/systems/TsVU/Coord/PPM_Lat");
    var PPM_Lon = getprop("/mig29/systems/TsVU/Coord/PPM_Lon");
    TCS.set_latlon(TCS_Lat, TCS_Lon, 0);
    PPM.set_latlon(PPM_Lat, PPM_Lon, 0);
    OPU = TCS.course_to(PPM);
    if (OPU < 0) {var OPU = OPU=360;}
    Dl = TCS.distance_to(PPM);
    setprop("/mig29/systems/TsVU/OPU", OPU);
    setprop("/mig29/systems/TsVU/distance", (Dl/1000));
   }
  settimer(OPU_Dist, 0);
}


var Mayak_Heading = 0;
var Mayak_Dist = 0;
var Mayak_Alt = 0;
var Mayak_Lat = 0;
var Mayak_Lon = 0;
var Mayak_A = 0;

 var Mayak_K = func {
  if (getprop("/mig29/systems/TsVU/RSBN") == 1)
   {
    var Mayak_Heading = getprop("/instrumentation/nav/heading-deg");
    var Mayak_Dist = getprop("/instrumentation/nav/nav-distance");
    var Mayak_Lat = getprop("/mig29/systems/TsVU/Coord/Mayak_Lat");
    var Mayak_Lon = getprop("/mig29/systems/TsVU/Coord/Mayak_Lon");
    var Mayak_A = geodtocart(Mayak_Lat, Mayak_Lon, 388);
    var Mayak_Lat = Mayak_A[0];
    var Mayak_Lon = Mayak_A[1];
    var Mayak_Alt = Mayak_A[2];
    if (Mayak_Heading < 180) {var Mayak_Heading = Mayak_Heading+180;}
    else {var Mayak_Heading = Mayak_Heading-180;}
    var Mayak_Lat = Mayak_Lat+(Mayak_Dist*math.cos(Mayak_Heading));
    var Mayak_Lon = Mayak_Lon+(Mayak_Dist*math.sin(Mayak_Heading));
    var Mayak_A = carttogeod(Mayak_Lat, Mayak_Lon, Mayak_Alt);
    setprop("/mig29/systems/TsVU/Coord/Korr_Lat", Mayak_A[0]);
    setprop("/mig29/systems/TsVU/Coord/Korr_Lon", Mayak_A[1]);
   }
  settimer(Mayak_K, 0.1);
}

var h_deg_norm = 0;

 H_Deg_Norm = func {
  var h_deg_norm = getprop("/fdm/jsbsim/systems/IK-VK/heading-deg");
  if (h_deg_norm > 180)
   {
    var h_deg_norm = h_deg_norm-180;
    if (h_deg_norm > 90) {var h_deg_norm = 180-h_deg_norm;}
   }
  else
   {
    if (h_deg_norm > 90) {var h_deg_norm = 180-h_deg_norm;}
   }
  setprop("/fdm/jsbsim/calculations/TsVU/h-deg-norm", h_deg_norm);
  settimer(H_Deg_Norm, 0);
}

 var D40 = func {
  if (getprop("/mig29/systems/TsVU/landing") == 0 and getprop("/mig29/systems/TsVU/fly") == 1)
   {
    if (getprop("/mig29/systems/TsVU/distance") > 40) {setprop("/mig29/instrumentation/SN/d40", 0);}
    if (getprop("/mig29/systems/TsVU/distance") < 40) {setprop("/mig29/instrumentation/SN/d40", 1);}
   }
  if (getprop("/mig29/systems/TsVU/landing") == 1 and getprop("/mig29/systems/TsVU/fly") == 1)
   {
    if (getprop("/mig29/systems/TsVU/Ldist") > 40) {setprop("/mig29/instrumentation/SN/d40", 0);}
    if (getprop("/mig29/systems/TsVU/Ldist") < 40) {setprop("/mig29/instrumentation/SN/d40", 1);}
   }
  settimer(D40, 0);
}

 var KorrInd0 = func {
  if (getprop("/mig29/systems/TsVU/RSBN") == 0) {setprop("/mig29/instrumentation/SN/korr", 0);}
  if (getprop("/mig29/systems/TsVU/RSBN") == 1) {KorrInd1();}
}

 var KorrInd1 = func {
  if (getprop("/mig29/systems/TsVU/RSBN") == 1) {setprop("/mig29/instrumentation/SN/korr", 1);}
}

var BPK_ChKK = 0;
var BPK_Freq = 0;

# Блок преобразования кодов
 var BPK = func {
  var BPK_ChKK = getprop("/mig29/systems/TsVU/Aer/ILS_ChKK");
  if (BPK_ChKK == 0) {var BPK_ChKK = 1;}
  var BPK_ChKK = BPK_ChKK/2;
  if (BPK_ChKK == int(BPK_ChKK))  # Если номер четный
   {var BPK_Freq = (BPK_ChKK*0.2)+107.95;}
  else
   {
    var BPK_ChKK = BPK_ChKK+0.5;
    var BPK_Freq = (int(BPK_ChKK)*0.2)+107.9;
   }
  setprop("/mig29/systems/TsVU/Aer/ILS_Freq", BPK_Freq);
}

var BPK_RSBN_ChKK = 0;
var BPK_RSBN_Freq = 0;

# Блок преобразования кодов - РСБН
 var BPK_RSBN = func {
  var BPK_RSBN_ChKK = getprop("/mig29/systems/TsVU/Mayak/Mayak_Channel");
  if (BPK_RSBN_ChKK < 0) {var BPK_RSBN_ChKK = 1;}
  var BPK_RSBN_Freq = (BPK_RSBN_ChKK*0.05)+115.95;
  setprop("/mig29/systems/TsVU/Mayak/Freq", BPK_RSBN_Freq);
}

 var BPK_dch = func {
  if (getprop("/mig29/systems/TsVU/landing") == 1)
   {setprop("/instrumentation/nav/frequencies/selected-mhz", getprop("/mig29/systems/TsVU/Aer/ILS_Freq"));}
  else {setprop("/instrumentation/nav/frequencies/selected-mhz", getprop("/mig29/systems/TsVU/Mayak/Freq"));}
}

 var Aer_PPM_handler = func {
  if (getprop("/mig29/controls/SN/PPM_Aer") == 0) {setprop("/mig29/systems/SN/PPM_Aer", 0);}
  if (getprop("/mig29/controls/SN/PPM_Aer") == 1) {setprop("/mig29/systems/SN/PPM_Aer", 1);}
  if (getprop("/mig29/systems/SN/PPM_Aer_s") == 1) {Aer_PPM_1_handler();}
  if (getprop("/mig29/systems/SN/PPM_Aer_s") == 2) {Aer_PPM_2_handler();}
  if (getprop("/mig29/systems/SN/PPM_Aer_s") == 3) {Aer_PPM_3_handler();}
}

 var Aer_PPM_1_handler = func {
  if (getprop("/mig29/systems/TsVU/on") == 0) {return;}
  if (getprop("/mig29/systems/SN/PPM_Aer") == 0)
   {
    setprop("/mig29/systems/TsVU/Coord/PPM_Lat", getprop("/mig29/systems/TsVU/Coord/Aer1_Lat"));
    setprop("/mig29/systems/TsVU/Coord/PPM_Lon", getprop("/mig29/systems/TsVU/Coord/Aer1_Lon"));
    setprop("/mig29/systems/TsVU/Aer/Course", getprop("/mig29/systems/TsVU/Aer/Aer1_Course"));
    setprop("/mig29/systems/TsVU/Aer/ILS_ChKK1", getprop("/mig29/systems/TsVU/Aer/Aer1_ILS_ChKK1"));
    setprop("/mig29/systems/TsVU/Aer/ILS_ChKK2", getprop("/mig29/systems/TsVU/Aer/Aer1_ILS_ChKK2"));
    setprop("/mig29/systems/SN/PPM_Aer_s", 1);
    setprop("/mig29/instrumentation/SN/PPM_Aer1", 1);
    setprop("/mig29/instrumentation/SN/PPM_Aer2", 0);
    setprop("/mig29/instrumentation/SN/PPM_Aer3", 0);
   }
  if (getprop("/mig29/systems/SN/PPM_Aer") == 1)
   {
    setprop("/mig29/systems/TsVU/Coord/PPM_Lat", getprop("/mig29/systems/TsVU/Coord/PPM1_Lat"));
    setprop("/mig29/systems/TsVU/Coord/PPM_Lon", getprop("/mig29/systems/TsVU/Coord/PPM1_Lon"));
    setprop("/mig29/systems/SN/PPM_Aer_s", 1);
    setprop("/mig29/instrumentation/SN/PPM_Aer1", 1);
    setprop("/mig29/instrumentation/SN/PPM_Aer2", 0);
    setprop("/mig29/instrumentation/SN/PPM_Aer3", 0);
   }
}
 var Aer_PPM_2_handler = func {
  if (getprop("/mig29/systems/TsVU/on") == 0) {return;}
  if (getprop("/mig29/systems/SN/PPM_Aer") == 0)
   {
    setprop("/mig29/systems/TsVU/Coord/PPM_Lat", getprop("/mig29/systems/TsVU/Coord/Aer2_Lat"));
    setprop("/mig29/systems/TsVU/Coord/PPM_Lon", getprop("/mig29/systems/TsVU/Coord/Aer2_Lon"));
    setprop("/mig29/systems/TsVU/Aer/Course", getprop("/mig29/systems/TsVU/Aer/Aer2_Course"));
    setprop("/mig29/systems/TsVU/Aer/ILS_ChKK1", getprop("/mig29/systems/TsVU/Aer/Aer2_ILS_ChKK1"));
    setprop("/mig29/systems/TsVU/Aer/ILS_ChKK2", getprop("/mig29/systems/TsVU/Aer/Aer2_ILS_ChKK2"));
    setprop("/mig29/systems/SN/PPM_Aer_s", 2);
    setprop("/mig29/instrumentation/SN/PPM_Aer1", 0);
    setprop("/mig29/instrumentation/SN/PPM_Aer2", 1);
    setprop("/mig29/instrumentation/SN/PPM_Aer3", 0);
   }
  if (getprop("/mig29/systems/SN/PPM_Aer") == 1)
   {
    setprop("/mig29/systems/TsVU/Coord/PPM_Lat", getprop("/mig29/systems/TsVU/Coord/PPM2_Lat"));
    setprop("/mig29/systems/TsVU/Coord/PPM_Lon", getprop("/mig29/systems/TsVU/Coord/PPM2_Lon"));
    setprop("/mig29/systems/SN/PPM_Aer_s", 2);
    setprop("/mig29/instrumentation/SN/PPM_Aer1", 0);
    setprop("/mig29/instrumentation/SN/PPM_Aer2", 1);
    setprop("/mig29/instrumentation/SN/PPM_Aer3", 0);
   }
}
 var Aer_PPM_3_handler = func {
  if (getprop("/mig29/systems/TsVU/on") == 0) {return;}
  if (getprop("/mig29/controls/SN/PPM_Aer") == 0)
   {
    setprop("/mig29/systems/TsVU/Coord/PPM_Lat", getprop("/mig29/systems/TsVU/Coord/Aer3_Lat"));
    setprop("/mig29/systems/TsVU/Coord/PPM_Lon", getprop("/mig29/systems/TsVU/Coord/Aer3_Lon"));
    setprop("/mig29/systems/TsVU/Aer/Course", getprop("/mig29/systems/TsVU/Aer/Aer3_Course"));
    setprop("/mig29/systems/TsVU/Aer/ILS_ChKK1", getprop("/mig29/systems/TsVU/Aer/Aer3_ILS_ChKK1"));
    setprop("/mig29/systems/TsVU/Aer/ILS_ChKK2", getprop("/mig29/systems/TsVU/Aer/Aer3_ILS_ChKK2"));
    setprop("/mig29/systems/SN/PPM_Aer_s", 3);
    setprop("/mig29/instrumentation/SN/PPM_Aer1", 0);
    setprop("/mig29/instrumentation/SN/PPM_Aer2", 0);
    setprop("/mig29/instrumentation/SN/PPM_Aer3", 1);
   }
  if (getprop("mig29/controls/SN/PPM_Aer") == 1)
   {
    setprop("/mig29/systems/TsVU/Coord/PPM_Lat", getprop("/mig29/systems/TsVU/Coord/PPM3_Lat"));
    setprop("/mig29/systems/TsVU/Coord/PPM_Lon", getprop("/mig29/systems/TsVU/Coord/PPM3_Lon"));
    setprop("/mig29/systems/SN/PPM_Aer_s", 3);
    setprop("/mig29/instrumentation/SN/PPM_Aer1", 0);
    setprop("/mig29/instrumentation/SN/PPM_Aer2", 0);
    setprop("/mig29/instrumentation/SN/PPM_Aer3", 1);
   }
}

 var Mayak_1_handler = func {
  if (getprop("/mig29/systems/TsVU/on") == 0) {return;}
  setprop("/mig29/systems/TsVU/Coord/Mayak_Lat", getprop("/mig29/systems/TsVU/Coord/Mayak1_Lat"));
  setprop("/mig29/systems/TsVU/Coord/Mayak_Lon", getprop("/mig29/systems/TsVU/Coord/Mayak1_Lon"));
  setprop("/mig29/systems/TsVU/Mayak/Mayak_Channel", getprop("/mig29/systems/TsVU/Mayak/Mayak1_Channel"));
  setprop("/mig29/instrumentation/SN/Mayak1", 1);
  setprop("/mig29/instrumentation/SN/Mayak2", 0);
  setprop("/mig29/instrumentation/SN/Mayak3", 0);
}
 var Mayak_2_handler = func {
  if (getprop("/mig29/systems/TsVU/on") == 0) {return;}
  setprop("/mig29/systems/TsVU/Coord/Mayak_Lat", getprop("/mig29/systems/TsVU/Coord/Mayak2_Lat"));
  setprop("/mig29/systems/TsVU/Coord/Mayak_Lon", getprop("/mig29/systems/TsVU/Coord/Mayak2_Lon"));
  setprop("/mig29/systems/TsVU/Mayak/Mayak_Channel", getprop("/mig29/systems/TsVU/Mayak/Mayak2_Channel"));
  setprop("/mig29/instrumentation/SN/Mayak1", 0);
  setprop("/mig29/instrumentation/SN/Mayak2", 1);
  setprop("/mig29/instrumentation/SN/Mayak3", 0);
}
 var Mayak_3_handler = func {
  if (getprop("/mig29/systems/TsVU/on") == 0) {return;}
  setprop("/mig29/systems/TsVU/Coord/Mayak_Lat", getprop("/mig29/systems/TsVU/Coord/Mayak3_Lat"));
  setprop("/mig29/systems/TsVU/Coord/Mayak_Lon", getprop("/mig29/systems/TsVU/Coord/Mayak3_Lon"));
  setprop("/mig29/systems/TsVU/Mayak/Mayak_Channel", getprop("/mig29/systems/TsVU/Mayak/Mayak3_Channel"));
  setprop("/mig29/instrumentation/SN/Mayak1", 0);
  setprop("/mig29/instrumentation/SN/Mayak2", 0);
  setprop("/mig29/instrumentation/SN/Mayak3", 1);
}

 var Sbros_handler = func {
  if (getprop("/mig29/systems/TsVU/on") == 0) {return;}
  if (getprop("/mig29/controls/SN/sbros") == 0)
   {
    setprop("/mig29/systems/TsVU/sbros", 0);
    setprop("/mig29/instrumentation/SN/sbros", 0);
   }
  if (getprop("/mig29/controls/SN/sbros") == 1)
   {
    setprop("/mig29/systems/TsVU/sbros", 1);
    setprop("/mig29/instrumentation/SN/sbros", 1);
   }
}

 var VK_obnul_handler = func {
  if (getprop("/mig29/systems/TsVU/on") == 0) {return;}
  if (getprop("/mig29/controls/SN/VK_obnul") == 0)
   {
    setprop("/mig29/systems/TsVU/VK_obnul", 0);
    setprop("/mig29/instrumentation/SN/VK_obnul", 0);
   }
  if (getprop("/mig29/controls/SN/VK_obnul") == 1)
   {
    setprop("/mig29/systems/TsVU/VK_obnul", 1);
    setprop("/mig29/instrumentation/SN/VK_obnul", 1);
   }
}

 var Return_handler = func {
  if (getprop("/mig29/systems/TsVU/on") == 0) {return;}
  if (getprop("/mig29/systems/TsVU/return") == 0)
   {
    setprop("/mig29/systems/TsVU/return", 1);
    setprop("/mig29/instrumentation/SN/return", 1);
    setprop("/mig29/systems/SN/PPM_Aer", 0);
    Aer_PPM_1_handler();
    return;
   }
  if (getprop("/mig29/systems/TsVU/return") == 1)
   {
    setprop("/mig29/systems/TsVU/return", 0);
    setprop("/mig29/instrumentation/SN/return", 0);
    setprop("/mig29/systems/SN/PPM_Aer", getprop("/mig29/controls/SN/PPM_Aer"));
    mode_Navigation();
    return;
   }
}

  var Channels_handler = func {
  if (getprop("/mig29/systems/TsVU/on") == 0) {return;}
  if (getprop("/mig29/controls/SN/channels") == 0)
   {
    if (getprop("/mig29/controls/SN/kurs") == 0) {setprop("/mig29/systems/TsVU/Aer/ILS_ChKK", getprop("/mig29/systems/TsVU/Aer/ILS_ChKK1"));}
    else {setprop("/mig29/systems/TsVU/Aer/ILS_ChKK", getprop("/mig29/systems/TsVU/Aer/ILS_ChKK2"));}
    return;
   }
  if (getprop("/mig29/controls/SN/channels") == 1)
   {
    setprop("/mig29/systems/TsVU/Aer/ILS_ChKK", getprop("/mig29/controls/SN/pos"));
    setprop("/mig29/systems/TsVU/Mayak/Channel", getprop("/mig29/controls/SN/navigat2"));
    return;
   }
}

  var Kur_handler = func {
  if (getprop("/mig29/systems/TsVU/on") == 0) {return;}
  if (getprop("/mig29/controls/SN/kur") == 0)
   {setprop("/mig29/systems/TsVU/kur", 0); return;}
  if (getprop("/mig29/controls/SN/kur") == 1)
   {setprop("/mig29/systems/TsVU/kur", 1); return;}
}

  var Kurs_handler = func {
  if (getprop("/mig29/systems/TsVU/on") == 0) {return;}
  if (getprop("/mig29/controls/SN/kurs") == 0)
   {
    if (getprop("/mig29/systems/TsVU/Aer/Course") < 180) {return;}
    else
     {
      setprop("/mig29/systems/TsVU/Aer/Course", getprop("/mig29/systems/TsVU/Aer/Course")-180);
      return;
     }
   }
  if (getprop("/mig29/controls/SN/kurs") == 1)
   {
    if (getprop("/mig29/systems/TsVU/Aer/Course") < 180)
     {
      setprop("/mig29/systems/TsVU/Aer/Course", getprop("/mig29/systems/TsVU/Aer/Course")+180);
      return;
     }
    else {return;}
   }
}

  var Landing_handler = func {
  if (getprop("/mig29/systems/TsVU/on") == 0) {return;}
  if (getprop("/mig29/controls/SN/landing") == 0)
   {
    if (getprop("/mig29/systems/TsVU/landing") == 1)
     {
      setprop("/mig29/systems/TsVU/landing", 0);
      return;
     }
    else {return;}
   }
  if (getprop("/mig29/controls/SN/landing") == 1)
   {
    if (getprop("/mig29/systems/TsVU/landing") == 0)
     {
      setprop("/mig29/systems/TsVU/landing", 1);
      mode_Landing();
      return;
     }
    else {return;}
   }
}

var KorrCoord_TCS = 0;
var KorrCoord_PPM = 0;
var KorrCoord_Lat1 = 0;
var KorrCoord_Lat2 = 0;
var KorrCoord_Lon1 = 0;
var KorrCoord_Lon2 = 0;

 var KorrCoord = func {
  if (getprop("/mig29/systems/TsVU/fly") == 1)
   {
    if (getprop("/mig29/systems/TsVU/RSBN") == 1 and getprop("/mig29/systems/TsVU/VK_obnul") == 0)
     {
      if (getprop("/fdm/jsbsim/systems/TsVU/Korr") == 0) {setprop("/fdm/jsbsim/systems/TsVU/Korr", 1);}
      var KorrCoord_TCS = geo.Coord.new();
      var KorrCoord_PPM = geo.Coord.new();
      var KorrCoord_Lat1 = getprop("/fdm/jsbsim/systems/TsVU/Coord/TCS_Lat");
      var KorrCoord_Lon1 = getprop("/fdm/jsbsim/systems/TsVU/Coord/TCS_Lon");
      var KorrCoord_Lat2 = getprop("/position/latitude-deg");
      var KorrCoord_Lon2 = getprop("/position/longitude-deg");
      KorrCoord_TCS.set_latlon(KorrCoord_Lat1, KorrCoord_Lon1, 0);
      KorrCoord_PPM.set_latlon(KorrCoord_Lat2, KorrCoord_Lon2, 0);
      if (KorrCoord_TCS.distance_to(KorrCoord_PPM) < 40000)
       {
        setprop("/fdm/jsbsim/systems/TsVU/Coord/KCS_Lat", getprop("/position/latitude-deg"));
        setprop("/fdm/jsbsim/systems/TsVU/Coord/KCS_Lon", getprop("/position/longitude-deg"));
#        setprop("/fdm/jsbsim/systems/TsVU/Coord/KCS_Lat", getprop("/mig29/systems/TsVU/Coord/Korr_Lat"));
#        setprop("/fdm/jsbsim/systems/TsVU/Coord/KCS_Lon", getprop("/mig29/systems/TsVU/Coord/Korr_Lon"));
       }
     }
    if (getprop("/mig29/systems/TsVU/RSBN") == 0) {setprop("/fdm/jsbsim/systems/TsVU/Korr", 0);}
   }
  if (getprop("/mig29/controls/SN/rabota-podgotovka") == 1 and getprop("/mig29/systems/TsVU/VK_obnul") == 1)
   {
    var KorrCoord_TCS = geo.Coord.new();
    var KorrCoord_PPM = geo.Coord.new();
    var KorrCoord_Lat1 = getprop("/fdm/jsbsim/systems/TsVU/Coord/TCS_Lat");
    var KorrCoord_Lon1 = getprop("/fdm/jsbsim/systems/TsVU/Coord/TCS_Lon");
    var KorrCoord_Lat2 = getprop("/position/latitude-deg");
    var KorrCoord_Lon2 = getprop("/position/longitude-deg");
    KorrCoord_TCS.set_latlon(KorrCoord_Lat1, KorrCoord_Lon1, 0);
    KorrCoord_PPM.set_latlon(KorrCoord_Lat2, KorrCoord_Lon2, 0);
    if (KorrCoord_TCS.distance_to(KorrCoord_PPM) < 40000)
     {
      setprop("/fdm/jsbsim/systems/TsVU/Coord/KCS_Lat", getprop("/mig29/systems/TsVU/Coord/PPM_Lat"));
      setprop("/fdm/jsbsim/systems/TsVU/Coord/KCS_Lon", getprop("/mig29/systems/TsVU/Coord/PPM_Lon"));
      setprop("/fdm/jsbsim/systems/TsVU/Korr", 1);
     }
   }
  settimer(KorrCoord, 0);
}

 var Mayak_PPM = func {
  if (getprop("/mig29/controls/SN/rabota-podgotovka") == 1 and getprop("/mig29/systems/TsVU/sbros") == 1)
   {
    setprop("/mig29/systems/TsVU/Coord/PPM_Lat", getprop("/mig29/systems/TsVU/Coord/Mayak_Lat"));
    setprop("/mig29/systems/TsVU/Coord/PPM_Lon", getprop("/mig29/systems/TsVU/Coord/Mayak_Lon"));
   }
}

var time_elapsed_src = 0;
var time_elapsed = 0;

 var SN_prepare = func {
  if (getprop("/mig29/systems/SN/prepare_act") == 1) {return;}
  var time_elapsed = getprop("/sim/time/elapsed-sec");
  setprop("/mig29/systems/SN/time-elapsed", time_elapsed);
  setprop("/mig29/systems/SN/prepare_act", 1);
  var coordLat = getprop("/mig29/systems/TsVU/Coord/Aer1_Lat");
  var coordLon = getprop("/mig29/systems/TsVU/Coord/Aer1_Lon");
#  var coordLat = (coordLat-(0.192433705*math.sin(2*coordLat)));
  setprop("/fdm/jsbsim/systems/TsVU/Coord/ICS_Lat", coordLat);
  setprop("/fdm/jsbsim/systems/TsVU/Coord/ICS_Lon", coordLon);
  setprop("/fdm/jsbsim/systems/TsVU/Coord/TCS_Lat", coordLat);
  setprop("/fdm/jsbsim/systems/TsVU/Coord/TCS_Lon", coordLon);
  SN_prepare_p();
}

 var SN_prepare_p = func {
  var time_elapsed_src = getprop("/mig29/systems/SN/time-elapsed");
  var time_elapsed = getprop("/sim/time/elapsed-sec");
  var time_elapsed = time_elapsed-time_elapsed_src;
  if (getprop("/gear/gear[1]/wow") == 0) {return;}
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
  if (getprop("/mig29/o/snv") == 1) {SN_navig(); return;}
#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
  if (getprop("/mig29/controls/SN/rabota-podgotovka") == 1)
   {
    if (time_elapsed > 90 and time_elapsed < 180)
     {
      var time_elapsed = 180-time_elapsed;
      settimer(SN_uskor, time_elapsed);
      return;
     }
    if (time_elapsed > 389 and time_elapsed < 720) {SN_uskor(); return;}
   }  
  if (time_elapsed > 720) {SN_navig(); return;}
  if (getprop("/mig29/instrumentation/SN/PPM_Aer1") == 0 and getprop("/mig29/instrumentation/SN/PPM_Aer2") == 0 and getprop("/mig29/instrumentation/SN/PPM_Aer3") == 0)
   {Aer_PPM_1_handler();}
  if (getprop("/mig29/instrumentation/SN/Mayak1") == 0 and getprop("/mig29/instrumentation/SN/Mayak2") == 0 and getprop("/mig29/instrumentation/SN/Mayak3") == 0)
   {Mayak_1_handler();}
  settimer(SN_prepare_p, 1);
}

 var SN_navig = func {
  if (getprop("/mig29/instrumentation/SN/navig_gotov") == 0)
   {
    setprop("/mig29/instrumentation/SN/navig_gotov", 1);
   }
  if (getprop("/gear/gear[1]/wow") == 0 and getprop("/mig29/controls/SN/rabota-podgotovka") == 1)
   {
    setprop("/fdm/jsbsim/systems/TsVU/Coord/TCS_Lat", getprop("/fdm/jsbsim/position/lat-gc-deg"));
    setprop("/fdm/jsbsim/systems/TsVU/Coord/ICS_Lon", getprop("/fdm/jsbsim/position/long-gc-deg"));

    setprop("/fdm/jsbsim/systems/TsVU/Coord/ICS_Lon_R", getprop("/fdm/jsbsim/position/long-gc-deg"));
    setprop("/fdm/jsbsim/systems/TsVU/IRS_on", 1);
    setprop("/fdm/jsbsim/systems/TsVU/RS", 1);
    setprop("/mig29/instrumentation/SN/navig_gotov", 0);
    setprop("/mig29/systems/TsVU/fly", 1);
    mode_Navigation();
    return;
   }
  settimer(SN_navig, 1);
}

 var SN_uskor = func {
  if (getprop("/mig29/instrumentation/SN/uskor_gotov") == 0)
   {
    setprop("/mig29/instrumentation/SN/uskor_gotov", 1);
   }
  if (getprop("/gear/gear[1]/wow") == 0)
   {
    setprop("/fdm/jsbsim/systems/TsVU/Coord/ICS_Lon_R", getprop("/fdm/jsbsim/position/long-gc-deg"));
    setprop("/fdm/jsbsim/systems/TsVU/RS", 2);
    setprop("/fdm/jsbsim/systems/TsVU/KRS_on", 1);
    setprop("/mig29/instrumentation/SN/uskor_gotov", 0);
    setprop("/mig29/systems/TsVU/fly", 1);
    mode_Navigation();
    return;
   }
  settimer(SN_uskor, 1);
}

 var mode_Navigation = func {
  setprop("/mig29/systems/TsVU/navigation", 1);
  setprop("/mig29/systems/TsVU/return", 0);
  setprop("/mig29/systems/TsVU/landing", 0);
  setprop("/mig29/systems/TsVU/go-around", 0);
  setprop("/mig29/systems/TsVU/OPU_Dist", 1);
}

var mLA_Altitude = 0;
var mLA_Angle = 0;
var mLA_Course = 0;     # Аэр
var mLA_Distance = 0;
var mLA_Heading = 0;

 var mode_LandingA = func {
  if (getprop("/mig29/systems/TsVU/return") == 1)
   {
    if (getprop("/mig29/instrumentation/UV-30-3/indicated-altitude-m") < 1400) {var mLA_Altitude = 1;}   # Высота менее 1400 метров
    else {var mLA_Altitude = 0;}
    var mLA_Course = getprop("/mig29/instrumentation/PNP-72-12/heading-indicated-deg")-getprop("/mig29/systems/TsVU/Aer/Course");
    if (mLA_Course > 180) {mLA_Course = 360-mLA_Course;}
    if (mLA_Course < -180) {var mLA_Course = 360+mLA_Course;}
    if (mLA_Course < 60 and mLA_Course > -60) {var mLA_Course = 1;}     # Разность курса менее 60 градусов
    else {var mLA_Course = 0;}
    var mLA_Distance = getprop("/mig29/systems/TsVU/distance");
    
    if (mLA_Distance > 8 and mLA_Distance < 37.5)
     {
      var mLA_Angle = getprop("/mig29/systems/TsVU/OPU")-getprop("/mig29/systems/TsVU/Aer/Course");
      if (mLA_Angle == 0) {var mLA_Angle = 1;}
      else
       {
        var mLA_Distance = 29.5-(mLA_Distance-8);
        if (mLA_Distance == 0) {var mLA_Distance = 6.123;}
        if (mLA_Distance == 1) {var mLA_Distance = 7.181;}
        if (mLA_Distance > 0 and mLA_Distance < 1) {var mLA_Distance = (mLA_Distance*0.03620339)+6.123;}
        if (mLA_Angle > 0)
         {
          if (mLA_Angle > 180) {var mLA_Angle = mLA_Angle-360;}
          if (mLA_Angle < mLA_Distance) {var mLA_Angle = 1;}
          else {var mLA_Angle = 0;}
         }
        if (mLA_Angle < 0)
         {
          if (mLA_Angle < -180) {var mLA_Angle = mLA_Angle-360;}
          var mLA_Angle = mLA_Angle*(-1);
          if (mLA_Angle < mLA_Distance) {var mLA_Angle = 1;}
          else {var mLA_Angle = 0;}
         }
       }
     }
    if (mLA_Altitude == 1 and mLA_Angle == 1 and mLA_Course == 1) {setprop("/mig29/systems/TsVU/landing", 1); mode_Landing(); return;}
    
   }
  else {return;}
  settimer(mode_LandingA, 0);
}

 var mode_Landing = func {
  if (getprop("/mig29/systems/TsVU/landing") == 1)
   {
    setprop("/mig29/systems/TsVU/Ldist", getprop("/instrumentation/nav/gs-distance")/1000);
    setprop("/mig29/systems/TsVU/oKurs", getprop("/fdm/jsbsim/ap/heading-needle-deflection-ils"));
    setprop("/mig29/systems/TsVU/oGlissada", getprop("/fdm/jsbsim/ap/gs-needle-deflection"));
   }
  if (getprop("/mig29/systems/TsVU/landing") == 0)
   {
#    setprop("/mig29/systems/TsVU/Ldist", 0);
    setprop("/mig29/systems/TsVU/oKurs", 0);
    setprop("/mig29/systems/TsVU/oGlissada", 0);
    return;
   }
  settimer(mode_Landing, 0);
}

 var RSBN_ = func {
  if (getprop("/mig29/systems/TsVU/on") == 1 and getprop("/mig29/controls/SN/rabota-podgotovka") == 1)
   {
    if (getprop("/instrumentation/nav/in-range") == 1)
     {
      setprop("/mig29/systems/TsVU/RSBN", 1);
      if (getprop("/mig29/instrumentation/SN/korr") == 0) {KorrInd1();}
     }
    else {setprop("/mig29/systems/TsVU/RSBN", 0); settimer(KorrInd0, 60);}
   }
  settimer(RSBN_, 0.05);
}

var SNv115 = 0;
var SNv36 = 0;
var SNv27 = 0;

 var TsVU_power = func {
  var SNv115 = getprop("/mig29/systems/electrical/buses/AC1x115-bus-navigation/volts");
  var SNv36 = getprop("/mig29/systems/electrical/buses/AC3x36-bus-navigation/volts");
  var SNv27 = getprop("/mig29/systems/electrical/buses/DC27-bus-navigation/volts");
  if (SNv115 > 108 and SNv36 > 33 and SNv27 > 24)
   {
    if (getprop("/mig29/systems/TsVU/serviceable") == 1) {setprop("/mig29/systems/TsVU/on", 1); SN_prepare();}
    else {setprop("/mig29/systems/TsVU/on", 0);}
   }
}

var coordAlt = 0;
var coordLat = 0;
var coordLon = 0;

 TsVU_init = func {
  var coordAlt = getprop("/fdm/jsbsim/position/radius-to-vehicle-ft");
  var coordLat = getprop("/fdm/jsbsim/position/lat-geod-deg");
  var coordLon = getprop("/fdm/jsbsim/position/long-gc-deg");
  var coordAlt = (coordAlt*0.3048);
  var coordLat = (coordLat-(0.192433705*math.sin(2*coordLat)));
  setprop("/fdm/jsbsim/systems/TsVU/Coord/ICS_Alt", coordAlt);
  setprop("/fdm/jsbsim/systems/TsVU/Coord/ICS_Lat", coordLat);
  setprop("/fdm/jsbsim/systems/TsVU/Coord/ICS_Lon", coordLon);
  setprop("/fdm/jsbsim/systems/TsVU/Coord/TCS_Alt", coordAlt);
  setprop("/fdm/jsbsim/systems/TsVU/Coord/TCS_Lat", coordLat);
  setprop("/fdm/jsbsim/systems/TsVU/Coord/TCS_Lon", coordLon);
  setprop("/fdm/jsbsim/systems/TsVU/pos/BarAltS", getprop("fdm/jsbsim/position/h-sl-meters"));
  setprop("/mig29/systems/TsVU/Aer/Course", 0);
  setlistener("/mig29/systems/TsVU/Aer/Course", Channels_handler);
  setprop("/mig29/systems/TsVU/Aer/ILS_ChKK", 1);
  setlistener("/mig29/systems/TsVU/Aer/ILS_ChKK", BPK);
  setprop("/mig29/systems/TsVU/Aer/ILS_ChKK1", 1);
  setprop("/mig29/systems/TsVU/Aer/ILS_ChKK2", 1);
  setprop("/mig29/systems/TsVU/Aer/ILS_Freq", 0);
  setprop("/mig29/systems/TsVU/Coord/Aer1_Lat", 0.0);
  setprop("/mig29/systems/TsVU/Coord/Aer1_Lon", 0.0);
  setprop("/mig29/systems/TsVU/Aer/Aer1_Course", 0.0);
  setprop("/mig29/systems/TsVU/Aer/Aer1_ILS_ChKK1", 1);
  setprop("/mig29/systems/TsVU/Aer/Aer1_ILS_ChKK2", 1);
  setprop("/mig29/systems/TsVU/Coord/Aer2_Lat", 0.0);
  setprop("/mig29/systems/TsVU/Coord/Aer2_Lon", 0.0);
  setprop("/mig29/systems/TsVU/Aer/Aer2_Course", 0.0);
  setprop("/mig29/systems/TsVU/Aer/Aer2_ILS_ChKK1", 1);
  setprop("/mig29/systems/TsVU/Aer/Aer2_ILS_ChKK2", 1);
  setprop("/mig29/systems/TsVU/Coord/Aer3_Lat", 0.0);
  setprop("/mig29/systems/TsVU/Coord/Aer3_Lon", 0.0);
  setprop("/mig29/systems/TsVU/Aer/Aer3_Course", 0.0);
  setprop("/mig29/systems/TsVU/Aer/Aer3_ILS_ChKK1", 1);
  setprop("/mig29/systems/TsVU/Aer/Aer3_ILS_ChKK2", 1);
  setprop("/mig29/systems/TsVU/Coord/Mayak_Lat", 0.0);
  setprop("/mig29/systems/TsVU/Coord/Mayak_Lon", 0.0);
  setprop("/mig29/systems/TsVU/Mayak/Channel", 1);
  setlistener("/mig29/systems/TsVU/Mayak/Mayak_Channel", BPK_RSBN);
  setprop("/mig29/systems/TsVU/Mayak/Freq", 116.0);
  setprop("/mig29/systems/TsVU/Coord/Mayak1_Lat", 0.0);
  setprop("/mig29/systems/TsVU/Coord/Mayak1_Lon", 0.0);
  setprop("/mig29/systems/TsVU/Mayak/Mayak1_Channel", 1);
  setprop("/mig29/systems/TsVU/Coord/Mayak2_Lat", 0.0);
  setprop("/mig29/systems/TsVU/Coord/Mayak2_Lon", 0.0);
  setprop("/mig29/systems/TsVU/Mayak/Mayak2_Channel", 1);
  setprop("/mig29/systems/TsVU/Coord/Mayak3_Lat", 0.0);
  setprop("/mig29/systems/TsVU/Coord/Mayak3_Lon", 0.0);
  setprop("/mig29/systems/TsVU/Mayak/Mayak3_Channel", 1);
  setprop("/mig29/systems/TsVU/Coord/PPM1_Lat", 0.0);
  setprop("/mig29/systems/TsVU/Coord/PPM1_Lon", 0.0);
  setprop("/mig29/systems/TsVU/Coord/PPM2_Lat", 0.0);
  setprop("/mig29/systems/TsVU/Coord/PPM2_Lon", 0.0);
  setprop("/mig29/systems/TsVU/Coord/PPM3_Lat", 0.0);
  setprop("/mig29/systems/TsVU/Coord/PPM3_Lon", 0.0);
  setprop("/mig29/systems/TsVU/Coord/PPM_Lat", 0.0);
  setprop("/mig29/systems/TsVU/Coord/PPM_Lon", 0.0);
  setprop("/mig29/systems/TsVU/Coord/Korr_Lat", 0.0);
  setprop("/mig29/systems/TsVU/Coord/Korr_Lon", 0.0);
  setprop("/mig29/systems/SN/PPM_Aer_s", 0);
  setprop("/mig29/systems/SN/PPM_Aer", 0);
  setprop("/mig29/systems/TsVU/Ldist", 0);
  setprop("/mig29/controls/SN/IKV", 0);
  setprop("/mig29/controls/SN/channels", 0);
  setlistener("/mig29/controls/SN/channels", Channels_handler);
  setprop("/mig29/controls/SN/PPM_Aer", 0);
  setlistener("/mig29/controls/SN/PPM_Aer", Aer_PPM_handler);
  setprop("/mig29/controls/SN/kur", 0);
  setlistener("/mig29/controls/SN/kur", Kur_handler);
  setprop("/mig29/controls/SN/sbros", 0);
  setlistener("/mig29/controls/SN/sbros", Sbros_handler);
  setprop("/mig29/controls/SN/VK_obnul", 0);
  setlistener("/mig29/controls/SN/VK_obnul", VK_obnul_handler);
  setprop("/mig29/controls/SN/return", 0);
  setlistener("/mig29/controls/SN/return", Return_handler);
  setprop("/mig29/controls/SN/kurs", 0);
  setlistener("/mig29/controls/SN/kurs", Kurs_handler);
  setprop("/mig29/controls/SN/krug", 0);
  setprop("/mig29/controls/SN/landing", 0);
  setlistener("/mig29/controls/SN/landing", Landing_handler);
  setprop("/mig29/controls/SN/opozn", 0);
  setprop("/mig29/controls/SN/navigat1", 0);
  setprop("/mig29/controls/SN/navigat2", 0);
  setprop("/mig29/controls/SN/pos", 1);
  setprop("/mig29/controls/SN/rabota-podgotovka", 0);
  setprop("/mig29/controls/SN/kurs_zadan", 0);
  setprop("/mig29/instrumentation/SN/PPM_Aer1", 0);
  setprop("/mig29/instrumentation/SN/PPM_Aer2", 0);
  setprop("/mig29/instrumentation/SN/PPM_Aer3", 0);
  setprop("/mig29/instrumentation/SN/Mayak1", 0);
  setprop("/mig29/instrumentation/SN/Mayak2", 0);
  setprop("/mig29/instrumentation/SN/Mayak3", 0);
  setprop("/mig29/instrumentation/SN/sbros", 0);
  setprop("/mig29/instrumentation/SN/VK_obnul", 0);
  setprop("/mig29/instrumentation/SN/return", 0);
  setprop("/mig29/instrumentation/SN/navig_gotov", 0);
  setprop("/mig29/instrumentation/SN/uskor_gotov", 0);
  
  setprop("/instrumentation/nav/gs-distance", 0);
  setprop("/instrumentation/nav/gs-needle-deflection-norm", 0);
  
  setprop("/mig29/systems/SN/time-elapsed", 0);
  
  setprop("/mig29/systems/TsVU/OPU", 0);
  setprop("/mig29/systems/TsVU/distance", 0);
  setprop("/mig29/systems/TsVU/navigation", 0);
  setprop("/mig29/systems/TsVU/return", 0);
  setlistener("/mig29/systems/TsVU/return", mode_LandingA);
  setprop("/mig29/systems/TsVU/landing", 0);
  setlistener("/mig29/systems/TsVU/landing", BPK_dch);
  setprop("/mig29/systems/TsVU/sbros", 0);
  setlistener("/mig29/systems/TsVU/sbros", Mayak_PPM);
  setprop("/mig29/systems/TsVU/VK_obnul", 0);
  setprop("/mig29/systems/TsVU/RSBN", 0);

  setlistener("/mig29/systems/TsVU/Aer/ILS_Freq", BPK_dch);
  setlistener("/mig29/systems/TsVU/Mayak/Freq", BPK_dch);

  setprop("/mig29/systems/TsVU/on", 0);
  setlistener("/mig29/systems/TsVU/on", Kur_handler);
  setprop("/mig29/systems/TsVU/serviceable", 1);
  setprop("/mig29/systems/SN/prepare_act", 0);
  setprop("/mig29/systems/TsVU/OPU_Dist", 0);

  setlistener("/mig29/switches/navigation", TsVU_power);
  setlistener("/mig29/systems/electrical/buses/AC1x115-bus-navigation/volts", TsVU_power);
  setlistener("/mig29/systems/electrical/buses/AC3x36-bus-navigation/volts", TsVU_power);
  setlistener("/mig29/systems/electrical/buses/DC27-bus-navigation/volts", TsVU_power);
  
  setlistener("/mig29/controls/SN/navigat2", Channels_handler);
  setlistener("/mig29/controls/SN/pos", Channels_handler);
  
  OPU_Dist();
  H_Deg_Norm();
  D40();
  RSBN_();
  BPK_dch();
  Mayak_K();
  KorrCoord();
  
  print("TsVU-M init");
}