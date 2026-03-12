//==============================================================
//Vitis HLS - High-Level Synthesis from C, C++ and OpenCL v2025.1 (64-bit)
//Tool Version Limit: 2025.05
//Copyright 1986-2022 Xilinx, Inc. All Rights Reserved.
//Copyright 2022-2025 Advanced Micro Devices, Inc. All Rights Reserved.
//
//==============================================================
`ifndef EQUALSTEP_BASELINE_ENV__SV                                                                                   
    `define EQUALSTEP_BASELINE_ENV__SV                                                                               
                                                                                                                    
                                                                                                                    
    class equalStep_baseline_env extends uvm_env;                                                                          
                                                                                                                    
        equalStep_baseline_virtual_sequencer equalStep_baseline_virtual_sqr;                                                      
        equalStep_baseline_config equalStep_baseline_cfg;                                                                         
                                                                                                                    
                                                                                                                    
        equalStep_baseline_reference_model   refm;                                                                         
                                                                                                                    
        equalStep_baseline_subsystem_monitor subsys_mon;                                                                   
                                                                                                                    
        `uvm_component_utils_begin(equalStep_baseline_env)                                                                 
        `uvm_field_object (refm, UVM_DEFAULT | UVM_REFERENCE)                                                       
        `uvm_field_object (equalStep_baseline_virtual_sqr, UVM_DEFAULT | UVM_REFERENCE)                                    
        `uvm_field_object (equalStep_baseline_cfg        , UVM_DEFAULT)                                                    
        `uvm_component_utils_end                                                                                    
                                                                                                                    
        function new (string name = "equalStep_baseline_env", uvm_component parent = null);                              
            super.new(name, parent);                                                                                
        endfunction                                                                                                 
                                                                                                                    
        extern virtual function void build_phase(uvm_phase phase);                                                  
        extern virtual function void connect_phase(uvm_phase phase);                                                
        extern virtual task          run_phase(uvm_phase phase);                                                    
                                                                                                                    
    endclass                                                                                                        
                                                                                                                    
    function void equalStep_baseline_env::build_phase(uvm_phase phase);                                                    
        super.build_phase(phase);                                                                                   
        equalStep_baseline_cfg = equalStep_baseline_config::type_id::create("equalStep_baseline_cfg", this);                           
                                                                                                                    



        refm = equalStep_baseline_reference_model::type_id::create("refm", this);


        uvm_config_db#(equalStep_baseline_reference_model)::set(this, "*", "refm", refm);


        `uvm_info(this.get_full_name(), "set reference model by uvm_config_db", UVM_LOW)


        subsys_mon = equalStep_baseline_subsystem_monitor::type_id::create("subsys_mon", this);


        equalStep_baseline_virtual_sqr = equalStep_baseline_virtual_sequencer::type_id::create("equalStep_baseline_virtual_sqr", this);
        `uvm_info(this.get_full_name(), "build_phase done", UVM_LOW)
    endfunction


    function void equalStep_baseline_env::connect_phase(uvm_phase phase);
        super.connect_phase(phase);


        refm.equalStep_baseline_cfg = equalStep_baseline_cfg;
        `uvm_info(this.get_full_name(), "connect phase done", UVM_LOW)
    endfunction


    task equalStep_baseline_env::run_phase(uvm_phase phase);
        `uvm_info(this.get_full_name(), "equalStep_baseline_env is running", UVM_LOW)
    endtask


`endif
