module spr_de_gamma (
    input clk,
    input i_hs,
    input i_vs,
    input [87:0] spr_de_gamma_in,     //8*11
    output [63:0] spr_de_gamma_out     //8*11
);

wire [10:0] de_gamma_0_r_in, de_gamma_1_r_in;
wire [10:0] de_gamma_0_b_in, de_gamma_1_b_in;
wire [10:0] de_gamma_0_g_in, de_gamma_1_g_in, de_gamma_2_g_in, de_gamma_3_g_in;

wire [7:0] de_gamma_0_r_out, de_gamma_1_r_out;
wire [7:0] de_gamma_0_b_out, de_gamma_1_b_out;
wire [7:0] de_gamma_0_g_out, de_gamma_1_g_out, de_gamma_2_g_out, de_gamma_3_g_out;

assign de_gamma_0_r_in = spr_de_gamma_in[10:0];
assign de_gamma_1_r_in = spr_de_gamma_in[21:11];
assign de_gamma_0_g_in = spr_de_gamma_in[32:22];
assign de_gamma_1_g_in = spr_de_gamma_in[43:33];
assign de_gamma_2_g_in = spr_de_gamma_in[54:44];
assign de_gamma_3_g_in = spr_de_gamma_in[65:55];
assign de_gamma_0_b_in = spr_de_gamma_in[76:66];
assign de_gamma_1_b_in = spr_de_gamma_in[87:77];

assign spr_de_gamma_out = {de_gamma_1_b_out, de_gamma_0_b_out, de_gamma_3_g_out, de_gamma_2_g_out, 
                            de_gamma_1_g_out, de_gamma_0_g_out, de_gamma_1_r_out, de_gamma_0_r_out};

de_gamma dg_0_r(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .de_gamma_in(de_gamma_0_r_in),
    .de_gamma_out(de_gamma_0_r_out)
);

de_gamma dg_1_r(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .de_gamma_in(de_gamma_1_r_in),
    .de_gamma_out(de_gamma_1_r_out)
);

de_gamma dg_0_g(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .de_gamma_in(de_gamma_0_g_in),
    .de_gamma_out(de_gamma_0_g_out)
);

de_gamma dg_1_g(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .de_gamma_in(de_gamma_1_g_in),
    .de_gamma_out(de_gamma_1_g_out)
);

de_gamma dg_2_g(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .de_gamma_in(de_gamma_2_g_in),
    .de_gamma_out(de_gamma_2_g_out)
);

de_gamma dg_3_g(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .de_gamma_in(de_gamma_3_g_in),
    .de_gamma_out(de_gamma_3_g_out)
);

de_gamma dg_0_b(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .de_gamma_in(de_gamma_0_b_in),
    .de_gamma_out(de_gamma_0_b_out)
);

de_gamma dg_1_b(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .de_gamma_in(de_gamma_1_b_in),
    .de_gamma_out(de_gamma_1_b_out)
);


endmodule
