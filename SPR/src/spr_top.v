module spr_top (
    input clk,
    input rst_n,
    input i_hs,
    input i_vs,
    input i_de,
    input i_spr_sharp_en,
    input i_spr_sharp_prt,
    input i_spr_seperate_case,
    input [12:0] i_spr_thr_hi,
    input [12:0] i_spr_thr_lo,
    input [11:0] i_spr_thr_edge_r,
    input [13:0] i_pValue2_edge_r,
    input [13:0] i_pValue3_edge_r,
    input [13:0] i_pValue4_edge_r,
    input [13:0] i_pValue5_edge_r,
    input [13:0] i_pValue_border_r,
    input [11:0] i_spr_thr_edge_b,
    input [13:0] i_pValue2_edge_b,
    input [13:0] i_pValue3_edge_b,
    input [13:0] i_pValue4_edge_b,
    input [13:0] i_pValue5_edge_b,
    input [13:0] i_pValue_border_b,
    input [119:0] i_data,
    output o_valid,
    output [95:0] o_data
);

integer i;

reg [8:0] hd_cnt;
reg [4:0] dly_cnt;
wire is_first_pixel_shp, is_last_pixel, is_first_pixel_core;
assign is_first_pixel_shp = (hd_cnt == 4);
assign is_last_pixel = (dly_cnt == 4);
assign is_first_pixel_core = (hd_cnt == 13);

wire [119:0] i_data_w;
wire i_de_w;
assign i_data_w = i_data;
assign i_de_w = i_de;
reg [119:0] i_data_r;
reg [19:0] i_de_r;

wire [10:0] shp_1_g, shp_2_g, shp_3_g, shp_4_g;

wire [131:0] spr_re_gamma_out;
reg spr_sharp_en, spr_sharp_prt, spr_seperate_case;
reg [12:0] spr_thr_hi, spr_thr_lo;
reg [11:0] spr_thr_edge_r, spr_thr_edge_b;
reg [13:0] pValue_border_r, pValue2_edge_r, pValue3_edge_r, pValue4_edge_r, pValue5_edge_r;
reg [13:0] pValue_border_b, pValue2_edge_b, pValue3_edge_b, pValue4_edge_b, pValue5_edge_b;
wire [71:0] spr_shp_in_r, spr_shp_in_g, spr_shp_in_b;
reg [10:0] buffer_0_r, buffer_1_r, buffer_2_r, buffer_3_r, buffer_4_r;
reg [10:0] buffer_0_g, buffer_1_g, buffer_2_g, buffer_3_g, buffer_4_g;
reg [10:0] buffer_0_b, buffer_1_b, buffer_2_b, buffer_3_b, buffer_4_b;
wire [10:0] buffer_5_r, buffer_5_g, buffer_5_b;
reg [11:0] shp_buffer_0_r, shp_buffer_1_r, shp_buffer_2_r, shp_buffer_3_r, shp_buffer_4_r;
reg [11:0] shp_buffer_0_b, shp_buffer_1_b, shp_buffer_2_b, shp_buffer_3_b, shp_buffer_4_b; 
wire [59:0] spr_core_in_r, spr_core_in_b;
wire [21:0] spr_core_out_r, spr_core_out_b;
reg [43:0] shift_reg_g [0:2];
wire [43:0] spr_shift_reg_out_g;
wire [87:0] spr_de_gamma_in;
wire [63:0] spr_de_gamma_out;
reg odd_even_flag;
wire [47:0] spr_shp_out_r, spr_shp_out_g, spr_shp_out_b;
wire [31:0] o_data_r, o_data_g, o_data_b;

assign shp_1_g = spr_shp_out_g[11:0]>>1;
assign shp_2_g = spr_shp_out_g[23:12]>>1; 
assign shp_3_g = spr_shp_out_g[35:24]>>1; 
assign shp_4_g = spr_shp_out_g[47:36]>>1; 

assign o_data_r = (odd_even_flag) ? {spr_de_gamma_out[15:8], 8'b0, spr_de_gamma_out[7:0], 8'b0} : {8'b0, spr_de_gamma_out[15:8], 8'b0, spr_de_gamma_out[7:0]}; 
assign o_data_g = spr_de_gamma_out[47:16];
assign o_data_b = (odd_even_flag) ? {8'b0, spr_de_gamma_out[63:56], 8'b0, spr_de_gamma_out[55:48]} : {spr_de_gamma_out[63:56], 8'b0, spr_de_gamma_out[55:48], 8'b0}; 
assign o_data = {o_data_b, o_data_g, o_data_r};



