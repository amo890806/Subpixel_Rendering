module spr_de_gamma_lut (
    input [4:0] idx,
    output [10:0] lobound,
    output [10:0] upbound
);

wire [4:0] odd_idx;
wire [5:0] even_idx;
assign odd_idx = (idx[0]) ? idx : idx+1;
assign even_idx = (idx[0]) ? idx+1 : idx;

reg [10:0] spr_gamma_odd, spr_gamma_even;

assign lobound = (idx[0]) ? spr_gamma_odd : spr_gamma_even;
assign upbound = (idx[0]) ? spr_gamma_even : spr_gamma_odd;

always @(*) begin
    case(odd_idx)
        1: spr_gamma_odd = 11'd32;
        3: spr_gamma_odd = 11'd96;
        5: spr_gamma_odd = 11'd160;
        7: spr_gamma_odd = 11'd224;
        9: spr_gamma_odd = 11'd288;
        11: spr_gamma_odd = 11'd352;
        13: spr_gamma_odd = 11'd416;
        15: spr_gamma_odd = 11'd502;
        17: spr_gamma_odd = 11'd636;
        19: spr_gamma_odd = 11'd790;
        21: spr_gamma_odd = 11'd952;
        23: spr_gamma_odd = 11'd1200;
        25: spr_gamma_odd = 11'd1400;
        27: spr_gamma_odd = 11'd1720;
        29: spr_gamma_odd = 11'd1980;
        31: spr_gamma_odd = 11'd2038;
        default: spr_gamma_odd = 0;
    endcase
end

always @(*) begin
    case(even_idx)
        0: spr_gamma_even = 11'd0;
        2: spr_gamma_even = 11'd64;
        4: spr_gamma_even = 11'd128;
        6: spr_gamma_even = 11'd192;
        8: spr_gamma_even = 11'd256;
        10: spr_gamma_even = 11'd320;
        12: spr_gamma_even = 11'd364;
        14: spr_gamma_even = 11'd462;
        16: spr_gamma_even = 11'd574;
        18: spr_gamma_even = 11'd692;
        20: spr_gamma_even = 11'd876;
        22: spr_gamma_even = 11'd1084;
        24: spr_gamma_even = 11'd1304;
        26: spr_gamma_even = 11'd1570;
        28: spr_gamma_even = 11'd1856;
        30: spr_gamma_even = 11'd2010;
        32: spr_gamma_even = 11'd2040;
        default: spr_gamma_even = 0;
    endcase
end
    
endmodule