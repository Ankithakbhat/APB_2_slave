class apb_mon_passive extends uvm_monitor;

  `uvm_component_utils(apb_mon_passive)

  //-------------------------------------------------------------------------
  // Declarations
  //-------------------------------------------------------------------------

  // Virtual interface handle
  virtual apb_intrf vif;

  // Analysis port to send transactions to scoreboard/coverage
  uvm_analysis_port#(apb_seq_item) op_mon_port;

  // Transaction object
  apb_seq_item trans;

  //-------------------------------------------------------------------------
  // Constructor
  //-------------------------------------------------------------------------

  function new(string name, uvm_component parent);
    super.new(name, parent);
  endfunction

  //-------------------------------------------------------------------------
  // Build Phase
  //-------------------------------------------------------------------------

  function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    // Create analysis port
    op_mon_port = new("op_mon_port", this);

    // Get virtual interface from config DB
    if (!uvm_config_db#(virtual apb_intrf)::get(this, "*", "vif", vif)) begin
      `uvm_fatal(get_name(), "Virtual interface not found")
    end
  endfunction

  //-------------------------------------------------------------------------
  // Run Phase
  //-------------------------------------------------------------------------

  task run_phase(uvm_phase phase);
    `uvm_info("APB_PASSIVE_MONITOR", "Entered run phase", UVM_LOW)

    forever begin
      // Wait for positive edge of clock
      @(posedge vif.pclk);

      // Check if transaction is valid (psel && penable)
      if (/* valid transaction condition */) begin

        // Create a new sequence item
        trans = apb_seq_item::type_id::create("trans", this);

        // Fill fields for write or read based on READ_WRITE
        if (/* write transaction */) begin
          // Capture write-related fields
        end else begin
          // Capture read-related fields
        end

        // Send the collected transaction
        op_mon_port.write(trans);

        // Optional: Log the transaction
      end
    end
  endtask

endclass
