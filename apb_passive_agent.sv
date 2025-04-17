class apb_agent_passive extends uvm_agent;

  `uvm_component_utils(apb_agent_passive)

  // Passive monitor handle
  apb_monitor_passive mon;

  // Constructor
  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  // Build phase
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    mon = apb_monitor_passive::type_id::create("mon", this);
  endfunction

endclass
