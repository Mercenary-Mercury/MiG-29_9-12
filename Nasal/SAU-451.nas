#
# SAU support
# Sergey "Mercenary_Mercury" Salov
# 2012
#

var HEADING_DEVIATION_LIMIT = 20.0;
var GLIDESLOPE_DEVIATION_LIMIT = 10.0;
var GO_AROUND_PITCH_RAD = 0.2;
var PITCH_YOKE_LIMIT = 0.5;
var BANK_YOKE_LIMIT = 0.5;

var sau_property_update = func {
 settimer(sau_property_update, 0);



# Heading ILS SAU support
 var LOCALIZER_CONST = 0.7;
 var GLIDESLOPE_CONST = 0.7;

 var param = num(getprop("instrumentation/nav[0]/heading-needle-deflection"));
 if (param == nil) {param = 0.0;}
 setprop("/fdm/jsbsim/ap/ils-epsilon", param * LOCALIZER_CONST);

# Glideslope ILS SAU support
   param = num(getprop("instrumentation/nav[0]/gs-rate-of-climb"));
   if (param == nil) {param = 0.0;}

   # with sanity check
   if (abs(param) < 100) {setprop("/fdm/jsbsim/ap/input-glideslope-speed", param * GLIDESLOPE_CONST);}

   param = num(getprop("instrumentation/nav[0]/gs-needle-deflection"));
   if (param == nil) {param = 0.0;}
   if (abs(param) < 100) {setprop("/fdm/jsbsim/ap/input-glideslope-delta", param *  GLIDESLOPE_CONST);}

#
# VOR support
 var radial_actual = "instrumentation/nav[0]/radials/actual-deg";
 var radial_reciprocal = "instrumentation/nav[0]/radials/reciprocal-radial-deg";
 var radial_selected = "instrumentation/nav[0]/radials/selected-deg";
 var to_flag_prop = "instrumentation/nav[0]/to-flag";
 var to_flag = getprop( to_flag_prop );
 if( to_flag == nil ) {to_flag = 0.0;}
 if( to_flag ) {param = getprop(radial_reciprocal);}
 else {param = getprop(radial_actual);}
 if (param == nil) {param = 0.0;}
 var param2 = getprop(radial_selected);
 if (param2 == nil) {param2 = 0.0;}
 param = param - param2;
 if (param < -180.0) {param = 360.0 + param;}
 if (param > 180.0) {param = 360.0 - param;}
 if ( to_flag ) {param = -param;}
 setprop("/fdm/jsbsim/ap/input-heading-delta", param);
#
#
#Delivery gyro heading to TKS compass system
 param = getprop("orientation/heading-deg")+
	getprop("instrumentation/heading-indicator[0]/offset-deg");
 if( param < 0.0 ) param = param + 360.0;
 if( param > 360.0 ) param = param - 360.0;
 setprop("/fdm/jsbsim/ap/input-heading-gyro-1", param);

 param = getprop("orientation/heading-deg")+
	getprop("instrumentation/heading-indicator/offset-deg");
 if( param < 0.0 ) param = param + 360.0;
 if( param > 360.0 ) param = param - 360.0;
 setprop("/fdm/jsbsim/ap/input-heading-gyro-2", param);
#
#Delivery magnetic heading to TKS compass system

 param = getprop("orientation/heading-magnetic-deg");
 if( param == nil ) param = 0.0;
 setprop("/fdm/jsbsim/ap/input-magnetic-heading", param);
#
#Delivery brakes
 param = getprop("controls/gear/brake-left");
 if( param == nil ) param = 0.0;
 setprop("/fdm/jsbsim/gear/brake-left", param);
 param = getprop("controls/gear/brake-right");
 if( param == nil ) param = 0.0;
 setprop("/fdm/jsbsim/gear/brake-right", param);
 param = getprop("controls/gear/brake-parking");
 if( param == nil ) param = 0.0;
 setprop("/fdm/jsbsim/gear/brake-parking", param);
# delivery steering parameters
 param = getprop("controls/gear/steering");
 if( param == nil ) param = 0.0;
 setprop("/fdm/jsbsim/gear/steering", param);
 param = getprop("controls/gear/nose-wheel-steering");
 if( param == nil ) param = 0.0;
 setprop("/fdm/jsbsim/gear/nose-wheel-steering", param);
#

# PNP 

# "Plane" handle
 param = getprop("/mig29/instrumentation/PNP-72-12/course");
 if( param == nil ) {param = 0.0;}
 setprop("/fdm/jsbsim/ap/input-heading-pnp", param);

# ZK handle
 param = getprop("tu154/switches/zk-selector");
 if( param == nil ) param = 0.0;

 param = getprop("/mig29/instrumentation/PNP-72-12/course");
 if (param == nil) {param = 0.0;}
 setprop("/fdm/jsbsim/ap/input-heading-zk", param);

 var needles = getprop("/mig29/systems/SAU/strelki");
 if (needles == nil) {needles = 0.0;}
   var needles = 1;
 if (needles != 0.0)
  {
   # Directors
   param = getprop("/fdm/jsbsim/ap/pitch-error");
   if (param == nil) {param = 0.0;}
   if (getprop("/fdm/jsbsim/ap/pitch-selector") != 5.0) {param = 0.0;}
   setprop("/mig29/instrumentation/KPP/pitch-director", param);

   param = getprop("/fdm/jsbsim/ap/roll-error");
   if (param == nil)  {param = 0.0;}
   if (getprop("/fdm/jsbsim/ap/roll-selector") != 5.0) {param = 0.0;}
   setprop("/mig29/instrumentation/KPP/roll-director", param);
  }
 else
  {
   interpolate("/mig29/instrumentation/KPP/pitch-director", 0.3, 1.0);
   interpolate("/mig29/instrumentation/KPP/roll-director", 0.3, 1.0);
  }	


# Pitch auto trim
 var K_AUTOTRIM = -0.001;#-0.01
 var THRESHOLD_AUTOTRIM = 0.05;

 if( getprop("/fdm/jsbsim/ap/pitch-hold") == 1.0 )
    if( getprop("/mig29/switches/long-control") == 1.0 )
	{
	var pitch_error = getprop("/fdm/jsbsim/ap/pitch-hold-pid");
	if( pitch_error == nil ) pitch_error = 0.0;
	var pitch_trim = getprop("controls/flight/elevator-trim");
	if( pitch_trim == nil ) pitch_trim = 0.0;
	if( abs( pitch_error ) > THRESHOLD_AUTOTRIM )
	setprop("controls/flight/elevator-trim", pitch_trim + K_AUTOTRIM * pitch_error );
	}
	
# Glideslope auto switch
 if (getprop("/fdm/jsbsim/fcs/flap-pos-deg") > 40.0)
   if (getprop("/fdm/jsbsim/ap/roll-selector") == 5.0)
    if (getprop("/fdm/jsbsim/ap/pitch-selector") != 5.0)
      if (getprop("instrumentation/nav[0]/gs-needle-deflection") < 0.2)
       if (getprop("instrumentation/nav[0]/gs-needle-deflection") > 0.0)
	{sau_glideslope();}
		
# Go around procedure
 if (getprop("/fdm/jsbsim/ap/pitch-selector") == 5.0)
    if (getprop("/fdm/jsbsim/fcs/throttle-cmd-norm[0]") > 0.9)
    	if (!getprop("/fdm/jsbsim/ap/go-around"))
    		{sau_start_go_around();}
    		

}