assign buffer_5_r = (is_last_pixel) ? buffer_4_r : spr_re_gamma_out[10:0];
assign buffer_5_g = (is_last_pixel) ? buffer_4_g : spr_re_gamma_out[21:11];
assign buffer_5_b = (is_last_pixel) ? buffer_4_b : spr_re_gamma_out[32:22];
assign spr_shp_in_r = {buffer_5_r, 1'b0, buffer_4_r, 1'b0, buffer_3_r, 1'b0, buffer_2_r, 1'b0, buffer_1_r, 1'b0, buffer_0_r, 1'b0};
assign spr_shp_in_g = {buffer_5_g, 1'b0, buffer_4_g, 1'b0, buffer_3_g, 1'b0, buffer_2_g, 1'b0, buffer_1_g, 1'b0, buffer_0_g, 1'b0};
assign spr_shp_in_b = {buffer_5_b, 1'b0, buffer_4_b, 1'b0, buffer_3_b, 1'b0, buffer_2_b, 1'b0, buffer_1_b, 1'b0, buffer_0_b, 1'b0};


// odd / even
assign spr_core_in_r = (odd_even_flag) ? {spr_shp_out_r[11:0], shp_buffer_4_r, shp_buffer_3_r, shp_buffer_2_r, shp_buffer_1_r} : {shp_buffer_4_r, shp_buffer_3_r, shp_buffer_2_r, shp_buffer_1_r, shp_buffer_0_r};
assign spr_core_in_b = (odd_even_flag) ? {shp_buffer_4_b, shp_buffer_3_b, shp_buffer_2_b, shp_buffer_1_b, shp_buffer_0_b} : {spr_shp_out_b[11:0], shp_buffer_4_b, shp_buffer_3_b, shp_buffer_2_b, shp_buffer_1_b};

assign spr_shift_reg_out_g = shift_reg_g[2];
assign spr_de_gamma_in = {spr_core_out_b, spr_shift_reg_out_g, spr_core_out_r};

assign o_valid = i_de_r[19];

always @(posedge clk) begin
    if(!rst_n)begin
	spr_sharp_en <= 0;
	spr_sharp_prt <= 0;
	spr_seperate_case <= 0;
	spr_thr_hi <= 0;
	spr_thr_lo <= 0;
	spr_thr_edge_r <= 0;
	pValue2_edge_r <= 0;
	pValue3_edge_r <= 0;
	pValue4_edge_r <= 0;
	pValue5_edge_r <= 0;
	pValue_border_r <= 0;
	spr_thr_edge_b <= 0;
	pValue2_edge_b <= 0;
	pValue3_edge_b <= 0;
	pValue4_edge_b <= 0;
	pValue5_edge_b <= 0;
	pValue_border_b <= 0;
    end
    else if(!i_vs)begin
	spr_sharp_en <= i_spr_sharp_en;
	spr_sharp_prt <= i_spr_sharp_prt;
	spr_seperate_case <= i_spr_seperate_case;
	spr_thr_hi <= i_spr_thr_hi;
	spr_thr_lo <= i_spr_thr_lo;
	spr_thr_edge_r <= i_spr_thr_edge_r;
	pValue2_edge_r <= i_pValue2_edge_r;
	pValue3_edge_r <= i_pValue3_edge_r;
	pValue4_edge_r <= i_pValue4_edge_r;
	pValue5_edge_r <= i_pValue5_edge_r;
	pValue_border_r <= i_pValue_border_r;
	spr_thr_edge_b <= i_spr_thr_edge_b;
	pValue2_edge_b <= i_pValue2_edge_b;
	pValue3_edge_b <= i_pValue3_edge_b;
	pValue4_edge_b <= i_pValue4_edge_b;
	pValue5_edge_b <= i_pValue5_edge_b;
	pValue_border_b <= i_pValue_border_b;
    end
end

always @(posedge clk) begin
    if(!rst_n)begin
        odd_even_flag <= 0;
    end
    else if(!i_vs)begin
    	odd_even_flag <= 0;
    end
    else begin
        odd_even_flag <= (dly_cnt == 18) ? ~odd_even_flag : odd_even_flag;
    end
end

