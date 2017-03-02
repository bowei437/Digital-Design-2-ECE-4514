onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate /sinc_tester/u1/clk_clk
add wave -noupdate /sinc_tester/u1/reset_reset_n
add wave -noupdate /sinc_tester/u1/start_export
add wave -noupdate -color Coral -radix decimal /sinc_tester/u1/i
add wave -noupdate -color Coral -radix decimal /sinc_tester/u1/s_count
add wave -noupdate -color Coral -radix decimal /sinc_tester/u1/out_count
add wave -noupdate -radix float32 /sinc_tester/u1/x_export
add wave -noupdate /sinc_tester/u1/done_export
add wave -noupdate -radix float32 /sinc_tester/u1/sinc_out_export
add wave -noupdate -radix float32 /sinc_tester/u1/x2_1
add wave -noupdate -radix float32 /sinc_tester/u1/x2_2
add wave -noupdate -radix float32 /sinc_tester/u1/x2_3
add wave -noupdate -radix float32 /sinc_tester/u1/x2_4
add wave -noupdate -radix float32 /sinc_tester/u1/x2_5
add wave -noupdate -radix float32 /sinc_tester/u1/x4_1
add wave -noupdate -radix float32 /sinc_tester/u1/x4_2
add wave -noupdate -radix float32 /sinc_tester/u1/x4_3
add wave -noupdate -radix float32 /sinc_tester/u1/x6_1
add wave -noupdate -radix float32 /sinc_tester/u1/x6_2
add wave -noupdate -radix float32 /sinc_tester/u1/x8_1
add wave -noupdate -radix float32 /sinc_tester/u1/d1
add wave -noupdate -radix float32 /sinc_tester/u1/d2
add wave -noupdate -radix float32 /sinc_tester/u1/d3
add wave -noupdate -radix float32 /sinc_tester/u1/d4
add wave -noupdate -radix float32 /sinc_tester/u1/ad1
add wave -noupdate -radix float32 /sinc_tester/u1/ad2
add wave -noupdate -radix float32 /sinc_tester/u1/ad3
add wave -noupdate -radix float32 /sinc_tester/u1/ad4
add wave -noupdate -radix float32 /sinc_tester/u1/ad5
add wave -noupdate -radix float32 /sinc_tester/u1/adres
add wave -noupdate -radix float32 /sinc_tester/u1/tempout
add wave -noupdate -radix float32 /sinc_tester/u1/fcompare
add wave -noupdate -radix float32 /sinc_tester/u1/tempdone
add wave -noupdate /sinc_tester/u1/inx
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {769124 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 214
configure wave -valuecolwidth 100
configure wave -justifyvalue left
configure wave -signalnamewidth 0
configure wave -snapdistance 10
configure wave -datasetprefix 0
configure wave -rowmargin 4
configure wave -childrowmargin 2
configure wave -gridoffset 0
configure wave -gridperiod 1
configure wave -griddelta 40
configure wave -timeline 0
configure wave -timelineunits ps
update
WaveRestoreZoom {11314664 ps} {11699228 ps}
