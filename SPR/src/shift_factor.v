module shift_factor (
    input clk,
    input i_hs,
    input i_vs,
    input shp_en,
    input spr_sharp_prt,
    input [11:0] shp_curr,
    input shp_sel,
    output [11:0] amout_r
);

wire cpr_0, cpr_1, cpr_2;
wire [12:0] sub_left_w;
wire [11:0] sub_left_trunc_w;
wire [11:0] sub_right_w;
reg [11:0] sub_left_r, sub_right_r;
wire [11:0] sub1;
reg [12:0] sub2;
reg [11:0] sub3;
wire [12:0] add_left_0_w, add_left_1_w;
wire [13:0] add_left_tmp_w;
wire [12:0] add_right_0_w, add_right_1_w;
wire [13:0] add_right_tmp_w;
wire sub_sel;
wire [2:0] fac_sel;
reg [2:0] fac_sel_dly;
assign cpr_0 = (shp_curr >= `SHP_192);
assign cpr_1 = (shp_curr >= `SHP_128);
assign cpr_2 = (shp_curr >= `SHP_64);
assign fac_sel = {cpr_0, cpr_1, cpr_2};

assign sub_sel = shp_sel;
assign sub1 = shp_curr;
assign sub_left_w = sub2 - {1'b0, sub1};
assign sub_left_trunc_w = (sub_left_w << 1) >> 1;
assign sub_right_w = sub1 - sub3;

reg [11:0] add_left_w, add_right_w, add_left_r, add_right_r;
wire [11:0] sharp_fac_w;
reg [11:0] sharp_fac_r;
assign add_left_0_w = {1'b0, sub_left_r};
assign add_left_1_w = {sub_left_r, 1'b0};
assign add_left_tmp_w = add_left_0_w + add_left_1_w;
assign add_right_0_w = {1'b0, sub_right_r};
assign add_right_1_w = {sub_right_r, 1'b0};
assign add_right_tmp_w = add_right_0_w + add_right_1_w;
assign sharp_fac_w = add_left_r + add_right_r;

wire [11:0] mult1, mult2;
wire [15:0] mult_w;
reg [11:0] mult_r;
assign mult1 = `SPR_SHARP_amout;
assign mult2 = sharp_fac_r;
assign mult_w = mult1 * mult2;

assign amout_r = mult_r;    //(2, 10)

always @(*) begin
    case (fac_sel)
        3'b111: begin
            sub2 = `SHP_256;  
            sub3 = `SHP_192;  
        end
        3'b011: begin
            sub2 = `SHP_192;  
            sub3 = `SHP_128;  
        end
        3'b001: begin
            sub2 = `SHP_128;  
            sub3 = `SHP_64;  
        end
        3'b000: begin
            sub2 = `SHP_64;  
            sub3 = 0;
        end
        default: begin
            sub2 = 0;  
            sub3 = 0;  
        end
    endcase
end

always @(*) begin
    if(sub_sel)begin
        add_left_w = 0;  
        add_right_w = 0; 
    end
    else begin
        case (fac_sel_dly)
            3'b111: begin
            	add_left_w = sub_left_r >> 2;
            	add_right_w = sub_right_r >> 3;
            end
            3'b011: begin
            	add_left_w = sub_left_r >> 1;
            	add_right_w = sub_right_r >> 2;
            end
            3'b001: begin
	    	add_left_w = add_left_tmp_w >> 2;
            	add_right_w = sub_right_r >> 1;
            end
            3'b000: begin
            	add_left_w = sub_left_r;
	    	add_right_w = add_right_tmp_w >> 2;
            end
            default: begin
            	add_left_w = 0;
            	add_right_w = 0;
            end
    	endcase
    end
end

always @(posedge clk) begin
    if(!i_hs || !i_vs)begin
        sub_left_r <= 0;
        sub_right_r <= 0;
        fac_sel_dly <= 0;
        add_left_r <= 0;
        add_right_r <= 0;
        sharp_fac_r <= 0;
        mult_r <= 0;
    end
    else if(shp_en)begin
        sub_left_r <= sub_left_trunc_w;
        sub_right_r <= sub_right_w;
        fac_sel_dly <= fac_sel;
        add_left_r <= add_left_w;
        add_right_r <= add_right_w;
        sharp_fac_r <= {sharp_fac_w>>1, 1'b0};
        mult_r <= (spr_sharp_prt) ? mult_w>>4 : mult1;
    end
end
    
endmodule