# SAU control

var sau_stab_on = func {
if( sau_powered() == 0 ) return;

var kren = getprop("/mig29/systems/SAU/cmd-kren");
if( kren == nil ) kren = 0.0;
var tang = getprop("/mig29/systems/SAU/cmd-tang");
if( tang == nil ) tang = 0.0;

	if( kren != 0  ) 
	{
	setprop("/mig29/instrumentation/SAU/stab", 1.0 );
	sau_stab_roll();
	setprop("/fdm/jsbsim/ap/roll-hold", 1.0 );
	}
	
	if( tang != 0  )
	{
	setprop("/mig29/instrumentation/SAU/stab", 1.0 );
	sau_stab_current_pitch();
	setprop("/fdm/jsbsim/ap/pitch-hold", 1.0 );
	}

}

# Демпфер

 var Damp_on = func {
  if (sau_powered() == 0) {return;}
  setprop("/mig29/systems/SAU/damp", 1);
  setprop("/fdm/jsbsim/ap/suu-enable", 1);
}

 var Damp_off = func {
  if (sau_powered() == 0) {return;}
  setprop("/mig29/systems/SAU/damp", 0);
  setprop("/fdm/jsbsim/ap/suu-enable", 0);
}

# Стабилизация

 var Stab_on = func {
  if (sau_powered() == 0) {return;}
  setprop("/mig29/systems/SAU/ap", 1);
  if (getprop("/mig29/systems/TsVU/landing") == 0)
   {setprop("/fdm/jsbsim/ap/control/Stab", 1);}
  if (getprop("/mig29/systems/TsVU/landing") == 1)
   {
    setprop("/mig29/systems/SAU/traek_upr", 2);
    setprop("/fdm/jsbsim/ap/control/Traek_Upr", 2);
   }
}

 var Stab_off = func {
  if (sau_powered() == 0) {return;}
  setprop("/mig29/systems/SAU/ap", 0);
  if (getprop("/fdm/jsbsim/ap/control/Traek_Upr") == 0)
   {setprop("/fdm/jsbsim/ap/control/Stab", 0);}
  if (getprop("/fdm/jsbsim/ap/control/Traek_Upr") == 2)
   {
    if (getprop(mig29/systems/SAU/traek_upr) == 0) {setprop("/fdm/jsbsim/ap/control/Traek_Upr", 0);}
    else {setprop("/fdm/jsbsim/ap/control/Traek_Upr", 1);}
   }
  if (getprop("/mig29/systems/SAU/stabvys") == 1)
   {
    setprop("/mig29/systems/SAU/stabvys", 0);
    setprop("/mig29/instrumentation/PU-189/stabvys", 0);
    setprop("/fdm/jsbsim/ap/control/StabH", 0);
   }
}

