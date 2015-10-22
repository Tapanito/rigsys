--# inherit Sensors, Console, Alarm, EscapeValve;
package AVP
is
         
   procedure Control;
   --# global in Sensors.State, Console.Reset_Status;
   --#        in out Alarm.State, EscapeValve.State, Console.Alarm_Cnt;

   
end AVP;