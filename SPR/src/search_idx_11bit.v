module search_idx_11bit (
    input clk,
    input i_hs,
    input i_vs,
    input [10:0] de_gamma_in,
    output [4:0] idx,
    output [10:0] pixel_in,
    output [10:0] lowLevel,
    output [10:0] highLevel
);

parameter level_0 = 11'd0;
parameter level_1 = 11'd4;
parameter level_2 = 11'd8;
parameter level_3 = 11'd12;
parameter level_4 = 11'd16;
parameter level_5 = 11'd20;
parameter level_6 = 11'd24;
parameter level_7 = 11'd28;
parameter level_8 = 11'd32;
parameter level_9 = 11'd36;
parameter level_10 = 11'd40;
parameter level_11 = 11'd44;
parameter level_12 = 11'd46;
parameter level_13 = 11'd62;
parameter level_14 = 11'd78;
parameter level_15 = 11'd94;
parameter level_16 = 11'd126;
parameter level_17 = 11'd158;
parameter level_18 = 11'd190;
parameter level_19 = 11'd254;
parameter level_20 = 11'd318;
parameter level_21 = 11'd382;
parameter level_22 = 11'd510;
parameter level_23 = 11'd638;
parameter level_24 = 11'd766;
parameter level_25 = 11'd894;
parameter level_26 = 11'd1150;
parameter level_27 = 11'd1406;
parameter level_28 = 11'd1662;
parameter level_29 = 11'd1918;
parameter level_30 = 11'd1982;
parameter level_31 = 11'd2046;
parameter level_32 = 11'd2047;

reg [4:0] idx_w, idx_r;
reg [10:0] lowLevel_w, lowLevel_r;
reg [10:0] highLevel_w, highLevel_r;
reg [10:0] pixel_in_r;

wire [31:0] mask;
wire [10:0] pixel_in_w;
assign pixel_in_w = de_gamma_in;

assign mask[31] = pixel_in_w >= level_31;
assign mask[30] = pixel_in_w >= level_30;
assign mask[29] = pixel_in_w >= level_29;
assign mask[28] = pixel_in_w >= level_28;
assign mask[27] = pixel_in_w >= level_27;
assign mask[26] = pixel_in_w >= level_26;
assign mask[25] = pixel_in_w >= level_25;
assign mask[24] = pixel_in_w >= level_24;
assign mask[23] = pixel_in_w >= level_23;
assign mask[22] = pixel_in_w >= level_22;
assign mask[21] = pixel_in_w >= level_21;
assign mask[20] = pixel_in_w >= level_20;
assign mask[19] = pixel_in_w >= level_19;
assign mask[18] = pixel_in_w >= level_18;
assign mask[17] = pixel_in_w >= level_17;
assign mask[16] = pixel_in_w >= level_16;
assign mask[15] = pixel_in_w >= level_15;
assign mask[14] = pixel_in_w >= level_14;
assign mask[13] = pixel_in_w >= level_13;
assign mask[12] = pixel_in_w >= level_12;
assign mask[11] = pixel_in_w >= level_11;
assign mask[10] = pixel_in_w >= level_10;
assign mask[9] = pixel_in_w >= level_9;
assign mask[8] = pixel_in_w >= level_8;
assign mask[7] = pixel_in_w >= level_7;
assign mask[6] = pixel_in_w >= level_6;
assign mask[5] = pixel_in_w >= level_5;
assign mask[4] = pixel_in_w >= level_4;
assign mask[3] = pixel_in_w >= level_3;
assign mask[2] = pixel_in_w >= level_2;
assign mask[1] = pixel_in_w >= level_1;
assign mask[0] = pixel_in_w >= level_0;

assign idx = idx_r;
assign pixel_in = pixel_in_r;
assign lowLevel = lowLevel_r;
assign highLevel = highLevel_r;

