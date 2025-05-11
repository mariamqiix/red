transcript on
if {[file exists rtl_work]} {
	vdel -lib rtl_work -all
}
vlib rtl_work
vmap work rtl_work

vcom -93 -work work {//wsl.localhost/Ubuntu/home/gaith/red/RED_DATA_MEM.vhd}

