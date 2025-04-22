//------------------------------------------------------------------------------
// APB Environment Skeleton
// Description: Top-level environment that instantiates agents, scoreboard, and coverage.
//------------------------------------------------------------------------------

class apb_env extends uvm_env;

  //--------------------------------------------------------------------------
  // UVM Factory Registration
  //--------------------------------------------------------------------------

  `uvm_component_utils(apb_env)

  //--------------------------------------------------------------------------
  // Component Declarations
  //--------------------------------------------------------------------------

  apb_agent_active agent_a;     // Active APB master agent
  apb_agent_passive agent_p;    // Passive APB slave agent
  apb_scoreboard scb;           // Scoreboard for checking correctness
  apb_coverage cov;             // Coverage component for functional coverage

  //--------------------------------------------------------------------------
  // Constructor
  //--------------------------------------------------------------------------

  function new(string name = "apb_env", uvm_component parent);
    super.new(name, parent);  // Call parent class constructor
  endfunction

  //--------------------------------------------------------------------------
  // Build Phase
  // Purpose: Instantiate all child components using factory
  //--------------------------------------------------------------------------

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create active agent (master)
    agent_a = apb_agent_active::type_id::create("agent_a", this);

    // Create passive agent (slave)
    agent_p = apb_agent_passive::type_id::create("agent_p", this);

    // Create coverage component
    cov = apb_coverage::type_id::create("cov", this);

    // Create scoreboard
    scb = apb_scoreboard::type_id::create("scb", this);
  endfunction

  //--------------------------------------------------------------------------
  // Connect Phase
  // Purpose: Connect monitor ports to scoreboard and coverage components
  //--------------------------------------------------------------------------

  function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);

    // Connect active agent’s monitor to scoreboard input port
    agent_a.mon_a.ip_mon_port.connect(scb.item_collected_export_ip);

    // Connect passive agent’s monitor to scoreboard output port
    agent_p.mon_p.op_mon_port.connect(scb.item_collected_export_op);

    // Connect monitor to coverage input analysis port
    agent_a.mon_a.ip_mon_port.connect(cov.inp_mon_imp);

    // Connect monitor to coverage output analysis port
    agent_p.mon_p.op_mon_port.connect(cov.out_mon_imp);
  endfunction

endclass