# Go to manual control
var sau_stab_off = func {
# Autopilot state
# Clear audio warning if stale interpolation
	setprop("/mig29/systems/warning/alarm/sau_warn", 0.0 );
	var state = 0;
	if( getprop("/fdm/jsbsim/ap/pitch-hold") ) state = 1;
	if( getprop("/fdm/jsbsim/ap/roll-hold") ) state = state + 1;
	if( getprop("/mig29/instrumentation/SAU/stab") ) state = state + 1;
	if( state )
	
	setprop("/fdm/jsbsim/ap/roll-selector", 0.0 );
	setprop("/fdm/jsbsim/ap/pitch-selector", 0.0 );
	setprop("/fdm/jsbsim/ap/pitch-hold", 0.0 );
	setprop("/fdm/jsbsim/ap/roll-hold", 0.0 );
# Blue lamp on PU-46
	setprop("/mig29/instrumentation/SAU/stab", 0.0 );
# stop go around 	
	setprop("/fdm/jsbsim/ap/go-around", 0.0);
	
	if( sau_powered() == 1 )
	{
# PN-5 indicators
	setprop( "/mig29/instrumentation/SAU/pitch-state", 1 );
	setprop( "/mig29/instrumentation/SAU/heading-state", 1 );
	setprop("/mig29/instrumentation/SAU/sbros", 1.0 );
	}
	else{
	setprop( "/mig29/instrumentation/SAU/pitch-state", 0 );
	setprop( "/mig29/instrumentation/SAU/heading-state", 0 );
	}
}

