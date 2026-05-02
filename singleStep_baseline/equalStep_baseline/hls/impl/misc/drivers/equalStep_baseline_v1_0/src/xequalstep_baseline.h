// ==============================================================
// Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.2 (64-bit)
// Tool Version Limit: 2025.11
// Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
// Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
// 
// ==============================================================
#ifndef XEQUALSTEP_BASELINE_H
#define XEQUALSTEP_BASELINE_H

#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#ifndef __linux__
#include "xil_types.h"
#include "xil_assert.h"
#include "xstatus.h"
#include "xil_io.h"
#else
#include <stdint.h>
#include <assert.h>
#include <dirent.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/mman.h>
#include <unistd.h>
#include <stddef.h>
#endif
#include "xequalstep_baseline_hw.h"

/**************************** Type Definitions ******************************/
#ifdef __linux__
typedef uint8_t u8;
typedef uint16_t u16;
typedef uint32_t u32;
typedef uint64_t u64;
#else
typedef struct {
#ifdef SDT
    char *Name;
#else
    u16 DeviceId;
#endif
    u64 Control_BaseAddress;
} XEqualstep_baseline_Config;
#endif

typedef struct {
    u64 Control_BaseAddress;
    u32 IsReady;
} XEqualstep_baseline;

typedef u32 word_type;

/***************** Macros (Inline Functions) Definitions *********************/
#ifndef __linux__
#define XEqualstep_baseline_WriteReg(BaseAddress, RegOffset, Data) \
    Xil_Out32((BaseAddress) + (RegOffset), (u32)(Data))
#define XEqualstep_baseline_ReadReg(BaseAddress, RegOffset) \
    Xil_In32((BaseAddress) + (RegOffset))
#else
#define XEqualstep_baseline_WriteReg(BaseAddress, RegOffset, Data) \
    *(volatile u32*)((BaseAddress) + (RegOffset)) = (u32)(Data)
#define XEqualstep_baseline_ReadReg(BaseAddress, RegOffset) \
    *(volatile u32*)((BaseAddress) + (RegOffset))

#define Xil_AssertVoid(expr)    assert(expr)
#define Xil_AssertNonvoid(expr) assert(expr)

#define XST_SUCCESS             0
#define XST_DEVICE_NOT_FOUND    2
#define XST_OPEN_DEVICE_FAILED  3
#define XIL_COMPONENT_IS_READY  1
#endif

/************************** Function Prototypes *****************************/
#ifndef __linux__
#ifdef SDT
int XEqualstep_baseline_Initialize(XEqualstep_baseline *InstancePtr, UINTPTR BaseAddress);
XEqualstep_baseline_Config* XEqualstep_baseline_LookupConfig(UINTPTR BaseAddress);
#else
int XEqualstep_baseline_Initialize(XEqualstep_baseline *InstancePtr, u16 DeviceId);
XEqualstep_baseline_Config* XEqualstep_baseline_LookupConfig(u16 DeviceId);
#endif
int XEqualstep_baseline_CfgInitialize(XEqualstep_baseline *InstancePtr, XEqualstep_baseline_Config *ConfigPtr);
#else
int XEqualstep_baseline_Initialize(XEqualstep_baseline *InstancePtr, const char* InstanceName);
int XEqualstep_baseline_Release(XEqualstep_baseline *InstancePtr);
#endif

void XEqualstep_baseline_Start(XEqualstep_baseline *InstancePtr);
u32 XEqualstep_baseline_IsDone(XEqualstep_baseline *InstancePtr);
u32 XEqualstep_baseline_IsIdle(XEqualstep_baseline *InstancePtr);
u32 XEqualstep_baseline_IsReady(XEqualstep_baseline *InstancePtr);
void XEqualstep_baseline_EnableAutoRestart(XEqualstep_baseline *InstancePtr);
void XEqualstep_baseline_DisableAutoRestart(XEqualstep_baseline *InstancePtr);


void XEqualstep_baseline_InterruptGlobalEnable(XEqualstep_baseline *InstancePtr);
void XEqualstep_baseline_InterruptGlobalDisable(XEqualstep_baseline *InstancePtr);
void XEqualstep_baseline_InterruptEnable(XEqualstep_baseline *InstancePtr, u32 Mask);
void XEqualstep_baseline_InterruptDisable(XEqualstep_baseline *InstancePtr, u32 Mask);
void XEqualstep_baseline_InterruptClear(XEqualstep_baseline *InstancePtr, u32 Mask);
u32 XEqualstep_baseline_InterruptGetEnabled(XEqualstep_baseline *InstancePtr);
u32 XEqualstep_baseline_InterruptGetStatus(XEqualstep_baseline *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif
