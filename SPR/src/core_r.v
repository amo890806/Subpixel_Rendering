module core_r (
    input clk,
    input i_hs,
    input i_vs,
    input en,
    input spr_seperate_case,
    input is_original,
    input [13:0] pValue2_edge,
    input [13:0] pValue3_edge,
    input [13:0] pValue4_edge,
    input [13:0] pValue5_edge,
    input [3:0] is_edge,
    input [11:0] prev,
    input [11:0] curr,
    output [10:0] core_out
);

wire is_special_case_w;
reg is_special_case_r;
assign is_special_case_w = (spr_seperate_case) ? (is_edge[3] || is_edge[2] || is_edge[1] || is_edge[0]) : is_original;

wire [11:0] add1, add2;
wire [12:0] add_w;
reg [12:0] add_r;
assign add1 = prev;
assign add2 = curr;
assign add_w = add1 + add2;

wire [12:0] mult1;
reg [13:0] mult2;
wire [19:0] mult_w;
reg [11:0] mult_r;
assign mult1 = add_r;
assign mult_w = mult1 * mult2;

wire [11:0] add_shift_w;
reg [11:0] add_shift_r;
assign add_shift_w = add_r>>1;

assign core_out = (is_special_case_r) ? ((mult_r[11])?11'b111_1111_1111:mult_r[10:0]) : add_shift_r>>1;

always @(*) begin
    if(spr_seperate_case)begin
            case (is_edge)
                4'b1000: begin
                    mult2 = pValue2_edge;
                end
                4'b0100: begin
                    mult2 = pValue3_edge;
                end
                4'b0010: begin
                    mult2 = pValue4_edge;
                end
                4'b0001: begin
                    mult2 = pValue5_edge;
                end
                default: begin
                    mult2 = pValue2_edge;
                end
            endcase
    end
    else begin
        mult2 = pValue2_edge;
    end
end

always @(posedge clk) begin
    if(!i_hs || !i_vs)begin
        mult_r <= 0;
    end
    else if(en)begin
        mult_r <= mult_w>>8;
    end
end

always @(posedge clk) begin
    if(!i_hs || !i_vs)begin
        add_r <= 0;
        add_shift_r <= 0;
        is_special_case_r <= 0;
    end
    else begin
        add_r <= add_w;
        add_shift_r <= add_shift_w;
        is_special_case_r <= is_special_case_w;
    end
end
    
endmodule