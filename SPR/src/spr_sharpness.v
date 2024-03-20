module spr_sharpness (
    input clk,
    input i_hs,
    input i_vs,
    input shp_pre_en,
    input shp_en,
    input spr_sharp_en,
    input spr_sharp_prt,
    input [12:0] spr_thr_hi,
    input [12:0] spr_thr_lo,
    input [71:0] spr_shp_in_r,    //12*6
    input [71:0] spr_shp_in_g,
    input [71:0] spr_shp_in_b,
    output [47:0] spr_shp_out_r,   //12*4
    output [47:0] spr_shp_out_g,
    output [47:0] spr_shp_out_b
);

wire [47:0] shp_curr_r, shp_curr_g, shp_curr_b;
wire [11:0] shp_curr_0_r, shp_curr_1_r, shp_curr_2_r, shp_curr_3_r;
wire [11:0] shp_curr_0_g, shp_curr_1_g, shp_curr_2_g, shp_curr_3_g;
wire [11:0] shp_curr_0_b, shp_curr_1_b, shp_curr_2_b, shp_curr_3_b;
assign shp_curr_0_r = shp_curr_r[11:0];
assign shp_curr_1_r = shp_curr_r[23:12];
assign shp_curr_2_r = shp_curr_r[35:24];
assign shp_curr_3_r = shp_curr_r[47:36];
assign shp_curr_0_g = shp_curr_g[11:0];
assign shp_curr_1_g = shp_curr_g[23:12];
assign shp_curr_2_g = shp_curr_g[35:24];
assign shp_curr_3_g = shp_curr_g[47:36];
assign shp_curr_0_b = shp_curr_b[11:0];
assign shp_curr_1_b = shp_curr_b[23:12];
assign shp_curr_2_b = shp_curr_b[35:24];
assign shp_curr_3_b = shp_curr_b[47:36];

wire [51:0] shp_curr_prev_diff_r, shp_curr_prev_diff_g, shp_curr_prev_diff_b;
wire [12:0] shp_curr_prev_diff_0_r, shp_curr_prev_diff_1_r, shp_curr_prev_diff_2_r, shp_curr_prev_diff_3_r;
wire [12:0] shp_curr_prev_diff_0_g, shp_curr_prev_diff_1_g, shp_curr_prev_diff_2_g, shp_curr_prev_diff_3_g;
wire [12:0] shp_curr_prev_diff_0_b, shp_curr_prev_diff_1_b, shp_curr_prev_diff_2_b, shp_curr_prev_diff_3_b;
assign shp_curr_prev_diff_0_r = shp_curr_prev_diff_r[12:0];
assign shp_curr_prev_diff_1_r = shp_curr_prev_diff_r[25:13];
assign shp_curr_prev_diff_2_r = shp_curr_prev_diff_r[38:26];
assign shp_curr_prev_diff_3_r = shp_curr_prev_diff_r[51:39];
assign shp_curr_prev_diff_0_g = shp_curr_prev_diff_g[12:0];
assign shp_curr_prev_diff_1_g = shp_curr_prev_diff_g[25:13];
assign shp_curr_prev_diff_2_g = shp_curr_prev_diff_g[38:26];
assign shp_curr_prev_diff_3_g = shp_curr_prev_diff_g[51:39];
assign shp_curr_prev_diff_0_b = shp_curr_prev_diff_b[12:0];
assign shp_curr_prev_diff_1_b = shp_curr_prev_diff_b[25:13];
assign shp_curr_prev_diff_2_b = shp_curr_prev_diff_b[38:26];
assign shp_curr_prev_diff_3_b = shp_curr_prev_diff_b[51:39];

