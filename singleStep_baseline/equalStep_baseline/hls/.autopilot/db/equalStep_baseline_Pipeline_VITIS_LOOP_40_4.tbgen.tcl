set moduleName equalStep_baseline_Pipeline_VITIS_LOOP_40_4
set isTopModule 0
set isCombinational 0
set isDatapathOnly 0
set isPipelined 1
set isPipelined_legacy 1
set pipeline_type loop_auto_rewind
set FunctionProtocol ap_ctrl_hs
set isOneStateSeq 0
set ProfileFlag 0
set StallSigGenFlag 0
set isEnableWaveformDebug 1
set hasInterrupt 0
set DLRegFirstOffset 0
set DLRegItemOffset 0
set svuvm_can_support 1
set cdfgNum 7
set C_modelName {equalStep_baseline_Pipeline_VITIS_LOOP_40_4}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict imStack { MEM_WIDTH 16 MEM_SIZE 40960 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ zext_ln34 int 6 regular  }
	{ zext_ln35 int 6 regular  }
	{ imStack int 16 regular {array 20480 { 1 3 } 1 1 }  }
	{ Phi_t2_out double 64 regular {pointer 1}  }
	{ Phi_t1_out double 64 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "zext_ln34", "interface" : "wire", "bitwidth" : 6, "direction" : "READONLY"} , 
 	{ "Name" : "zext_ln35", "interface" : "wire", "bitwidth" : 6, "direction" : "READONLY"} , 
 	{ "Name" : "imStack", "interface" : "memory", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "Phi_t2_out", "interface" : "wire", "bitwidth" : 64, "direction" : "WRITEONLY"} , 
 	{ "Name" : "Phi_t1_out", "interface" : "wire", "bitwidth" : 64, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 24
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ zext_ln34 sc_in sc_lv 6 signal 0 } 
	{ zext_ln35 sc_in sc_lv 6 signal 1 } 
	{ imStack_address0 sc_out sc_lv 15 signal 2 } 
	{ imStack_ce0 sc_out sc_logic 1 signal 2 } 
	{ imStack_q0 sc_in sc_lv 16 signal 2 } 
	{ Phi_t2_out sc_out sc_lv 64 signal 3 } 
	{ Phi_t2_out_ap_vld sc_out sc_logic 1 outvld 3 } 
	{ Phi_t1_out sc_out sc_lv 64 signal 4 } 
	{ Phi_t1_out_ap_vld sc_out sc_logic 1 outvld 4 } 
	{ grp_fu_131_p_din0 sc_out sc_lv 64 signal -1 } 
	{ grp_fu_131_p_din1 sc_out sc_lv 64 signal -1 } 
	{ grp_fu_131_p_opcode sc_out sc_lv 1 signal -1 } 
	{ grp_fu_131_p_dout0 sc_in sc_lv 64 signal -1 } 
	{ grp_fu_131_p_ce sc_out sc_logic 1 signal -1 } 
	{ grp_fu_135_p_din0 sc_out sc_lv 64 signal -1 } 
	{ grp_fu_135_p_din1 sc_out sc_lv 64 signal -1 } 
	{ grp_fu_135_p_dout0 sc_in sc_lv 64 signal -1 } 
	{ grp_fu_135_p_ce sc_out sc_logic 1 signal -1 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "zext_ln34", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "zext_ln34", "role": "default" }} , 
 	{ "name": "zext_ln35", "direction": "in", "datatype": "sc_lv", "bitwidth":6, "type": "signal", "bundle":{"name": "zext_ln35", "role": "default" }} , 
 	{ "name": "imStack_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":15, "type": "signal", "bundle":{"name": "imStack", "role": "address0" }} , 
 	{ "name": "imStack_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "imStack", "role": "ce0" }} , 
 	{ "name": "imStack_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "imStack", "role": "q0" }} , 
 	{ "name": "Phi_t2_out", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "Phi_t2_out", "role": "default" }} , 
 	{ "name": "Phi_t2_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "Phi_t2_out", "role": "ap_vld" }} , 
 	{ "name": "Phi_t1_out", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "Phi_t1_out", "role": "default" }} , 
 	{ "name": "Phi_t1_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "Phi_t1_out", "role": "ap_vld" }} , 
 	{ "name": "grp_fu_131_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "grp_fu_131_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_131_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "grp_fu_131_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_131_p_opcode", "direction": "out", "datatype": "sc_lv", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_131_p_opcode", "role": "default" }} , 
 	{ "name": "grp_fu_131_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "grp_fu_131_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_131_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_131_p_ce", "role": "default" }} , 
 	{ "name": "grp_fu_135_p_din0", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "grp_fu_135_p_din0", "role": "default" }} , 
 	{ "name": "grp_fu_135_p_din1", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "grp_fu_135_p_din1", "role": "default" }} , 
 	{ "name": "grp_fu_135_p_dout0", "direction": "in", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "grp_fu_135_p_dout0", "role": "default" }} , 
 	{ "name": "grp_fu_135_p_ce", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "grp_fu_135_p_ce", "role": "default" }}  ]}

set ArgLastReadFirstWriteLatency {
	equalStep_baseline_Pipeline_VITIS_LOOP_40_4 {
		zext_ln34 {Type I LastRead 0 FirstWrite -1}
		zext_ln35 {Type I LastRead 0 FirstWrite -1}
		imStack {Type I LastRead 0 FirstWrite -1}
		Phi_t2_out {Type O LastRead -1 FirstWrite 12}
		Phi_t1_out {Type O LastRead -1 FirstWrite 12}
		sin_k {Type I LastRead -1 FirstWrite -1}
		cos_k {Type I LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "34", "Max" : "34"}
	, {"Name" : "Interval", "Min" : "34", "Max" : "34"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	zext_ln34 { ap_none {  { zext_ln34 in_data 0 6 } } }
	zext_ln35 { ap_none {  { zext_ln35 in_data 0 6 } } }
	imStack { ap_memory {  { imStack_address0 mem_address 1 15 }  { imStack_ce0 mem_ce 1 1 }  { imStack_q0 mem_dout 0 16 } } }
	Phi_t2_out { ap_vld {  { Phi_t2_out out_data 1 64 }  { Phi_t2_out_ap_vld out_vld 1 1 } } }
	Phi_t1_out { ap_vld {  { Phi_t1_out out_data 1 64 }  { Phi_t1_out_ap_vld out_vld 1 1 } } }
}
