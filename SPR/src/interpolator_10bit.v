module interpolator_10bit (
    input clk,
    input i_hs,
    input i_vs,
    input [9:0] pixel_in,
    input [7:0] lowLevel,
    input [8:0] highLevel,
    input [11:0] lobound,   //(8, 4)
    input [11:0] upbound,
    output [3:0] interval,
    output [16:0] delta_bound
);

wire [11:0] bound_diff_w; //max (upbound-lobound) =  270, (8, 4)
wire [8:0] bound_diff_trunc_w;
wire [9:0] alpha_w;  //max alpha = 255
wire [8:0] interval_w;   //max interval =  16
wire [3:0] interval_trunc_w;   
wire [16:0] delta_bound_w; //max delta_bound =  68850

reg [8:0] bound_diff_r;
reg [9:0] alpha_r;
reg [3:0] interval_r;
reg [16:0] delta_bound_r;

assign bound_diff_w = upbound - lobound;
assign bound_diff_trunc_w = (bound_diff_w << 3) >> 3;
assign alpha_w = pixel_in - {lowLevel, 2'b0};
assign interval_w = highLevel - {1'b0,lowLevel};
assign interval_trunc_w = (interval_w << 5) >> 5;
assign delta_bound_w = bound_diff_r * alpha_r;

assign delta_bound = delta_bound_r;
assign interval = interval_r;

always @(posedge clk) begin
//    if(!rst_n)begin   //rst_n可省
//        bound_diff_r <= 0;
//        alpha_r <= 0;
//        interval_r <= 0;
//        delta_bound_r <= 0;
//    end
//    else 
    if(!i_hs || !i_vs)begin
        bound_diff_r <= 0;
        alpha_r <= 0;
        interval_r <= 0;
        delta_bound_r <= 0;
    end
    else begin
        bound_diff_r <= bound_diff_trunc_w;
        alpha_r <= alpha_w;
        interval_r <= interval_trunc_w;
        delta_bound_r <= delta_bound_w;
    end
end
    
endmodule