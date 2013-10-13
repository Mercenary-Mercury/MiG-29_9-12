# MiG-29 (9-12) electrical system.
# Based on Tu-154B electrical system
# Aug 2011, Sergey "Mercenary_Mercury" Salow.

#print(getprop("/sim/gui/dialogs"));

var UPDATE_PERIOD = 0.3;

var enode="mig29/systems/electrical/";
var swnode = "mig29/switches/";

var battery1 = nil;
var battery2 = nil;

var GSR = nil;
var GT30_1 = nil;
var GT30_2 = nil;

var SHRAP_AC = nil;
var SHRAP_DC = nil;

var TSZZOSS4B_1 = nil;

var PTO_1000 = nil;
var PTO_1500 = nil;

var DC27_bus_0   = nil;
var DC27_bus   = nil;
var DC27_bus_radio = nil;
var DC27_bus_bortsyst = nil;
var DC27_bus_KVosn = nil;
var DC27_bus_KVzap = nil;
var DC27_bus_navigation = nil;
var DC27_bus_SAU = nil;
var DC27_bus_SRO = nil;
var DC27_bus_Tester = nil;
var DC27_bus_SUV = nil;
var DC27_bus_fuelpump = nil;

var AC3x200_bus_0 = nil;
var AC3x200_bus_1 = nil;
var AC3x200_bus_engine_systems = nil;
var AC3x200_bus_SPP = nil;

var AC1x115_bus_0 = nil;
var AC1x115_bus_1 = nil;
var AC1x115_bus_bortsyst = nil;
var AC1x115_bus_KVosn = nil;
var AC1x115_bus_KVzap = nil;
var AC1x115_bus_navigation = nil;
var AC1x115_bus_SAU = nil;
var AC1x115_bus_SRO = nil;
var AC1x115_bus_WeaponPilons = nil;
var AC1x115_bus_SUV = nil;
var AC1x115_bus_glass_pito_heat = nil;

var AC3x200_bus_PTO1000 = nil;

var AC1x115_bus_PTO1500 = nil;

var AC3x36_bus_1 = nil;
var AC3x36_bus_bortsyst = nil;
var AC3x36_bus_navigation = nil;
var AC3x36_bus_SO = nil;


var SO_DC = nil;
var SRO_DC = nil;
var SRZ_DC = nil;
var RPM_DC = nil;
var RV_DC = nil;
var ARK_DC = nil;
var R_862_DC = nil;
var RI_DC = nil;
var Ekran_DC = nil;
var KRU_DC = nil;
var Biruza_DC = nil;
var RLPK_DC = nil;
var OEPrNK_DC = nil;
var SN_DC = nil;
var KVosn_DC = nil;
var KVzap_DC = nil;
var navigation_DC = nil;
var SAU_DC = nil;
var Tester_DC = nil;
var SUV_DC = nil;

var KVosn_AC = nil;
var KVosnHeat_AC = nil;
var KVzap_AC = nil;
var KVzapHeat_AC = nil;
var navigation_AC115 = nil;
var navigation_AC36 = nil;
var SAU_AC115 = nil;
var SO_AC115 = nil;
var SO_AC36 = nil;
var SRO_AC = nil;
var WeaponPilons_AC = nil;
var SUV_AC = nil;
var GlassFrontHeat_AC = nil;
var GlassUpperHeat_AC = nil;
var GlassMidlleHeat_AC = nil;
var PitotHeat_AC = nil;

var DvigatSyst = nil;
var ToplivNasos = nil;
var SPP = nil;


var last_time = 0.0;
var bat_src_volts = 0.0;
var alt_flag = 0x00;

ammeter_ave = 0.0;

update_buses_thandler = func{

    AC1x115_bus_0.update_voltage();
    AC1x115_bus_1.update_voltage();
    AC1x115_bus_KVosn.update_voltage();
    AC1x115_bus_KVzap.update_voltage();
    AC1x115_bus_navigation.update_voltage();
    AC1x115_bus_SRO.update_voltage();
    AC1x115_bus_WeaponPilons.update_voltage();
    AC1x115_bus_SUV.update_voltage();
    AC1x115_bus_glass_pito_heat.update_voltage();

    AC3x200_bus_0.update_voltage();
    AC3x200_bus_1.update_voltage();
    AC3x200_bus_engine_systems.update_voltage();

    AC1x115_bus_PTO1500.update_voltage();
    AC3x200_bus_PTO1000.update_voltage();

    TSZZOSS4B_1.update();

    AC3x36_bus_1.update_voltage();
    AC3x36_bus_bortsyst.update_voltage();
    AC3x36_bus_navigation.update_voltage();
    AC3x36_bus_SO.update_voltage();

    DC27_bus_0.update_voltage();
    DC27_bus.update_voltage();
    DC27_bus_radio.update_voltage();
    DC27_bus_bortsyst.update_voltage();
    DC27_bus_KVosn.update_voltage();
    DC27_bus_KVzap.update_voltage();
    DC27_bus_navigation.update_voltage();
    DC27_bus_SRO.update_voltage();
    DC27_bus_Tester.update_voltage();
    DC27_bus_SUV.update_voltage();
    DC27_bus_fuelpump.update_voltage();

    PTO_1000.update();
    PTO_1500.update();

    AC1x115_bus_1.update_load();
    AC1x115_bus_KVosn.update_load();
    AC1x115_bus_KVzap.update_load();
    AC1x115_bus_navigation.update_load();
    AC1x115_bus_SRO.update_load();
    AC1x115_bus_WeaponPilons.update_load();
    AC1x115_bus_SUV.update_load();
    AC1x115_bus_glass_pito_heat.update_load();

    AC3x200_bus_1.update_load();
    AC3x200_bus_engine_systems.update_load();

    AC3x36_bus_1.update_load();
    AC3x36_bus_bortsyst.update_load();
    AC3x36_bus_navigation.update_load();
    AC3x36_bus_SO.update_load();

    DC27_bus.update_load();
    DC27_bus_KVosn.update_load();
    DC27_bus_KVzap.update_load();
    DC27_bus_navigation.update_load();
    DC27_bus_SRO.update_load();
    DC27_bus_Tester.update_load();
    DC27_bus_SUV.update_load();
    DC27_bus_fuelpump.update_load();

    settimer(update_buses_thandler, UPDATE_PERIOD );

}


GSR_rpm_handler = func {
    GSR.rpm_handler();
}
GT30_1_rpm_handler = func {
    GT30_1.rpm_handler();
}
GT30_2_rpm_handler = func {
    GT30_2.rpm_handler();
}


generator_1_shandler = func{
    if( getprop("mig29/switches/generator-1")==1 ){
	DC27_bus.add_input( GSR );
	GSR.connect_to_bus( DC27_bus );
	DC27_bus.rm_input( "SHRAP-DC" );
	print(" GSR On");
    } 
    if( getprop("mig29/switches/generator-1")==0 ){
	DC27_bus.rm_input( "GSR" );
	GSR.disconnect_from_bus();
	print("GSR Off");
    }
}

generator_2_shandler = func{
    if( getprop("mig29/switches/generator-2")==1 ){
	AC3x200_bus_1.add_input( GT30_1 );
	AC1x115_bus_1.add_input( GT30_2 );
	GT30_1.connect_to_bus( AC3x200_bus_1 );
	GT30_2.connect_to_bus( AC1x115_bus_1 );
	AC3x200_bus_1.rm_input( "SHRAP-AC" );
	print(" GT30 On");
    } 
    if( getprop("mig29/switches/generator-2")==0 ){
	AC3x200_bus_1.rm_input( "GT30-1" );
	AC1x115_bus_1.rm_input( "GT30-2" );
	GT30_1.disconnect_from_bus();
	GT30_2.disconnect_from_bus();
	print("GT30 Off");
    }
}

