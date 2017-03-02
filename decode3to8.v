//  File         : decode3to8.v
//  Author       : B. Zhao
//  Date         : 01/20/17
//  Version      : 1
//  Description  : This file models the functional behavior of an 74ls138
//                 3-to-8 decoder / demultiplexor.  The decoder accepts three
//                 binary weighted address inputs (A0, A1 and A2).  When 
//                 enabled, the device provides 8 mutually exclusive active 
//                 LOW outputs (m0_n to m7_n).

module decode3to8(e1_n, e2_n, e3, a0, a1, a2, 
         m0_n, m1_n, m2_n, m3_n, m4_n, m5_n, m6_n, m7_n);

   input e1_n;          // enable inputs active low
   input e2_n;          // enable inputs active low
   input e3;            // enable inputs active high
   input a0;            // address input
   input a1;            // address input
   input a2;            // address input  

   output m0_n;         // output active low
   output m1_n;         // output active low
   output m2_n;         // output active low
   output m3_n;         // output active low
   output m4_n;         // output active low
   output m5_n;         // output active low
   output m6_n;         // output active low
   output m7_n;         // output active low
  

// 
//  I N S E R T   Y O U R   C O D E   H E R E

      // Wire Declarations
   wire e1neg, e2neg, a0neg, a1neg, a2neg;
   wire enablewire;

   // Block for enable 
   not (e1neg, e1_n);
   not (e2neg, e2_n);
   and (enablewire, e3, e1neg, e2neg);

   // Block for negative Selects
   not (a0neg, a0);
   not (a1neg, a1);
   not (a2neg, a2);

   // m0_n block output
   nand (m0_n, a0neg, a1neg, a2neg, enablewire);

   // m1_n block output
   nand (m1_n, a0, a1neg, a2neg, enablewire);

   // m2_n block output
   nand (m2_n, a0neg, a1, a2neg, enablewire);

   // m3_n block output
   nand (m3_n, a0, a1, a2neg, enablewire);

   //m4_n block output
   nand (m4_n, a0neg, a1neg, a2, enablewire);

   //m5_n block output
   nand (m5_n, a0, a1neg, a2, enablewire);

   //m6_n block output
   nand (m6_n, a0neg, a1, a2, enablewire);

   //m7_n block output
   nand (m7_n, a0, a1, a2, enablewire);

//  E N D   I N S E R T

endmodule