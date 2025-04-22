class apb_mon_active extends uvm_monitor;

  `uvm_component_utils(apb_mon_active)

  //--------------------------------------------------------------------------
  // Declarations
  //--------------------------------------------------------------------------

  virtual apb_intrf vif;  // Virtual interface handle
  uvm_analysis_port#(apb_seq_item) ip_mon_port;  // Analysis port
  apb_seq_item trans;  // Transaction container

  //--------------------------------------------------------------------------
  // Constructor
  //--------------------------------------------------------------------------

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //--------------------------------------------------------------------------
  // Build Phase
  //--------------------------------------------------------------------------

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ip_mon_port = new("ip_mon_port", this);
    if (!uvm_config_db#(virtual apb_intrf)::get(this, "*", "vif", vif))
      `uvm_fatal(get_name(), "Cannot get virtual interface")
  endfunction

  //--------------------------------------------------------------------------
  // Run Phase
  // Monitors the bus and captures transactions
  //--------------------------------------------------------------------------

  task run_phase(uvm_phase phase);
    `uvm_info("APB_ACTIVE_MON", "Inside run phase of APB Active Monitor", UVM_LOW)

    forever begin
      @(posedge vif.pclk);

        if (vif.pwrite) begin
          // Write operation
          trans.READ_WRITE     = 1;
          trans.apb_write_paddr = vif.paddr[8:0];     // Lower 9 bits for 9-bit address
          trans.apb_write_data  = vif.pwdata[7:0];    // Lower 8 bits for 8-bit data
        end
        else begin
          // Read operation
          trans.READ_WRITE      = 0;
          trans.apb_read_paddr  = vif.paddr[8:0];
          trans.apb_read_data_out = vif.prdata[7:0];  // Sampled read data
        end

        // Send transaction through analysis port
        ip_mon_port.write(trans);

        `uvm_info("APB_ACTIVE_MON", $sformatf("Sampled APB Transaction: %s", trans.convert2string()), UVM_MEDIUM)
      end
    end
  endtask

endclass