# switches on PN-5 
# for XML animation
var sau_stab_kren = func {

var state = getprop("/mig29/instrumentation/SAU/stab");
if ( state == nil ) return;
if ( arg[0] != 0 )	# start roll stabilizer
	{
	if( state != 0 ) 
		{
		sau_stab_roll();
		setprop("/fdm/jsbsim/ap/roll-hold", 1.0 );
		}
	}

else	# stop roll stabilizer
	{
        setprop("/mig29/systems/electrical/indicators/nvu", 0.0 );
        setprop("/mig29/systems/electrical/indicators/vor", 0.0 );
        setprop("/mig29/systems/electrical/indicators/heading", 0.0 );
        setprop("/mig29/systems/electrical/indicators/stab-heading", 0.0 );
	setprop("/fdm/jsbsim/ap/roll-hold", 0.0 );
	if( sau_powered() == 1 )
		{
		setprop( "/mig29/instrumentation/SAU/heading-state", 1 );
		}
	if( getprop("/mig29/systems/SAU/cmd-tang") != 1.0 )
		 setprop("/mig29/instrumentation/SAU/stab", 0.0 ); 
	}
}


var sau_stab_tang = func {
var state = getprop("/mig29/instrumentation/SAU/stab");
if ( state == nil ) return;
if ( arg[0] != 0 )	# start pitch stabilizer
	{
	if( state != 0 ){ 
		sau_stab_current_pitch();
		setprop("/fdm/jsbsim/ap/pitch-hold", 1.0 );
		}
	}

else	# stop pitch stabilizer
	{
	setprop("/fdm/jsbsim/ap/pitch-hold", 0.0 );
	if( sau_powered() == 1 )
		{
		setprop( "/mig29/instrumentation/SAU/pitch-state", 1 );
		}
	if( getprop("/mig29/systems/SAU/cmd-kren") != 1.0 )
		 setprop("/mig29/instrumentation/SAU/stab", 0.0 );
	}
}

# Helpers


var sau_powered = func {
 if (getprop("/mig29/systems/SAU/serviceable") == 1) {return 1;}
 else {return 0;}
}

var sau_stab_current_pitch = func{
	var current_pitch = getprop("/fdm/jsbsim/attitude/pitch-rad");
	if( current_pitch == nil ) current_pitch = 0.0; 
	setprop("/fdm/jsbsim/ap/stab-input-pitch-rad", current_pitch );
	setprop("/fdm/jsbsim/ap/pitch-selector", 1.0 ); # 1 - stabilize pitch
	setprop( "/mig29/instrumentation/SAU/pitch-state", 2 );
	setprop("/mig29/systems/electrical/indicators/stab-pitch", 1.0 );
}

var sau_stab_roll = func{
	setprop("/fdm/jsbsim/ap/stab-input-roll-rad", 0.0 ); # roll=0, stabilize wing level
	setprop("/fdm/jsbsim/ap/roll-selector", 1.0 ); # 1 - stabilize roll
	setprop( "/mig29/instrumentation/SAU/heading-state", 2 );
	setprop("/mig29/systems/electrical/indicators/stab-heading", 1.0 );
}

# "Sbros progr" lamp - reset AP to zero roll state
# also use in heading wheel animation
var sau_reset = func {
if( sau_powered() == 0 ) return;
setprop("/mig29/instrumentation/SAU/sbros", 1.0  );
if( getprop("/fdm/jsbsim/ap/pitch-selector" ) == 5 )
	if( getprop("/mig29/instrumentation/SAU/stab" ) == 1.0 )
		sau_stab_current_pitch(); # Glideslope mode -> stab current pitch
		
setprop("/mig29/instrumentation/SAU/gliss", 0.0  );
setprop("/mig29/systems/electrical/indicators/glideslope", 0.0 );

restore_pnp_needles();
setprop("/fdm/jsbsim/ap/go-around", 0.0);
setprop("/mig29/systems/electrical/indicators/reject", 0.0 );

if( getprop("/mig29/instrumentation/SAU/stab" ) == 1.0 
    and getprop("/mig29/systems/SAU/cmd-kren" ) == 1.0 ) 
    {
    sau_stab_roll();
    setprop("/fdm/jsbsim/ap/roll-hold", 1.0 );
#    setprop("/mig29/systems/electrical/indicators/stab-heading", 1.0 );# lamps on
    }
}


