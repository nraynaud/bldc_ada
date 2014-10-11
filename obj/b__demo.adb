pragma Ada_95;
pragma Source_File_Name (ada_main, Spec_File_Name => "b__demo.ads");
pragma Source_File_Name (ada_main, Body_File_Name => "b__demo.adb");

package body ada_main is
   pragma Warnings (Off);

   E06 : Short_Integer; pragma Import (Ada, E06, "ada__real_time_E");
   E69 : Short_Integer; pragma Import (Ada, E69, "system__tasking__protected_objects_E");
   E73 : Short_Integer; pragma Import (Ada, E73, "system__tasking__protected_objects__multiprocessors_E");
   E67 : Short_Integer; pragma Import (Ada, E67, "system__tasking__restricted__stages_E");
   E03 : Short_Integer; pragma Import (Ada, E03, "driver_E");
   E90 : Short_Integer; pragma Import (Ada, E90, "last_chance_handler_E");
   E77 : Short_Integer; pragma Import (Ada, E77, "stm32f4_E");
   E75 : Short_Integer; pragma Import (Ada, E75, "registers_E");
   E60 : Short_Integer; pragma Import (Ada, E60, "button_E");
   E86 : Short_Integer; pragma Import (Ada, E86, "leds_E");
   E88 : Short_Integer; pragma Import (Ada, E88, "motor_E");


   procedure adainit is
      Main_Priority : Integer;
      pragma Import (C, Main_Priority, "__gl_main_priority");

   begin
      Main_Priority := 0;

      Ada.Real_Time'Elab_Spec;
      Ada.Real_Time'Elab_Body;
      E06 := E06 + 1;
      System.Tasking.Protected_Objects'Elab_Body;
      E69 := E69 + 1;
      System.Tasking.Protected_Objects.Multiprocessors'Elab_Body;
      E73 := E73 + 1;
      System.Tasking.Restricted.Stages'Elab_Body;
      E67 := E67 + 1;
      Driver'Elab_Spec;
      E77 := E77 + 1;
      Registers'Elab_Spec;
      E75 := E75 + 1;
      Button'Elab_Body;
      E60 := E60 + 1;
      Leds'Elab_Body;
      E86 := E86 + 1;
      E90 := E90 + 1;
      motor'elab_body;
      E88 := E88 + 1;
      Driver'Elab_Body;
      E03 := E03 + 1;
   end adainit;

   procedure Ada_Main_Program;
   pragma Import (Ada, Ada_Main_Program, "_ada_demo");

   procedure main is
      Ensure_Reference : aliased System.Address := Ada_Main_Program_Name'Address;
      pragma Volatile (Ensure_Reference);

   begin
      adainit;
      Ada_Main_Program;
   end;

--  BEGIN Object file/option list
   --   /vagrant/bldc_ada/obj/demo.o
   --   /vagrant/bldc_ada/obj/stm32f4.o
   --   /vagrant/bldc_ada/obj/stm32f4-busses.o
   --   /vagrant/bldc_ada/obj/stm32f4-genericperipheral.o
   --   /vagrant/bldc_ada/obj/stm32f4-gpio.o
   --   /vagrant/bldc_ada/obj/stm32f4-reset_clock_control.o
   --   /vagrant/bldc_ada/obj/stm32f4-sysconfig_control.o
   --   /vagrant/bldc_ada/obj/stm32f4-tim.o
   --   /vagrant/bldc_ada/obj/registers.o
   --   /vagrant/bldc_ada/obj/button.o
   --   /vagrant/bldc_ada/obj/leds.o
   --   /vagrant/bldc_ada/obj/last_chance_handler.o
   --   /vagrant/bldc_ada/obj/motor.o
   --   /vagrant/bldc_ada/obj/driver.o
   --   -L/vagrant/bldc_ada/obj/
   --   -L/vagrant/bldc_ada/obj/
   --   -L/vagrant/arm-ada/adalib/
--  END Object file/option list   

end ada_main;
