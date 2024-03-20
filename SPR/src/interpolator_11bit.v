module interpolator_11bit (
    input clk,
    input i_hs,
    input i_vs,
    input [10:0] pixel_in,
    input [10:0] lowLevel,
    input [10:0] highLevel,
    input [10:0] lobound,
    input [10:0] upbound,
    output [7:0] interval,
    output [18:0] delta_bound
);

wire [10:0] bound_diff_w; //max (upbound-lobound) =  170
wire [7:0] bound_diff_trunc_w;
wire [10:0] alpha_w;  //max alpha = 2047
wire [10:0] interval_w;   //max interval =  256
wire [7:0] interval_trunc_w;   
wire [18:0] delta_bound_w; //max delta_bound =  170*2047 = 347990

reg [7:0] bound_diff_r;
reg [10:0] alpha_r;
reg [7:0] interval_r;
reg [18:0] delta_bound_r;

assign bound_diff_w = upbound - lobound;
assign bound_diff_trunc_w = (bound_diff_w << 3) >> 3;
assign alpha_w = pixel_in - lowLevel;
assign interval_w = highLevel - lowLevel;
assign interval_trunc_w = (interval_w << 3) >> 3;
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