# restore PNP needles
 var restore_pnp_needles = func {
  interpolate( "/mig29/instrumentation/PNP-72-12/course", getprop( "/mig29/instrumentation/PNP-72-12/course-delayed"), 0.5 );
}

# Выключение режимов САУ
 var VyklRezhSAU = func {
  if (sau_powered() == 0) {return;}
  setprop("/fdm/jsbsim/ap/control/Stab", 0);
  setprop("/fdm/jsbsim/ap/control/StabH", 0);
  setprop("/fdm/jsbsim/ap/control/PrivGor", 0);
  setprop("/fdm/jsbsim/ap/control/Uvod", 0);
  setprop("/fdm/jsbsim/ap/control/Traek_Upr", 0);
  setprop("/fdm/jsbsim/ap/control/Povt_Zahod", 0);
  setprop("/mig29/systems/SAU/ap", 0);
  setprop("/mig29/systems/SAU/stab", 0);
  setprop("/mig29/systems/SAU/stabvys", 0);
  setprop("/mig29/systems/SAU/PrivGor", 0);
  setprop("/mig29/systems/SAU/uvod", 0);
  setprop("/mig29/systems/SAU/traek_upr", 0);
  setprop("/mig29/systems/SAU/povt_zahod", 0);
}

var VRDtime = 0;

 var VyklRezhDamp = func {
  if (arg[0] == 0)
   {
    var VRDtime = getprop("sim/time/elapsed-sec");
    setprop("/mig29/systems/SAU/VRDtime", VRDtime);
    Damp_off();
   }
  if (arg[0] == 1)
   {
    var VRDtime = getprop("sim/time/elapsed-sec");
    var VRDtime = VRDtime-3;
    if (VRDtime >= getprop("/mig29/systems/SAU/VRDtime")) {return;}
    Damp_on();
   }
}


# --------------- Pitch modes ------------------------------

var sau_drop_mvh = func{
if( sau_powered() == 0 ) return;
if( getprop("/mig29/instrumentation/SAU/stab" ) == 1.0 )
if( getprop("/fdm/jsbsim/ap/pitch-selector" ) != 1.0 )
	{
        setprop("/fdm/jsbsim/ap/pitch-selector",1);
        setprop("/fdm/jsbsim/ap/pitch-hold",1);
        if( getprop("/mig29/systems/SAU/cmd-tang" ) == 1.0 )
		{
       		setprop( "/mig29/instrumentation/SAU/pitch-state", 2 );
		setprop("/mig29/systems/electrical/indicators/stab-pitch", 1.0 );
		}
	}
}

# Приведение к горизонту
 var PrivGor = func {
  if (sau_powered() == 0) {return;}
  setprop("/mig29/systems/SAU/PrivGor", 1);
  setprop("/mig29/systems/SAU/ap", 0);
  setprop("/mig29/systems/SAU/stabvys", 0);
  setprop("/mig29/systems/SAU/uvod", 0);
  setprop("/mig29/systems/SAU/traek_upr", 0);
  setprop("/mig29/systems/SAU/povt_zahod", 0);
  setprop("/fdm/jsbsim/ap/control/PrivGor", 1);
  setprop("/fdm/jsbsim/ap/control/Stab", 0);
  setprop("/fdm/jsbsim/ap/control/StabH", 0);
  PrivGor_s();
}

 var PrivGor_s = func {
  if (getprop("/fdm/jsbsim/ap/control/PrivGor") == 0) {return;}
  if (getprop("/fdm/jsbsim/calculations/ap/PrivGorType2") == 1)
   {
    setprop("/fdm/jsbsim/ap/control/PrivGor", 0);
    setprop("/mig29/systems/SAU/PrivGor", 0);
    StabVys_on();
    return;
   }
  settimer(PrivGor_s, 0);
}

