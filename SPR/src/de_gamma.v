module de_gamma (
    input clk,
    input i_hs,
    input i_vs,
    input [10:0] de_gamma_in,
    output [7:0] de_gamma_out
);

wire [4:0] idx;
wire [10:0] pixel_in;
wire [10:0] lowLevel;
wire [10:0] highLevel;

wire [7:0] interval;
wire [3:0] shift_bit;
wire [10:0] lobound, upbound;
wire [18:0] delta_bound;

wire [10:0] lobound_w;
assign lobound_w = lobound;
reg [10:0] lobound_r, lobound_r_dly;

wire [10:0] pixel_out;
wire offset;
wire [10:0] de_gamma_out_w;
reg [7:0] de_gamma_out_r;
assign pixel_out = lobound_r_dly + delta_bound[shift_bit+:11];
assign offset = (shift_bit == 0) ? 0 : (delta_bound[shift_bit-1] == 1);
assign de_gamma_out_w = pixel_out + {10'b0, offset};
assign de_gamma_out = de_gamma_out_r;

search_idx_11bit s1(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .de_gamma_in(de_gamma_in),
    .idx(idx),
    .pixel_in(pixel_in),
    .lowLevel(lowLevel),
    .highLevel(highLevel)
);


spr_de_gamma_lut sp1(
    .idx(idx),
    .lobound(lobound),
    .upbound(upbound)
);

interpolator_11bit i1(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .pixel_in(pixel_in),
    .lowLevel(lowLevel),
    .highLevel(highLevel),
    .lobound(lobound),
    .upbound(upbound),
    .interval(interval),
    .delta_bound(delta_bound)
);

log2_8bit l1(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .interval(interval),
    .shift_bit(shift_bit)
);

always @(posedge clk) begin
//    if(!rst_n)begin //rst_n 可省
//        lobound_r <= 0;
//        lobound_r_dly <= 0;
//        de_gamma_out_r <= 0;
//    end
//    else 
    if(!i_vs)begin
        lobound_r <= 0;
        lobound_r_dly <= 0;
        de_gamma_out_r <= 0;
    end
    else if(!i_hs)begin
        lobound_r <= 0;
        lobound_r_dly <= 0;
        de_gamma_out_r <= 0;
    end
    else begin
        lobound_r <= lobound_w;
        lobound_r_dly <= lobound_r;
        de_gamma_out_r <= de_gamma_out_w>>3;
    end
end
    
endmodule