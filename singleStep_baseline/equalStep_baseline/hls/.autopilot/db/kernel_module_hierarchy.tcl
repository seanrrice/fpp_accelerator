set ModuleHierarchy {[{
"Name" : "equalStep_baseline", "RefName" : "equalStep_baseline","ID" : "0","Type" : "sequential",
"SubLoops" : [
	{"Name" : "VITIS_LOOP_34_2","RefName" : "VITIS_LOOP_34_2","ID" : "1","Type" : "no",
	"SubLoops" : [
	{"Name" : "VITIS_LOOP_35_3","RefName" : "VITIS_LOOP_35_3","ID" : "2","Type" : "no",
		"SubInsts" : [
		{"Name" : "grp_equalStep_baseline_Pipeline_VITIS_LOOP_40_4_fu_109", "RefName" : "equalStep_baseline_Pipeline_VITIS_LOOP_40_4","ID" : "3","Type" : "sequential",
				"SubLoops" : [
				{"Name" : "VITIS_LOOP_40_4","RefName" : "VITIS_LOOP_40_4","ID" : "4","Type" : "pipeline"},]},
		{"Name" : "grp_atan2_cordic_double_s_fu_123", "RefName" : "atan2_cordic_double_s","ID" : "5","Type" : "sequential",
				"SubInsts" : [
				{"Name" : "grp_atan2_generic_double_s_fu_162", "RefName" : "atan2_generic_double_s","ID" : "6","Type" : "sequential",
					"SubInsts" : [
					{"Name" : "grp_atan2_generic_double_Pipeline_1_fu_118", "RefName" : "atan2_generic_double_Pipeline_1","ID" : "7","Type" : "sequential",
						"SubLoops" : [
						{"Name" : "Loop 1","RefName" : "Loop 1","ID" : "8","Type" : "pipeline"},]},]},]},]},]},]
}]}