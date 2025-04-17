class apb_seq_item extends uvm_sequence_item;

  // APB input signals
  randc bit [8:0]  i_paddr;     // Address
  rand  bit        i_pwrite;    // Write enable
  rand  bit [7:0]  i_pwdata;    // Write data
  rand  bit [3:0]  i_pstrb;     // Write strobe

  // APB control signals (non-rand)
  bit              i_psel;
  bit              i_penable;

  // APB output signals
  bit [7:0]        o_prdata;    // Read data
  bit              o_pslverr;   // Slave error
  bit              o_pready;    // Ready

  // Factory registration
  `uvm_object_utils_begin(apb_seq_item)
    `uvm_field_int(i_paddr,    UVM_ALL_ON)
    `uvm_field_int(i_pwrite,   UVM_ALL_ON)
    `uvm_field_int(i_pwdata,   UVM_ALL_ON)
    `uvm_field_int(i_pstrb,    UVM_ALL_ON)
    `uvm_field_int(i_psel,     UVM_ALL_ON)
    `uvm_field_int(i_penable,  UVM_ALL_ON)
    `uvm_field_int(o_prdata,   UVM_ALL_ON)
    `uvm_field_int(o_pslverr,  UVM_ALL_ON)
    `uvm_field_int(o_pready,   UVM_ALL_ON)
  `uvm_object_utils_end

  // Constructor
  function new(string name = "apb_seq_item");
    super.new(name);
  endfunction

  // Optional string display (skeleton only)
  function string convert2string();
    return $sformatf("i_paddr=%0h, i_pwrite=%0b, i_pwdata=%0h, i_pstrb=%0b", i_paddr, i_pwrite, i_pwdata, i_pstrb);
  endfunction

  // Example constraint skeleton
  

endclass