# Стабилизация высоты
 var StabVys_on = func {
  if (sau_powered() == 0) {return;}
  setprop("/mig29/systems/SAU/stabvys", 1);
  setprop("/mig29/systems/SAU/PrivGor", 0);
  setprop("/mig29/systems/SAU/uvod", 0);
  setprop("/mig29/systems/SAU/traek_upr", 0);
  setprop("/mig29/systems/SAU/povt_zahod", 0);
  setprop("/fdm/jsbsim/ap/control/StabH", 1);
  setprop("/fdm/jsbsim/ap/control/Stab", 0);
}

 var StabVys_off = func {
  if (sau_powered() == 0) {return;}
  setprop("/mig29/systems/SAU/stabvys", 0);
  setprop("/fdm/jsbsim/ap/control/StabH", 0);
  setprop("/fdm/jsbsim/ap/control/Stab", 1);
}

# Увод из зоны "опасной" высоты
 var Uvod_on = func {
  if (sau_powered() == 0) {return;}
  setprop("/mig29/systems/SAU/PrivGor", 0);
  setprop("/mig29/systems/SAU/ap", 0);
  setprop("/mig29/systems/SAU/stabvys", 0);
  setprop("/mig29/systems/SAU/uvod", 1);
  setprop("/mig29/systems/SAU/traek_upr", 0);
  setprop("/mig29/systems/SAU/povt_zahod", 0);
  setprop("/fdm/jsbsim/ap/control/Stab", 0);
  setprop("/fdm/jsbsim/ap/control/StabH", 0);
  setprop("/fdm/jsbsim/ap/control/PrivGor", 0);
  Uvod_s();
}

 var Uvod_off = func {
  if (sau_powered() == 0) {return;}
  setprop("/mig29/systems/SAU/uvod", 0);
  setprop("/fdm/jsbsim/ap/control/Uvod", 0);
}

 var Uvod_s = func {
  if (getprop("/mig29/instrumentation/RV-21/danger_altitude") == 1 and getprop("/controls/gear/gear-down") == 0 and getprop("/fdm/jsbsim/ap/control/Uvod") == 0)
   {setprop("/fdm/jsbsim/ap/control/Uvod", 1);}
  if (getprop("/mig29/instrumentation/RV-21/danger_altitude") == 0 and getprop("/fdm/jsbsim/ap/control/Uvod") == 1)
   {
    setprop("/fdm/jsbsim/ap/control/Uvod", 0);
    setprop("/mig29/systems/SAU/Uvod", 0);
    PrivGor();
    return;
   }
  settimer(Uvod_s, 0);
}

# GLideslope
var sau_glideslope = func{
 if (sau_powered() == 0) {return;}
 if (getprop("/mig29/controls/SAU/p-posadk") != 1.0) {return;}# "podgotovka posadki" not engaged
 if (getprop("/mig29/controls/SAU/p-navigac" ) != 0.0) {return;} # wrong control!
# if (getprop("instrumentation/nav[0]/data-is-valid") != 1) {return;} # Silence in air!
# if (getprop("instrumentation/nav[0]/has-gs") != 1) {return;} # has not glideslope from nav radio!
#deviation too big:
# if (abs(getprop("instrumentation/nav[0]/gs-needle-deflection")) > GLIDESLOPE_DEVIATION_LIMIT) {return;}

 setprop("/mig29/instrumentation/SAU/sbros", 0.0);
 setprop("/fdm/jsbsim/ap/pitch-selector", 5.0); # Glideslope code
 setprop("/mig29/instrumentation/SAU/gliss", 1.0);
 if (getprop("/mig29/systems/SAU/cmd-tang") == 1.0)
	if (getprop("/mig29/instrumentation/SAU/stab") == 1.0)
		setprop("/mig29/systems/electrical/indicators/glideslope", 1.0);
}

