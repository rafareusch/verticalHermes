onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /topnoc/TIERS
add wave -noupdate -divider {FONTE DOS DADOS}
add wave -noupdate -radix hexadecimal /topnoc/ce1
add wave -noupdate -radix hexadecimal /topnoc/data1
add wave -noupdate -divider {ROUTER 26 (TIER 3) MAIN}
add wave -noupdate -radix hexadecimal /topnoc/noc1/clock(26)
add wave -noupdate -radix hexadecimal /topnoc/noc1/rx(26)(4)
add wave -noupdate -radix hexadecimal /topnoc/noc1/credit_o(26)(4)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_in(26)(4)
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(26)/router/SwitchControl/header
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(26)/router/SwitchControl/tx
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(26)/router/SwitchControl/ty
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(26)/router/SwitchControl/dirx
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(26)/router/SwitchControl/diry
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(26)/router/SwitchControl/lt
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(26)/router/SwitchControl/tt
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(26)/router/SwitchControl/ls
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(26)/router/SwitchControl/ts
add wave -noupdate -divider {ROUTER 26 (TIER 3) WEST}
add wave -noupdate -radix hexadecimal /topnoc/noc1/tx(26)(1)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_out(26)(1)
add wave -noupdate -radix hexadecimal /topnoc/noc1/credit_o(26)(1)
add wave -noupdate -divider {ROUTER 26 (TIER 3) EAST}
add wave -noupdate -radix hexadecimal /topnoc/noc1/tx(26)(0)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_out(26)(0)
add wave -noupdate -radix hexadecimal /topnoc/noc1/credit_o(26)(0)
add wave -noupdate -divider {ROUTER 17 (TIER 2) WEST}
add wave -noupdate -radix hexadecimal /topnoc/noc1/tx(17)(1)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_out(17)(1)
add wave -noupdate -radix hexadecimal /topnoc/noc1/credit_o(17)(1)
add wave -noupdate -divider {ROUTER 17 (TIER 2) NORTH}
add wave -noupdate -radix hexadecimal /topnoc/noc1/rx(17)(2)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_in(17)(2)
add wave -noupdate -radix hexadecimal /topnoc/noc1/credit_i(17)(2)
add wave -noupdate -divider {ROUTER 8 (TIER 1) NORTH}
add wave -noupdate -radix hexadecimal /topnoc/noc1/rx(8)(2)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_in(8)(2)
add wave -noupdate -radix hexadecimal /topnoc/noc1/credit_i(8)(2)
add wave -noupdate -divider {ROUTER 06 (TIER 1) EAST}
add wave -noupdate -radix hexadecimal /topnoc/noc1/rx(6)(0)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_in(6)(0)
add wave -noupdate -radix hexadecimal /topnoc/noc1/credit_i(6)(0)
add wave -noupdate -divider {ROUTER 00 (TIER 1) NORTH}
add wave -noupdate -radix hexadecimal /topnoc/noc1/rx(0)(2)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_in(0)(2)
add wave -noupdate -radix hexadecimal /topnoc/noc1/credit_i(0)(2)
add wave -noupdate -divider {ROUTER 00 (TIER 1) EAST}
add wave -noupdate -radix hexadecimal /topnoc/noc1/clock(0)
add wave -noupdate -radix hexadecimal /topnoc/noc1/rx(0)(4)
add wave -noupdate -radix hexadecimal /topnoc/noc1/credit_o(0)(4)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_in(0)(0)
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(0)/router/SwitchControl/header
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(0)/router/SwitchControl/tx
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(0)/router/SwitchControl/ty
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(0)/router/SwitchControl/dirx
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(0)/router/SwitchControl/diry
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(0)/router/SwitchControl/lt
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(0)/router/SwitchControl/tt
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(0)/router/SwitchControl/ls
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(0)/router/SwitchControl/ts
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {1756490 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 291
configure wave -valuecolwidth 40
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
configure wave -timelineunits ns
update
WaveRestoreZoom {268949 ps} {2498814 ps}
