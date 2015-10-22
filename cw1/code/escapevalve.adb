package body EscapeValve
   --# own State is Valve_State;
is
   Valve_State: Boolean;

   procedure Activate
   --# global out Valve_State;
   --# derives Valve_State from ;
   is
   begin
      Valve_State := True;
   end Activate;

   procedure Deactivate
   --# global out Valve_State;
   --# derives Valve_State from ;
   is
   begin
      Valve_State := False;
   end Deactivate;

   function Activated return Boolean
   --# global in Valve_State;
   is
   begin
      return Valve_State;
   end Activated;

begin
   Valve_State := False;
end EscapeValve;



