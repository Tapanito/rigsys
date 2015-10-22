package body Sensors
   --# own State is Sensor_1, Sensor_2, Sensor_3;
is

   -- initializing at 0 might be bad
   Sensor_1: Sensor_Type;
   Sensor_2: Sensor_Type;
   Sensor_3: Sensor_Type;

   procedure Write_Sensors(Value_1, Value_2, Value_3: in Sensor_Type) 
   --# global out Sensor_1, Sensor_2, Sensor_3;
   --# derives Sensor_1 from Value_1 & Sensor_2 from Value_2 & Sensor_3 from Value_3;
   is
   begin
      Sensor_1 := Value_1;
      Sensor_2 := Value_2;
      Sensor_3 := Value_3;
   end Write_Sensors;

   function Read_Sensor(Sensor_Index: in Sensor_Index_Type) return Sensor_Type
   --# global in Sensor_1, Sensor_2, Sensor_3;
   is
      t : Sensor_Type := Init_Value;
   begin
      if Sensor_Index < Sensor_Index_Type'Last then
         if Sensor_Index = 1 then
            t := Sensor_1;
         elsif Sensor_Index = 2 then
            t := Sensor_2;
         else
            t := Sensor_3;
         end if;
      end if;
      return t;
   end Read_Sensor;


   function Read_Sensor_Majority return Sensor_Type 
   --# global in Sensor_1, Sensor_2, Sensor_3;
   is
      t: Sensor_Type;
   begin
   if Sensor_1 = Sensor_2 then
      t := Sensor_1;
   elsif Sensor_1 = Sensor_3 then
      t := Sensor_1;
   elsif Sensor_2 = Sensor_3 then
      t := Sensor_2;
   else
      t := Undef_Value;
   end if;

   return t;
   end Read_Sensor_Majority;
begin
   Sensor_1 := Init_Value;
   Sensor_2 := Init_Value;
   Sensor_3 := Init_Value;   
end Sensors;