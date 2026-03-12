// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
// Tool Version Limit: 2025.05
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
`timescale 1ns/1ps


`define AUTOTB_DUT      equalStep_baseline
`define AUTOTB_DUT_INST AESL_inst_equalStep_baseline
`define AUTOTB_TOP      apatb_equalStep_baseline_top
`define AUTOTB_LAT_RESULT_FILE "equalStep_baseline.result.lat.rb"
`define AUTOTB_PER_RESULT_TRANS_FILE "equalStep_baseline.performance.result.transaction.xml"
`define AUTOTB_TOP_INST AESL_inst_apatb_equalStep_baseline_top
`define AUTOTB_MAX_ALLOW_LATENCY  15000000
`define AUTOTB_CLOCK_PERIOD_DIV2 8.00

`define AESL_MEM_imStack AESL_automem_imStack
`define AESL_MEM_INST_imStack mem_inst_imStack
`define AESL_MEM_wrappedPhase AESL_automem_wrappedPhase
`define AESL_MEM_INST_wrappedPhase mem_inst_wrappedPhase
`define AESL_MEM_mod_r AESL_automem_mod_r
`define AESL_MEM_INST_mod_r mem_inst_mod_r
`define AUTOTB_TVIN_imStack  "../tv/cdatafile/c.equalStep_baseline.autotvin_imStack.dat"
`define AUTOTB_TVIN_wrappedPhase  "../tv/cdatafile/c.equalStep_baseline.autotvin_wrappedPhase.dat"
`define AUTOTB_TVIN_mod_r  "../tv/cdatafile/c.equalStep_baseline.autotvin_mod_r.dat"
`define AUTOTB_TVIN_imStack_out_wrapc  "../tv/rtldatafile/rtl.equalStep_baseline.autotvin_imStack.dat"
`define AUTOTB_TVIN_wrappedPhase_out_wrapc  "../tv/rtldatafile/rtl.equalStep_baseline.autotvin_wrappedPhase.dat"
`define AUTOTB_TVIN_mod_r_out_wrapc  "../tv/rtldatafile/rtl.equalStep_baseline.autotvin_mod_r.dat"
`define AUTOTB_TVOUT_wrappedPhase  "../tv/cdatafile/c.equalStep_baseline.autotvout_wrappedPhase.dat"
`define AUTOTB_TVOUT_mod_r  "../tv/cdatafile/c.equalStep_baseline.autotvout_mod_r.dat"
`define AUTOTB_TVOUT_wrappedPhase_out_wrapc  "../tv/rtldatafile/rtl.equalStep_baseline.autotvout_wrappedPhase.dat"
`define AUTOTB_TVOUT_mod_r_out_wrapc  "../tv/rtldatafile/rtl.equalStep_baseline.autotvout_mod_r.dat"
module `AUTOTB_TOP;

parameter AUTOTB_TRANSACTION_NUM = 1;
parameter PROGRESS_TIMEOUT = 10000000;
parameter LATENCY_ESTIMATION = 868481;
parameter LENGTH_imStack = 20480;
parameter LENGTH_mod_r = 4096;
parameter LENGTH_wrappedPhase = 4096;

reg AESL_clock;
reg rst;
reg dut_rst;
reg start;
reg ce;
reg tb_continue;
wire AESL_start;
wire AESL_reset;
wire AESL_ce;
wire AESL_ready;
wire AESL_idle;
wire AESL_continue;
wire AESL_done;
reg AESL_done_delay = 0;
reg AESL_done_delay2 = 0;
reg AESL_ready_delay = 0;
wire ready;
wire ready_wire;
wire ap_start;
wire ap_done;
wire ap_idle;
wire ap_ready;
wire [14 : 0] imStack_address0;
wire  imStack_ce0;
wire [15 : 0] imStack_q0;
wire [11 : 0] wrappedPhase_address0;
wire  wrappedPhase_ce0;
wire  wrappedPhase_we0;
wire [63 : 0] wrappedPhase_d0;
wire [11 : 0] mod_r_address0;
wire  mod_r_ce0;
wire  mod_r_we0;
wire [63 : 0] mod_r_d0;
integer done_cnt = 0;
integer AESL_ready_cnt = 0;
integer ready_cnt = 0;
reg ready_initial;
reg ready_initial_n;
reg ready_last_n;
reg ready_delay_last_n;
reg done_delay_last_n;
reg interface_done = 0;


