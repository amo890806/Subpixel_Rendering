module log2_4bit (
    input clk,
    input i_hs,
    input i_vs,
    input [3:0] interval,
    output [2:0] shift_bit  //+2
);

reg [2:0] shift_bit_w, shift_bit_r;

wire cpr0, cpr1, cpr2;
wire [2:0] sel;
assign cpr0 = (interval == 8);
assign cpr1 = (interval == 4);
assign cpr2 = (interval == 2);
assign sel = {cpr0, cpr1, cpr2};

assign shift_bit = shift_bit_r;

always @(*) begin
    case (sel)
        3'b100: begin
            shift_bit_w = 5;
        end
        3'b010: begin
            shift_bit_w = 4;
        end
        3'b001: begin
            shift_bit_w = 3;
        end
        default: begin
            shift_bit_w = 6;
        end
    endcase
end

always @(posedge clk) begin
//    if(!rst_n)begin     //rst_n可省
//        shift_bit_r <= 0;
//    end
//    else 
    if(!i_hs || !i_vs)begin
        shift_bit_r <= 0;
    end
    else begin
        shift_bit_r <= shift_bit_w;
    end
end
    
endmodule