//  File         : clockblink.v
//  Author       : B. Zhao
//  Date         : 01/26/17
//  Version      : 1
//  Description  : This file contains two modules that is used to time
//                1/2second and 1/4second.
      

module  clockblink(clock, secondhalf);
  output  reg secondhalf;
  input clock;
  reg [25:0] count;
  always @(posedge clock)
  begin
    if (count <= 26'd24_999_999)
    begin
      count <= count + 1;
      secondhalf <= 0;
    end
    else if (count >= 26'd25_000_000)
    begin
      count <= count + 1;
      secondhalf <= 1;
    end
    else if (count >= 26'd49_999_999)
    begin
      count <= 0;
    end
  end
endmodule



module  quarterblink(clock, secondquarter);
  output  reg secondquarter;
  input clock;
  reg [25:0] count;
  always @(posedge clock)
  begin
    if (count <= 26'd12_499_999)
    begin
      count <= count + 1;
      secondquarter <= 0;
    end
    else if (count >= 26'd12_500_000)
    begin
      count <= count + 1;
      secondquarter <= 1;
    end
    else if (count >= 26'd25_000_000)
    begin
      count <= 0;
    end
  end
endmodule