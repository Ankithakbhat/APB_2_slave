//======================================================//
//            Passive APB Agent Definition              //
//======================================================//

// This agent is passive — it doesn't drive any signals to the DUT.
// It only observes signals using the monitor.

class apb_agent_passive extends uvm_agent;

  //---------------- Factory Registration ----------------//
  // Register this class with the UVM factory
  `uvm_component_utils(apb_agent_passive)

  //---------------- Passive Monitor Handle -------------//
  apb_monitor_passive mon;  // Only monitor is needed for passive agent

  //---------------- Constructor ------------------------//
  // Initializes the passive agent
  function new(string name, uvm_component parent);
    super.new(name, parent);  // Call base constructor
  endfunction

  //---------------- Build Phase ------------------------//
  // Create the monitor component
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create only the monitor since it's passive
    mon = apb_monitor_passive::type_id::create("mon", this);
  endfunction

endclass
