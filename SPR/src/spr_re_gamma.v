module spr_re_gamma (
    input clk,
    input i_hs,
    input i_vs,
    input spr_re_gamma_en,
    input [119:0] spr_re_gamma_in,
    output [131:0] spr_re_gamma_out
);

wire [9:0] re_gamma_0_r_in, re_gamma_0_g_in, re_gamma_0_b_in;
wire [9:0] re_gamma_1_r_in, re_gamma_1_g_in, re_gamma_1_b_in;
wire [9:0] re_gamma_2_r_in, re_gamma_2_g_in, re_gamma_2_b_in;
wire [9:0] re_gamma_3_r_in, re_gamma_3_g_in, re_gamma_3_b_in;
wire [10:0] re_gamma_0_r_out, re_gamma_0_g_out, re_gamma_0_b_out;
wire [10:0] re_gamma_1_r_out, re_gamma_1_g_out, re_gamma_1_b_out;
wire [10:0] re_gamma_2_r_out, re_gamma_2_g_out, re_gamma_2_b_out;
wire [10:0] re_gamma_3_r_out, re_gamma_3_g_out, re_gamma_3_b_out;

assign re_gamma_0_r_in = spr_re_gamma_in[9:0];
assign re_gamma_0_g_in = spr_re_gamma_in[19:10];
assign re_gamma_0_b_in = spr_re_gamma_in[29:20];
assign re_gamma_1_r_in = spr_re_gamma_in[39:30];
assign re_gamma_1_g_in = spr_re_gamma_in[49:40];
assign re_gamma_1_b_in = spr_re_gamma_in[59:50];
assign re_gamma_2_r_in = spr_re_gamma_in[69:60];
assign re_gamma_2_g_in = spr_re_gamma_in[79:70];
assign re_gamma_2_b_in = spr_re_gamma_in[89:80];
assign re_gamma_3_r_in = spr_re_gamma_in[99:90];
assign re_gamma_3_g_in = spr_re_gamma_in[109:100];
assign re_gamma_3_b_in = spr_re_gamma_in[119:110];

assign spr_re_gamma_out = {re_gamma_3_b_out, re_gamma_3_g_out, re_gamma_3_r_out, 
                            re_gamma_2_b_out, re_gamma_2_g_out, re_gamma_2_r_out,
                            re_gamma_1_b_out, re_gamma_1_g_out, re_gamma_1_r_out,
                            re_gamma_0_b_out, re_gamma_0_g_out, re_gamma_0_r_out};

re_gamma rg_0_r(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .re_gamma_en(spr_re_gamma_en),
    .re_gamma_in(re_gamma_0_r_in),
    .re_gamma_out(re_gamma_0_r_out)
);

re_gamma rg_0_g(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .re_gamma_en(spr_re_gamma_en),
    .re_gamma_in(re_gamma_0_g_in),
    .re_gamma_out(re_gamma_0_g_out)
);

re_gamma rg_0_b(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .re_gamma_en(spr_re_gamma_en),
    .re_gamma_in(re_gamma_0_b_in),
    .re_gamma_out(re_gamma_0_b_out)
);

re_gamma rg_1_r(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .re_gamma_en(spr_re_gamma_en),
    .re_gamma_in(re_gamma_1_r_in),
    .re_gamma_out(re_gamma_1_r_out)
);

re_gamma rg_1_g(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .re_gamma_en(spr_re_gamma_en),
    .re_gamma_in(re_gamma_1_g_in),
    .re_gamma_out(re_gamma_1_g_out)
);

re_gamma rg_1_b(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .re_gamma_en(spr_re_gamma_en),
    .re_gamma_in(re_gamma_1_b_in),
    .re_gamma_out(re_gamma_1_b_out)
);

re_gamma rg_2_r(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .re_gamma_en(spr_re_gamma_en),
    .re_gamma_in(re_gamma_2_r_in),
    .re_gamma_out(re_gamma_2_r_out)
);

re_gamma rg_2_g(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .re_gamma_en(spr_re_gamma_en),
    .re_gamma_in(re_gamma_2_g_in),
    .re_gamma_out(re_gamma_2_g_out)
);

re_gamma rg_2_b(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .re_gamma_en(spr_re_gamma_en),
    .re_gamma_in(re_gamma_2_b_in),
    .re_gamma_out(re_gamma_2_b_out)
);

re_gamma rg_3_r(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .re_gamma_en(spr_re_gamma_en),
    .re_gamma_in(re_gamma_3_r_in),
    .re_gamma_out(re_gamma_3_r_out)
);

re_gamma rg_3_g(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .re_gamma_en(spr_re_gamma_en),
    .re_gamma_in(re_gamma_3_g_in),
    .re_gamma_out(re_gamma_3_g_out)
);

re_gamma rg_3_b(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .re_gamma_en(spr_re_gamma_en),
    .re_gamma_in(re_gamma_3_b_in),
    .re_gamma_out(re_gamma_3_b_out)
);
    
endmodule