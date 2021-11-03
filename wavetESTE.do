onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix hexadecimal /topnoc/noc1/address_router1
add wave -noupdate -radix hexadecimal -childformat {{/topnoc/noc1/address_router2(15) -radix hexadecimal} {/topnoc/noc1/address_router2(14) -radix hexadecimal} {/topnoc/noc1/address_router2(13) -radix hexadecimal} {/topnoc/noc1/address_router2(12) -radix hexadecimal} {/topnoc/noc1/address_router2(11) -radix hexadecimal} {/topnoc/noc1/address_router2(10) -radix hexadecimal} {/topnoc/noc1/address_router2(9) -radix hexadecimal} {/topnoc/noc1/address_router2(8) -radix hexadecimal} {/topnoc/noc1/address_router2(7) -radix hexadecimal} {/topnoc/noc1/address_router2(6) -radix hexadecimal} {/topnoc/noc1/address_router2(5) -radix hexadecimal} {/topnoc/noc1/address_router2(4) -radix hexadecimal} {/topnoc/noc1/address_router2(3) -radix hexadecimal} {/topnoc/noc1/address_router2(2) -radix hexadecimal} {/topnoc/noc1/address_router2(1) -radix hexadecimal} {/topnoc/noc1/address_router2(0) -radix hexadecimal}} -subitemconfig {/topnoc/noc1/address_router2(15) {-height 15 -radix hexadecimal} /topnoc/noc1/address_router2(14) {-height 15 -radix hexadecimal} /topnoc/noc1/address_router2(13) {-height 15 -radix hexadecimal} /topnoc/noc1/address_router2(12) {-height 15 -radix hexadecimal} /topnoc/noc1/address_router2(11) {-height 15 -radix hexadecimal} /topnoc/noc1/address_router2(10) {-height 15 -radix hexadecimal} /topnoc/noc1/address_router2(9) {-height 15 -radix hexadecimal} /topnoc/noc1/address_router2(8) {-height 15 -radix hexadecimal} /topnoc/noc1/address_router2(7) {-height 15 -radix hexadecimal} /topnoc/noc1/address_router2(6) {-height 15 -radix hexadecimal} /topnoc/noc1/address_router2(5) {-height 15 -radix hexadecimal} /topnoc/noc1/address_router2(4) {-height 15 -radix hexadecimal} /topnoc/noc1/address_router2(3) {-height 15 -radix hexadecimal} /topnoc/noc1/address_router2(2) {-height 15 -radix hexadecimal} /topnoc/noc1/address_router2(1) {-height 15 -radix hexadecimal} /topnoc/noc1/address_router2(0) {-height 15 -radix hexadecimal}} /topnoc/noc1/address_router2
add wave -noupdate -radix hexadecimal /topnoc/noc1/address_router3
add wave -noupdate /topnoc/noc1/localRouterInt
add wave -noupdate -radix unsigned /topnoc/noc1/RouterTierInt
add wave -noupdate /topnoc/noc1/pos_x
add wave -noupdate -expand /topnoc/noc1/rx(17)
add wave -noupdate -expand /topnoc/noc1/rx(15)
add wave -noupdate -expand /topnoc/noc1/rx(11)
add wave -noupdate -expand /topnoc/noc1/rx(9)
add wave -noupdate -expand /topnoc/noc1/rx(8)
add wave -noupdate -expand /topnoc/noc1/rx(6)
add wave -noupdate -expand /topnoc/noc1/rx(2)
add wave -noupdate -expand /topnoc/noc1/rx(0)
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {99125 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 258
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
WaveRestoreZoom {99055 ps} {100050 ps}
