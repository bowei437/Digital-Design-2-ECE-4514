//  File            : majority.v
//  Author         : Bowei Zhao
//  Date            : 1/18/2017
//  Version        : 1
//  Description  : This file models majority circuit that produces a '1' when
//                      two or more of the inputs are '1'.

module majority(a, b, c, major );
   input a, b, c;
   output major;
   wire w1, w2, w3;

   and  (w1, a, b);
   and  (w2, b, c);
   and  (w3, c, a);

   or (major, w1, w2, w3);

//
//  I N S E R T   Y O U R   C O D E   H E R E

//  E N D   I N S E R T
endmodule