wire [51:0] shp_curr_next_diff_r, shp_curr_next_diff_g, shp_curr_next_diff_b;
wire [12:0] shp_curr_next_diff_0_r, shp_curr_next_diff_1_r, shp_curr_next_diff_2_r, shp_curr_next_diff_3_r;
wire [12:0] shp_curr_next_diff_0_g, shp_curr_next_diff_1_g, shp_curr_next_diff_2_g, shp_curr_next_diff_3_g;
wire [12:0] shp_curr_next_diff_0_b, shp_curr_next_diff_1_b, shp_curr_next_diff_2_b, shp_curr_next_diff_3_b;
assign shp_curr_next_diff_0_r = shp_curr_next_diff_r[12:0];
assign shp_curr_next_diff_1_r = shp_curr_next_diff_r[25:13];
assign shp_curr_next_diff_2_r = shp_curr_next_diff_r[38:26];
assign shp_curr_next_diff_3_r = shp_curr_next_diff_r[51:39];
assign shp_curr_next_diff_0_g = shp_curr_next_diff_g[12:0];
assign shp_curr_next_diff_1_g = shp_curr_next_diff_g[25:13];
assign shp_curr_next_diff_2_g = shp_curr_next_diff_g[38:26];
assign shp_curr_next_diff_3_g = shp_curr_next_diff_g[51:39];
assign shp_curr_next_diff_0_b = shp_curr_next_diff_b[12:0];
assign shp_curr_next_diff_1_b = shp_curr_next_diff_b[25:13];
assign shp_curr_next_diff_2_b = shp_curr_next_diff_b[38:26];
assign shp_curr_next_diff_3_b = shp_curr_next_diff_b[51:39];

wire [3:0] shp_sel_r, shp_sel_g, shp_sel_b;

wire [11:0] shp_out_0_r, shp_out_1_r, shp_out_2_r, shp_out_3_r;
wire [11:0] shp_out_0_g, shp_out_1_g, shp_out_2_g, shp_out_3_g;
wire [11:0] shp_out_0_b, shp_out_1_b, shp_out_2_b, shp_out_3_b;

assign spr_shp_out_r = {shp_out_3_r, shp_out_2_r, shp_out_1_r, shp_out_0_r};
assign spr_shp_out_g = {shp_out_3_g, shp_out_2_g, shp_out_1_g, shp_out_0_g};
assign spr_shp_out_b = {shp_out_3_b, shp_out_2_b, shp_out_1_b, shp_out_0_b};

sharpness_preprocess shp_pre_r(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .shp_pre_en(shp_pre_en),
    .spr_sharp_en(spr_sharp_en),
    .spr_thr_hi(spr_thr_hi),
    .spr_thr_lo(spr_thr_lo),
    .pre_shp_in(spr_shp_in_r),
    .shp_curr_prev_diff(shp_curr_prev_diff_r),
    .shp_curr_next_diff(shp_curr_next_diff_r),
    .shp_curr(shp_curr_r),
    .shp_sel(shp_sel_r)
);

sharpness shp_0_r(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .shp_en(shp_en),
    .spr_sharp_prt(spr_sharp_prt),
    .shp_curr(shp_curr_0_r),
    .curr_prev_diff(shp_curr_prev_diff_0_r),
    .curr_next_diff(shp_curr_next_diff_0_r),
    .shp_sel(shp_sel_r[0]),
    .shp_out(shp_out_0_r)
);

sharpness shp_1_r(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .shp_en(shp_en),
    .spr_sharp_prt(spr_sharp_prt),
    .shp_curr(shp_curr_1_r),
    .curr_prev_diff(shp_curr_prev_diff_1_r),
    .curr_next_diff(shp_curr_next_diff_1_r),
    .shp_sel(shp_sel_r[1]),
    .shp_out(shp_out_1_r)
);

sharpness shp_2_r(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .shp_en(shp_en),
    .spr_sharp_prt(spr_sharp_prt),
    .shp_curr(shp_curr_2_r),
    .curr_prev_diff(shp_curr_prev_diff_2_r),
    .curr_next_diff(shp_curr_next_diff_2_r),
    .shp_sel(shp_sel_r[2]),
    .shp_out(shp_out_2_r)
);

sharpness shp_3_r(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .shp_en(shp_en),
    .spr_sharp_prt(spr_sharp_prt),
    .shp_curr(shp_curr_3_r),
    .curr_prev_diff(shp_curr_prev_diff_3_r),
    .curr_next_diff(shp_curr_next_diff_3_r),
    .shp_sel(shp_sel_r[3]),
    .shp_out(shp_out_3_r)
);


