set moduleName atan2_generic_double_Pipeline_1
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
set C_modelName {atan2_generic<double>_Pipeline_1}
set C_modelType { void 0 }
set ap_memory_interface_dict [dict create]
set C_modelArgList {
	{ y_1 int 89 regular  }
	{ zext_ln681 int 86 regular  }
	{ z_2_out int 86 regular {pointer 1}  }
}
set hasAXIMCache 0
set l_AXIML2Cache [list]
set AXIMCacheInstDict [dict create]
set C_modelArgMapList {[ 
	{ "Name" : "y_1", "interface" : "wire", "bitwidth" : 89, "direction" : "READONLY"} , 
 	{ "Name" : "zext_ln681", "interface" : "wire", "bitwidth" : 86, "direction" : "READONLY"} , 
 	{ "Name" : "z_2_out", "interface" : "wire", "bitwidth" : 86, "direction" : "WRITEONLY"} ]}
# RTL Port declarations: 
set portNum 10
set portList { 
	{ ap_clk sc_in sc_logic 1 clock -1 } 
	{ ap_rst sc_in sc_logic 1 reset -1 active_high_sync } 
	{ ap_start sc_in sc_logic 1 start -1 } 
	{ ap_done sc_out sc_logic 1 predone -1 } 
	{ ap_idle sc_out sc_logic 1 done -1 } 
	{ ap_ready sc_out sc_logic 1 ready -1 } 
	{ y_1 sc_in sc_lv 89 signal 0 } 
	{ zext_ln681 sc_in sc_lv 86 signal 1 } 
	{ z_2_out sc_out sc_lv 86 signal 2 } 
	{ z_2_out_ap_vld sc_out sc_logic 1 outvld 2 } 
}
set NewPortList {[ 
	{ "name": "ap_clk", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "clock", "bundle":{"name": "ap_clk", "role": "default" }} , 
 	{ "name": "ap_rst", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "reset", "bundle":{"name": "ap_rst", "role": "default" }} , 
 	{ "name": "ap_start", "direction": "in", "datatype": "sc_logic", "bitwidth":1, "type": "start", "bundle":{"name": "ap_start", "role": "default" }} , 
 	{ "name": "ap_done", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "predone", "bundle":{"name": "ap_done", "role": "default" }} , 
 	{ "name": "ap_idle", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "done", "bundle":{"name": "ap_idle", "role": "default" }} , 
 	{ "name": "ap_ready", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "ready", "bundle":{"name": "ap_ready", "role": "default" }} , 
 	{ "name": "y_1", "direction": "in", "datatype": "sc_lv", "bitwidth":89, "type": "signal", "bundle":{"name": "y_1", "role": "default" }} , 
 	{ "name": "zext_ln681", "direction": "in", "datatype": "sc_lv", "bitwidth":86, "type": "signal", "bundle":{"name": "zext_ln681", "role": "default" }} , 
 	{ "name": "z_2_out", "direction": "out", "datatype": "sc_lv", "bitwidth":86, "type": "signal", "bundle":{"name": "z_2_out", "role": "default" }} , 
 	{ "name": "z_2_out_ap_vld", "direction": "out", "datatype": "sc_logic", "bitwidth":1, "type": "outvld", "bundle":{"name": "z_2_out", "role": "ap_vld" }}  ]}

set ArgLastReadFirstWriteLatency {
	atan2_generic_double_Pipeline_1 {
		y_1 {Type I LastRead 0 FirstWrite -1}
		zext_ln681 {Type I LastRead 0 FirstWrite -1}
		z_2_out {Type O LastRead -1 FirstWrite 1}
		cordic_ctab_table_128 {Type I LastRead -1 FirstWrite -1}}}

set hasDtUnsupportedChannel 0

set PerformanceInfo {[
	{"Name" : "Latency", "Min" : "91", "Max" : "91"}
	, {"Name" : "Interval", "Min" : "91", "Max" : "91"}
]}

set PipelineEnableSignalInfo {[
	{"Pipeline" : "0", "EnableSignal" : "ap_enable_pp0"}
]}

set Spec2ImplPortList { 
	y_1 { ap_none {  { y_1 in_data 0 89 } } }
	zext_ln681 { ap_none {  { zext_ln681 in_data 0 86 } } }
	z_2_out { ap_vld {  { z_2_out out_data 1 86 }  { z_2_out_ap_vld out_vld 1 1 } } }
}
