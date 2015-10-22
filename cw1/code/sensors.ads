package Sensors
   --# own State;
   --# initializes State;
is
   Init_Value:  constant := 0;
   Undef_Value: constant := 200; -- range of valid pressure readings is 0..199. A value of 200 denotes an undefined reading.

   subtype Sensor_Type is Integer range 0..200;
   subtype Sensor_Index_Type is Integer range 1..3;
         
   procedure Write_Sensors(Value_1, Value_2, Value_3: in Sensor_Type);
   --# global out State;
   --# derives State from Value_1, Value_2, Value_3;

   function Read_Sensor(Sensor_Index: in Sensor_Index_Type) return Sensor_Type;
   --# global in State;

   function Read_Sensor_Majority return Sensor_Type;
   --# global in State;
   
end Sensors;