# --------------- Heading modes ------------------------------
# Approach
 var sau_approach = func{
  if (sau_powered() == 0) {return;}
  if (getprop("/mig29/controls/SAU/p-posadk") != 1.0) {return;} # "podgotovka posadki" not engaged
  if (getprop("/mig29/controls/SAU/p-navigac") != 0.0) {return;} # wrong control!
#  if (getprop("instrumentation/nav[0]/data-is-valid") != 1) {return;} # Silence in air!
#  if (getprop("instrumentation/nav[0]/nav-loc") != 1) {return;} # has not localizer signal from nav radio!
# deviation too big:
#  if (getprop("/fdm/jsbsim/ap/ils-angle-deviation-abs") > HEADING_DEVIATION_LIMIT) {return;}

  restore_pnp_needles();
  setprop("/fdm/jsbsim/ap/roll-selector", 5); # ILS approach code
  setprop("/mig29/instrumentation/SAU/zahod", 1.0 );
  if (getprop("/mig29/systems/SAU/cmd-kren" ) == 1.0)
	if (getprop("/mig29/instrumentation/SAU/stab" ) == 1.0)
		setprop("/mig29/systems/electrical/indicators/heading", 1.0);
}


# Траекторное управление
 var Traek_Upr_on = func {
  if (sau_powered() == 0) {return;}
  setprop("/mig29/systems/SAU/stabvys", 0);
  setprop("/mig29/systems/SAU/PrivGor", 0);
  setprop("/mig29/systems/SAU/uvod", 0);
  setprop("/mig29/systems/SAU/traek_upr", 1);
  setprop("/mig29/systems/SAU/povt_zahod", 0);
  setprop("/fdm/jsbsim/ap/control/Traek_Upr", 1);
#  setprop("/fdm/jsbsim/ap/control/Stab", 0);
  setprop("/mig29/instrumentation/PU-189/traek_upr", 1);
}

 var Traek_Upr_off = func {
  if (sau_powered() == 0) {return;}
  setprop("/mig29/systems/SAU/traek_upr", 0);
  setprop("/fdm/jsbsim/ap/control/Traek_Upr", 0);
#  setprop("/fdm/jsbsim/ap/control/Stab", 0);
  setprop("/mig29/instrumentation/PU-189/traek_upr", 0);
}

 var sau_shutdown = func {
# Drop sau to idle state
 sau_reset();
 sau_stab_off();

 setprop("/mig29/systems/electrical/indicators/stab-heading", 0.0);
 setprop("/mig29/systems/electrical/indicators/stab-pitch", 0.0);

 if (getprop("/mig29/systems/SAU/serviceable") == 0)
  {
   sau_drop_mvh();
  }
}

setlistener("/mig29/systems/SAU/serviceable", sau_shutdown, 0, 0 );

sau_property_update();

# ********************** Go around procedure ********************************

var sau_start_go_around = func{
	sau_stab_roll();
	sau_stab_current_pitch();
	setprop("/fdm/jsbsim/ap/stab-input-pitch-rad", GO_AROUND_PITCH_RAD );
	setprop("/fdm/jsbsim/ap/go-around", 1.0);
	setprop("/fdm/jsbsim/ap/roll-selector", 1.0);
	setprop("/fdm/jsbsim/ap/input-speed", getprop("/fdm/jsbsim/velocities/vc-fps") );
	interpolate("/fdm/jsbsim/ap/input-speed", 260.0, 35.0 );
#	setprop("/fdm/jsbsim/ap/pitch-selector", 3.0);
# Blank indicators, but stay button-lamps on PN-5 untouched
	setprop("/mig29/systems/electrical/indicators/nvu", 0.0 );
        setprop("/mig29/systems/electrical/indicators/vor", 0.0 );
        setprop("/mig29/systems/electrical/indicators/heading", 0.0 );
        
	setprop("/mig29/systems/electrical/indicators/glideslope", 0.0 );
        setprop("/mig29/systems/electrical/indicators/stab-pitch", 0.0 );
        setprop("/mig29/instrumentation/PU-189/stab-h", 0.0 );
        setprop("/mig29/systems/electrical/indicators/reject", 0.0 );
        
       	setprop("/mig29/systems/electrical/indicators/reject", 1.0 );
	setprop("/mig29/systems/electrical/indicators/stab-heading", 1.0 );
	sau_go_around_handler();
}

