module re_gamma (
    input clk,
    input i_hs,
    input i_vs,
    input re_gamma_en,
    input [9:0] re_gamma_in,
    output [10:0] re_gamma_out
);

wire [4:0] idx;
wire [9:0] pixel_in;
wire [7:0] lowLevel;
wire [8:0] highLevel;

wire [3:0] interval;
wire [2:0] shift_bit;
wire [11:0] lobound, upbound;
wire [16:0] delta_bound;

wire [11:0] lobound_w;
assign lobound_w = lobound;
reg [11:0] lobound_r, lobound_r_dly;

wire [11:0] pixel_out;
wire offset;
wire [11:0] re_gamma_out_w;
wire [10:0] re_gamma_out_shift_w;
reg [10:0] re_gamma_out_r;
assign pixel_out = lobound_r_dly + {2'b0, delta_bound[shift_bit+:10]};
assign offset = (shift_bit == 0) ? 0 : (delta_bound[shift_bit-1] == 1);
assign re_gamma_out_w = pixel_out + {11'b0,offset};
assign re_gamma_out_shift_w = re_gamma_out_w >> 1;
assign re_gamma_out = re_gamma_out_r;

search_idx_10bit s1(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .en(re_gamma_en),
    .re_gamma_in(re_gamma_in),
    .idx(idx),
    .pixel_in(pixel_in),
    .lowLevel(lowLevel),
    .highLevel(highLevel)
);

//spr_lut: output lobound, upbound
spr_re_gamma_lut sp1(
    .idx(idx),
    .lobound(lobound),
    .upbound(upbound)
);

interpolator_10bit i1(
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

//shift bit decoder: input interval, output shift_bit
log2_4bit l1(
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
//        re_gamma_out_r <= 0;
//    end
//    else 
    if(!i_hs || !i_vs)begin
    	lobound_r <= 0;
        lobound_r_dly <= 0;
        re_gamma_out_r <= 0;
    end
    else begin
        lobound_r <= lobound_w;
        lobound_r_dly <= lobound_r;
        re_gamma_out_r <= (re_gamma_out_w[11]) ? re_gamma_out_shift_w : re_gamma_out_w[10:0];
    end
end
    
endmodule
