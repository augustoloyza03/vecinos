onerror {quit -f}
vlib work
vlog -work work vecinos.vo
vlog -work work vecinos.vt
vsim -novopt -c -t 1ps -L cycloneive_ver -L altera_ver -L altera_mf_ver -L 220model_ver -L sgate work.controlgeneralversion3_4_vlg_vec_tst
vcd file -direction vecinos.msim.vcd
vcd add -internal controlgeneralversion3_4_vlg_vec_tst/*
vcd add -internal controlgeneralversion3_4_vlg_vec_tst/i1/*
add wave /*
run -all
