//======================================================//
//             Active APB Agent Definition              //
//======================================================//

// This UVM agent contains driver, sequencer, and monitor.
// It is an "active agent", meaning it drives stimulus using a sequencer and driver.

class apb_agent_active extends uvm_agent;

  //---------------- Factory Registration ----------------//
  // Registers the component with the UVM factory
  `uvm_component_utils(apb_agent_active)

  //---------------- Component Handles -------------------//
  apb_driver     drv;   // Handles driving transactions to DUT
  apb_sequencer  seqr;  // Provides sequence items to the driver
  apb_monitor    mon;   // Observes DUT signals and captures transactions

  //---------------- Constructor ------------------------//
  // Initializes the agent and connects it to its parent in hierarchy
  function new(string name, uvm_component parent);
    super.new(name, parent);  // Call base constructor
  endfunction

  //---------------- Build Phase ------------------------//
  // Create driver, sequencer, and monitor components here
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create components using UVM factory
    drv  = apb_driver::type_id::create("drv", this);
    seqr = apb_sequencer::type_id::create("seqr", this);
    mon  = apb_monitor::type_id::create("mon", this);
  endfunction

  //---------------- Connect Phase -----------------------//
  // Connect the sequencer to the driver if agent is active
  function void connect_phase(uvm_phase phase);
    if (get_is_active() == UVM_ACTIVE) begin
      // Connect sequence item port (driver) to export (sequencer)
      drv.seq_item_port.connect(seqr.seq_item_export);
    end
  endfunction

endclass
