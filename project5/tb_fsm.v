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
        // TEST SET 2
        dataa = 32'H0129126E; // 2.567
        datab = 32'H01520831; // 5.127 
        // result should equal 7.694 or 017B1A9F


        #60;
        dataa = 32'H01100000; //  1
        datab = 32'H812AAAAA; //  -2.666667
        // result =  or 
        #60;
        dataa = 32'H01222222; // 2.1333
        datab = 32'H80D00D00; //  -0.81269
        // result =  or 
        #60;
        dataa = 32'H01152152; // 1.32063
        datab = 32'H002E3BC7; //  0.180599
        // result =  or 
        #60;
        dataa = 32'H811AAAAA; // -1.666667
        datab = 32'H0118050E; //  1.50123
        // result =  or 
        #60;
        dataa = 32'H811AAACD; // -1.666667
        datab = 32'H011804EA; //  1.50123
        // result =  or 
        #60;
        dataa = 32'H00000000; // 
        datab = 32'H00000000; //  
        // result =  or 
        #60;
        dataa = 32'H00000000; // 
        datab = 32'H00000000; //  
        // result =  or 
        #60;
        dataa = 32'H00000000; // 
        datab = 32'H00000000; //  
        // result =  or 
        #60;
        dataa = 32'H00000000; // 
        datab = 32'H00000000; //  
        // result =  or 

        #80;
            //dataa = 32'H018E3D46; //8.88996
        //dataa = 32'H01FE58E2; // 15.8967
    end    


// Test the counter functionality here.  You should set up a 50 MHz
// clock, along with the various control and input signals.

endmodule


        /*
        #60;
        dataa = 32'H00000000; // 
        datab = 32'H00000000; //  
        // result =  or 
        #60;
        dataa = 32'H00000000; // 
        datab = 32'H00000000; //  
        // result =  or 
        #60;
        dataa = 32'H00000000; // 
        datab = 32'H00000000; //  
        // result =  or 

        // TEST SET 1
        //dataa = 32'H0176288C; // 7.3849
        dataa = 32'H0129126E; // 2.567
        datab = 32'H01520831; // 5.127 
        // result should equal 7.694 or 017B1A9F
        #60;
        dataa = 32'H02240000; // 36
        datab = 32'H01C00000; // 12
        // result = 48 or 02300000
        #60;
        dataa = 32'H822D0000; // -45
        datab = 32'H01D00000; // 13
        //result = -32 or 82200000
        #60;
        dataa = 32'H02330000; // 51
        datab = 32'H81700000; // -7
        // result = 44 or 022C0000
        #60;
        dataa = 32'H8225E4F0; // -37.8943
        datab = 32'H0161FDF3; // 6.1245
        // result = -31.7698 or 821FC511
        #60;
        dataa = 32'H01C00000; // 12
        datab = 32'H02260000; // 38
        // result = 50 or 02320000
        #60;
        dataa = 32'H81400000; // -4
        datab = 32'H02120000; // 18
        // result = 14 or 01E00000
        #60;
        dataa = 32'H81B00000; // -11
        datab = 32'H02270000; // 39
        // result = 28 or 021C0000
        #60;
        dataa = 32'H81200000; // -2
        datab = 32'H01B00000; // 11
        // result = 9 or 01900000
        #60;
        dataa = 32'H01B00000; // 11
        datab = 32'H81200000; // -2
        // result = 9 or 01900000
        */

        /* TEST 2
        dataa = 32'H82130000; // -19
        datab = 32'H01A00000; //  10
        // result =  9 or 01900000
        #60;
        dataa = 32'H02120000; // 18
        datab = 32'H81F00000; //  -15
        // result =  or 01300000
        #60;
        dataa = 32'H82130000; // -19
        datab = 32'H81E00000; //  -14
        // result =  or 82210000
        #60;
        dataa = 32'H02FF0000; // 255
        datab = 32'H01F00000; //  15
        // result =  or 0310E000
        #60;
        dataa = 32'H01B00000; // 11
        datab = 32'H82120000; //  -18
        // result =  or 81700000
        #60;
        dataa = 32'H81D00000; // -13
        datab = 32'H02110000; //  17
        // result =  or 01400000
        #60;
        dataa = 32'H81A00000; // -10
        datab = 32'H82190000; //  -25
        // result =  or 82230000
        #60;
        dataa = 32'H01F00000; // 15
        datab = 32'H02FF0000; //  255
        // result =  or 0310E000
        #60;
        dataa = 32'H01F00000; // 15
        datab = 32'H01F00000; //  15
        // result =  or 021E0000
        #60;
        dataa = 32'H81E00000; // -14
        datab = 32'H01C00000; //  12
        // result =  or 81200000
        #60;
        dataa = 32'H81500000; // -5
        datab = 32'H01B00000; //  11
        // result =  or 01600000
        #60;
        dataa = 32'H01F00000; // 15
        datab = 32'H81C00000; //  -12
        // result =  or 01300000
        #60;
        dataa = 32'H81E00000; // -14
        datab = 32'H81B00000; //  -11
        // result =  or 82190000
        #60;
        dataa = 32'H81500000; // -5
        datab = 32'H81500000; //  -5
        // result =  or 81A00000
        #60;
        dataa = 32'H01400000; // 4
        datab = 32'H01800000; //  8
        // result =  or 01C00000
        #60;
        dataa = 32'H01900000; // 9
        datab = 32'H01A00000; //  10
        // result =  or 02130000
        */