Akkum_Bort_Aerodrom_handler = func{
    if( getprop("mig29/switches/Akkum-Bort-Aerodrom")==1 ){
	DC27_bus.add_input( battery1 );
	DC27_bus.add_input( battery2 );
        DC27_bus.add_input( DC27_bus_0 );
        AC3x200_bus_1.add_input( AC3x200_bus_0);
	battery1.connect_to_bus( DC27_bus );
	battery2.connect_to_bus( DC27_bus );
	print("On");
    } 
    if( getprop("mig29/switches/Akkum-Bort-Aerodrom")==0 ){
	DC27_bus.rm_input( battery1.name );
	DC27_bus.rm_input( battery2.name );
        DC27_bus.rm_input( DC27_bus_0 );
        AC3x200_bus_1.rm_input( AC3x200_bus_0);
	battery1.disconnect_from_bus();
	battery2.disconnect_from_bus();
	print("Off");
    }
}

SHRAP_shandler = func{
    if( getprop("mig29/systems/electrical/EP")==1 ){
	DC27_bus_0.rm_input( "SHRAP-DC");
	AC3x200_bus_0.rm_input( "SHRAP-AC");
        setprop("mig29/systems/electrical/EP", 0);
	print(" External power Off");
        var window = screen.window.new(-1, 0, 1, 4);
        window.fg = [0.8, 1, 0.8, 1];
        window.align = "right";
        window.write("External power Off");
        return;
    } 
    if( getprop("mig29/systems/electrical/EP")==0 ){
	DC27_bus_0.add_input( SHRAP_DC );
	AC3x200_bus_0.add_input( SHRAP_AC);
        setprop("mig29/systems/electrical/EP", 1);
	print(" External power On");
        var window = screen.window.new(-1, 0, 1, 4);
        window.fg = [0.8, 1, 0.8, 1];
        window.align = "right";
        window.write("External power On");
        return;
    }
}

PTO_shandler = func{
    if( getprop("mig29/switches/PTO")==1 ){
	AC1x115_bus_PTO1500.add_input( PTO_1500 );
	AC3x200_bus_PTO1000.add_input( PTO_1000 );
	print(" PTO On");
    } 
    if( getprop("mig29/switches/PTO")==0 ){
	AC1x115_bus_PTO1500.rm_input( "PTO-1500" );
	AC3x200_bus_PTO1000.rm_input( "PTO-1000" );
	print("PTO Off");
    }
}

DvigatSyst_shandler = func{
    if( getprop("mig29/switches/engine_systems")==1 ){
	AC3x200_bus_engine_systems.add_input( AC3x200_bus_1 );
	AC3x200_bus_engine_systems.add_output( "DvigatSyst", 20 );
	setprop("fdm/jsbsim/hs/buster-1-switch", 1.0);
	setprop("fdm/jsbsim/hs/buster-2-switch", 1.0);
	print(" Engine systems On");
    } 
    if( getprop("mig29/switches/engine_systems")==0 ){
	AC3x200_bus_engine_systems.rm_input( "AC3x200-bus-1" );
	AC3x200_bus_engine_systems.rm_output( "DvigatSyst" );
	setprop("fdm/jsbsim/hs/buster-1-switch", 0.0);
	setprop("fdm/jsbsim/hs/buster-2-switch", 0.0);
	print("Engine systems Off");
    }
}

ToplivNasos_shandler = func{
    if( getprop("mig29/switches/fuel_pump")==1 ){
	DC27_bus_fuelpump.add_input( DC27_bus );
	DC27_bus_fuelpump.add_output( "ToplivNasos", 20 );
# Немного временно, как сделаю (работающею) нагрузку - уберу.
        setprop("fdm/jsbsim/systems/fuel/on", 1);
	print(" Fuel pump On");
    } 
    if( getprop("mig29/switches/fuel_pump")==0 ){
	DC27_bus_fuelpump.rm_input( "DC27-bus" );
	DC27_bus_fuelpump.rm_output( "ToplivNasos" );
# Немного временно, как сделаю (работающею) нагрузку - уберу.
        setprop("fdm/jsbsim/systems/fuel/on", 0);
	print("Fuel pump Off");
    }
}

SPP_shandler = func{
    if( getprop("mig29/switches/SPP")==1 ){
	AC3x200_bus_SPP.add_input( AC3x200_bus_1 );
	AC3x200_bus_SPP.add_output( "SPP", 1 );
	print(" Antisurge system On");
    } 
    if( getprop("mig29/switches/SPP")==0 ){
	AC3x200_bus_SPP.rm_input( "AC3x200-bus-1" );
	AC3x200_bus_SPP.rm_output( "SPP" );
	print("Antisurge system Off");
    }
}

R_862_shandler = func{
    if( getprop("mig29/switches/radio")==1 ){
	DC27_bus_radio.add_input( DC27_bus );
	DC27_bus_radio.add_output( "R-862-DC", 2 );
	print(" Radio On");
    } 
    if( getprop("mig29/switches/radio")==0 ){
	DC27_bus_radio.rm_input( "DC27-bus" );
	DC27_bus_radio.rm_output( "R-862-DC" );
	print("Radio Off");
    }
}

Bort_Syst_shandler = func{
    if( getprop("mig29/switches/bortsyst")==1 ){
	DC27_bus_bortsyst.add_input( DC27_bus );
	AC1x115_bus_bortsyst.add_input( AC1x115_bus_1 );
	AC3x36_bus_bortsyst.add_input( AC3x36_bus_1 );
#	DC27_bus_bortsyst.add_output( "Bort-Syst-DC", 10 );
#	AC1x115_bus_bortsyst.add_output( "Bort-Syst-AC115", 10 );
#	AC3x36_bus_bortsyst.add_output( "Bort-Syst-AC36", 10 );
	print(" Aircraft systems On");
    } 
    if( getprop("mig29/switches/bortsyst")==0 ){
	DC27_bus_bortsyst.rm_input( "DC27-bus" );
	AC1x115_bus_bortsyst.rm_input( "AC1x115-bus-1" );
	AC3x36_bus_bortsyst.rm_input( "AC3x36-bus-1" );
#	DC27_bus_bortsyst.rm_output( "Bort-Syst-DC" );
#	AC1x115_bus_bortsyst.rm_output( "Bort-Syst-AC115" );
#	AC3x36_bus_bortsyst.rm_output( "Bort-Syst-AC36" );
	print("Aircraft systems Off");
    }
}

Bort_Syst_v27_shandler = func{
    if( getprop("mig29/systems/electrical/suppliers/GSR/volts") > 24){
	DC27_bus_bortsyst.add_output( "ARK-DC", 10 );
        DC27_bus_bortsyst.add_output( "RPM-DC", 10 );
        DC27_bus_bortsyst.add_output( "RV-DC", 10 );
        DC27_bus_bortsyst.add_output( "RI-DC", 10 );
        DC27_bus_bortsyst.add_output( "Ekran-DC", 10 );
        DC27_bus_bortsyst.add_output( "KRU-DC", 10 );
        DC27_bus_bortsyst.add_output( "Biruza-DC", 10 );
        DC27_bus_bortsyst.add_output( "RLPK-DC", 10 );
        DC27_bus_bortsyst.add_output( "OEPrNK-DC", 10 );
        RV_DC.add_input( DC27_bus_bortsyst );
#	print(" Aircraft systems On21");
    } 
    if( getprop("mig29/systems/electrical/suppliers/GSR/volts") < 24 ){
        DC27_bus_bortsyst.rm_output( "KRU-DC", 10 );
        DC27_bus_bortsyst.rm_output( "Biruza-DC", 10 );
        DC27_bus_bortsyst.rm_output( "RLPK-DC", 10 );
        DC27_bus_bortsyst.rm_output( "OEPrNK-DC", 10 );
#	print("Aircraft systems Off21");
    }
}

