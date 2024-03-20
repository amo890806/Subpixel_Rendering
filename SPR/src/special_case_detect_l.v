module special_case_detect_l (
    input clk,
    input i_hs,
    input i_vs,
    input is_first_pixel,
    input [11:0] spr_thr_edge,
    input [11:0] prev,
    input [11:0] curr,
    input [11:0] next,
    output is_boarder,
    output is_original,
    output [3:0] is_edge
);

wire is_original_w;
reg is_original_r;
wire [3:0] is_edge_w;
reg [3:0] is_edge_r;

wire is_boarder_w;
reg is_boarder_r;

wire [12:0] curr_prev_diff_w, curr_next_diff_w;

wire [12:0] abs_curr_prev_diff_w, abs_curr_next_diff_w;
reg edge_2_flag, edge_3_flag, edge_4_flag, edge_5_flag;

assign is_original_w = (prev == 0) ^ (curr == 0);
assign is_boarder_w = is_first_pixel;

assign is_original = is_original_r;
assign is_boarder = is_boarder_r;
assign is_edge_w = {edge_2_flag, edge_3_flag, edge_4_flag, edge_5_flag};

assign curr_prev_diff_w = curr - prev;
assign curr_next_diff_w = curr - next;

assign is_edge = is_edge_r;

assign abs_curr_prev_diff_w = ~curr_prev_diff_w+1;
assign abs_curr_next_diff_w = (curr_next_diff_w[12]) ? ~curr_next_diff_w+1 : curr_next_diff_w;

always @(*) begin
    edge_2_flag = (curr_prev_diff_w[12]) ? 0 : ((curr_prev_diff_w>>4 >= spr_thr_edge)&&(abs_curr_next_diff_w>>4 >= spr_thr_edge));
    edge_3_flag = (curr_prev_diff_w[12]) ? 0 : ((curr_prev_diff_w>>4 >= spr_thr_edge)&&(abs_curr_next_diff_w>>4 < spr_thr_edge));
    edge_4_flag = (curr_prev_diff_w[12]) ? ((abs_curr_prev_diff_w>>4 >= spr_thr_edge)&&(abs_curr_next_diff_w>>4 <= spr_thr_edge)) : 0;
    edge_5_flag = (curr_prev_diff_w[12]) ? ((abs_curr_prev_diff_w>>4 >= spr_thr_edge)&&(abs_curr_next_diff_w>>4 > spr_thr_edge)) : 0;
end

always @(posedge clk) begin
//    if(!rst_n)begin
//        is_original_r <= 0;
//        is_boarder_r <= 0;
//	is_edge_r <= 0;
//    end
//    else 
    if(!i_hs || !i_vs)begin
        is_original_r <= 0;
        is_boarder_r <= 0;
	is_edge_r <= 0;
    end
    else begin
        is_original_r <= is_original_w;
        is_boarder_r <= is_boarder_w;
	is_edge_r <= is_edge_w;
    end
end
    
endmodule