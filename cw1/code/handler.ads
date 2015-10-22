
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
-- Filename:            handler.ads
--
-- Description:         Provides the drivers required for simulating the
--                      environment in which the AVP system operates as
--                      well as a logging capability. 

package Handler is

  subtype Sensor_Range is Integer range 0..200;
   
  type Pressure_Cat is (Normal, High, Critical, Undef);
   
  procedure Update_Env;

  function At_End return Boolean;

  procedure Open_Env_File;

  procedure Close_Env_File;

  procedure Update_Log;

  procedure Open_Log_File;

  procedure Close_Log_File;

end Handler;



