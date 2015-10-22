
-- Author:              A. Ireland
--
-- Address:             School Mathematical & Computer Sciences
--                      Heriot-Watt University
--                      Edinburgh, EH14 4AS
--
-- E-mail:              a.ireland@hw.ac.uk
--
-- Last modified:       17.8.2015
--
-- Filename:            handler.adb
--
-- Description:         Provides the drivers required for simulating the
--                      environment in which the AVP system operates as
--                      well as a logging capability. 


with Text_IO, Sensors, Alarm, EscapeValve, Console;

package body Handler is

   Env_File: Text_IO.File_Type;

   package Integer_INOUT is new Text_IO.Integer_IO(Integer);

   procedure Update_Env Is

      Sensor_1: Integer;
      Sensor_2: Integer;
      Sensor_3: Integer;
      ResetSig: Integer;

      function Int_To_Sensor_Type(X: in Integer) return Pressure_Cat is
      begin
         case X is
            when 0..99    => return Normal;
            when 100..149 => return High;
            when 150..199 => return Critical;
            when others   => return Undef;
         end case;
      end Int_To_Sensor_Type;

   begin
      Integer_INOUT.Get(Env_File, Sensor_1);
      Integer_INOUT.Get(Env_File, Sensor_2);
      Integer_INOUT.Get(Env_File, Sensor_3);
      Integer_INOUT.Get(Env_File, ResetSig);
      Sensors.Write_Sensors(Sensor_1, Sensor_2, Sensor_3);
      if ResetSig = 1 then
         Console.Enable_Reset;
      else
         Console.Disable_Reset;
      end if;
      Text_IO.Put('.');
   end Update_Env;

   function At_End return Boolean is
   begin
      return Text_IO.End_Of_File(Env_File);
   end At_End;

   procedure Open_Env_File is
   begin
      Text_IO.Open(Env_File, Text_IO.In_File, "env.dat");
   end Open_Env_File;

   procedure Close_Env_File is
   begin
      Text_IO.Close(Env_File);
      Text_IO.Put_Line(" [ complete ]");
   end Close_Env_File;


   package Sensor_INOUT is new Text_IO.Enumeration_IO(Pressure_Cat);
   -- use Sensor_INOUT;
   -- package Integer_INOUT is new Text_IO.Integer_IO(Integer);
   -- use Integer_INOUT;

   Log_File: Text_IO.File_Type;
   
   function Sensor_2_Pressure_Cat(Sensor_Value: in Sensors.Sensor_Type) return Pressure_Cat
   is
      PC: Pressure_Cat;
   begin
      if Sensor_Value < 100 then 
	 PC := Normal;
      elsif Sensor_Value < 150 then
	 PC := High;
      elsif Sensor_Value < 200 then
	 PC := Critical;
      else
	 PC := Undef;
      end if;
      return PC;
   end Sensor_2_Pressure_Cat;

   procedure Update_Log is
   begin
      Sensor_INOUT.Put(Log_File, Sensor_2_Pressure_Cat(Sensors.Read_Sensor(1)), 10);
      Sensor_INOUT.Put(Log_File, Sensor_2_Pressure_Cat(Sensors.Read_Sensor(2)), 10);
      Sensor_INOUT.Put(Log_File, Sensor_2_Pressure_Cat(Sensors.Read_Sensor(3)), 10);
      Sensor_INOUT.Put(Log_File, Sensor_2_Pressure_Cat(Sensors.Read_Sensor_Majority), 10);
      if Alarm.Enabled then
         Text_IO.Put(Log_File, "ON   ");
      else
         Text_IO.Put(Log_File, "--   ");
      end if;
      if EscapeValve.Activated then
         Text_IO.Put(Log_File, "  OPEN  ");
      else
         Text_IO.Put(Log_File, "  --    ");
      end if;
      if Console.Reset_Enabled then
         Text_IO.Put(Log_File, "   ON");
      else
         Text_IO.Put(Log_File, "   --");
      end if;
      Integer_INOUT.Put(Log_File, Console.Alarm_Cnt_Value, 6);
      Text_IO.New_Line(Log_File);
   end Update_Log;

   procedure Open_Log_File is
   begin
      Text_IO.Create(Log_File, Text_IO.Out_File, "log.dat");
      Text_IO.Put_Line(Log_File,
               "SENSOR-1  SENSOR-2  SENSOR-3  MAJORITY  ALARM  E-VALVE  RESET  ALARM-CNT");
      Text_IO.Put_Line(Log_File,
               "--------  --------  --------  --------  -----  -------  -----  ---------");
   end Open_Log_File;

   procedure Close_Log_File is
   begin
      Text_IO.Close(Log_File);
   end Close_Log_File;

end Handler;



