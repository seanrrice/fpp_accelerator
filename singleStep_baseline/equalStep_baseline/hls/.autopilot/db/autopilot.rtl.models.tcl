set SynModuleInfo {
  {SRCNAME equalStep_baseline_Pipeline_VITIS_LOOP_40_4 MODELNAME equalStep_baseline_Pipeline_VITIS_LOOP_40_4 RTLNAME equalStep_baseline_equalStep_baseline_Pipeline_VITIS_LOOP_40_4
    SUBMODULES {
      {MODELNAME equalStep_baseline_uitodp_32ns_64_4_no_dsp_1 RTLNAME equalStep_baseline_uitodp_32ns_64_4_no_dsp_1 BINDTYPE op TYPE uitodp IMPL auto LATENCY 3 ALLOW_PRAGMA 1}
      {MODELNAME equalStep_baseline_equalStep_baseline_Pipeline_VITIS_LOOP_40_4_sin_k_ROM_AUTO_1R RTLNAME equalStep_baseline_equalStep_baseline_Pipeline_VITIS_LOOP_40_4_sin_k_ROM_AUTO_1R BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME equalStep_baseline_equalStep_baseline_Pipeline_VITIS_LOOP_40_4_cos_k_ROM_AUTO_1R RTLNAME equalStep_baseline_equalStep_baseline_Pipeline_VITIS_LOOP_40_4_cos_k_ROM_AUTO_1R BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
      {MODELNAME equalStep_baseline_flow_control_loop_pipe_sequential_init RTLNAME equalStep_baseline_flow_control_loop_pipe_sequential_init BINDTYPE interface TYPE internal_upc_flow_control INSTNAME equalStep_baseline_flow_control_loop_pipe_sequential_init_U}
    }
  }
  {SRCNAME atan2_generic<double>_Pipeline_1 MODELNAME atan2_generic_double_Pipeline_1 RTLNAME equalStep_baseline_atan2_generic_double_Pipeline_1
    SUBMODULES {
      {MODELNAME equalStep_baseline_atan2_generic_double_Pipeline_1_cordic_ctab_table_128_ROM_AUTO_1R RTLNAME equalStep_baseline_atan2_generic_double_Pipeline_1_cordic_ctab_table_128_ROM_AUTO_1R BINDTYPE storage TYPE rom IMPL auto LATENCY 2 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME atan2_generic<double> MODELNAME atan2_generic_double_s RTLNAME equalStep_baseline_atan2_generic_double_s
    SUBMODULES {
      {MODELNAME equalStep_baseline_ddiv_64ns_64ns_64_31_no_dsp_1 RTLNAME equalStep_baseline_ddiv_64ns_64ns_64_31_no_dsp_1 BINDTYPE op TYPE ddiv IMPL fabric LATENCY 30 ALLOW_PRAGMA 1}
      {MODELNAME equalStep_baseline_ctlz_86_86_1_1 RTLNAME equalStep_baseline_ctlz_86_86_1_1 BINDTYPE op TYPE ctlz IMPL auto}
      {MODELNAME equalStep_baseline_bitselect_1ns_86ns_7ns_1_1_1 RTLNAME equalStep_baseline_bitselect_1ns_86ns_7ns_1_1_1 BINDTYPE op TYPE bitselect IMPL auto}
    }
  }
  {SRCNAME atan2_cordic<double> MODELNAME atan2_cordic_double_s RTLNAME equalStep_baseline_atan2_cordic_double_s
    SUBMODULES {
      {MODELNAME equalStep_baseline_dcmp_64ns_64ns_1_2_no_dsp_1 RTLNAME equalStep_baseline_dcmp_64ns_64ns_1_2_no_dsp_1 BINDTYPE op TYPE dcmp IMPL auto LATENCY 1 ALLOW_PRAGMA 1}
    }
  }
  {SRCNAME equalStep_baseline MODELNAME equalStep_baseline RTLNAME equalStep_baseline IS_TOP 1
    SUBMODULES {
      {MODELNAME equalStep_baseline_dadddsub_64ns_64ns_64_5_full_dsp_1 RTLNAME equalStep_baseline_dadddsub_64ns_64ns_64_5_full_dsp_1 BINDTYPE op TYPE dadd IMPL fulldsp LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME equalStep_baseline_dmul_64ns_64ns_64_5_max_dsp_1 RTLNAME equalStep_baseline_dmul_64ns_64ns_64_5_max_dsp_1 BINDTYPE op TYPE dmul IMPL maxdsp LATENCY 4 ALLOW_PRAGMA 1}
      {MODELNAME equalStep_baseline_dsqrt_64ns_64ns_64_30_no_dsp_1 RTLNAME equalStep_baseline_dsqrt_64ns_64ns_64_30_no_dsp_1 BINDTYPE op TYPE dsqrt IMPL fabric LATENCY 29 ALLOW_PRAGMA 1}
    }
  }
}
