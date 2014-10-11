pragma Ada_95;
pragma Restrictions (No_Exception_Propagation);
with System;
package ada_main is
   pragma Warnings (Off);


   GNAT_Version : constant String :=
                    "GNAT Version: GPL 2014 (20140331)" & ASCII.NUL;
   pragma Export (C, GNAT_Version, "__gnat_version");

   Ada_Main_Program_Name : constant String := "_ada_demo" & ASCII.NUL;
   pragma Export (C, Ada_Main_Program_Name, "__gnat_ada_main_program_name");

   procedure adainit;
   pragma Export (C, adainit, "adainit");

   procedure main;
   pragma Export (C, main, "main");

   type Version_32 is mod 2 ** 32;
   u00001 : constant Version_32 := 16#40634f63#;
   pragma Export (C, u00001, "demoB");
   u00002 : constant Version_32 := 16#eb623963#;
   pragma Export (C, u00002, "driverB");
   u00003 : constant Version_32 := 16#a02c920d#;
   pragma Export (C, u00003, "driverS");
   u00004 : constant Version_32 := 16#3ffc8e18#;
   pragma Export (C, u00004, "adaS");
   u00005 : constant Version_32 := 16#8913be18#;
   pragma Export (C, u00005, "ada__real_timeB");
   u00006 : constant Version_32 := 16#cf4a25c2#;
   pragma Export (C, u00006, "ada__real_timeS");
   u00007 : constant Version_32 := 16#9bca7a93#;
   pragma Export (C, u00007, "systemS");
   u00008 : constant Version_32 := 16#313e5f97#;
   pragma Export (C, u00008, "system__task_primitivesS");
   u00009 : constant Version_32 := 16#7ed58bec#;
   pragma Export (C, u00009, "system__os_interfaceS");
   u00010 : constant Version_32 := 16#13fd1245#;
   pragma Export (C, u00010, "system__bbS");
   u00011 : constant Version_32 := 16#23c4c3b5#;
   pragma Export (C, u00011, "system__bb__board_supportB");
   u00012 : constant Version_32 := 16#c731b4f5#;
   pragma Export (C, u00012, "system__bb__board_supportS");
   u00013 : constant Version_32 := 16#62b5669c#;
   pragma Export (C, u00013, "system__bb__parametersS");
   u00014 : constant Version_32 := 16#9471015d#;
   pragma Export (C, u00014, "system__machine_codeS");
   u00015 : constant Version_32 := 16#dabbcdd4#;
   pragma Export (C, u00015, "system__bb__cpu_primitivesB");
   u00016 : constant Version_32 := 16#ce5d8649#;
   pragma Export (C, u00016, "system__bb__cpu_primitivesS");
   u00017 : constant Version_32 := 16#5e68f5cc#;
   pragma Export (C, u00017, "ada__exceptionsB");
   u00018 : constant Version_32 := 16#ff69fba4#;
   pragma Export (C, u00018, "ada__exceptionsS");
   u00019 : constant Version_32 := 16#bdc69a9d#;
   pragma Export (C, u00019, "system__bb__threadsB");
   u00020 : constant Version_32 := 16#dfbae800#;
   pragma Export (C, u00020, "system__bb__threadsS");
   u00021 : constant Version_32 := 16#53ebb543#;
   pragma Export (C, u00021, "system__bb__protectionB");
   u00022 : constant Version_32 := 16#7cbd1653#;
   pragma Export (C, u00022, "system__bb__protectionS");
   u00023 : constant Version_32 := 16#86b94167#;
   pragma Export (C, u00023, "system__bb__threads__queuesB");
   u00024 : constant Version_32 := 16#204e2c19#;
   pragma Export (C, u00024, "system__bb__threads__queuesS");
   u00025 : constant Version_32 := 16#f22a3c08#;
   pragma Export (C, u00025, "system__bb__cpu_primitives__multiprocessorsB");
   u00026 : constant Version_32 := 16#71f00eda#;
   pragma Export (C, u00026, "system__bb__cpu_primitives__multiprocessorsS");
   u00027 : constant Version_32 := 16#84f3a776#;
   pragma Export (C, u00027, "system__multiprocessorsB");
   u00028 : constant Version_32 := 16#82767aec#;
   pragma Export (C, u00028, "system__multiprocessorsS");
   u00029 : constant Version_32 := 16#69adb1b9#;
   pragma Export (C, u00029, "interfacesS");
   u00030 : constant Version_32 := 16#84b803dd#;
   pragma Export (C, u00030, "interfaces__cS");
   u00031 : constant Version_32 := 16#2dd27587#;
   pragma Export (C, u00031, "system__bb__timeB");
   u00032 : constant Version_32 := 16#abe932e9#;
   pragma Export (C, u00032, "system__bb__timeS");
   u00033 : constant Version_32 := 16#b5993228#;
   pragma Export (C, u00033, "ada__tagsB");
   u00034 : constant Version_32 := 16#45b7e1de#;
   pragma Export (C, u00034, "ada__tagsS");
   u00035 : constant Version_32 := 16#5e68c1f5#;
   pragma Export (C, u00035, "system__secondary_stackB");
   u00036 : constant Version_32 := 16#12d95ad5#;
   pragma Export (C, u00036, "system__secondary_stackS");
   u00037 : constant Version_32 := 16#39a03df9#;
   pragma Export (C, u00037, "system__storage_elementsB");
   u00038 : constant Version_32 := 16#b6093097#;
   pragma Export (C, u00038, "system__storage_elementsS");
   u00039 : constant Version_32 := 16#57810d75#;
   pragma Export (C, u00039, "system__bb__interruptsB");
   u00040 : constant Version_32 := 16#4d02f0ec#;
   pragma Export (C, u00040, "system__bb__interruptsS");
   u00041 : constant Version_32 := 16#ed22f7d3#;
   pragma Export (C, u00041, "system__bb__timing_eventsB");
   u00042 : constant Version_32 := 16#bf231a9e#;
   pragma Export (C, u00042, "system__bb__timing_eventsS");
   u00043 : constant Version_32 := 16#ec2092fc#;
   pragma Export (C, u00043, "system__multiprocessors__fair_locksB");
   u00044 : constant Version_32 := 16#a70e2885#;
   pragma Export (C, u00044, "system__multiprocessors__fair_locksS");
   u00045 : constant Version_32 := 16#9fbff207#;
   pragma Export (C, u00045, "system__multiprocessors__spin_locksB");
   u00046 : constant Version_32 := 16#9ac42bf1#;
   pragma Export (C, u00046, "system__multiprocessors__spin_locksS");
   u00047 : constant Version_32 := 16#f45f1d5b#;
   pragma Export (C, u00047, "system__parametersB");
   u00048 : constant Version_32 := 16#66c00ddd#;
   pragma Export (C, u00048, "system__parametersS");
   u00049 : constant Version_32 := 16#eb2bcc3b#;
   pragma Export (C, u00049, "system__task_primitives__operationsB");
   u00050 : constant Version_32 := 16#957d280f#;
   pragma Export (C, u00050, "system__task_primitives__operationsS");
   u00051 : constant Version_32 := 16#138ec2af#;
   pragma Export (C, u00051, "system__taskingB");
   u00052 : constant Version_32 := 16#bd89bceb#;
   pragma Export (C, u00052, "system__taskingS");
   u00053 : constant Version_32 := 16#e0fce7f8#;
   pragma Export (C, u00053, "system__task_infoB");
   u00054 : constant Version_32 := 16#1bd0c792#;
   pragma Export (C, u00054, "system__task_infoS");
   u00055 : constant Version_32 := 16#0f8eba36#;
   pragma Export (C, u00055, "system__tasking__debugB");
   u00056 : constant Version_32 := 16#8e39484d#;
   pragma Export (C, u00056, "system__tasking__debugS");
   u00057 : constant Version_32 := 16#4a32d090#;
   pragma Export (C, u00057, "ada__real_time__delaysB");
   u00058 : constant Version_32 := 16#6fcba83e#;
   pragma Export (C, u00058, "ada__real_time__delaysS");
   u00059 : constant Version_32 := 16#68cb51f8#;
   pragma Export (C, u00059, "buttonB");
   u00060 : constant Version_32 := 16#e913a290#;
   pragma Export (C, u00060, "buttonS");
   u00061 : constant Version_32 := 16#a34e0368#;
   pragma Export (C, u00061, "ada__interruptsB");
   u00062 : constant Version_32 := 16#426c174d#;
   pragma Export (C, u00062, "ada__interruptsS");
   u00063 : constant Version_32 := 16#0a6637d7#;
   pragma Export (C, u00063, "system__interruptsB");
   u00064 : constant Version_32 := 16#4daf528b#;
   pragma Export (C, u00064, "system__interruptsS");
   u00065 : constant Version_32 := 16#4d5ecdbf#;
   pragma Export (C, u00065, "system__tasking__restrictedS");
   u00066 : constant Version_32 := 16#ff80c2ec#;
   pragma Export (C, u00066, "system__tasking__restricted__stagesB");
   u00067 : constant Version_32 := 16#63151109#;
   pragma Export (C, u00067, "system__tasking__restricted__stagesS");
   u00068 : constant Version_32 := 16#406a6d14#;
   pragma Export (C, u00068, "system__tasking__protected_objectsB");
   u00069 : constant Version_32 := 16#a15edde4#;
   pragma Export (C, u00069, "system__tasking__protected_objectsS");
   u00070 : constant Version_32 := 16#3ace95d0#;
   pragma Export (C, u00070, "system__tasking__protected_objects__single_entryB");
   u00071 : constant Version_32 := 16#d8cc26ef#;
   pragma Export (C, u00071, "system__tasking__protected_objects__single_entryS");
   u00072 : constant Version_32 := 16#a9162ed1#;
   pragma Export (C, u00072, "system__tasking__protected_objects__multiprocessorsB");
   u00073 : constant Version_32 := 16#1e3d54f2#;
   pragma Export (C, u00073, "system__tasking__protected_objects__multiprocessorsS");
   u00074 : constant Version_32 := 16#df6423ea#;
   pragma Export (C, u00074, "ada__interrupts__namesS");
   u00075 : constant Version_32 := 16#845f95b2#;
   pragma Export (C, u00075, "registersS");
   u00076 : constant Version_32 := 16#769021fa#;
   pragma Export (C, u00076, "stm32f4B");
   u00077 : constant Version_32 := 16#2e82ef90#;
   pragma Export (C, u00077, "stm32f4S");
   u00078 : constant Version_32 := 16#cacce83c#;
   pragma Export (C, u00078, "system__unsigned_typesS");
   u00079 : constant Version_32 := 16#886e6d5b#;
   pragma Export (C, u00079, "stm32f4__genericperipheralS");
   u00080 : constant Version_32 := 16#b690b229#;
   pragma Export (C, u00080, "stm32f4__gpioS");
   u00081 : constant Version_32 := 16#e5deb954#;
   pragma Export (C, u00081, "stm32f4__reset_clock_controlS");
   u00082 : constant Version_32 := 16#5e8e95ab#;
   pragma Export (C, u00082, "stm32f4__bussesS");
   u00083 : constant Version_32 := 16#4f89875b#;
   pragma Export (C, u00083, "stm32f4__sysconfig_controlS");
   u00084 : constant Version_32 := 16#8a4e5ff0#;
   pragma Export (C, u00084, "stm32f4__timS");
   u00085 : constant Version_32 := 16#4cad0c7d#;
   pragma Export (C, u00085, "ledsB");
   u00086 : constant Version_32 := 16#fe108a8f#;
   pragma Export (C, u00086, "ledsS");
   u00087 : constant Version_32 := 16#1037e51a#;
   pragma Export (C, u00087, "motorB");
   u00088 : constant Version_32 := 16#0b6df15f#;
   pragma Export (C, u00088, "motorS");
   u00089 : constant Version_32 := 16#5d9af033#;
   pragma Export (C, u00089, "last_chance_handlerB");
   u00090 : constant Version_32 := 16#419b8a97#;
   pragma Export (C, u00090, "last_chance_handlerS");
   --  BEGIN ELABORATION ORDER
   --  ada%s
   --  interfaces%s
   --  interfaces.c%s
   --  system%s
   --  ada.exceptions%s
   --  ada.exceptions%b
   --  system.bb%s
   --  system.bb.parameters%s
   --  system.bb.cpu_primitives%s
   --  system.bb.protection%s
   --  system.machine_code%s
   --  system.multiprocessors%s
   --  system.multiprocessors%b
   --  system.bb.cpu_primitives.multiprocessors%s
   --  system.bb.cpu_primitives.multiprocessors%b
   --  system.bb.interrupts%s
   --  system.bb.board_support%s
   --  system.bb.board_support%b
   --  system.bb.time%s
   --  system.multiprocessors.spin_locks%s
   --  system.multiprocessors.spin_locks%b
   --  system.multiprocessors.fair_locks%s
   --  system.parameters%s
   --  system.parameters%b
   --  system.bb.threads%s
   --  system.bb.threads.queues%s
   --  system.bb.threads.queues%b
   --  system.bb.protection%b
   --  system.os_interface%s
   --  system.multiprocessors.fair_locks%b
   --  system.storage_elements%s
   --  system.storage_elements%b
   --  system.bb.threads%b
   --  system.bb.interrupts%b
   --  system.bb.cpu_primitives%b
   --  ada.tags%s
   --  system.bb.timing_events%s
   --  system.bb.timing_events%b
   --  system.bb.time%b
   --  system.task_info%s
   --  system.task_info%b
   --  system.task_primitives%s
   --  system.tasking%s
   --  system.task_primitives.operations%s
   --  system.tasking.debug%s
   --  system.tasking.debug%b
   --  system.task_primitives.operations%b
   --  system.unsigned_types%s
   --  system.secondary_stack%s
   --  system.tasking%b
   --  ada.tags%b
   --  system.secondary_stack%b
   --  ada.real_time%s
   --  ada.real_time%b
   --  ada.real_time.delays%s
   --  ada.real_time.delays%b
   --  system.tasking.protected_objects%s
   --  system.tasking.protected_objects%b
   --  system.tasking.protected_objects.multiprocessors%s
   --  system.tasking.protected_objects.multiprocessors%b
   --  system.tasking.protected_objects.single_entry%s
   --  system.tasking.protected_objects.single_entry%b
   --  system.tasking.restricted%s
   --  system.tasking.restricted.stages%s
   --  system.tasking.restricted.stages%b
   --  system.interrupts%s
   --  system.interrupts%b
   --  ada.interrupts%s
   --  ada.interrupts%b
   --  ada.interrupts.names%s
   --  driver%s
   --  last_chance_handler%s
   --  demo%b
   --  stm32f4%s
   --  stm32f4%b
   --  stm32f4.busses%s
   --  stm32f4.genericperipheral%s
   --  stm32f4.gpio%s
   --  stm32f4.reset_clock_control%s
   --  stm32f4.sysconfig_control%s
   --  stm32f4.tim%s
   --  registers%s
   --  button%s
   --  button%b
   --  leds%s
   --  leds%b
   --  last_chance_handler%b
   --  motor%s
   --  motor%b
   --  driver%b
   --  END ELABORATION ORDER


end ada_main;