KVosn_shandler = func{
    if( getprop("mig29/switches/KVosn")==1 ){
	DC27_bus_KVosn.add_input( DC27_bus );
	AC1x115_bus_KVosn.add_input( AC1x115_bus_1 );
	DC27_bus_KVosn.add_output( "KVosn-DC", 5 );
	AC1x115_bus_KVosn.add_output( "KVosn-AC115", 5 );
	AC1x115_bus_KVosn.add_output( "KVosnHeat-AC115", 1 );
	print(" Main attitude and heading reference system On");
    } 
    if( getprop("mig29/switches/KVosn")==0 ){
	DC27_bus_KVosn.rm_input( "DC27-bus" );
	AC1x115_bus_KVosn.rm_input( "AC1x115-bus-1" );
	DC27_bus_KVosn.rm_output( "KVosn-DC" );
	AC1x115_bus_KVosn.rm_output( "KVosn-AC115" );
	AC1x115_bus_KVosn.rm_output( "KVosnHeat-AC115" );
	print("Main attitude and heading reference system Off");
    }
}

KVzap_shandler = func{
    if( getprop("mig29/switches/KVzap")==1 ){
	DC27_bus_KVzap.add_input( DC27_bus );
	AC1x115_bus_KVzap.add_input( AC1x115_bus_1 );;
	DC27_bus_KVzap.add_output( "KVzap-DC", 5 );
	AC1x115_bus_KVzap.add_output( "KVzap-AC115", 5 );
	AC1x115_bus_KVzap.add_output( "KVzapHeat-AC115", 1 );
	print(" Reserve attitude and heading reference system On");
    } 
    if( getprop("mig29/switches/KVzap")==0 ){
	DC27_bus_KVzap.rm_input( "DC27-bus" );
	AC1x115_bus_KVzap.rm_input( "AC1x115-bus-1" );
	DC27_bus_KVzap.rm_output( "KVzap-DC" );
	AC1x115_bus_KVzap.rm_output( "KVzap-AC115" );
	AC1x115_bus_KVzap.rm_output( "KVzapHeat-AC115" );
	print("Reserve attitude and heading reference system Off");
    }
}

navigation_shandler = func{
    if( getprop("mig29/switches/navigation")==1 ){
	DC27_bus_navigation.add_input( DC27_bus );
	AC1x115_bus_navigation.add_input( AC1x115_bus_1 );;
        AC3x36_bus_navigation.add_input( AC3x36_bus_1 );;
	DC27_bus_navigation.add_output( "navigation-DC", 5 );
	AC1x115_bus_navigation.add_output( "navigation-AC115", 5 );
        AC3x36_bus_navigation.add_output( "navigation-AC36", 5 );
	print(" Navigation system On");
    } 
    if( getprop("mig29/switches/navigation")==0 ){
	DC27_bus_navigation.rm_input( "DC27-bus" );
	AC1x115_bus_navigation.rm_input( "AC1x115-bus-1" );
        AC3x36_bus_navigation.rm_input( "AC3x36-bus-1" );
	DC27_bus_navigation.rm_output( "navigation-DC" );
	AC1x115_bus_navigation.rm_output( "navigation-AC115" );
        AC3x36_bus_navigation.rm_output( "navigation-AC36" );
	print("Navigation system Off");
    }
}

SAU_shandler = func{
    if( getprop("mig29/switches/SAU")==1 ){
	DC27_bus_SAU.add_input( DC27_bus );
	AC1x115_bus_SAU.add_input( AC1x115_bus_1 );;
	DC27_bus_SAU.add_output( "SAU-DC", 5 );
	AC1x115_bus_SAU.add_output( "SAU-AC115", 5 );
	print(" AFCS On");
    } 
    if( getprop("mig29/switches/SAU")==0 ){
	DC27_bus_SAU.rm_input( "DC27-bus" );
	AC1x115_bus_SAU.rm_input( "AC1x115-bus-1" );
	DC27_bus_SAU.rm_output( "SAU-DC" );
	AC1x115_bus_SAU.rm_output( "SAU-AC115" );
	print("AFCS Off");
    }
}

SRO_SO_shandler = func{
    if( getprop("mig29/switches/SRO_SO")==1 ){
	DC27_bus_SRO.add_input( DC27_bus );
	AC1x115_bus_SRO.add_input( AC1x115_bus_1 );;
	AC3x36_bus_SO.add_input( AC1x115_bus_1 );;
	DC27_bus_SRO.add_output( "SRO-DC", 5 );
	DC27_bus_SRO.add_output( "SO-DC", 5 );
	AC1x115_bus_SRO.add_output( "SRO-AC", 5 );
	AC1x115_bus_SRO.add_output( "SO-AC115", 5 );
	AC3x36_bus_SO.add_output( "SO-AC36", 5 );
	print(" SRO SO On");
    } 
    if( getprop("mig29/switches/SRO_SO")==0 ){
	DC27_bus_SRO.rm_input( "DC27-bus" );
	AC1x115_bus_SRO.rm_input( "AC1x115-bus-1" );
	AC3x36_bus_SO.rm_input( "AC1x115-bus-1" );
	DC27_bus_SRO.rm_output( "SRO-DC" );
	DC27_bus_SRO.rm_output( "SO-DC" );
	AC1x115_bus_SRO.rm_output( "SRO-AC" );
	AC1x115_bus_SRO.rm_output( "SO-AC115" );
	AC3x36_bus_SO.rm_output( "SO-AC36" );
	print("SRO SO Off");
    }
}

Tester_shandler = func{
    if( getprop("mig29/switches/regist")==1 ){
	DC27_bus_Tester.add_input( DC27_bus );
	DC27_bus_Tester.add_output( "Tester-DC", 1 );
	print(" Tester On");
    } 
    if( getprop("mig29/switches/regist")==0 ){
	DC27_bus_Tester.rm_input( "DC27-bus" );
	DC27_bus_Tester.rm_output( "Tester-DC" );
	print("Tester Off");
    }
}

weapon_shandler = func{
    if( getprop("mig29/switches/weapon")==1 ){
	AC1x115_bus_WeaponPilons.add_input( AC1x115_bus_1 );
	AC1x115_bus_WeaponPilons.add_output( "WeaponPilons-AC", 1 );
	print(" weapon On");
    } 
    if( getprop("mig29/switches/weapon")==0 ){
	AC1x115_bus_WeaponPilons.rm_input( "AC1x115-bus-1" );
	AC1x115_bus_WeaponPilons.rm_output( "WeaponPilons-AC" );
	print("weapon Off");
    }
}

SUV_shandler = func{
    if( getprop("mig29/switches/SUV")==1 ){
	DC27_bus_SUV.add_input( DC27_bus );
	AC1x115_bus_SUV.add_input( AC1x115_bus_1 );;
	DC27_bus_SUV.add_output( "SUV-DC", 5 );
	AC1x115_bus_SUV.add_output( "SUV-AC", 5 );
	print(" WCS On");
    } 
    if( getprop("mig29/switches/SUV")==0 ){
	DC27_bus_SUV.rm_input( "DC27-bus" );
	AC1x115_bus_SUV.rm_input( "AC1x115-bus-1" );
	DC27_bus_SUV.rm_output( "SUV-DC" );
	AC1x115_bus_SUV.rm_output( "SUV-AC" );
	print("WCS Off");
    }
}

