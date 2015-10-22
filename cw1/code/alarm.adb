with Console;
package body Alarm 
is
    State: Boolean;
    procedure Enable
    is
    begin
        Console.Inc_Alarm_Cnt;
        State := True;
    end Enable;

    procedure Disable
    is
    begin
        State := False;
    end Disable;


    function Enabled return Boolean
    is
    begin
        return State;
    end Enabled;

begin
    -- init
    State := False;
end Alarm;