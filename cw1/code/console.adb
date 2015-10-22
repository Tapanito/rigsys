package  body Console is   
   procedure Enable_Reset 
   is
   begin
        Reset_Status := True;
   end Enable_Reset;

   procedure Disable_Reset 
   is
   begin
        Reset_Status := False;
   end Disable_Reset;

   function Reset_Enabled return Boolean
   is
   begin
        return Reset_Status;
   end Reset_Enabled;
   
   procedure Inc_Alarm_Cnt
   is
   begin
      -- prevent overflow
      if Alarm_Cnt < Integer'Last then
        Alarm_Cnt := Alarm_Cnt + 1;
      end if;
   end Inc_Alarm_Cnt;
   
   procedure Reset_Alarm_Cnt
   is
   begin
        Alarm_Cnt := 0;
   end Reset_Alarm_Cnt;
      
   function Alarm_Cnt_Value return Integer
   is
   begin
        return Alarm_Cnt;
   end Alarm_Cnt_Value;
begin
    -- init
    Reset_Status := False;
    Alarm_Cnt := 0;
end Console;