glass_pito_heat_shandler = func{
    if( getprop("mig29/switches/glass-pito-heat")==1 ){
	AC1x115_bus_glass_pito_heat.add_input( AC1x115_bus_1 );
	AC1x115_bus_glass_pito_heat.add_output( "GlassFrontHeat-AC", 1 );
	AC1x115_bus_glass_pito_heat.add_output( "GlassUpperHeat-AC", 1 );
	AC1x115_bus_glass_pito_heat.add_output( "GlassMidlleHeat-AC", 1 );
	AC1x115_bus_glass_pito_heat.add_output( "PitotHeat-AC", 1 );
	print(" Heating cockpit glass and pitot On");
    } 
    if( getprop("mig29/switches/glass-pito-heat")==0 ){
	AC1x115_bus_glass_pito_heat.rm_input( "AC1x115-bus-1" );
	AC1x115_bus_glass_pito_heat.rm_output( "GlassFrontHeat-AC" );
	AC1x115_bus_glass_pito_heat.rm_output( "GlassUpperHeat-AC" );
	AC1x115_bus_glass_pito_heat.rm_output( "GlassMidlleHeat-AC" );
	AC1x115_bus_glass_pito_heat.rm_output( "PitotHeat-AC" );
	print("Heating cockpit glass and pitot Off");
    }
}

Bort_Syst_v115_shandler = func{
    if( getprop("mig29/switches/bortsyst")==1 ){
        AC1x115_bus_bortsyst.add_output( "RV-AC115", 10 );
        AC1x115_bus_bortsyst.add_output( "RPM-AC115", 10 );
        AC1x115_bus_PTO1500.rm_output( "RV-AC115", 10 );
        AC1x115_bus_PTO1500.rm_output( "RPM-AC115", 10 );
#	print(" Aircraft systems On22");
    } 
    if( getprop("mig29/switches/bortsyst")==0 ){
        AC1x115_bus_bortsyst.rm_output( "RV-AC115", 10 );
        AC1x115_bus_bortsyst.rm_output( "RPM-AC115", 10 );
        AC1x115_bus_PTO1500.add_output( "RV-AC115", 10 );
        AC1x115_bus_PTO1500.add_output( "RPM-AC115", 10 );
#	print("Aircraft systems Off22");
    }
}

Bort_Syst_v36_shandler = func{
    if( getprop("mig29/switches/bortsyst")==1 ){
	AC3x36_bus_bortsyst.add_output( "SO-AC36", 10 );
        AC3x36_bus_bortsyst.add_output( "ARK-AC36", 10 );
#	print(" Aircraft systems On23");
    } 
    if( getprop("mig29/switches/bortsyst")==0 ){
#	print("Aircraft systems Off23");
    }
}

