set moduleName equalStep_baseline
set isTopModule 1
set isCombinational 0
set isDatapathOnly 0
set isPipelined 0
set isPipelined_legacy 0
set pipeline_type none
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
set C_modelName {equalStep_baseline}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
dict set ap_memory_interface_dict imStack { MEM_WIDTH 16 MEM_SIZE 40960 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict wrappedPhase { MEM_WIDTH 64 MEM_SIZE 32768 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
dict set ap_memory_interface_dict mod_r { MEM_WIDTH 64 MEM_SIZE 32768 MASTER_TYPE BRAM_CTRL MEM_ADDRESS_MODE WORD_ADDRESS PACKAGE_IO port READ_LATENCY 1 }
set C_modelArgList {
	{ imStack int 16 regular {array 20480 { 1 3 } 1 1 }  }
	{ wrappedPhase int 64 regular {array 4096 { 0 3 } 0 1 }  }
	{ mod_r int 64 regular {array 4096 { 0 3 } 0 1 }  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "imStack", "interface" : "memory", "bitwidth" : 16, "direction" : "READONLY"} , 
 	{ "Name" : "wrappedPhase", "interface" : "memory", "bitwidth" : 64, "direction" : "WRITEONLY"} , 
 	{ "Name" : "mod_r", "interface" : "memory", "bitwidth" : 64, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 17
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ imStack_address0 sc_out sc_lv 15 signal 0 } 
	{ imStack_ce0 sc_out sc_logic 1 signal 0 } 
	{ imStack_q0 sc_in sc_lv 16 signal 0 } 
	{ wrappedPhase_address0 sc_out sc_lv 12 signal 1 } 
	{ wrappedPhase_ce0 sc_out sc_logic 1 signal 1 } 
	{ wrappedPhase_we0 sc_out sc_logic 1 signal 1 } 
	{ wrappedPhase_d0 sc_out sc_lv 64 signal 1 } 
	{ mod_r_address0 sc_out sc_lv 12 signal 2 } 
	{ mod_r_ce0 sc_out sc_logic 1 signal 2 } 
	{ mod_r_we0 sc_out sc_logic 1 signal 2 } 
	{ mod_r_d0 sc_out sc_lv 64 signal 2 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "imStack_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":15, "type": "signal", "bundle":{"name": "imStack", "role": "address0" }} , 
 	{ "name": "imStack_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "imStack", "role": "ce0" }} , 
 	{ "name": "imStack_q0", "direction": "in", "datatype": "sc_lv", "bitwidth":16, "type": "signal", "bundle":{"name": "imStack", "role": "q0" }} , 
 	{ "name": "wrappedPhase_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "wrappedPhase", "role": "address0" }} , 
 	{ "name": "wrappedPhase_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "wrappedPhase", "role": "ce0" }} , 
 	{ "name": "wrappedPhase_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "wrappedPhase", "role": "we0" }} , 
 	{ "name": "wrappedPhase_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "wrappedPhase", "role": "d0" }} , 
 	{ "name": "mod_r_address0", "direction": "out", "datatype": "sc_lv", "bitwidth":12, "type": "signal", "bundle":{"name": "mod_r", "role": "address0" }} , 
 	{ "name": "mod_r_ce0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mod_r", "role": "ce0" }} , 
 	{ "name": "mod_r_we0", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "signal", "bundle":{"name": "mod_r", "role": "we0" }} , 
 	{ "name": "mod_r_d0", "direction": "out", "datatype": "sc_lv", "bitwidth":64, "type": "signal", "bundle":{"name": "mod_r", "role": "d0" }}  ]}

set ArgLastReadFirstWriteLatency {
	equalStep_baseline {
		imStack {Type I LastRead 0 FirstWrite -1}
		wrappedPhase {Type O LastRead -1 FirstWrite 5}
		mod_r {Type O LastRead -1 FirstWrite 44}
		sin_k {Type I LastRead -1 FirstWrite -1}
		cos_k {Type I LastRead -1 FirstWrite -1}
		cordic_ctab_table_128 {Type I LastRead -1 FirstWrite -1}}
	equalStep_baseline_Pipeline_VITIS_LOOP_40_4 {
		zext_ln34 {Type I LastRead 0 FirstWrite -1}
		zext_ln35 {Type I LastRead 0 FirstWrite -1}
		imStack {Type I LastRead 0 FirstWrite -1}
		Phi_t2_out {Type O LastRead -1 FirstWrite 12}
		Phi_t1_out {Type O LastRead -1 FirstWrite 12}
		sin_k {Type I LastRead -1 FirstWrite -1}
		cos_k {Type I LastRead -1 FirstWrite -1}}
	atan2_cordic_double_s {
		y_in {Type I LastRead 0 FirstWrite -1}
		x_in {Type I LastRead 0 FirstWrite -1}
		cordic_ctab_table_128 {Type I LastRead -1 FirstWrite -1}}
	atan2_generic_double_s {
		y_in {Type I LastRead 0 FirstWrite -1}
		x_in {Type I LastRead 0 FirstWrite -1}
		cordic_ctab_table_128 {Type I LastRead -1 FirstWrite -1}}
	atan2_generic_double_Pipeline_1 {
		y_1 {Type I LastRead 0 FirstWrite -1}
		zext_ln681 {Type I LastRead 0 FirstWrite -1}
		z_2_out {Type O LastRead -1 FirstWrite 1}
		cordic_ctab_table_128 {Type I LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "319617", "Max" : "868481"}
	, {"Name" : "Interval", "Min" : "319618", "Max" : "868482"}
]}

set PipelineEnableSignalInfo {[
]}

set Spec2ImplPortList { 
	imStack { ap_memory {  { imStack_address0 mem_address 1 15 }  { imStack_ce0 mem_ce 1 1 }  { imStack_q0 mem_dout 0 16 } } }
	wrappedPhase { ap_memory {  { wrappedPhase_address0 mem_address 1 12 }  { wrappedPhase_ce0 mem_ce 1 1 }  { wrappedPhase_we0 mem_we 1 1 }  { wrappedPhase_d0 mem_din 1 64 } } }
	mod_r { ap_memory {  { mod_r_address0 mem_address 1 12 }  { mod_r_ce0 mem_ce 1 1 }  { mod_r_we0 mem_we 1 1 }  { mod_r_d0 mem_din 1 64 } } }
}

set maxi_interface_dict [dict create]

# RTL port scheduling information:
set fifoSchedulingInfoList { 
}

# RTL bus port read request latency information:
set busReadReqLatencyList { 
}

# RTL bus port write response latency information:
set busWriteResLatencyList { 
}

# RTL array port load latency information:
set memoryLoadLatencyList { 
}