wire all_finish;
wire ap_clk;
wire ap_rst;
wire ap_rst_n;

`AUTOTB_DUT `AUTOTB_DUT_INST(
    .ap_clk(ap_clk),
    .ap_rst(ap_rst),
    .ap_start(ap_start),
    .ap_done(ap_done),
    .ap_idle(ap_idle),
    .ap_ready(ap_ready),
    .imStack_address0(imStack_address0),
    .imStack_ce0(imStack_ce0),
    .imStack_q0(imStack_q0),
    .wrappedPhase_address0(wrappedPhase_address0),
    .wrappedPhase_ce0(wrappedPhase_ce0),
    .wrappedPhase_we0(wrappedPhase_we0),
    .wrappedPhase_d0(wrappedPhase_d0),
    .mod_r_address0(mod_r_address0),
    .mod_r_ce0(mod_r_ce0),
    .mod_r_we0(mod_r_we0),
    .mod_r_d0(mod_r_d0));
assign ap_clk = AESL_clock;
assign ap_rst = AESL_reset;
assign ap_rst_n = ~AESL_reset;
assign AESL_reset = dut_rst;
assign AESL_start = svtb_top.misc_if.tb2dut_ap_start;
assign AESL_ready = svtb_top.misc_if.dut2tb_ap_ready;
assign AESL_done  = svtb_top.misc_if.dut2tb_ap_done;
assign all_finish = svtb_top.misc_if.finished;
initial begin : initial_process
    integer proc_rand;
    rst = 1;
    # 100;
    repeat(0+3) @ (posedge AESL_clock);
    # 0.1;
    rst = 0;
end
initial begin : initial_process_for_dut_rst
    integer proc_rand;
    dut_rst = 1;
    # 100;
    repeat(3) @ (posedge AESL_clock);
    # 0.1;
    dut_rst = 0;
end
initial begin
    AESL_clock = 0;
    forever #`AUTOTB_CLOCK_PERIOD_DIV2 AESL_clock = ~AESL_clock;
end

    sv_module_top svtb_top();
//------------------------arrayimStack Instantiation--------------

// The input and output of arrayimStack
wire    arrayimStack_ce0, arrayimStack_ce1;
wire [2 - 1 : 0]    arrayimStack_we0, arrayimStack_we1;
wire    [14 : 0]    arrayimStack_address0, arrayimStack_address1;
wire    [15 : 0]    arrayimStack_din0, arrayimStack_din1;
wire    [15 : 0]    arrayimStack_dout0, arrayimStack_dout1;
wire    arrayimStack_ready;
wire    arrayimStack_done;

`AESL_MEM_imStack `AESL_MEM_INST_imStack(
    .clk        (AESL_clock),
    .rst        (AESL_reset),
    .ce0        (arrayimStack_ce0),
    .we0        (arrayimStack_we0),
    .address0   (arrayimStack_address0),
    .din0       (arrayimStack_din0),
    .dout0      (arrayimStack_dout0),
    .ce1        (arrayimStack_ce1),
    .we1        (arrayimStack_we1),
    .address1   (arrayimStack_address1),
    .din1       (arrayimStack_din1),
    .dout1      (arrayimStack_dout1),
    .ready      (arrayimStack_ready),
    .done    (arrayimStack_done)
);

// Assignment between dut and arrayimStack
assign arrayimStack_address0 = imStack_address0;
assign arrayimStack_ce0 = imStack_ce0;
assign imStack_q0 = arrayimStack_dout0;
assign arrayimStack_we0 = 0;
assign arrayimStack_din0 = 0;
assign arrayimStack_we1 = 0;
assign arrayimStack_din1 = 0;
assign arrayimStack_ready=    ready;
assign arrayimStack_done = 0;

