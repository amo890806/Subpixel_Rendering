module spr_core (
    input clk,
    input i_hs,
    input i_vs,
    input en,
    input spr_seperate_case,
    input is_first_pixel,
    input odd_even_flag,
    input [11:0] spr_thr_edge_r,
    input [13:0] pValue2_edge_r,
    input [13:0] pValue3_edge_r,
    input [13:0] pValue4_edge_r,
    input [13:0] pValue5_edge_r,
    input [13:0] pValue_border_r,
    input [11:0] spr_thr_edge_b,
    input [13:0] pValue2_edge_b,
    input [13:0] pValue3_edge_b,
    input [13:0] pValue4_edge_b,
    input [13:0] pValue5_edge_b,
    input [13:0] pValue_border_b,
    input [59:0] spr_core_in_r,   //5*12
    input [59:0] spr_core_in_b,   //5*12
    output [21:0] spr_core_out_r,      //2*11
    output [21:0] spr_core_out_b
);

wire [11:0] spr_core_prev_0_r, spr_core_prev_1_r; 
wire [11:0] spr_core_curr_0_r, spr_core_curr_1_r; 
wire [11:0] spr_core_next_0_r, spr_core_next_1_r;
wire [11:0] spr_core_prev_0_b, spr_core_prev_1_b; 
wire [11:0] spr_core_curr_0_b, spr_core_curr_1_b; 
wire [11:0] spr_core_next_0_b, spr_core_next_1_b;

wire is_boarder_0_r;
wire is_original_0_r, is_original_1_r;
wire [3:0] is_edge_0_r, is_edge_1_r;

wire is_boarder_0_b;
wire is_original_0_b, is_original_1_b;
wire [3:0] is_edge_0_b, is_edge_1_b;

wire [10:0] core_out_0_r, core_out_1_r;
wire [10:0] core_out_0_b, core_out_1_b;
assign spr_core_out_r = {core_out_1_r, core_out_0_r};
assign spr_core_out_b = {core_out_1_b, core_out_0_b};

assign spr_core_prev_0_r = spr_core_in_r[11:0];
assign spr_core_curr_0_r = spr_core_in_r[23:12];
assign spr_core_next_0_r = spr_core_in_r[35:24];
assign spr_core_prev_1_r = spr_core_in_r[35:24];
assign spr_core_curr_1_r = spr_core_in_r[47:36];
assign spr_core_next_1_r = spr_core_in_r[59:48];
assign spr_core_prev_0_b = spr_core_in_b[11:0];
assign spr_core_curr_0_b = spr_core_in_b[23:12];
assign spr_core_next_0_b = spr_core_in_b[35:24];
assign spr_core_prev_1_b = spr_core_in_b[35:24];
assign spr_core_curr_1_b = spr_core_in_b[47:36];
assign spr_core_next_1_b = spr_core_in_b[59:48];

wire is_first_pixel_r, is_first_pixel_b;
assign is_first_pixel_r = (odd_even_flag) ? 0 : is_first_pixel;
assign is_first_pixel_b = (odd_even_flag) ? is_first_pixel : 0;

special_case_detect_l scd_0_r(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .is_first_pixel(is_first_pixel_r),
    .spr_thr_edge(spr_thr_edge_r),
    .prev(spr_core_prev_0_r),
    .curr(spr_core_curr_0_r),
    .next(spr_core_next_0_r),
    .is_boarder(is_boarder_0_r),
    .is_original(is_original_0_r),
    .is_edge(is_edge_0_r)
);

special_case_detect_r scd_1_r(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .spr_thr_edge(spr_thr_edge_r),
    .prev(spr_core_prev_1_r),
    .curr(spr_core_curr_1_r),
    .next(spr_core_next_1_r),
    .is_original(is_original_1_r),
    .is_edge(is_edge_1_r)
);

core_l c_0_r(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .en(en),
    .spr_seperate_case(spr_seperate_case),
    .is_boarder(is_boarder_0_r),
    .is_original(is_original_0_r),
    .is_edge(is_edge_0_r),
    .pValue_border(pValue_border_r),
    .pValue2_edge(pValue2_edge_r),
    .pValue3_edge(pValue3_edge_r),
    .pValue4_edge(pValue4_edge_r),
    .pValue5_edge(pValue5_edge_r),
    .prev(spr_core_prev_0_r),
    .curr(spr_core_curr_0_r),
    .core_out(core_out_0_r)
);

core_r c_1_r(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .en(en),
    .spr_seperate_case(spr_seperate_case),
    .is_original(is_original_1_r),
    .is_edge(is_edge_1_r),
    .pValue2_edge(pValue2_edge_r),
    .pValue3_edge(pValue3_edge_r),
    .pValue4_edge(pValue4_edge_r),
    .pValue5_edge(pValue5_edge_r),
    .prev(spr_core_prev_1_r),
    .curr(spr_core_curr_1_r),
    .core_out(core_out_1_r)
);

special_case_detect_l scd_0_b(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .spr_thr_edge(spr_thr_edge_b),
    .is_first_pixel(is_first_pixel_b),
    .prev(spr_core_prev_0_b),
    .curr(spr_core_curr_0_b),
    .next(spr_core_next_0_b),
    .is_boarder(is_boarder_0_b),
    .is_original(is_original_0_b),
    .is_edge(is_edge_0_b)
);

special_case_detect_r scd_1_b(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .spr_thr_edge(spr_thr_edge_b),
    .prev(spr_core_prev_1_b),
    .curr(spr_core_curr_1_b),
    .next(spr_core_next_1_b),
    .is_original(is_original_1_b),
    .is_edge(is_edge_1_b)
);

core_l c_0_b(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .en(en),
    .spr_seperate_case(spr_seperate_case),
    .is_boarder(is_boarder_0_b),
    .is_original(is_original_0_b),
    .is_edge(is_edge_0_b),
    .pValue_border(pValue_border_b),
    .pValue2_edge(pValue2_edge_b),
    .pValue3_edge(pValue3_edge_b),
    .pValue4_edge(pValue4_edge_b),
    .pValue5_edge(pValue5_edge_b),
    .prev(spr_core_prev_0_b),
    .curr(spr_core_curr_0_b),
    .core_out(core_out_0_b)
);

core_r c_1_b(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .en(en),
    .spr_seperate_case(spr_seperate_case),
    .is_original(is_original_1_b),
    .is_edge(is_edge_1_b),
    .pValue2_edge(pValue2_edge_b),
    .pValue3_edge(pValue3_edge_b),
    .pValue4_edge(pValue4_edge_b),
    .pValue5_edge(pValue5_edge_b),
    .prev(spr_core_prev_1_b),
    .curr(spr_core_curr_1_b),
    .core_out(core_out_1_b)
);

    
endmodule