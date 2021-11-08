onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -divider {FONTE DOS DADOS}
add wave -noupdate /topnoc/ce1
add wave -noupdate -radix hexadecimal /topnoc/data1
add wave -noupdate -divider {ROUTER 11 (TIER 1) MAIN}
add wave -noupdate /topnoc/noc1/clock(4)
add wave -noupdate /topnoc/noc1/rx(4)(4)
add wave -noupdate /topnoc/noc1/credit_o(4)(4)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_in(4)(4)
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(4)/router/SwitchControl/header
add wave -noupdate -radix decimal /topnoc/noc1/noc(4)/router/SwitchControl/tx
add wave -noupdate -radix decimal /topnoc/noc1/noc(4)/router/SwitchControl/ty
add wave -noupdate /topnoc/noc1/noc(4)/router/SwitchControl/dirx
add wave -noupdate /topnoc/noc1/noc(4)/router/SwitchControl/diry
add wave -noupdate -radix decimal /topnoc/noc1/noc(4)/router/SwitchControl/lt
add wave -noupdate -radix decimal /topnoc/noc1/noc(4)/router/SwitchControl/tt
add wave -noupdate -radix decimal /topnoc/noc1/noc(4)/router/SwitchControl/ls
add wave -noupdate -radix decimal /topnoc/noc1/noc(4)/router/SwitchControl/ts
add wave -noupdate -divider {ROUTER 11 (TIER 1) EAST}
add wave -noupdate /topnoc/noc1/tx(4)(0)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_out(4)(0)
add wave -noupdate /topnoc/noc1/credit_o(4)(0)
add wave -noupdate -divider {ROUTER 11 (TIER 1) WEST}
add wave -noupdate /topnoc/noc1/credit_i(4)(1)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_out(4)(1)
add wave -noupdate /topnoc/noc1/tx(4)(1)
add wave -noupdate -divider {ROUTER 01 (TIER 1) EAST}
add wave -noupdate /topnoc/noc1/rx(3)(0)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_in(3)(0)
add wave -noupdate /topnoc/noc1/credit_i(3)(0)
add wave -noupdate -divider {ROUTER 01 (TIER 1) SOUTH}
add wave -noupdate /topnoc/noc1/credit_o(3)(3)
add wave -noupdate /topnoc/noc1/tx(3)(3)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_out(3)(3)
add wave -noupdate -divider {ROUTER 00 (TIER 1) LOCAL}
add wave -noupdate /topnoc/noc1/clock(0)
add wave -noupdate /topnoc/noc1/credit_i(0)(4)
add wave -noupdate /topnoc/noc1/tx(4)(4)
add wave -noupdate -radix hexadecimal -childformat {{/topnoc/noc1/data_out(0)(4)(15) -radix hexadecimal} {/topnoc/noc1/data_out(0)(4)(14) -radix hexadecimal} {/topnoc/noc1/data_out(0)(4)(13) -radix hexadecimal} {/topnoc/noc1/data_out(0)(4)(12) -radix hexadecimal} {/topnoc/noc1/data_out(0)(4)(11) -radix hexadecimal} {/topnoc/noc1/data_out(0)(4)(10) -radix hexadecimal} {/topnoc/noc1/data_out(0)(4)(9) -radix hexadecimal} {/topnoc/noc1/data_out(0)(4)(8) -radix hexadecimal} {/topnoc/noc1/data_out(0)(4)(7) -radix hexadecimal} {/topnoc/noc1/data_out(0)(4)(6) -radix hexadecimal} {/topnoc/noc1/data_out(0)(4)(5) -radix hexadecimal} {/topnoc/noc1/data_out(0)(4)(4) -radix hexadecimal} {/topnoc/noc1/data_out(0)(4)(3) -radix hexadecimal} {/topnoc/noc1/data_out(0)(4)(2) -radix hexadecimal} {/topnoc/noc1/data_out(0)(4)(1) -radix hexadecimal} {/topnoc/noc1/data_out(0)(4)(0) -radix hexadecimal}} -subitemconfig {/topnoc/noc1/data_out(0)(4)(15) {-height 15 -radix hexadecimal} /topnoc/noc1/data_out(0)(4)(14) {-height 15 -radix hexadecimal} /topnoc/noc1/data_out(0)(4)(13) {-height 15 -radix hexadecimal} /topnoc/noc1/data_out(0)(4)(12) {-height 15 -radix hexadecimal} /topnoc/noc1/data_out(0)(4)(11) {-height 15 -radix hexadecimal} /topnoc/noc1/data_out(0)(4)(10) {-height 15 -radix hexadecimal} /topnoc/noc1/data_out(0)(4)(9) {-height 15 -radix hexadecimal} /topnoc/noc1/data_out(0)(4)(8) {-height 15 -radix hexadecimal} /topnoc/noc1/data_out(0)(4)(7) {-height 15 -radix hexadecimal} /topnoc/noc1/data_out(0)(4)(6) {-height 15 -radix hexadecimal} /topnoc/noc1/data_out(0)(4)(5) {-height 15 -radix hexadecimal} /topnoc/noc1/data_out(0)(4)(4) {-height 15 -radix hexadecimal} /topnoc/noc1/data_out(0)(4)(3) {-height 15 -radix hexadecimal} /topnoc/noc1/data_out(0)(4)(2) {-height 15 -radix hexadecimal} /topnoc/noc1/data_out(0)(4)(1) {-height 15 -radix hexadecimal} /topnoc/noc1/data_out(0)(4)(0) {-height 15 -radix hexadecimal}} /topnoc/noc1/data_out(0)(4)
add wave -noupdate -radix hexadecimal /topnoc/noc1/noc(0)/router/SwitchControl/header
add wave -noupdate -radix unsigned /topnoc/noc1/noc(0)/router/SwitchControl/tx
add wave -noupdate -radix unsigned /topnoc/noc1/noc(0)/router/SwitchControl/ty
add wave -noupdate -radix unsigned /topnoc/noc1/noc(0)/router/SwitchControl/tt
add wave -noupdate -radix unsigned /topnoc/noc1/noc(0)/router/SwitchControl/ts
add wave -noupdate -divider {ROUTER 00 (TIER 1) EAST}
add wave -noupdate /topnoc/noc1/tx(0)(0)
add wave -noupdate /topnoc/noc1/credit_i(0)(0)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_out(0)(0)
add wave -noupdate -divider {ROUTER 00 (TIER 1) SOUTH}
add wave -noupdate -radix hexadecimal /topnoc/noc1/tx(0)(3)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_out(0)(3)
add wave -noupdate -radix hexadecimal /topnoc/noc1/credit_o(0)(3)
add wave -noupdate -divider {ROUTER 10 (TIER 1) EAST}
add wave -noupdate /topnoc/noc1/tx(1)(0)
add wave -noupdate /topnoc/noc1/credit_i(1)(0)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_out(1)(0)
add wave -noupdate -divider {ROUTER 00 (TIER 2) WEST}
add wave -noupdate -radix hexadecimal /topnoc/noc1/rx(9)(1)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_in(9)(1)
add wave -noupdate -radix hexadecimal /topnoc/noc1/credit_i(9)(1)
add wave -noupdate -divider {ROUTER 00 (TIER 2) SOUTH}
add wave -noupdate -radix hexadecimal /topnoc/noc1/tx(9)(3)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_out(9)(3)
add wave -noupdate -radix hexadecimal /topnoc/noc1/credit_o(9)(3)
add wave -noupdate -divider {ROUTER 10 (TIER 2) WEST}
add wave -noupdate /topnoc/noc1/rx(8)(1)
add wave -noupdate /topnoc/noc1/credit_i(8)(1)
add wave -noupdate /topnoc/noc1/data_in(8)(1)
add wave -noupdate -divider {ROUTER 01 (TIER 2) SOUTH}
add wave -noupdate /topnoc/noc1/rx(12)(3)
add wave -noupdate /topnoc/noc1/credit_i(12)(3)
add wave -noupdate /topnoc/noc1/data_in(12)(3)
add wave -noupdate -divider {ROUTER 00 (TIER 3) WEST}
add wave -noupdate -radix hexadecimal /topnoc/noc1/rx(18)(1)
add wave -noupdate -radix hexadecimal /topnoc/noc1/credit_i(18)(1)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_in(18)(1)
add wave -noupdate -divider {ROUTER 20 (TIER 3) SOUTH}
add wave -noupdate /topnoc/noc1/rx(20)(1)
add wave -noupdate /topnoc/noc1/credit_i(20)(1)
add wave -noupdate /topnoc/noc1/data_in(20)(1)
add wave -noupdate -divider {ROUTER 22 (TIER 3) SOUTH}
add wave -noupdate -radix hexadecimal /topnoc/noc1/rx(26)(3)
add wave -noupdate -radix hexadecimal /topnoc/noc1/data_in(26)(3)
add wave -noupdate -radix hexadecimal /topnoc/noc1/credit_i(26)(3)
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {3344326 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 291
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
configure wave -timelineunits ns
update
WaveRestoreZoom {0 ps} {2301031 ps}