always @(posedge clk) begin
    if(!rst_n)begin
        hd_cnt <= 0;
    end
    else if(!i_vs || !i_hs)begin
    	hd_cnt <= 0;
    end
    else begin
        hd_cnt <= (i_de_r[0]) ? hd_cnt+1 : 0;
    end
end

always @(posedge clk) begin
//    if(!rst_n)begin
//        dly_cnt <= 0;
//    end
//    else 
    if(!i_vs)begin
    	dly_cnt <= 0;
    end
    else if(!i_hs)begin
    	dly_cnt <= 0;
    end
    else begin
        dly_cnt <= (!i_de_r[0] && o_valid) ? dly_cnt+1 : 0;
    end
end

spr_re_gamma spr_re_gamma_0(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .spr_re_gamma_en(i_de_r[0]),
    .spr_re_gamma_in(i_data_r),
    .spr_re_gamma_out(spr_re_gamma_out)
);

spr_sharpness spr_sharpness_0(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .shp_pre_en(i_de_r[6]),
    .shp_en(i_de_r[0] || i_de_r[19]),
    .spr_sharp_en(spr_sharp_en),
    .spr_sharp_prt(spr_sharp_prt),
    .spr_thr_hi(spr_thr_hi),
    .spr_thr_lo(spr_thr_lo),
    .spr_shp_in_r(spr_shp_in_r),
    .spr_shp_in_g(spr_shp_in_g),
    .spr_shp_in_b(spr_shp_in_b),
    .spr_shp_out_r(spr_shp_out_r),
    .spr_shp_out_g(spr_shp_out_g),
    .spr_shp_out_b(spr_shp_out_b)
);

spr_core spr_core_0(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .en(i_de_r[13]),
    .spr_seperate_case(spr_seperate_case),
    .is_first_pixel(is_first_pixel_core),
    .odd_even_flag(odd_even_flag),
    .spr_thr_edge_r(spr_thr_edge_r),
    .pValue2_edge_r(pValue2_edge_r),
    .pValue3_edge_r(pValue3_edge_r),
    .pValue4_edge_r(pValue4_edge_r),
    .pValue5_edge_r(pValue5_edge_r),
    .pValue_border_r(pValue_border_r),
    .spr_thr_edge_b(spr_thr_edge_b),
    .pValue2_edge_b(pValue2_edge_b),
    .pValue3_edge_b(pValue3_edge_b),
    .pValue4_edge_b(pValue4_edge_b),
    .pValue5_edge_b(pValue5_edge_b),
    .pValue_border_b(pValue_border_b),
    .spr_core_in_r(spr_core_in_r),   
    .spr_core_in_b(spr_core_in_b),   
    .spr_core_out_r(spr_core_out_r),     
    .spr_core_out_b(spr_core_out_b)
);

spr_de_gamma spr_de_gamma_0(
    .clk(clk),
    .i_hs(i_hs),
    .i_vs(i_vs),
    .spr_de_gamma_in(spr_de_gamma_in),
    .spr_de_gamma_out(spr_de_gamma_out)
);

always @(posedge clk) begin
    if(!rst_n)begin
	for(i=0; i<20; i=i+1)begin
            i_de_r[i] <= 0;
        end
    end
    else if(!i_hs || !i_vs)begin
    	for(i=0; i<20; i=i+1)begin
            i_de_r[i] <= 0;
        end
    end
    else begin
	i_de_r[0] <= i_de;
        for(i=0; i<19; i=i+1)begin
            i_de_r[i+1] <= i_de_r[i];
        end
    end
end

always @(posedge clk) begin
    if(!i_vs)begin
	i_data_r <= 0;
        buffer_0_r <= 0;
        buffer_1_r <= 0; 
        buffer_2_r <= 0; 
        buffer_3_r <= 0; 
        buffer_4_r <= 0;
        buffer_0_g <= 0;
        buffer_1_g <= 0; 
        buffer_2_g <= 0; 
        buffer_3_g <= 0; 
        buffer_4_g <= 0;
        buffer_0_b <= 0;
        buffer_1_b <= 0; 
        buffer_2_b <= 0; 
        buffer_3_b <= 0; 
        buffer_4_b <= 0;
        shp_buffer_0_r <= 0; 
        shp_buffer_1_r <= 0; 
        shp_buffer_2_r <= 0; 
        shp_buffer_3_r <= 0; 
        shp_buffer_4_r <= 0;
        shp_buffer_0_b <= 0; 
        shp_buffer_1_b <= 0; 
        shp_buffer_2_b <= 0; 
        shp_buffer_3_b <= 0; 
        shp_buffer_4_b <= 0;
        shift_reg_g[0] <= 0;
        shift_reg_g[1] <= 0;
        shift_reg_g[2] <= 0;
