module abs_thr_comparator (
    input signed [12:0] curr_prev_diff,
    input signed [12:0] curr_next_diff,
    input [12:0] spr_thr_hi,
    input [12:0] spr_thr_lo,
    output shp_sel
);

wire flag;
wire [12:0] diff_hi;
wire [12:0] diff_lo;
assign diff_hi = (flag) ? curr_prev_diff : curr_next_diff;
assign diff_lo = (flag) ? curr_next_diff : curr_prev_diff;
wire [12:0] abs_diff_hi, abs_diff_lo;

assign flag = (curr_prev_diff < curr_next_diff) ? 1 : 0;
assign abs_diff_hi = (diff_hi[12]) ? ~diff_hi+1 : diff_hi;
assign abs_diff_lo = (diff_lo[12]) ? ~diff_lo+1 : diff_lo;

assign shp_sel = (abs_diff_hi >= spr_thr_hi) || (abs_diff_lo <= spr_thr_lo);
    
endmodule