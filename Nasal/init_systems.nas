# init.nas

var init_systems = func{
 if (getprop("/sim[0]/sceneryloaded") == nil) {settimer(init_systems, 0.5);}
 if (getprop("/sim[0]/sceneryloaded") == 1) {init_systems2();}
}

var init_systems2 = func{
 print ("Start");
 system.preins();
 system.IG2Hz5();
 system.CLs();
 system.ARVTinit();
 system.BUANO_init();
 system.Ekran_init();
 system.IKVK_init();
 system.OATL_init();
 oxygensystem.OxygenSystemInit();
 control.ControlInit();
 engines.InitEngs();
 navigation.TsVU_init();
 instrumentation.init_instrumentation();
 instrumentation.SEI_31_init();
 instrumentation.Tablo_init();
 weapon.Weapon_init();
 ARK19_dialog = gui.Dialog.new("/sim/gui/dialogs/ARK-19/dialog","Aircraft/MiG-29_9-12/Dialogs/ARK-19.xml");
 R862_dialog = gui.Dialog.new("/sim/gui/dialogs/R-862/dialog","Aircraft/MiG-29_9-12/Dialogs/R-862.xml");
 BoardNum_dialog = gui.Dialog.new("/sim/gui/dialogs/BoardNum/dialog","Aircraft/MiG-29_9-12/Dialogs/BoardNum.xml");
 aircraft.livery.init("Aircraft/MiG-29_9-12/Models/Liveries");
 PVP_dialog = gui.Dialog.new("/sim/gui/dialogs/PVP/dialog","Aircraft/MiG-29_9-12/Dialogs/PVP.xml");
 EL_dialog = gui.Dialog.new("/sim/gui/dialogs/EL/dialog","Aircraft/MiG-29_9-12/Dialogs/external-loads.xml");
}