//	for(i=0; i<20; i=i+1)begin
//            i_de_r[i] <= 0;
//        end
    end
    else if(!i_hs)begin
	i_data_r <= 0;
        buffer_0_r <= 0;
        buffer_1_r <= 0; 
        buffer_2_r <= 0; 
        buffer_3_r <= 0; 
        buffer_4_r <= 0;
        buffer_0_g <= 0;
        buffer_1_g <= 0; 
        buffer_2_g <= 0; 
        buffer_3_g <= 0; 
        buffer_4_g <= 0;
        buffer_0_b <= 0;
        buffer_1_b <= 0; 
        buffer_2_b <= 0; 
        buffer_3_b <= 0; 
        buffer_4_b <= 0;
        shp_buffer_0_r <= 0; 
        shp_buffer_1_r <= 0; 
        shp_buffer_2_r <= 0; 
        shp_buffer_3_r <= 0; 
        shp_buffer_4_r <= 0;
        shp_buffer_0_b <= 0; 
        shp_buffer_1_b <= 0; 
        shp_buffer_2_b <= 0; 
        shp_buffer_3_b <= 0; 
        shp_buffer_4_b <= 0;
        shift_reg_g[0] <= 0;
        shift_reg_g[1] <= 0;
        shift_reg_g[2] <= 0;
//	for(i=0; i<20; i=i+1)begin
//            i_de_r[i] <= 0;
//        end
    end
    else begin
        i_data_r <= (i_de_w) ? i_data_w : i_data_r;
	if(i_de_r[4])begin
            buffer_1_r <= spr_re_gamma_out[10:0];
            buffer_1_g <= spr_re_gamma_out[21:11];
            buffer_1_b <= spr_re_gamma_out[32:22];
            buffer_2_r <= spr_re_gamma_out[43:33]; 
            buffer_2_g <= spr_re_gamma_out[54:44]; 
            buffer_2_b <= spr_re_gamma_out[65:55]; 
            buffer_3_r <= spr_re_gamma_out[76:66]; 
            buffer_3_g <= spr_re_gamma_out[87:77]; 
            buffer_3_b <= spr_re_gamma_out[98:88]; 
            buffer_4_r <= spr_re_gamma_out[109:99]; 
            buffer_4_g <= spr_re_gamma_out[120:110]; 
            buffer_4_b <= spr_re_gamma_out[131:121];
	end 
        buffer_0_r <= (spr_sharp_en) ? ((is_first_pixel_shp)?spr_re_gamma_out[10:0]:buffer_4_r) : 0;
        buffer_0_g <= (spr_sharp_en) ? ((is_first_pixel_shp)?spr_re_gamma_out[21:11]:buffer_4_g) : 0;
        buffer_0_b <= (spr_sharp_en) ? ((is_first_pixel_shp)?spr_re_gamma_out[32:22]:buffer_4_b) : 0;
	if(i_de_r[12])begin
            shp_buffer_1_r <= spr_shp_out_r[11:0]; 
            shp_buffer_1_b <= spr_shp_out_b[11:0]; 
            shp_buffer_2_r <= spr_shp_out_r[23:12]; 
            shp_buffer_2_b <= spr_shp_out_b[23:12]; 
            shp_buffer_3_r <= spr_shp_out_r[35:24]; 
            shp_buffer_3_b <= spr_shp_out_b[35:24]; 
            shp_buffer_4_r <= spr_shp_out_r[47:36]; 
            shp_buffer_4_b <= spr_shp_out_b[47:36]; 
            shp_buffer_0_r <= shp_buffer_4_r;
            shp_buffer_0_b <= shp_buffer_4_b;
	end
        shift_reg_g[0] <= {shp_4_g, shp_3_g, shp_2_g, shp_1_g};
        shift_reg_g[1] <= shift_reg_g[0];
        shift_reg_g[2] <= shift_reg_g[1];
//	i_de_r[0] <= i_de;
//        for(i=0; i<19; i=i+1)begin
//            i_de_r[i+1] <= i_de_r[i];
//        end
    end
end
    
endmodule
