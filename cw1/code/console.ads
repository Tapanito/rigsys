package  Console
  --# own Reset_Status, Alarm_Cnt;
  --# initializes Reset_Status, Alarm_Cnt;
is
    Reset_Status: Boolean;
    Alarm_Cnt: Integer;
   
   procedure Enable_Reset;
      --# global out Reset_Status;
      --# derives Reset_Status from ; 
   
   procedure Disable_Reset;
     --# global out Reset_Status;
     --# derives Reset_Status from ;  
   
   function Reset_Enabled return Boolean;
     --# global in Reset_Status;  
   
   procedure Inc_Alarm_Cnt;
     --# global in out Alarm_Cnt;
     --# derives Alarm_Cnt from Alarm_Cnt;

   procedure Reset_Alarm_Cnt;
      --# global out Alarm_Cnt;
      --# derives Alarm_Cnt from ;
   
   function Alarm_Cnt_Value return Integer;
   --# global in Alarm_Cnt;

end Console;