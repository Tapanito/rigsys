with Sensors, Console, Alarm, EscapeValve;
package body AVP
is
   procedure Control is
        Sensor_Value: Sensors.Sensor_Type;
   begin 

        Sensor_Value := Sensors.Read_Sensor_Majority;
   
        if EscapeValve.Activated = False then

            -- if normal
            if (Sensor_Value < 100) then
                
                -- if alarm is active
                if Alarm.Enabled = True then
                    Alarm.Disable;
                end if;
            elsif (Sensor_Value >= 100) then
                -- check if value got reduced
                -- if high
                if(Sensor_Value <= 149) then
                    -- enable alarm
                    if Alarm.Enabled = False then
                        Alarm.Enable;

                    else -- if the alarm has already been activated activate the valve  
                            EscapeValve.Activate;
                    end if;
                -- if critical
                elsif (Sensor_Value >= 150) then
                    -- activate escape valve
                    EscapeValve.Activate;
                    -- if alarm not active - activate
                    if Alarm.Enabled = False then
                        Alarm.Enable;
                    end if;
                end if;
            end if;
        end if;
        
        -- if reset mechanism is enabled
        if Console.Reset_Enabled = True then
            Alarm.Disable;
            EscapeValve.Deactivate;
        end if;

   end Control;
   
end AVP;