init_electrical = func {
    print("Initializing Nasal Electrical System");

    battery1 = BatteryClass.new( "AKB15SCS45B-1" );
    battery2 = BatteryClass.new( "AKB15SCS45B-2" );

    GSR = DCAlternatorClass.new( "GSR" );
    GSR.rpm_source( props.globals.getNode("mig29/systems/engines") );
    GT30_1 = ACAlternatorClass.new( "GT30-1" );
    GT30_1.rpm_source( props.globals.getNode("mig29/systems/engines") );
    GT30_2 = ACAlternator2Class.new( "GT30-2" );
    GT30_2.rpm_source( props.globals.getNode("mig29/systems/engines") );

    SHRAP_AC = ExternalClass.new("SHRAP-AC");
    SHRAP_DC = ExternalClassDC.new("SHRAP-DC");

    AC1x115_bus_0 = ACBusClass.new( "AC1x115-bus-0" );
    AC1x115_bus_1 = ACBusClass.new( "AC1x115-bus-1" );
    AC1x115_bus_PTO1500 = ACBusClass.new( "AC1x115-bus-PTO1500" );
    AC1x115_bus_bortsyst = ACBusClass.new( "AC1x115-bus-bortsyst" );
    AC1x115_bus_KVosn = ACBusClass.new( "AC1x115-bus-KVosn" );
    AC1x115_bus_KVzap = ACBusClass.new( "AC1x115-bus-KVzap" );
    AC1x115_bus_navigation = ACBusClass.new( "AC1x115-bus-navigation" );
    AC1x115_bus_SAU = ACBusClass.new( "AC1x115-bus-SAU" );
    AC1x115_bus_SRO = ACBusClass.new( "AC1x115-bus-SRO" );
    AC1x115_bus_WeaponPilons = ACBusClass.new( "AC1x115-bus-WeaponPilons" );
    AC1x115_bus_SUV = ACBusClass.new( "AC1x115-bus-SUV" );
    AC1x115_bus_glass_pito_heat = ACBusClass.new( "AC1x115-bus-glass-pito-heat" );

    AC3x200_bus_0 = ACBusClass.new( "AC3x200-bus-0" );
    AC3x200_bus_1 = ACBusClass.new( "AC3x200-bus-1" );
    AC3x200_bus_engine_systems = ACBusClass.new( "AC3x200-bus-engine-systems" );
    AC3x200_bus_SPP = ACBusClass.new( "AC3x200-bus-SPP" );
    AC3x200_bus_PTO1000 = ACBusClass.new( "AC3x200-bus-PTO1000" );
    AC3x36_bus_bortsyst = ACBusClass.new( "AC3x36-bus-bortsyst" );
    AC3x36_bus_navigation = ACBusClass.new( "AC3x36-bus-navigation" );
    AC3x36_bus_SO = ACBusClass.new( "AC3x36-bus-SO" );

    TSZZOSS4B_1 = TransformerClass.new("TSZZOSS4B-1", 0.173 );

    DC27_bus_0   = DCBusClass.new( "DC27-bus-0" );
    DC27_bus   = DCBusClass.new( "DC27-bus" );
    DC27_bus_radio = DCBusClass.new( "DC27-bus-radio" );
    DC27_bus_bortsyst = DCBusClass.new( "DC27-bus-bortsyst" );
    DC27_bus_KVosn = DCBusClass.new( "DC27-bus-KVosn" );
    DC27_bus_KVzap = DCBusClass.new( "DC27-bus-KVzap" );
    DC27_bus_navigation = DCBusClass.new( "DC27-bus-navigation" );
    DC27_bus_SAU = DCBusClass.new( "DC27-bus-SAU" );
    DC27_bus_SRO = DCBusClass.new( "DC27-bus-SRO" );
    DC27_bus_Tester = DCBusClass.new( "DC27-bus-Tester" );
    DC27_bus_SUV = DCBusClass.new( "DC27-bus-SUV" );
    DC27_bus_fuelpump = DCBusClass.new( "DC27-bus-fuelpump" );

    PTO_1000 = DCACinverterClass.new("PTO-1000", 7.298 );
    PTO_1500 = DCACinverterClass.new("PTO-1500", 4.03 );

    AC3x36_bus_1    = ACBusClass.new( "AC3x36-bus-1" );

#---- Нагрузка - постоянный ток
    SO_DC = DCConsumerClass.new("SO-DC", 0.0 );
    SRO_DC = DCConsumerClass.new("SRO-DC", 0.0 );
    SRZ_DC = DCConsumerClass.new("SRZ-DC", 0.0 );
    RPM_DC = DCConsumerClass.new("RPM-DC", 0.0 );
    RV_DC = DCConsumerClass.new("RV-DC", 0.0 );
    ARK_DC = DCConsumerClass.new("ARK-DC", 1.85 );
    R_862_DC = DCConsumerClass.new("R-862-DC", 0.0 );
    RI_DC = DCConsumerClass.new("RI-DC", 0.0 );
    Ekran_DC = DCConsumerClass.new("Ekran-DC", 0.0 );
    KRU_DC = DCConsumerClass.new("KRU-DC", 0.0 );
    Biruza_DC = DCConsumerClass.new("Biruza-DC", 0.0 );
    RLPK_DC = DCConsumerClass.new("RLPK-DC", 0.0 );
    OEPrNK_DC = DCConsumerClass.new("OEPrNK-DC", 0.0 );
    SN_DC = DCConsumerClass.new("SN-DC", 0.0 );
    Tester_DC = DCConsumerClass.new("Tester-DC", 0.0 );
    KVosn_DC = DCConsumerClass.new("KVosn-DC", 0.0 );
    KVzap_DC = DCConsumerClass.new("KVzap-DC", 0.0 );
    navigation_DC = DCConsumerClass.new("navigation-DC", 0.0 );
    SAU_DC = DCConsumerClass.new("SAU-DC", 0.0 );
    SUV_DC = DCConsumerClass.new("SUV-DC", 0.0 );
    ToplivNasos = DCConsumerClass.new("ToplivNasos", 0.0 );

#---- Нагрузка - переменный ток
    DUALeftHeat_AC = AC115ConsumerClass.new("DUALeftHeat-AC", 0.0 );
    DUARightHeat_AC = AC115ConsumerClass.new("DUARightHeat-AC", 0.0 );
    DUSHeat_AC = AC115ConsumerClass.new("DUSHeat-AC", 0.0 );
    GlassFrontHeat_AC = AC115ConsumerClass.new("GlassFrontHeat-AC", 0.0 );
    GlassUpperHeat_AC = AC115ConsumerClass.new("GlassUpperHeat-AC", 0.0 );
    GlassMidlleHeat_AC = AC115ConsumerClass.new("GlassMidlleHeat-AC", 0.0 );
    PitotHeat_AC = AC115ConsumerClass.new("PitotHeat-AC", 0.0 );
    KVosnHeat_AC = AC115ConsumerClass.new("KVosnHeat-AC", 0.0 );
    KVzapHeat_AC = AC115ConsumerClass.new("KVzapHeat-AC", 0.0 );
    KVosn_AC = AC115ConsumerClass.new("KVosn-AC", 0.0 );
    KVzap_AC = AC115ConsumerClass.new("KVzap-AC", 0.0 );
    SAU_AC115 = AC36ConsumerClass.new("SAU-AC115", 0.0 );
    RLPK_AC = AC36ConsumerClass.new("RLPK-AC", 0.0 );
    OEPrNK_AC = AC36ConsumerClass.new("OEPrNK-AC", 0.0 );
    SN_AC = AC36ConsumerClass.new("SN-AC", 0.0 );
    WeaponPilons_AC = AC115ConsumerClass.new("WeaponPilons-AC", 0.0 );
    ARK_AC = AC36ConsumerClass.new("ARK-AC", 1.11 );
    RV_AC = AC115ConsumerClass.new("RV-AC", 0.0 );
    RPM_AC = AC115ConsumerClass.new("RPM-AC", 0.0 );
    SRO_AC = AC115ConsumerClass.new("SRO-AC", 0.0 );
    SRZ_AC = AC115ConsumerClass.new("SRZ-AC", 0.0 );
    SO_AC115 = AC115ConsumerClass.new("SO-AC115", 0.0 );
    SO_AC36 = AC36ConsumerClass.new("SO-AC36", 0.0 );
    SUV_AC = AC115ConsumerClass.new("SUV-AC", 0.0 );
    navigation_AC115 = AC115ConsumerClass.new("navigation-AC115", 0.0 );
    navigation_AC36 = AC36ConsumerClass.new("navigation-AC36", 0.0 );
    DvigatSyst = AC200ConsumerClass.new("DvigatSyst", 0.0 );
    SPP = AC200ConsumerClass.new("SPP", 0.0 );
    
#--------- connect bases ------------------
    DC27_bus.add_output( "DC27-bus" ,0.0);

    DC27_bus.add_output( "PTO-1000" ,20.0);
    DC27_bus.add_output( "PTO-1500" ,20.0);

    AC1x115_bus_PTO1500.add_input( PTO_1500 );	
    AC3x200_bus_PTO1000.add_input( PTO_1000 );
    AC3x200_bus_1.add_input( AC3x200_bus_PTO1000 );
    AC1x115_bus_1.add_input( AC1x115_bus_PTO1500 );

    AC3x36_bus_1.add_input( TSZZOSS4B_1 );

    AC3x200_bus_1.add_output( "TSZZOSS4B_1",10.0);

    AC3x200_bus_1.add_output( "AC3x200-bus-1",0.0);

    TSZZOSS4B_1.add_input( AC3x200_bus_1 );

    PTO_1000.add_input( DC27_bus );
    PTO_1500.add_input( DC27_bus );



    setprop("mig29/switches/Akkum-Bort-Aerodrom", 0);
    setlistener("mig29/switches/Akkum-Bort-Aerodrom", Akkum_Bort_Aerodrom_handler,0,0 );

    setprop("mig29/switches/generator-1", 0);  
    setlistener("mig29/switches/generator-1", generator_1_shandler,0,0 );
    setprop("mig29/switches/generator-2", 0);  
    setlistener("mig29/switches/generator-2", generator_2_shandler,0,0 );
    setprop("mig29/switches/SHRAP-selector", 1);  
    setlistener("mig29/switches/SHRAP-selector", SHRAP_shandler,0,0 );
    setprop("mig29/switches/PTO", 0); 
    setlistener("mig29/switches/PTO", PTO_shandler,0,0 );
    setprop("mig29/switches/engine_systems", 0); 
    setlistener("mig29/switches/engine_systems", DvigatSyst_shandler,0,0 );
    setprop("mig29/switches/fuel_pump", 0); 
    setlistener("mig29/switches/fuel_pump", ToplivNasos_shandler,0,0 );
    setprop("mig29/switches/SPP", 0); 
    setlistener("mig29/switches/SPP", SPP_shandler,0,0 );
    setprop("mig29/switches/radio", 0); 
    setlistener("mig29/switches/radio", R_862_shandler,0,0 );
    setprop("mig29/switches/bortsyst", 0);
    setlistener("mig29/switches/bortsyst", Bort_Syst_shandler,0,0 );
    setprop("mig29/switches/KVosn", 0);
    setlistener("mig29/switches/KVosn", KVosn_shandler,0,0 );
    setprop("mig29/switches/KVzap", 0);
    setlistener("mig29/switches/KVzap", KVzap_shandler,0,0 );
    setprop("mig29/switches/navigation", 0);
    setlistener("mig29/switches/navigation", navigation_shandler,0,0 );
    setprop("mig29/switches/SAU", 0);
    setlistener("mig29/switches/SAU", SAU_shandler,0,0 );
    setprop("mig29/switches/SRO_SO", 0);
    setlistener("mig29/switches/SRO_SO", SRO_SO_shandler,0,0 );
    setprop("mig29/switches/regist", 0);
    setlistener("mig29/switches/regist", Tester_shandler,0,0 );
    setprop("mig29/switches/weapon", 0);
    setlistener("mig29/switches/weapon", weapon_shandler,0,0 );
    setprop("mig29/switches/SUV", 0);
    setlistener("mig29/switches/SUV", SUV_shandler,0,0 );
    setprop("mig29/switches/glass-pito-heat", 0);
    setlistener("mig29/switches/glass-pito-heat", glass_pito_heat_shandler,0,0 );
    
    setprop("mig29/systems/electrical/EP", 0);


    setlistener("mig29/systems/engines/n2", GSR_rpm_handler,0,0 );
    setlistener("mig29/systems/engines/n2", GT30_1_rpm_handler,0,0 );
    setlistener("mig29/systems/engines/n2", GT30_2_rpm_handler,0,0 );

    setlistener("mig29/systems/electrical/suppliers/GSR/volts", Bort_Syst_v27_shandler);


    settimer(update_buses_thandler, UPDATE_PERIOD );
settimer(update_electrical, 0);
}


setlistener("/sim/signals/fdm-initialized", init_electrical);



