//======================================================//
//               APB Driver Definition                  //
//======================================================//

// This class drives stimulus from the sequencer onto the DUT
// using the APB virtual interface and clocking block.

`define DRV_if vif.DRV.drv_cb  // Macro to simplify access to the driver clocking block

class apb_driver extends uvm_driver#(apb_seq_item);

  //---------------- Factory Registration ----------------//
  `uvm_component_utils(apb_driver)

  //---------------- Virtual Interface -------------------//
  virtual apb_if vif;  // Interface handle to drive DUT signals

  //---------------- Constructor -------------------------//
  function new(string name = "apb_driver", uvm_component parent);
    super.new(name, parent);  // Call base constructor
  endfunction

  //---------------- Build Phase -------------------------//
  // Get the virtual interface from the configuration database
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    if (!uvm_config_db#(virtual apb_if)::get(this, "*", "vif", vif))
      `uvm_fatal("APB_DRIVER", "Interface not found in config DB");
  endfunction

  //---------------- Run Phase ---------------------------//
  // Main driving loop: gets items from the sequencer and drives them
  task run_phase(uvm_phase phase);
    super.run_phase(phase);
    
    forever begin
      seq_item_port.get_next_item(req);  // Get transaction from sequencer
      drive();                           // Drive it to DUT
      seq_item_port.item_done();         // Notify sequencer that item is done
    end
  endtask

  //---------------- Drive Task --------------------------//
  // Add clocking block-based signal driving here
  task drive();
    
    // Example: Wait for reset to be deasserted
    if (vif.presetn == 0) begin
      @(posedge vif.pclk);
      // Reset logic could go here if needed
      `DRV_if.transfer       <= `b0;
    `DRV_if.READ_WRITE     <= `bz;
    `DRV_if.apb_read_paddr <= `bz;
    `DRV_if.apb_write_paddr<= `bz;
    `DRV_if.apb_write_data <= `b0;
    end

    // Wait for a clock edge and begin driving signals from req
    @(posedge vif.pclk);

    // Example driving logic (to be elaborated in real use):
    `DRV_if.transfer       <= req.transfer;
    `DRV_if.READ_WRITE     <= req.READ_WRITE;
    `DRV_if.apb_read_paddr <= req.apb_read_paddr;
    `DRV_if.apb_write_paddr<= req.apb_write_paddr;
    `DRV_if.apb_write_data <= req.apb_write_data;

    
endtask
endclass
