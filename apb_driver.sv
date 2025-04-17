`define DRV_if vif.DRV.drv_cb

class apb_driver extends uvm_driver#(apb_seq_item);

  `uvm_component_utils(apb_driver)

  // Virtual interface
  virtual apb_if vif;

  // Constructor
  function new(string name = "apb_driver", uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if (!uvm_config_db#(virtual apb_if)::get(this, "*", "vif", vif))
      `uvm_fatal("APB_DRIVER", "Interface not found in config DB");
  endfunction

  // Run phase
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    forever begin
      seq_item_port.get_next_item(req);
      drive();  // drive APB transaction
      seq_item_port.item_done();
    end
  endtask

  // Drive task
  task drive();
    // Add clocking block-based driving logic here
  endtask

endclass