event imStack_reshape_ap_done_evt;
event imStack_reshape_ap_ready_evt;
initial begin
     `AESL_MEM_INST_imStack.initialed       = svtb_top.misc_if.initialed_evt  ;
     `AESL_MEM_INST_imStack.finished        = svtb_top.misc_if.finished_evt   ;
     `AESL_MEM_INST_imStack.dut2tb_ap_ready = svtb_top.misc_if.dut2tb_ap_ready_evt;
     `AESL_MEM_INST_imStack.dut2tb_ap_done = svtb_top.misc_if.dut2tb_ap_ready_evt;
end
//------------------------arraywrappedPhase Instantiation--------------

// The input and output of arraywrappedPhase
wire    arraywrappedPhase_ce0, arraywrappedPhase_ce1;
wire [8 - 1 : 0]    arraywrappedPhase_we0, arraywrappedPhase_we1;
wire    [11 : 0]    arraywrappedPhase_address0, arraywrappedPhase_address1;
wire    [63 : 0]    arraywrappedPhase_din0, arraywrappedPhase_din1;
wire    [63 : 0]    arraywrappedPhase_dout0, arraywrappedPhase_dout1;
wire    arraywrappedPhase_ready;
wire    arraywrappedPhase_done;

`AESL_MEM_wrappedPhase `AESL_MEM_INST_wrappedPhase(
    .clk        (AESL_clock),
    .rst        (AESL_reset),
    .ce0        (arraywrappedPhase_ce0),
    .we0        (arraywrappedPhase_we0),
    .address0   (arraywrappedPhase_address0),
    .din0       (arraywrappedPhase_din0),
    .dout0      (arraywrappedPhase_dout0),
    .ce1        (arraywrappedPhase_ce1),
    .we1        (arraywrappedPhase_we1),
    .address1   (arraywrappedPhase_address1),
    .din1       (arraywrappedPhase_din1),
    .dout1      (arraywrappedPhase_dout1),
    .ready      (arraywrappedPhase_ready),
    .done    (arraywrappedPhase_done)
);

// Assignment between dut and arraywrappedPhase
assign arraywrappedPhase_address0 = wrappedPhase_address0;
assign arraywrappedPhase_ce0 = wrappedPhase_ce0;
assign arraywrappedPhase_we0[0] = wrappedPhase_we0;
assign arraywrappedPhase_we0[1] = wrappedPhase_we0;
assign arraywrappedPhase_we0[2] = wrappedPhase_we0;
assign arraywrappedPhase_we0[3] = wrappedPhase_we0;
assign arraywrappedPhase_we0[4] = wrappedPhase_we0;
assign arraywrappedPhase_we0[5] = wrappedPhase_we0;
assign arraywrappedPhase_we0[6] = wrappedPhase_we0;
assign arraywrappedPhase_we0[7] = wrappedPhase_we0;
assign arraywrappedPhase_din0 = wrappedPhase_d0;
assign arraywrappedPhase_we1 = 0;
assign arraywrappedPhase_din1 = 0;
assign arraywrappedPhase_ready= ready_initial | arraywrappedPhase_done;
assign arraywrappedPhase_done =    AESL_done_delay;

event wrappedPhase_reshape_ap_done_evt;
event wrappedPhase_reshape_ap_ready_evt;
initial begin
     `AESL_MEM_INST_wrappedPhase.initialed       = svtb_top.misc_if.initialed_evt  ;
     `AESL_MEM_INST_wrappedPhase.finished        = svtb_top.misc_if.finished_evt   ;
     `AESL_MEM_INST_wrappedPhase.dut2tb_ap_done  = svtb_top.misc_if.dut2tb_ap_done_evt;
     `AESL_MEM_INST_wrappedPhase.dut2tb_ap_ready = wrappedPhase_reshape_ap_ready_evt;
end
initial begin
    forever begin
        @svtb_top.misc_if.dut2tb_ap_done_evt;
        #0;
        -> wrappedPhase_reshape_ap_ready_evt;
    end
