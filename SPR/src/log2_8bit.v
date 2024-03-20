module log2_8bit (
    input clk,
    input i_hs,
    input i_vs,
    input [7:0] interval,
    output [3:0] shift_bit
);

reg [3:0] shift_bit_w, shift_bit_r;

wire cpr0, cpr1, cpr2, cpr3, cpr4, cpr5, cpr6;
wire [6:0] sel;
assign cpr0 = (interval == 128);
assign cpr1 = (interval == 64);
assign cpr2 = (interval == 32);
assign cpr3 = (interval == 16);
assign cpr4 = (interval == 4);
assign cpr5 = (interval == 2);
assign cpr6 = (interval == 1);
assign sel = {cpr0, cpr1, cpr2, cpr3, cpr4, cpr5, cpr6};

assign shift_bit = shift_bit_r;

always @(*) begin
    case (sel)
        7'b1000000: begin
            shift_bit_w = 7;
        end
        7'b0100000: begin
            shift_bit_w = 6;
        end
        7'b0010000: begin
            shift_bit_w = 5;
        end
        7'b0001000: begin
            shift_bit_w = 4;
        end
//        8'h0001000: begin
//            shift_bit_w = 3;
//        end
        7'b0000100: begin
            shift_bit_w = 2;
        end
        7'b0000010: begin
            shift_bit_w = 1;
        end
        7'b0000001: begin
            shift_bit_w = 0;
        end
        default: begin
            shift_bit_w = 8;
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