always @(*) begin
    case (mask)
        32'hFFFFFFFF: begin
            idx_w = 31;
            highLevel_w = level_32;
            lowLevel_w = level_31;
        end
        32'h7FFFFFFF: begin
            idx_w = 30;
            highLevel_w = level_31;
            lowLevel_w = level_30;
        end 
        32'h3FFFFFFF: begin
            idx_w = 29;
            highLevel_w = level_30;
            lowLevel_w = level_29;
        end 
        32'h1FFFFFFF: begin
            idx_w = 28;
            highLevel_w = level_29;
            lowLevel_w = level_28;
        end 
        32'h0FFFFFFF: begin
            idx_w = 27;
            highLevel_w = level_28;
            lowLevel_w = level_27;
        end 
        32'h07FFFFFF: begin
            idx_w = 26;
            highLevel_w = level_27;
            lowLevel_w = level_26;
        end 
        32'h03FFFFFF: begin
            idx_w = 25;
            highLevel_w = level_26;
            lowLevel_w = level_25;
        end 
        32'h01FFFFFF: begin
            idx_w = 24;
            highLevel_w = level_25;
            lowLevel_w = level_24;
        end 
        32'h00FFFFFF: begin
            idx_w = 23;
            highLevel_w = level_24;
            lowLevel_w = level_23;
        end 
        32'h007FFFFF: begin
            idx_w = 22;
            highLevel_w = level_23;
            lowLevel_w = level_22;
        end 
        32'h003FFFFF: begin
            idx_w = 21;
            highLevel_w = level_22;
            lowLevel_w = level_21;
        end 
        32'h001FFFFF: begin
            idx_w = 20;
            highLevel_w = level_21;
            lowLevel_w = level_20;
        end 
        32'h000FFFFF: begin
            idx_w = 19;
            highLevel_w = level_20;
            lowLevel_w = level_19;
        end 
        32'h0007FFFF: begin
            idx_w = 18;
            highLevel_w = level_19;
            lowLevel_w = level_18;
        end 
        32'h0003FFFF: begin
            idx_w = 17;
            highLevel_w = level_18;
            lowLevel_w = level_17;
        end 
        32'h0001FFFF: begin
            idx_w = 16;
            highLevel_w = level_17;
            lowLevel_w = level_16;
        end 
        32'h0000FFFF: begin
            idx_w = 15;
            highLevel_w = level_16;
            lowLevel_w = level_15;
        end 
        32'h00007FFF: begin
            idx_w = 14;
            highLevel_w = level_15;
            lowLevel_w = level_14;
        end 
        32'h00003FFF: begin
            idx_w = 13;
            highLevel_w = level_14;
            lowLevel_w = level_13;
        end 
        32'h00001FFF: begin
            idx_w = 12;
            highLevel_w = level_13;
            lowLevel_w = level_12;
        end 
        32'h00000FFF: begin
            idx_w = 11;
            highLevel_w = level_12;
            lowLevel_w = level_11;
        end 
        32'h000007FF: begin
            idx_w = 10;
            highLevel_w = level_11;
            lowLevel_w = level_10;
        end 
        32'h000003FF: begin
            idx_w = 9;
            highLevel_w = level_10;
            lowLevel_w = level_9;
        end 
        32'h000001FF: begin
            idx_w = 8;
            highLevel_w = level_9;
            lowLevel_w = level_8;
        end 
        32'h000000FF: begin
            idx_w = 7;
            highLevel_w = level_8;
            lowLevel_w = level_7;
        end 
        32'h0000007F: begin
            idx_w = 6;
            highLevel_w = level_7;
            lowLevel_w = level_6;
        end 
        32'h0000003F: begin
            idx_w = 5;
            highLevel_w = level_6;
            lowLevel_w = level_5;
        end 
        32'h0000001F: begin
            idx_w = 4;
            highLevel_w = level_5;
            lowLevel_w = level_4;
        end 
        32'h0000000F: begin
            idx_w = 3;
            highLevel_w = level_4;
            lowLevel_w = level_3;
        end 
        32'h00000007: begin
            idx_w = 2;
            highLevel_w = level_3;
            lowLevel_w = level_2;
        end 
        32'h00000003: begin
            idx_w = 1;
            highLevel_w = level_2;
            lowLevel_w = level_1;
        end 
        32'h00000001: begin
            idx_w = 0;
            highLevel_w = level_1;
            lowLevel_w = level_0;
        end 
        default: begin
            idx_w = idx_r;
            highLevel_w = highLevel_r;
            lowLevel_w = lowLevel_r;
        end
    endcase
end

always @(posedge clk) begin
//    if(!rst_n)begin
//        idx_r <= 0;
//        lowLevel_r <= 0;
//        highLevel_r <= 0;
//        pixel_in_r <= 0;
//    end
//    else 
    if(!i_vs)begin
    	idx_r <= 0;
        lowLevel_r <= 0;
        highLevel_r <= 0;
        pixel_in_r <= 0;
    end
    else if(!i_hs)begin
    	idx_r <= 0;
        lowLevel_r <= 0;
        highLevel_r <= 0;
        pixel_in_r <= 0;
    end
    else begin
        idx_r <= idx_w;
        lowLevel_r <= lowLevel_w;
        highLevel_r <= highLevel_w;
        pixel_in_r <= pixel_in_w;
    end
end
    
endmodule