end
//------------------------arraymod_r Instantiation--------------

// The input and output of arraymod_r
wire    arraymod_r_ce0, arraymod_r_ce1;
wire [8 - 1 : 0]    arraymod_r_we0, arraymod_r_we1;
wire    [11 : 0]    arraymod_r_address0, arraymod_r_address1;
wire    [63 : 0]    arraymod_r_din0, arraymod_r_din1;
wire    [63 : 0]    arraymod_r_dout0, arraymod_r_dout1;
wire    arraymod_r_ready;
wire    arraymod_r_done;

`AESL_MEM_mod_r `AESL_MEM_INST_mod_r(
    .clk        (AESL_clock),
    .rst        (AESL_reset),
    .ce0        (arraymod_r_ce0),
    .we0        (arraymod_r_we0),
    .address0   (arraymod_r_address0),
    .din0       (arraymod_r_din0),
    .dout0      (arraymod_r_dout0),
    .ce1        (arraymod_r_ce1),
    .we1        (arraymod_r_we1),
    .address1   (arraymod_r_address1),
    .din1       (arraymod_r_din1),
    .dout1      (arraymod_r_dout1),
    .ready      (arraymod_r_ready),
    .done    (arraymod_r_done)
);

// Assignment between dut and arraymod_r
assign arraymod_r_address0 = mod_r_address0;
assign arraymod_r_ce0 = mod_r_ce0;
assign arraymod_r_we0[0] = mod_r_we0;
assign arraymod_r_we0[1] = mod_r_we0;
assign arraymod_r_we0[2] = mod_r_we0;
assign arraymod_r_we0[3] = mod_r_we0;
assign arraymod_r_we0[4] = mod_r_we0;
assign arraymod_r_we0[5] = mod_r_we0;
assign arraymod_r_we0[6] = mod_r_we0;
assign arraymod_r_we0[7] = mod_r_we0;
assign arraymod_r_din0 = mod_r_d0;
assign arraymod_r_we1 = 0;
assign arraymod_r_din1 = 0;
assign arraymod_r_ready= ready_initial | arraymod_r_done;
assign arraymod_r_done =    AESL_done_delay;

event mod_r_reshape_ap_done_evt;
event mod_r_reshape_ap_ready_evt;
initial begin
     `AESL_MEM_INST_mod_r.initialed       = svtb_top.misc_if.initialed_evt  ;
     `AESL_MEM_INST_mod_r.finished        = svtb_top.misc_if.finished_evt   ;
     `AESL_MEM_INST_mod_r.dut2tb_ap_done  = svtb_top.misc_if.dut2tb_ap_done_evt;
     `AESL_MEM_INST_mod_r.dut2tb_ap_ready = mod_r_reshape_ap_ready_evt;
end
initial begin
    forever begin
        @svtb_top.misc_if.dut2tb_ap_done_evt;
        #0;
        -> mod_r_reshape_ap_ready_evt;
    end
end

////////////////////////////////////////////
// progress and performance
////////////////////////////////////////////

task wait_start();
    while (~AESL_start) begin
        @ (posedge AESL_clock);
    end
endtask

reg [31:0] clk_cnt = 0;
reg AESL_ready_p1;
reg AESL_start_p1;

always @ (posedge AESL_clock) begin
    if (AESL_reset == 1) begin
        clk_cnt <= 32'h0;
        AESL_ready_p1 <= 1'b0;
        AESL_start_p1 <= 1'b0;
    end
    else begin
        clk_cnt <= clk_cnt + 1;
        AESL_ready_p1 <= AESL_ready;
        AESL_start_p1 <= AESL_start;
    end
end

reg [31:0] start_timestamp [0:AUTOTB_TRANSACTION_NUM - 1];
reg [31:0] start_cnt;
reg [31:0] ready_timestamp [0:AUTOTB_TRANSACTION_NUM - 1];
reg [31:0] ap_ready_cnt;
reg [31:0] finish_timestamp [0:AUTOTB_TRANSACTION_NUM - 1];
reg [31:0] finish_cnt;
reg [31:0] lat_total;
event report_progress;

