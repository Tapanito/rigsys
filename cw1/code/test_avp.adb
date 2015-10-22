
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
-- Filename:            test_avp.adb
--
-- Description:         Test harness for the AVP controller. Note that test data and
--                      results are managed via the Env and Log packages respectively.

-- With Env, Log, Sensors, Alarm, Console, AVP;
With Handler, AVP;
procedure Test_AVP is
begin
   Handler.Open_Env_File;
   Handler.Open_Log_File;
   loop
      exit when Handler.At_End;
      Handler.Update_Env;
      Handler.Update_Log;
      AVP.Control;
      Handler.Update_Log;
   end loop;
   Handler.Close_Env_File;
   Handler.Close_Log_File;
end Test_AVP;



