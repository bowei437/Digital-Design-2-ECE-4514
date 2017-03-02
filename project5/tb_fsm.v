`timescale 1ns/1ns

module tb_fsm();
    reg clock, add_sub;
    reg [31:0] dataa, datab;
    wire [31:0] result;
    reg stopClock;

// Instantiate counter.
    //myfpmult tb1(clock, dataa, datab, result);
    myfpadd tb2(add_sub, clock, dataa, datab, result);

    initial begin
      clock = 1;
      forever #10 clock = !clock;
   end

    initial begin
        #20;
        //dataa = 32'H0176288C; // 7.3849
        dataa = 32'H0129126E; // 2.567
        datab = 32'H01520831; // 5.127 
        // result should equal 7.694 or 017B1A9F
        #200;
        dataa = 32'H02240000; // 36
        datab = 32'H01C00000; // 12
        // result = 48 or 02300000
        #200;
        dataa = 32'H822D0000; // -45
        datab = 32'H01D00000; // 13
        //result = -32 or 82200000
        #200;
        dataa = 32'H02330000; // 51
        datab = 32'H81700000; // -7
        // result = 44 or 022C0000
        #200;
        dataa = 32'H8225E4F0; // -37.8943
        datab = 32'H0161FDF3; // 6.1245
        // result = -31.7698 or 821FC511
        #200;
        dataa = 32'H01C00000; // 12
        datab = 32'H02260000; // 38
        // result = 50 or 02320000
        #200;
        dataa = 32'H81400000; // -4
        datab = 32'H02120000; // 18
        // result = 14 or 01E00000
        #200;
        dataa = 32'H81B00000; // -11
        datab = 32'H02270000; // 39
        // result = 28 or 021C0000
        #200;
        dataa = 32'H81200000; // -2
        datab = 32'H01B00000; // 11
        // result = 9 or 01900000
        #200;
        dataa = 32'H00000000; // 
        datab = 32'H00000000; // 
        // result = 50 or 
        #200;
        #80;
            //dataa = 32'H018E3D46; //8.88996
        //dataa = 32'H01FE58E2; // 15.8967
    end    


// Test the counter functionality here.  You should set up a 50 MHz
// clock, along with the various control and input signals.

endmodule
