create_project prj -part xc7z020-clg400-1 -force
set_property target_language verilog [current_project]
set vivado_ver [version -short]
set COE_DIR "../../syn/verilog"
source "C:/Users/seanr/vitis_projects/fpp_project/singleStep_baseline/equalStep_baseline/hls/syn/verilog/equalStep_baseline_dadddsub_64ns_64ns_64_5_full_dsp_1_ip.tcl"
source "C:/Users/seanr/vitis_projects/fpp_project/singleStep_baseline/equalStep_baseline/hls/syn/verilog/equalStep_baseline_dcmp_64ns_64ns_1_2_no_dsp_1_ip.tcl"
source "C:/Users/seanr/vitis_projects/fpp_project/singleStep_baseline/equalStep_baseline/hls/syn/verilog/equalStep_baseline_ddiv_64ns_64ns_64_31_no_dsp_1_ip.tcl"
source "C:/Users/seanr/vitis_projects/fpp_project/singleStep_baseline/equalStep_baseline/hls/syn/verilog/equalStep_baseline_dmul_64ns_64ns_64_5_max_dsp_1_ip.tcl"
source "C:/Users/seanr/vitis_projects/fpp_project/singleStep_baseline/equalStep_baseline/hls/syn/verilog/equalStep_baseline_dsqrt_64ns_64ns_64_30_no_dsp_1_ip.tcl"
source "C:/Users/seanr/vitis_projects/fpp_project/singleStep_baseline/equalStep_baseline/hls/syn/verilog/equalStep_baseline_uitodp_32ns_64_4_no_dsp_1_ip.tcl"
