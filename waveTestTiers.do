onerror {resume}
quietly WaveActivateNextPane {} 0
add wave -noupdate -radix unsigned /topnoc/noc1/noc(13)/router/SwitchControl/lx
add wave -noupdate -radix unsigned /topnoc/noc1/noc(13)/router/SwitchControl/ly
add wave -noupdate -radix unsigned /topnoc/noc1/noc(17)/router/SwitchControl/lx
add wave -noupdate -radix unsigned /topnoc/noc1/noc(17)/router/SwitchControl/ly
add wave -noupdate -radix unsigned /topnoc/noc1/noc(16)/router/SwitchControl/lx
add wave -noupdate -radix unsigned /topnoc/noc1/noc(16)/router/SwitchControl/ly
add wave -noupdate -radix unsigned /topnoc/noc1/noc(9)/router/SwitchControl/lx
add wave -noupdate -radix unsigned /topnoc/noc1/noc(9)/router/SwitchControl/ly
TreeUpdate [SetDefaultTree]
WaveRestoreCursors {{Cursor 1} {90064 ps} 0}
quietly wave cursor active 1
configure wave -namecolwidth 344
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
WaveRestoreZoom {0 ps} {637560 ps}
