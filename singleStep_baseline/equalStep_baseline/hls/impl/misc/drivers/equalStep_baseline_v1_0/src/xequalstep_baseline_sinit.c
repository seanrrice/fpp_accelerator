// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef __linux__

#include "xstatus.h"
#ifdef SDT
#include "xparameters.h"
#endif
#include "xequalstep_baseline.h"

extern XEqualstep_baseline_Config XEqualstep_baseline_ConfigTable[];

#ifdef SDT
XEqualstep_baseline_Config *XEqualstep_baseline_LookupConfig(UINTPTR BaseAddress) {
	XEqualstep_baseline_Config *ConfigPtr = NULL;

	int Index;

	for (Index = (u32)0x0; XEqualstep_baseline_ConfigTable[Index].Name != NULL; Index++) {
		if (!BaseAddress || XEqualstep_baseline_ConfigTable[Index].Control_BaseAddress == BaseAddress) {
			ConfigPtr = &XEqualstep_baseline_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XEqualstep_baseline_Initialize(XEqualstep_baseline *InstancePtr, UINTPTR BaseAddress) {
	XEqualstep_baseline_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XEqualstep_baseline_LookupConfig(BaseAddress);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XEqualstep_baseline_CfgInitialize(InstancePtr, ConfigPtr);
}
#else
XEqualstep_baseline_Config *XEqualstep_baseline_LookupConfig(u16 DeviceId) {
	XEqualstep_baseline_Config *ConfigPtr = NULL;

	int Index;

	for (Index = 0; Index < XPAR_XEQUALSTEP_BASELINE_NUM_INSTANCES; Index++) {
		if (XEqualstep_baseline_ConfigTable[Index].DeviceId == DeviceId) {
			ConfigPtr = &XEqualstep_baseline_ConfigTable[Index];
			break;
		}
	}

	return ConfigPtr;
}

int XEqualstep_baseline_Initialize(XEqualstep_baseline *InstancePtr, u16 DeviceId) {
	XEqualstep_baseline_Config *ConfigPtr;

	Xil_AssertNonvoid(InstancePtr != NULL);

	ConfigPtr = XEqualstep_baseline_LookupConfig(DeviceId);
	if (ConfigPtr == NULL) {
		InstancePtr->IsReady = 0;
		return (XST_DEVICE_NOT_FOUND);
	}

	return XEqualstep_baseline_CfgInitialize(InstancePtr, ConfigPtr);
}
#endif

#endif