update_electrical = func {
    settimer(update_electrical, UPDATE_PERIOD);

# AC 200
var voltage = 0.0;
var freq = 0.0;
voltage = getprop( "mig29/systems/electrical/buses/AC3x200-bus-1/volts" );
freq = getprop( "mig29/systems/electrical/buses/AC3x200-bus-1/frequency" );
	
	if( voltage == nil ) voltage = 0.0;
	if( freq == nil ) freq = 0.0;
	interpolate("mig29/instrumentation/electrical/v200", voltage, UPDATE_PERIOD );
	interpolate("mig29/instrumentation/electrical/hz200", freq, UPDATE_PERIOD );
	
var current = 0.0;
current = getprop( "mig29/systems/electrical/buses/AC3x200-bus-1/load" );
	
	if( current == nil ) current = 0.0;
	
	interpolate("mig29/instrumentation/electrical/a200", current, UPDATE_PERIOD );
# AC 115
var voltage = 0.0;
var freq = 0.0;
voltage = getprop( "mig29/systems/electrical/buses/AC1x115-bus-1/volts" );
freq = getprop( "mig29/systems/electrical/buses/AC1x115-bus-1/frequency" );
	
	if( voltage == nil ) voltage = 0.0;
	if( freq == nil ) freq = 0.0;
	interpolate("mig29/instrumentation/electrical/v115", voltage, UPDATE_PERIOD );
	interpolate("mig29/instrumentation/electrical/hz115", freq, UPDATE_PERIOD );
	
var current = 0.0;
current = getprop( "mig29/systems/electrical/buses/AC1x115-bus-1/load" );
	
	if( current == nil ) current = 0.0;
	
	interpolate("mig29/instrumentation/electrical/a115", current, UPDATE_PERIOD );
# AC 36
var voltage = 0.0;
var freq = 0.0;
voltage = getprop( "mig29/systems/electrical/suppliers/TSZZOSS4B-1/volts" );
freq = getprop( "mig29/systems/electrical/suppliers/TSZZOSS4B-1/frequency" );
	
	if( voltage == nil ) voltage = 0.0;
	if( freq == nil ) freq = 0.0;
	interpolate("mig29/instrumentation/electrical/v36", voltage, UPDATE_PERIOD );
	interpolate("mig29/instrumentation/electrical/hz36", freq, UPDATE_PERIOD );
	
var current = 0.0;
current = getprop( "mig29/systems/electrical/buses/AC3x36-bus-1/load" );
	
	if( current == nil ) current = 0.0;
	
	interpolate("mig29/instrumentation/electrical/a36", current, UPDATE_PERIOD );
# DC
src = getprop( "mig29/systems/electrical/gen-1-failure" );
if( src == 0 )
	voltage = getprop( "mig29/systems/electrical/buses/DC27-bus/volts" );
if( src == 1 )
	voltage = getprop( "mig29/systems/electrical/suppliers/AKB15SCS45B-1/volts" );
	interpolate("mig29/instrumentation/electrical/v27", voltage, UPDATE_PERIOD );
# Only for demo!
	current = getprop( "mig29/systems/electrical/buses/DC27-bus/load" );
	if( current == nil ) current = 0.0;
	interpolate("mig29/instrumentation/electrical/a27", current, UPDATE_PERIOD );

# F
voltage = getprop( "mig29/systems/electrical/buses/DC27-bus/volts" );
if( voltage == nil ) voltage = 0.0;
if( voltage > 15.0 )
	{
	# Generators
	if( (getprop( "mig29/systems/electrical/suppliers/GSR/volts" ) > 25) and
		( getprop( "mig29/switches/generator-1") == 1 ) )
			setprop("mig29/systems/electrical/gen-1-failure", 0.0);
	else	setprop("mig29/systems/electrical/gen-1-failure", 1.0);
	
	if( (getprop( "mig29/systems/electrical/suppliers/GT30-1/volts" ) > 150) and
		( getprop( "mig29/switches/generator-2") == 1 ) )
			setprop("mig29/systems/electrical/gen-2-failure", 0.0);
	else	setprop("mig29/systems/electrical/gen-2-failure", 1.0);
	

	}
else	{
	setprop("mig29/systems/electrical/gen-1-failure", 0.0);
	setprop("mig29/systems/electrical/gen-2-failure", 0.0);
	interpolate("mig29/instrumentation/electrical/v27", 0.0, UPDATE_PERIOD );
	interpolate("mig29/instrumentation/electrical/a27", 0.0, UPDATE_PERIOD );
	interpolate("mig29/instrumentation/electrical/a200", 0.0, UPDATE_PERIOD );
	interpolate("mig29/instrumentation/electrical/v200", 0.0, UPDATE_PERIOD );
	interpolate("mig29/instrumentation/electrical/hz200", 0.0, UPDATE_PERIOD );
	}

}





#---- Buses -----

DCBusClass = {};

DCBusClass.new = func( name ) {
    obj = { parents : [DCBusClass],
#	    node :  props.globals.getNode( enode ~ "buses/" ~ name , 1 ),
	    node :  enode ~ "buses/" ~ name ~"/" ,
	    name :  name,
	    volts :  props.globals.getNode( enode ~ "buses/" ~ name ~ "/volts", 1 ),
	    load : props.globals.getNode( enode ~ "buses/" ~ name ~ "/load", 1 ),
	    inputs : props.globals.getNode( enode ~ "buses/" ~ name ~ "/inputs", 1 ),
	    outputs : props.globals.getNode( enode ~ "buses/" ~ name ~ "/ouputs", 1 ) };
    obj.volts.setValue(0.0);
    obj.load.setValue(0.0);
    return obj;
}

DCBusClass.add_input = func( obj ) {
    me.inputs.getNode( obj.name, 1).setValue( obj.node );
}

DCBusClass.add_output = func( name, load ) {
    me.outputs.getNode( name, 1).setValues({ "load" : load});
}

DCBusClass.rm_input = func( name ) {
    me.inputs.removeChild( name,0 );
}

DCBusClass.rm_output = func( name ) {
    me.outputs.removeChild( name,0 );
}

DCBusClass.voltage = func {
    return me.volts.getValue();
}

DCBusClass.update_intput = func( name, volts ) {
    me.inputs.getNode( name ).setValues( { "volts" : volts } );
}

DCBusClass.update_output = func( name, load ) {
    me.ouputs.getNode( name ).setValues( { name : load } );
}

DCBusClass.update_load = func {
    load = 0.0;
    outputs =  me.outputs.getChildren();
    if(outputs == nil) return;
    foreach( output; outputs ){
	load += output.getNode("load").getValue();
    }
    me.load.setValue( load );
}

DCBusClass.update_voltage = func {
    volts = 0.0;
    foreach( input; me.inputs.getChildren() ){
	ivolts = props.globals.getNode( input.getValue() ~ "volts" ).getValue();
	volts = volts < ivolts ? ivolts : volts;
    }
    me.volts.setValue( volts );
}


ACBusClass = {};

ACBusClass.new = func( name ) {
    obj = { parents : [ACBusClass],
#	    node :  props.globals.getNode( enode ~ "buses/" ~ name , 1 ),
	    node :  enode ~ "buses/" ~ name ~ "/",
	    name :  name,
	    volts :  props.globals.getNode( enode ~ "buses/" ~ name ~ "/volts", 1 ),
	    load : props.globals.getNode( enode ~ "buses/" ~ name ~ "/load", 1 ),
	    frequency: props.globals.getNode( enode ~ "buses/" ~ name ~ "/frequency", 1 ),
	    inputs : props.globals.getNode( enode ~ "buses/" ~ name ~ "/inputs", 1 ),
	    outputs : props.globals.getNode( enode ~ "buses/" ~ name ~ "/ouputs", 1 ) };
    obj.volts.setValue(0.0);
    obj.load.setValue(0.0);
    obj.frequency.setValue(0.0);
    return obj;
}

ACBusClass.add_input = func( obj  ) {
    me.inputs.getNode( obj.name, 1).setValue( obj.node );
}

ACBusClass.add_output = func( name, load ) {
    me.outputs.getNode( name, 1).setValues({ "load" : load});
}

ACBusClass.rm_input = func( name ) {
    me.inputs.removeChild( name,0 );
}

