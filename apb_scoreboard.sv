`uvm_analysis_imp_decl(_ip)
`uvm_analysis_imp_decl(_op)

class apb_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(apb_scoreboard)

  //-------------------------------------------------------------------------
  // Declarations
  //-------------------------------------------------------------------------

  // Input and Output transaction queues
  apb_seq_item pkt_inp[$];
  apb_seq_item pkt_op[$];

  // Virtual interface
  virtual apb_intrf vif;

  // Temporary variables
  bit match;
  bit [31:0] mask;
  bit [31:0] out;

  // Internal memory model
  logic [`DW-1:0] apb_mem[5];

  // Analysis imports
  uvm_analysis_imp_ip #(apb_seq_item, apb_scoreboard) item_collected_export_ip;
  uvm_analysis_imp_op #(apb_seq_item, apb_scoreboard) item_collected_export_op;

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

    // Create analysis ports
    item_collected_export_ip = new("item_collected_export_ip", this);
    item_collected_export_op = new("item_collected_export_op", this);

    // Get virtual interface from config DB
    if (!uvm_config_db#(virtual apb_intrf)::get(this, "", "vif", vif))
      `uvm_fatal("APB_SB", "APB interface handle not found!")
  endfunction

  //-------------------------------------------------------------------------
  // Write Handlers
  //-------------------------------------------------------------------------

  virtual function void write_ip(apb_seq_item pkt_ip);
    pkt_inp.push_back(pkt_ip);
  endfunction

  virtual function void write_op(apb_seq_item pkt_out);
    pkt_op.push_back(pkt_out);
  endfunction

  //-------------------------------------------------------------------------
  // Run Phase
  //-------------------------------------------------------------------------

  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.pclk);

      // Reset memory
      if (!vif.presetn) begin
        // Clear memory
        continue;
      end

      // Write Operation Handling
      if (pkt_inp.size() > 0) begin
        apb_seq_item ip_pkt = pkt_inp.pop_front();
        // Generate mask
        // Write to internal memory based on address
        // Handle slave error responses
        // Compare expected vs DUT output
      end

      // Read Operation Handling
      if (pkt_op.size() > 0) begin
        apb_seq_item op_pkt = pkt_op.pop_front();
        // Read from internal memory
        // Handle slave error responses
        // Compare expected vs DUT output
      end
    end
  endtask

  //-------------------------------------------------------------------------
  // Compare Task
  //-------------------------------------------------------------------------

  task compare(bit match);
    if (match) begin
      `uvm_info("SCOREBOARD", "Match detected", UVM_LOW)
    end else begin
      `uvm_error("SCOREBOARD", "Mismatch detected")
    end
  endtask

endclass
