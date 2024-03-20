module spr_re_gamma_lut (
    input [4:0] idx,
    output [11:0] lobound,
    output [11:0] upbound
);

wire [4:0] odd_idx;
wire [5:0] even_idx;
assign odd_idx = (idx[0]) ? idx : idx+1;
assign even_idx = (idx[0]) ? idx+1 : idx;

reg [11:0] spr_gamma_odd, spr_gamma_even;

assign lobound = (idx[0]) ? spr_gamma_odd : spr_gamma_even;
assign upbound = (idx[0]) ? spr_gamma_even : spr_gamma_odd;


always @(*) begin
    case(odd_idx)
        1: spr_gamma_odd = 12'd4;
        3: spr_gamma_odd = 12'd12;
        5: spr_gamma_odd = 12'd20;
        7: spr_gamma_odd = 12'd28;
        9: spr_gamma_odd = 12'd36;
        11: spr_gamma_odd = 12'd44;
        13: spr_gamma_odd = 12'd57;
        15: spr_gamma_odd = 12'd90;
        17: spr_gamma_odd = 12'd151;
        19: spr_gamma_odd = 12'd228;
        21: spr_gamma_odd = 12'd322;
        23: spr_gamma_odd = 12'd434;
        25: spr_gamma_odd = 12'd714;
        27: spr_gamma_odd = 12'd1071;
        29: spr_gamma_odd = 12'd1509;
        31: spr_gamma_odd = 12'd2029;
        default: spr_gamma_odd = 0;
    endcase
end

always @(*) begin
    case(even_idx)
        0: spr_gamma_even = 12'd0;
        2: spr_gamma_even = 12'd8;
        4: spr_gamma_even = 12'd16;
        6: spr_gamma_even = 12'd24;
        8: spr_gamma_even = 12'd32;
        10: spr_gamma_even = 12'd40;
        12: spr_gamma_even = 12'd46;
        14: spr_gamma_even = 12'd67;
        16: spr_gamma_even = 12'd118;
        18: spr_gamma_even = 12'd187;
        20: spr_gamma_even = 12'd273;
        22: spr_gamma_even = 12'd376;
        24: spr_gamma_even = 12'd565;
        26: spr_gamma_even = 12'd883;
        28: spr_gamma_even = 12'd1280;
        30: spr_gamma_even = 12'd1759;
        32: spr_gamma_even = 12'd2065;
        default: spr_gamma_even = 0;
    endcase
end



endmodule