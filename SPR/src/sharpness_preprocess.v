module sharpness_preprocess (
    input clk,
    input i_hs,
    input i_vs,
    input shp_pre_en,
    input spr_sharp_en,
    input [12:0] spr_thr_hi,
    input [12:0] spr_thr_lo,
    input [71:0] pre_shp_in,
    output [51:0] shp_curr_prev_diff,
    output [51:0] shp_curr_next_diff,
    output [47:0] shp_curr,
    output [3:0] shp_sel
);

wire [11:0] pre_shp_0_in, pre_shp_1_in, pre_shp_2_in, pre_shp_3_in, pre_shp_4_in, pre_shp_5_in;
wire [11:0] shp_curr_0_w, shp_curr_1_w, shp_curr_2_w, shp_curr_3_w;
wire [12:0] shp_1_0_diff_w, shp_1_2_diff_w, shp_2_3_diff_w, shp_3_4_diff_w, shp_4_5_diff_w;
reg [12:0] shp_1_0_diff_r, shp_1_2_diff_r, shp_2_3_diff_r, shp_3_4_diff_r, shp_4_5_diff_r;
reg [11:0] shp_curr_0_r, shp_curr_1_r, shp_curr_2_r, shp_curr_3_r;
wire shp_sel_0_w, shp_sel_1_w, shp_sel_2_w, shp_sel_3_w;
reg shp_sel_0_r, shp_sel_1_r, shp_sel_2_r, shp_sel_3_r;
wire [51:0] shp_curr_prev_diff_w, shp_curr_next_diff_w;
reg [51:0] shp_curr_prev_diff_r, shp_curr_next_diff_r;
assign pre_shp_0_in = (spr_sharp_en) ? pre_shp_in[11:0] : 0;
assign pre_shp_1_in = (spr_sharp_en) ? pre_shp_in[23:12] : 0;
assign pre_shp_2_in = (spr_sharp_en) ? pre_shp_in[35:24] : 0;
assign pre_shp_3_in = (spr_sharp_en) ? pre_shp_in[47:36] : 0;
assign pre_shp_4_in = (spr_sharp_en) ? pre_shp_in[59:48] : 0;
assign pre_shp_5_in = (spr_sharp_en) ? pre_shp_in[71:60] : 0;
assign shp_curr_0_w = pre_shp_in[23:12];
assign shp_curr_1_w = pre_shp_in[35:24];
assign shp_curr_2_w = pre_shp_in[47:36];
assign shp_curr_3_w = pre_shp_in[59:48];
assign shp_1_0_diff_w = pre_shp_1_in - pre_shp_0_in;
assign shp_1_2_diff_w = pre_shp_1_in - pre_shp_2_in;
assign shp_2_3_diff_w = pre_shp_2_in - pre_shp_3_in;
assign shp_3_4_diff_w = pre_shp_3_in - pre_shp_4_in;
assign shp_4_5_diff_w = pre_shp_4_in - pre_shp_5_in;

wire signed [12:0] curr_prev_0_diff, curr_prev_1_diff, curr_prev_2_diff, curr_prev_3_diff;
wire signed [12:0] curr_next_0_diff, curr_next_1_diff, curr_next_2_diff, curr_next_3_diff;
assign curr_prev_0_diff = shp_1_0_diff_r;
assign curr_prev_1_diff = ~shp_1_2_diff_r+1;
assign curr_prev_2_diff = ~shp_2_3_diff_r+1;
assign curr_prev_3_diff = ~shp_3_4_diff_r+1;
assign curr_next_0_diff = shp_1_2_diff_r;
assign curr_next_1_diff = shp_2_3_diff_r;
assign curr_next_2_diff = shp_3_4_diff_r;
assign curr_next_3_diff = shp_4_5_diff_r;

assign shp_curr_prev_diff_w = {curr_prev_3_diff, curr_prev_2_diff, curr_prev_1_diff, curr_prev_0_diff};
assign shp_curr_next_diff_w = {curr_next_3_diff, curr_next_2_diff, curr_next_1_diff, curr_next_0_diff};
assign shp_sel = {shp_sel_3_r, shp_sel_2_r, shp_sel_1_r, shp_sel_0_r};
assign shp_curr = {shp_curr_3_r, shp_curr_2_r, shp_curr_1_r, shp_curr_0_r};
assign shp_curr_prev_diff = shp_curr_prev_diff_r;
assign shp_curr_next_diff = shp_curr_next_diff_r;

always @(posedge clk) begin
    if(!i_hs || !i_vs)begin
        shp_1_0_diff_r <= 0;
        shp_1_2_diff_r <= 0;
        shp_2_3_diff_r <= 0;
        shp_3_4_diff_r <= 0;
        shp_4_5_diff_r <= 0;
        shp_curr_0_r <= 0;
        shp_curr_1_r <= 0;
        shp_curr_2_r <= 0;
        shp_curr_3_r <= 0;
	shp_sel_0_r <= 0;
	shp_sel_1_r <= 0;
	shp_sel_2_r <= 0;
	shp_sel_3_r <= 0;
    end
    else begin
        shp_1_0_diff_r <= shp_1_0_diff_w;
        shp_1_2_diff_r <= shp_1_2_diff_w;
        shp_2_3_diff_r <= shp_2_3_diff_w;
        shp_3_4_diff_r <= shp_3_4_diff_w;
        shp_4_5_diff_r <= shp_4_5_diff_w;
        shp_curr_0_r <= shp_curr_0_w;
        shp_curr_1_r <= shp_curr_1_w;
        shp_curr_2_r <= shp_curr_2_w;
        shp_curr_3_r <= shp_curr_3_w;
	shp_sel_0_r <= shp_sel_0_w;
	shp_sel_1_r <= shp_sel_1_w;
	shp_sel_2_r <= shp_sel_2_w;
	shp_sel_3_r <= shp_sel_3_w;
    end
end

always @(posedge clk) begin
    if(!i_hs || !i_vs)begin
	shp_curr_prev_diff_r <= 0;
	shp_curr_next_diff_r <= 0;
    end
    else if(shp_pre_en)begin
	shp_curr_prev_diff_r <= shp_curr_prev_diff_w;
	shp_curr_next_diff_r <= shp_curr_next_diff_w;
    end
end

abs_thr_comparator c1(
    .curr_prev_diff(curr_prev_0_diff),
    .curr_next_diff(curr_next_0_diff),
    .spr_thr_hi(spr_thr_hi),
    .spr_thr_lo(spr_thr_lo),
    .shp_sel(shp_sel_0_w)
);

abs_thr_comparator c2(
    .curr_prev_diff(curr_prev_1_diff),
    .curr_next_diff(curr_next_1_diff),
    .spr_thr_hi(spr_thr_hi),
    .spr_thr_lo(spr_thr_lo),
    .shp_sel(shp_sel_1_w)
);

abs_thr_comparator c3(
    .curr_prev_diff(curr_prev_2_diff),
    .curr_next_diff(curr_next_2_diff),
    .spr_thr_hi(spr_thr_hi),
    .spr_thr_lo(spr_thr_lo),
    .shp_sel(shp_sel_2_w)
);

abs_thr_comparator c4(
    .curr_prev_diff(curr_prev_3_diff),
    .curr_next_diff(curr_next_3_diff),
    .spr_thr_hi(spr_thr_hi),
    .spr_thr_lo(spr_thr_lo),
    .shp_sel(shp_sel_3_w)
);

endmodule