ACBusClass.rm_output = func( name ) {
    me.outputs.removeChild( name,0 );
}

ACBusClass.voltage = func {
    return me.volts.getValue();
}

ACBusClass.update_intput = func( name, volts, freq ) {
    me.inputs.getNode( name ).setValues( { "volts" : volts, "frequency": freq } );
}

ACBusClass.update_output = func( name, load ) {
    me.ouputs.getNode( name ).setValues( { "load" : load } );
}

ACBusClass.update_load = func {
    load = 0.0;
    outputs = me.outputs.getChildren();
    if(outputs == nil) return;
    foreach( output;  outputs ){
	load += output.getNode("load").getValue();
    }
    me.load.setValue( load );
}

ACBusClass.update_voltage = func {
    volts = 0.0;
    freq = 0.0;
    foreach( input; me.inputs.getChildren() ){
	ivolts = getprop( input.getValue() ~ "/volts" );
	ifreq  = getprop( input.getValue() ~ "/frequency" );
       	freq   = volts < ivolts ? ifreq : me.frequency.getValue();
	volts  = volts < ivolts ? ivolts : volts;
    }
    me.volts.setValue( volts );
    me.frequency.setValue( freq );
}

#---- Batterys ------

BatteryClass = {};
BatteryClass.new = func ( name ) {
    obj = { parents : [BatteryClass],
	    name : name,
	    node :   enode ~ "suppliers/" ~ name ~ "/",
	    volts :  props.globals.getNode( enode ~ "suppliers/" ~ name ~ "/volts", 1 ),
            bus :  nil,
            ideal_volts : 27.0,
            ideal_amps : 45.0,
            amp_hours : 44.0,
            charge_percent : 1.0,
            charge_amps : 7.0 };
    obj.volts.setValue(27.0);
    return obj;
}
BatteryClass.apply_load = func( amps, dt ) {
    amphrs_used = amps * dt / 3600.0;
    percent_used = amphrs_used / me.amp_hours;
    me.charge_percent -= percent_used;
    if ( me.charge_percent < 0.0 ) {
        me.charge_percent = 0.0;
    } elsif ( me.charge_percent > 1.0 ) {
        me.charge_percent = 1.0;
    }
    return me.amp_hours * me.charge_percent;
}
BatteryClass.get_output_volts = func {
    x = 1.0 - me.charge_percent;
    factor = x / 10;
    return me.ideal_volts - factor;
}
BatteryClass.get_output_amps = func {
    x = 1.0 - me.charge_percent;
    tmp = -(3.0 * x - 1.0);
    factor = (tmp*tmp*tmp*tmp*tmp + 32) / 32;
    return me.ideal_amps * factor;
}

BatteryClass.connect_to_bus = func( _bus ){
    me.bus = _bus;
}

BatteryClass.disconnect_from_bus = func{
    me.bus = nil;
}

#---- Alernators

DCAlternatorClass = {};
DCAlternatorClass.new = func( name ) {
    obj = { parents : [DCAlternatorClass],
	    name : name,
	    node :  enode ~ "suppliers/" ~ name ~ "/",
	    volts :   props.globals.getNode( enode ~ "suppliers/" ~ name ~ "/volts", 1 ),
	    engine : nil,
	    bus : nil,
            ideal_volts : 28.5,
            ideal_amps : 400.0 };
    props.globals.getNode(obj.node,1).setValues({ "volts": 0.0} );
    return obj;
}


DCAlternatorClass.apply_load = func( amps, dt ) {
    rpm = me.engine.getNode("n2").getValue();
    available_amps = me.ideal_amps * math.ln(rpm)/9;
    return available_amps - amps;
}

DCAlternatorClass.rpm_handler = func {
    rpm = me.engine.getNode("n2").getValue();
    if( rpm < 55.0 ) volts = 0.0;
    else volts = me.ideal_volts;
    me.volts.setValue( volts );
    if( me.bus != nil ) setprop(me.bus.volts, volts );
}

DCAlternatorClass.get_output_amps = func(src ){
    rpm = getprop( src );
    if( rpm == nil ) rpm = 0;
    # APU can have 0 rpm
    if (rpm < 55.0 ) {
        factor = 0;
    } else {
        factor = math.ln(rpm)/4;
    }
    return me.ideal_amps * factor;
}

DCAlternatorClass.connect_to_bus = func( _bus ){
    me.bus = _bus;
}

DCAlternatorClass.disconnect_from_bus = func{
    me.bus = nil;
}

DCAlternatorClass.rpm_source = func( eng ){
    me.engine = eng;
}

DCAlternatorClass.voltage = func( eng ){
    return me.volts.getValue();
}

ACAlternatorClass = {};
ACAlternatorClass.new = func( name ) {
    obj = { parents : [ACAlternatorClass],
            name : name,
            node :  enode ~ "suppliers/" ~ name ~ "/",
            volts :   props.globals.getNode( enode ~ "suppliers/" ~ name ~ "/volts", 1 ),
            frequency :  props.globals.getNode( enode ~ "suppliers/" ~ name ~ "/frequency", 1 ),
            engine : nil,
            bus : nil,
            ideal_volts : 208.0,
            ideal_freq : 400,
            ideal_amps : 83.3 };
    props.globals.getNode(obj.node,1).setValues({ "volts": 0.0, "frequency" : 400.0} );
    return obj;
}


ACAlternatorClass.apply_load = func( amps, dt ) {
    rpm = me.engine.getNode("n2").getValue();
    available_amps = me.ideal_amps * math.ln(rpm)/9;
    return available_amps - amps;
}

ACAlternatorClass.rpm_handler = func {
    rpm = me.engine.getNode("n2").getValue();
    if( rpm < 55.0 ) volts = 0.0;
    else volts = me.ideal_volts;
    me.volts.setValue( volts );
    if( me.bus != nil ) setprop(me.bus.volts, volts );
}

ACAlternatorClass.get_output_amps = func(src ){
    rpm = getprop( src );
    if( rpm == nil ) rpm = 0;
    if (rpm < 55.0 ) {
        factor = 0;
    } else {
        factor = math.ln(rpm)/0.06;
    }
    return me.ideal_amps * factor;
}

ACAlternatorClass.connect_to_bus = func( _bus ){
    me.bus = _bus;
}

ACAlternatorClass.disconnect_from_bus = func{
    me.bus = nil;
}

ACAlternatorClass.rpm_source = func( eng ){
    me.engine = eng;
}

ACAlternatorClass.voltage = func( eng ){
    return me.volts.getValue();
}

ACAlternator2Class = {};
ACAlternator2Class.new = func( name ) {
    obj = { parents : [ACAlternator2Class],
            name : name,
            node :  enode ~ "suppliers/" ~ name ~ "/",
            volts :   props.globals.getNode( enode ~ "suppliers/" ~ name ~ "/volts", 1 ),
            frequency :  props.globals.getNode( enode ~ "suppliers/" ~ name ~ "/frequency", 1 ),
            engine : nil,
            bus : nil,
            ideal_volts : 115.0,
            ideal_freq : 400,
            ideal_amps : 83.3 };
    props.globals.getNode(obj.node,1).setValues({ "volts": 0.0, "frequency" : 400.0} );
    return obj;
}


ACAlternator2Class.apply_load = func( amps, dt ) {
    rpm = me.engine.getNode("n2").getValue();
    available_amps = me.ideal_amps * math.ln(rpm)/9;
    return available_amps - amps;
}

ACAlternator2Class.rpm_handler = func {
    rpm = me.engine.getNode("n2").getValue();
    if( rpm < 55.0 ) volts = 0.0;
    else volts = me.ideal_volts;
    me.volts.setValue( volts );
    if( me.bus != nil ) setprop(me.bus.volts, volts );
}

