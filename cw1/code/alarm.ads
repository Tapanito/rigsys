--# inherit Console;
package Alarm
   --# own State;
   --# initializes State;
is
   procedure Enable;
   --# global in out Console.Alarm_Cnt;
   --#  out State;
   --# derives State from & Console.Alarm_Cnt from Console.Alarm_Cnt;


   procedure Disable;
   --# global out State;
   --# derives State from ;

   function Enabled return Boolean;
   --# global in State;

end Alarm;