always @(posedge AESL_clock)
begin
    if (finish_cnt == AUTOTB_TRANSACTION_NUM - 1 && AESL_done == 1'b1)
        lat_total = clk_cnt - start_timestamp[0];
end

initial begin
    start_cnt = 0;
    finish_cnt = 0;
    ap_ready_cnt = 0;
    wait (AESL_reset == 0);
    wait_start();
    start_timestamp[start_cnt] = clk_cnt;
    start_cnt = start_cnt + 1;
    if (AESL_done) begin
        finish_timestamp[finish_cnt] = clk_cnt;
        finish_cnt = finish_cnt + 1;
    end
    -> report_progress;
    forever begin
        @ (posedge AESL_clock);
        if (start_cnt < AUTOTB_TRANSACTION_NUM) begin
            if ((AESL_start && AESL_ready_p1)||(AESL_start && ~AESL_start_p1)) begin
                start_timestamp[start_cnt] = clk_cnt;
                start_cnt = start_cnt + 1;
            end
        end
        if (ap_ready_cnt < AUTOTB_TRANSACTION_NUM) begin
            if (AESL_start_p1 && AESL_ready_p1) begin
                ready_timestamp[ap_ready_cnt] = clk_cnt;
                ap_ready_cnt = ap_ready_cnt + 1;
            end
        end
        if (finish_cnt < AUTOTB_TRANSACTION_NUM) begin
            if (AESL_done) begin
                finish_timestamp[finish_cnt] = clk_cnt;
                finish_cnt = finish_cnt + 1;
            end
        end
        -> report_progress;
    end
end

reg [31:0] progress_timeout;

initial begin : simulation_progress
    real intra_progress;
    wait (AESL_reset == 0);
    progress_timeout = PROGRESS_TIMEOUT;
    $display("////////////////////////////////////////////////////////////////////////////////////");
    $display("// Inter-Transaction Progress: Completed Transaction / Total Transaction");
    $display("// Intra-Transaction Progress: Measured Latency / Latency Estimation * 100%%");
    $display("//");
    $display("// RTL Simulation : \"Inter-Transaction Progress\" [\"Intra-Transaction Progress\"] @ \"Simulation Time\"");
    $display("////////////////////////////////////////////////////////////////////////////////////");
    print_progress();
    while (finish_cnt < AUTOTB_TRANSACTION_NUM) begin
        @ (report_progress);
        if (finish_cnt < AUTOTB_TRANSACTION_NUM) begin
            if (AESL_done) begin
                print_progress();
                progress_timeout = PROGRESS_TIMEOUT;
            end else begin
                if (progress_timeout == 0) begin
                    print_progress();
                    progress_timeout = PROGRESS_TIMEOUT;
                end else begin
                    progress_timeout = progress_timeout - 1;
                end
            end
        end
    end
    print_progress();
    $display("////////////////////////////////////////////////////////////////////////////////////");
    calculate_performance();
end

task get_intra_progress(output real intra_progress);
    begin
        if (start_cnt > finish_cnt) begin
            intra_progress = clk_cnt - start_timestamp[finish_cnt];
        end else if(finish_cnt > 0) begin
            intra_progress = LATENCY_ESTIMATION;
        end else begin
            intra_progress = 0;
        end
        intra_progress = intra_progress / LATENCY_ESTIMATION;
    end
endtask

task print_progress();
    real intra_progress;
    begin
        if (LATENCY_ESTIMATION > 0) begin
            get_intra_progress(intra_progress);
            $display("// RTL Simulation : %0d / %0d [%2.2f%%] @ \"%0t\"", finish_cnt, AUTOTB_TRANSACTION_NUM, intra_progress * 100, $time);
        end else begin
            $display("// RTL Simulation : %0d / %0d [n/a] @ \"%0t\"", finish_cnt, AUTOTB_TRANSACTION_NUM, $time);
        end
    end
endtask

task calculate_performance();
    integer i;
    integer fp;
    reg [31:0] latency [0:AUTOTB_TRANSACTION_NUM - 1];
    reg [31:0] latency_min;
    reg [31:0] latency_max;
    reg [31:0] latency_total;
    reg [31:0] latency_average;
    reg [31:0] interval [0:AUTOTB_TRANSACTION_NUM - 2];
    reg [31:0] interval_min;
    reg [31:0] interval_max;
    reg [31:0] interval_total;
    reg [31:0] interval_average;
    reg [31:0] total_execute_time;
    begin
        latency_min = -1;
        latency_max = 0;
        latency_total = 0;
        interval_min = -1;
        interval_max = 0;
        interval_total = 0;
        total_execute_time = lat_total;

        for (i = 0; i < AUTOTB_TRANSACTION_NUM; i = i + 1) begin
            // calculate latency
            latency[i] = finish_timestamp[i] - start_timestamp[i];
            if (latency[i] > latency_max) latency_max = latency[i];
            if (latency[i] < latency_min) latency_min = latency[i];
            latency_total = latency_total + latency[i];
            // calculate interval
            if (AUTOTB_TRANSACTION_NUM == 1) begin
                interval[i] = 0;
                interval_max = 0;
                interval_min = 0;
                interval_total = 0;
            end else if (i < AUTOTB_TRANSACTION_NUM - 1) begin
                interval[i] = start_timestamp[i + 1] - start_timestamp[i];
                if (interval[i] > interval_max) interval_max = interval[i];
                if (interval[i] < interval_min) interval_min = interval[i];
                interval_total = interval_total + interval[i];
            end
        end

        latency_average = latency_total / AUTOTB_TRANSACTION_NUM;
        if (AUTOTB_TRANSACTION_NUM == 1) begin
            interval_average = 0;
        end else begin
            interval_average = interval_total / (AUTOTB_TRANSACTION_NUM - 1);
        end

        fp = $fopen(`AUTOTB_LAT_RESULT_FILE, "w");

        $fdisplay(fp, "$MAX_LATENCY = \"%0d\"", latency_max);
        $fdisplay(fp, "$MIN_LATENCY = \"%0d\"", latency_min);
        $fdisplay(fp, "$AVER_LATENCY = \"%0d\"", latency_average);
        $fdisplay(fp, "$MAX_THROUGHPUT = \"%0d\"", interval_max);
        $fdisplay(fp, "$MIN_THROUGHPUT = \"%0d\"", interval_min);
        $fdisplay(fp, "$AVER_THROUGHPUT = \"%0d\"", interval_average);
        $fdisplay(fp, "$TOTAL_EXECUTE_TIME = \"%0d\"", total_execute_time);

        $fclose(fp);

        fp = $fopen(`AUTOTB_PER_RESULT_TRANS_FILE, "w");

        $fdisplay(fp, "%20s%16s%16s", "", "latency", "interval");
        if (AUTOTB_TRANSACTION_NUM == 1) begin
            i = 0;
            $fdisplay(fp, "transaction%8d:%16d%16d", i, latency[i], interval[i]);
        end else begin
            for (i = 0; i < AUTOTB_TRANSACTION_NUM; i = i + 1) begin
                if (i < AUTOTB_TRANSACTION_NUM - 1) begin
                    $fdisplay(fp, "transaction%8d:%16d%16d", i, latency[i], interval[i]);
                end else begin
                    $fdisplay(fp, "transaction%8d:%16d               x", i, latency[i]);
                end
            end
        end

        $fclose(fp);
    end
endtask


////////////////////////////////////////////
// Dependence Check
////////////////////////////////////////////

`ifndef POST_SYN

`endif
///////////////////////////////////////////////////////
// dataflow status monitor
///////////////////////////////////////////////////////
dataflow_monitor U_dataflow_monitor(
    .clock(AESL_clock),
    .reset(rst),
    .finish(all_finish));

`include "fifo_para.vh"
endmodule
