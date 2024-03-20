module sharpness (
    input clk,
    input i_hs,
    input i_vs,
    input shp_en,
    input spr_sharp_prt,
    input [11:0] shp_curr,
    input [12:0] curr_prev_diff,
    input [12:0] curr_next_diff,
    input shp_sel,
    output [11:0] shp_out
);

integer i, j;

reg [11:0] shift_reg [0:4];
reg [9:0] dot_add_dly [0:1];
wire [11:0] shift_reg_w;
wire [11:0] shift_fac_curr_w;
assign shift_reg_w = shp_curr;
assign shift_fac_curr_w = shp_curr;

wire [13:0] dot_add_w;
wire [12:0] abs_dot_add_w;
reg [9:0] dot_add_r;
wire signed [12:0] add1, add2;
wire [9:0] dot_add_trunc_w;
assign add1 = (shp_sel) ? 0 : curr_prev_diff;
assign add2 = (shp_sel) ? 0 : curr_next_diff;
assign dot_add_w = add1 + add2;
assign abs_dot_add_w = dot_add_w[12:0];
assign dot_add_trunc_w = (dot_add_w[13]) ? 0 : abs_dot_add_w>>3;

wire [11:0] amout_r;

wire [9:0] mult1;
wire [11:0] mult2;  //(2, 10)
wire [21:0] mult_w;
reg [11:0] mult_r;
assign mult1 = dot_add_dly[1];
assign mult2 = amout_r;
assign mult_w = mult1 * mult2;

wire [11:0] add3, add4;
wire [12:0] shp_out_w;
reg [12:0] shp_out_r;
assign add3 = mult_r;
assign add4 = shift_reg[4];
assign shp_out_w = add3 + add4;

assign shp_out = (shp_out_r[12]) ? 12'hFFF : shp_out_r[11:0];

shift_factor sf1(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .shp_en(shp_en),
    .spr_sharp_prt(spr_sharp_prt),
    .shp_curr(shift_fac_curr_w),
    .shp_sel(shp_sel),
    .amout_r(amout_r)
);

always @(posedge clk) begin
//    if(!rst_n)begin
//        dot_add_r <= 0;
//        shp_out_r <= 0;
//        mult_r <= 0;
//        for(i=0; i<5; i=i+1)begin
//            shift_reg[i] <= 0;
//        end
//        for(j=0; j<2; j=j+1)begin
//            dot_add_dly[j] <= 0;
//        end
//    end
//    else 
    if(!i_vs)begin
        dot_add_r <= 0;
        shp_out_r <= 0;
        mult_r <= 0;
        for(i=0; i<5; i=i+1)begin
            shift_reg[i] <= 0;
        end
        for(j=0; j<2; j=j+1)begin
            dot_add_dly[j] <= 0;
        end
    end
    else if(!i_hs)begin
        dot_add_r <= 0;
        shp_out_r <= 0;
        mult_r <= 0;
        for(i=0; i<5; i=i+1)begin
            shift_reg[i] <= 0;
        end
        for(j=0; j<2; j=j+1)begin
            dot_add_dly[j] <= 0;
        end
    end
    else if(shp_en)begin
        dot_add_r <= dot_add_trunc_w;
        shift_reg[0] <= shift_reg_w;
        shp_out_r <= shp_out_w;
        dot_add_dly[0] <= dot_add_r;
        dot_add_dly[1] <= dot_add_dly[0];
        mult_r <= (spr_sharp_prt) ? mult_w>>10 : mult_w[15:4];   //trunc
        for(i=0;i<4;i=i+1)begin
            shift_reg[i+1] <= shift_reg[i];
        end
    end
end

    
endmodule