ACAlternator2Class.get_output_amps = func(src ){
    rpm = getprop( src );
    if( rpm == nil ) rpm = 0;
    if (rpm < 55.0 ) {
        factor = 0;
    } else {
        factor = math.ln(rpm)/0.06;
    }
    return me.ideal_amps * factor;
}

ACAlternator2Class.connect_to_bus = func( _bus ){
    me.bus = _bus;
}

ACAlternator2Class.disconnect_from_bus = func{
    me.bus = nil;
}

ACAlternator2Class.rpm_source = func( eng ){
    me.engine = eng;
}

ACAlternator2Class.voltage = func( eng ){
    return me.volts.getValue();
}

TransformerClass = {};

TransformerClass.new = func( name, coeff ) {
    obj = { parents : [TransformerClass],
	    name : name,
	    node :  enode ~ "suppliers/" ~ name ~ "/",
	    volts :   props.globals.getNode( enode ~ "suppliers/" ~ name ~ "/volts", 1 ),
	    frequency :  props.globals.getNode( enode ~ "suppliers/" ~ name ~ "/frequency", 1 ),
	    input : nil,
	    output : nil,
	    trans_coeff : coeff };
    props.globals.getNode(obj.node,1).setValues({ "volts": 0.0, "frequency" : 400.0} );
    return obj;
}

TransformerClass.add_input = func( obj ){
    me.input = obj;
}

TransformerClass.output = func( obj ){
    me.output = obj;
}

TransformerClass.update = func{
    volts = me.input == nil ? 0.0 : me.input.volts.getValue()*me.trans_coeff ;
    me.volts.setValue(volts);
}

DCACinverterClass = {};

DCACinverterClass.new = func( name, coeff ) {
    obj = { parents : [DCACinverterClass],
	    name : name,
	    node :  enode ~ "suppliers/" ~ name ~ "/",
	    volts :   props.globals.getNode( enode ~ "suppliers/" ~ name ~ "/volts", 1 ),
	    frequency :  props.globals.getNode( enode ~ "suppliers/" ~ name ~ "/frequency", 1 ),
	    input : nil,
	    output : nil,
	    conv_coeff : coeff };
    props.globals.getNode(obj.node,1).setValues({ "volts": 0.0, "frequency" : 400.0} );
    return obj;
}

DCACinverterClass.add_input = func( obj ){
    me.input = obj;
}

DCACinverterClass.output = func( obj ){
    me.output = obj;
}

DCACinverterClass.update = func{
    volts = me.input == nil ? 0.0 : me.input.volts.getValue()*me.conv_coeff;
    me.volts.setValue(volts);
}

ExternalClass = {};

ExternalClass.new = func( name ) {
    obj = { parents : [ExternalClass],
	    name : name,
	    node :  enode ~ "suppliers/" ~ name ~ "/",
	    volts :   props.globals.getNode( enode ~ "suppliers/" ~ name ~ "/volts", 1 ),
	    frequency :  props.globals.getNode( enode ~ "suppliers/" ~ name ~ "/frequency", 1 ),
	    bus : nil,
            ideal_volts : 208.0,
	    ideal_freq : 400,
            ideal_amps : 110.0 };
    props.globals.getNode(obj.node,1).setValues({ "volts": 208.0, "frequency" : 400.0} );
    return obj;
}

ExternalClass.connect_to_bus = func( _bus ){
    me.bus = _bus;
}

ExternalClass.disconnect_from_bus = func{
    me.bus = nil;
}

ExternalClassDC = {};

ExternalClassDC.new = func( name ) {
    obj = { parents : [ExternalClass],
	    name : name,
	    node :  enode ~ "suppliers/" ~ name ~ "/",
	    volts :   props.globals.getNode( enode ~ "suppliers/" ~ name ~ "/volts", 1 ),
	    bus : nil,
            ideal_volts : 28.5,
            ideal_amps : 110.0 };
    props.globals.getNode(obj.node,1).setValues({ "volts": 28.5} );
    return obj;
}

ExternalClassDC.connect_to_bus = func( _bus ){
    me.bus = _bus;
}

ExternalClassDC.disconnect_from_bus = func{
    me.bus = nil;
}

AC115ConsumerClass = {};

AC115ConsumerClass.new = func( name, value ) {
    obj = { parents : [AC115ConsumerClass],
	    name : name,
	    node :  enode ~ "consumers/" ~ name ~ "/",
	    volts :   props.globals.getNode( enode ~ "consumers/" ~ name ~ "/volts", 1 ),
	    frequency :  props.globals.getNode( enode ~ "consumers/" ~ name ~ "/frequency", 1 ),
	    input : nil,
	    output : nil,
	    consum_value : value };
    props.globals.getNode(obj.node,1).setValues({ "volts": 0.0, "frequency" : 400.0} );
    return obj;
}

AC115ConsumerClass.add_input = func( obj ){
    me.input = obj;
}

AC115ConsumerClass.output = func( obj ){
    me.output = obj;
}

AC115ConsumerClass.update = func{
    volts = me.input == nil ? 0.0 : me.input.volts.getValue()*me.consum_value ;
    me.volts.setValue(volts);
}

AC200ConsumerClass = {};

AC200ConsumerClass.new = func( name, value ) {
    obj = { parents : [AC200ConsumerClass],
	    name : name,
	    node :  enode ~ "consumers/" ~ name ~ "/",
	    volts :   props.globals.getNode( enode ~ "consumers/" ~ name ~ "/volts", 1 ),
	    frequency :  props.globals.getNode( enode ~ "consumers/" ~ name ~ "/frequency", 1 ),
	    input : nil,
	    output : nil,
	    consum_value : value };
    props.globals.getNode(obj.node,1).setValues({ "volts": 0.0, "frequency" : 400.0} );
    return obj;
}

AC200ConsumerClass.add_input = func( obj ){
    me.input = obj;
}

AC200ConsumerClass.output = func( obj ){
    me.output = obj;
}

AC200ConsumerClass.update = func{
    volts = me.input == nil ? 0.0 : me.input.volts.getValue()*me.consum_value ;
    me.volts.setValue(volts);
}

AC36ConsumerClass = {};

AC36ConsumerClass.new = func( name, value ) {
    obj = { parents : [AC36ConsumerClass],
	    name : name,
	    node :  enode ~ "consumers/" ~ name ~ "/",
	    volts :   props.globals.getNode( enode ~ "consumers/" ~ name ~ "/volts", 1 ),
	    frequency :  props.globals.getNode( enode ~ "consumers/" ~ name ~ "/frequency", 1 ),
	    input : nil,
	    output : nil,
	    consum_value : value };
    props.globals.getNode(obj.node,1).setValues({ "volts": 0.0, "frequency" : 400.0} );
    return obj;
}

AC36ConsumerClass.add_input = func( obj ){
    me.input = obj;
}

AC36ConsumerClass.output = func( obj ){
    me.output = obj;
}

AC36ConsumerClass.update = func{
    volts = me.input == nil ? 0.0 : me.input.volts.getValue()*me.consum_value ;
    me.volts.setValue(volts);
}

DCConsumerClass = {};

DCConsumerClass.new = func( name, value ) {
    obj = { parents : [DCConsumerClass],
	    name : name,
	    node :  enode ~ "consumers/" ~ name ~ "/",
	    volts :   props.globals.getNode( enode ~ "consumers/" ~ name ~ "/volts", 1 ),
	    input : nil,
	    output : nil,
	    consum_value : value };
    props.globals.getNode(obj.node,1).setValues({ "volts": 0.0} );
    return obj;
}

DCConsumerClass.add_input = func( obj ){
    me.input = obj;
}

DCConsumerClass.output = func( obj ){
    me.output = obj;
}

DCConsumerClass.update = func{
    volts = me.input == nil ? 0.0 : me.input.volts.getValue()*me.consum_value ;
    me.volts.setValue(volts);
}