sharpness_preprocess shp_pre_g(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .shp_pre_en(shp_pre_en),
    .spr_sharp_en(spr_sharp_en),
    .spr_thr_hi(spr_thr_hi),
    .spr_thr_lo(spr_thr_lo),
    .pre_shp_in(spr_shp_in_g),
    .shp_curr_prev_diff(shp_curr_prev_diff_g),
    .shp_curr_next_diff(shp_curr_next_diff_g),
    .shp_curr(shp_curr_g),
    .shp_sel(shp_sel_g)
);

sharpness shp_0_g(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .shp_en(shp_en),
    .spr_sharp_prt(spr_sharp_prt),
    .shp_curr(shp_curr_0_g),
    .curr_prev_diff(shp_curr_prev_diff_0_g),
    .curr_next_diff(shp_curr_next_diff_0_g),
    .shp_sel(shp_sel_g[0]),
    .shp_out(shp_out_0_g)
);

sharpness shp_1_g(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .shp_en(shp_en),
    .spr_sharp_prt(spr_sharp_prt),
    .shp_curr(shp_curr_1_g),
    .curr_prev_diff(shp_curr_prev_diff_1_g),
    .curr_next_diff(shp_curr_next_diff_1_g),
    .shp_sel(shp_sel_g[1]),
    .shp_out(shp_out_1_g)
);

sharpness shp_2_g(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .shp_en(shp_en),
    .spr_sharp_prt(spr_sharp_prt),
    .shp_curr(shp_curr_2_g),
    .curr_prev_diff(shp_curr_prev_diff_2_g),
    .curr_next_diff(shp_curr_next_diff_2_g),
    .shp_sel(shp_sel_g[2]),
    .shp_out(shp_out_2_g)
);

sharpness shp_3_g(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .shp_en(shp_en),
    .spr_sharp_prt(spr_sharp_prt),
    .shp_curr(shp_curr_3_g),
    .curr_prev_diff(shp_curr_prev_diff_3_g),
    .curr_next_diff(shp_curr_next_diff_3_g),
    .shp_sel(shp_sel_g[3]),
    .shp_out(shp_out_3_g)
);

sharpness_preprocess shp_pre_b(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .shp_pre_en(shp_pre_en),
    .spr_sharp_en(spr_sharp_en),
    .spr_thr_hi(spr_thr_hi),
    .spr_thr_lo(spr_thr_lo),
    .pre_shp_in(spr_shp_in_b),
    .shp_curr_prev_diff(shp_curr_prev_diff_b),
    .shp_curr_next_diff(shp_curr_next_diff_b),
    .shp_curr(shp_curr_b),
    .shp_sel(shp_sel_b)
);

sharpness shp_0_b(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .shp_en(shp_en),
    .spr_sharp_prt(spr_sharp_prt),
    .shp_curr(shp_curr_0_b),
    .curr_prev_diff(shp_curr_prev_diff_0_b),
    .curr_next_diff(shp_curr_next_diff_0_b),
    .shp_sel(shp_sel_b[0]),
    .shp_out(shp_out_0_b)
);

sharpness shp_1_b(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .shp_en(shp_en),
    .spr_sharp_prt(spr_sharp_prt),
    .shp_curr(shp_curr_1_b),
    .curr_prev_diff(shp_curr_prev_diff_1_b),
    .curr_next_diff(shp_curr_next_diff_1_b),
    .shp_sel(shp_sel_b[1]),
    .shp_out(shp_out_1_b)
);

sharpness shp_2_b(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .shp_en(shp_en),
    .spr_sharp_prt(spr_sharp_prt),
    .shp_curr(shp_curr_2_b),
    .curr_prev_diff(shp_curr_prev_diff_2_b),
    .curr_next_diff(shp_curr_next_diff_2_b),
    .shp_sel(shp_sel_b[2]),
    .shp_out(shp_out_2_b)
);

sharpness shp_3_b(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .shp_en(shp_en),
    .spr_sharp_prt(spr_sharp_prt),
    .shp_curr(shp_curr_3_b),
    .curr_prev_diff(shp_curr_prev_diff_3_b),
    .curr_next_diff(shp_curr_next_diff_3_b),
    .shp_sel(shp_sel_b[3]),
    .shp_out(shp_out_3_b)
);

endmodule