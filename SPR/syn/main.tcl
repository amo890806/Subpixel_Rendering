set hdlin_translate_off_skip_text "TRUE"
set edifout_netlist_only "TRUE"
set verilogout_no_tri true
set plot_command {lpr -Plw}
set hdlin_auto_save_templates "TRUE"
set compile_fix_multiple_port_nets "TRUE"

set DESIGN "spr_top"
set CLOCK "clk"
set CLOCK_PERIOD 2.6

sh rm -rf Netlist
sh rm -rf Report
sh mkdir Netlist
sh mkdir Report

read_file -format verilog "../src/$DESIGN.v"
read_file -format verilog { \
"../src/define.vh" \
"../src/interpolator_10bit.v" \
"../src/log2_4bit.v" \
"../src/re_gamma.v" \
"../src/search_idx_10bit.v" \
"../src/spr_re_gamma.v" \
"../src/spr_re_gamma_lut.v" \
"../src/interpolator_11bit.v" \
"../src/log2_8bit.v" \
"../src/de_gamma.v" \
"../src/search_idx_11bit.v" \
"../src/spr_de_gamma.v" \
"../src/spr_de_gamma_lut.v" \
"../src/spr_sharpness.v" \
"../src/sharpness_preprocess.v" \
"../src/sharpness.v" \
"../src/shift_factor.v" \
"../src/abs_thr_comparator.v" \
"../src/spr_core.v" \
"../src/core_l.v" \
"../src/core_r.v" \
"../src/special_case_detect_l.v" \
"../src/special_case_detect_r.v"}
current_design $DESIGN
link

create_clock $CLOCK -period $CLOCK_PERIOD
set_ideal_network -no_propagate $CLOCK
set_dont_touch_network [get_ports $CLOCK]

# ========== Do not modified block ================= #
set_clock_uncertainty  0.1  $CLOCK
set_input_delay  1.0 -clock $CLOCK [remove_from_collection [all_inputs] [get_ports $CLOCK]]
set_output_delay 1.0 -clock $CLOCK [all_outputs]
set_drive 1    [all_inputs]
set_load  0.05 [all_outputs]

set_operating_conditions -max_library slow -max slow
set_wire_load_model -name tsmc13_wl10 -library slow
# =================================================== #
check_design
uniquify
set_fix_multiple_port_nets -all -buffer_constants  [get_designs *]
set_fix_hold [all_clocks]

compile_ultra

report_area > Report/$DESIGN\.area
report_power > Report/$DESIGN\.power
report_timing > Report/$DESIGN\.timing

# set bus_inference_style "%s\[%d\]"
# set bus_naming_style "%s\[%d\]"
# set hdlout_internal_busses true
# change_names -hierarchy -rule verilog
# define_name_rules name_rule -allowed "a-z A-Z 0-9 _" -max_length 255 -type cell
# define_name_rules name_rule -allowed "a-z A-Z 0-9 _[]" -max_length 255 -type net
# define_name_rules name_rule -map {{"\\*cell\\*" "cell"}}
# define_name_rules name_rule -case_insensitive

write -format verilog -hierarchy -output Netlist/$DESIGN\_syn.v
write_sdf -version 2.1 -context verilog Netlist/$DESIGN\_syn.sdf
write_sdc Netlist/$DESIGN\_syn.sdc