var sau_go_around_handler = func{
if( getprop("/fdm/jsbsim/ap/go-around") ) # if not, stop handler
 {
# wait until speed will be increase
 if( getprop("/fdm/jsbsim/velocities/vc-fps") > getprop("/fdm/jsbsim/ap/go-around-speed") )
  settimer( sau_go_around_handler, 0.5 ); # repeat 
 else setprop("/fdm/jsbsim/ap/pitch-selector", 3.0); # speed OK, let's stabilise V
 } 
}

# ========================== yoke ap off =============================
var check_yoke_pitch = func{
var pitch = abs( getprop("/controls/flight/elevator") );
if( pitch < PITCH_YOKE_LIMIT ) return;
if( getprop( "/fdm/jsbsim/ap/pitch-hold" ) ) sau_stab_tang(0); # drop pitch stabilizer
}
var check_yoke_bank = func{
var bank = abs( getprop("/controls/flight/aileron") );
if( bank < BANK_YOKE_LIMIT ) return;
if( getprop( "/fdm/jsbsim/ap/roll-hold" ) ) sau_stab_kren(0); # drop roll
}

#setlistener("/controls/flight/elevator", check_yoke_pitch, 0, 0 );
#setlistener("/controls/flight/aileron", check_yoke_bank, 0, 0 );

#
 SAU_damp = func {
  if (getprop("/mig29/systems/SAU/serviceable") == 0)
   {
    setprop("/mig29/systems/SAU/damp", 0);
    setprop("/mig29/instrumentation/PU-189/damp", 0);
    setprop("/fdm/jsbsim/ap/suu-enable", 0);
   }
  if (getprop("/mig29/systems/SAU/serviceable") == 1)
   {
    setprop("/mig29/systems/SAU/damp", 1);
    setprop("/mig29/instrumentation/PU-189/damp", 1);
    setprop("/fdm/jsbsim/ap/suu-enable", 1);
   }
}

# Power support
 SAU_power = func {
  var acpwr = getprop( "/mig29/systems/electrical/buses/AC3x200-bus-1/volts" );
   if (getprop("/mig29/switches/SAU") == 1)
    {
     if (acpwr == nil) {return;} # system not ready yet
     if (acpwr < 150.0) {return;}
     # hydrosystem fails or busters off
     if (getprop("/fdm/jsbsim/hs/busters-serviceable") < 1.5) {return;}
     # IKV check
     if (getprop("systems/IK-VK/IK-VK-on") == 0) {return;}	# deny stab autopilot if all IKV failure
     # check hydropower of ARM-150M 
     if (getprop("/fdm/jsbsim/hs/arm-150m-roll-serviceable") < 1.0) {return;}
     if (getprop("/fdm/jsbsim/hs/arm-150m-yaw-serviceable") < 1.0) {return;}
     if (getprop("/fdm/jsbsim/hs/arm-150m-pitch-serviceable") < 1.0) {return;}
     # All OK, let's turn power on for SAU
     setprop("/mig29/systems/SAU/serviceable", 1);
#    electrical.AC3x200_bus_1.add_output("SAU", 100.0);
    }
   else
    {
     setprop("/mig29/systems/SAU/serviceable", 0);
#    electrical.AC3x200_bus_1.rm_output("SAU");
    }
}

setlistener("/mig29/switches/SAU", SAU_power, 0, 0 );
setlistener("/mig29/systems/SAU/serviceable", SAU_damp);

#gui.Dialog.new("/sim/gui/dialogs/MiG-29_9-12/nav/dialog", "Aircraft/MiG-29/Dialogs/nav.xml");


#setprop("sim/menubar/default/menu[3]/enabled", 0 );

setprop("/mig29/systems/SAU/VRDtime", 0);

print("SAU started, default autopilot disabled");
