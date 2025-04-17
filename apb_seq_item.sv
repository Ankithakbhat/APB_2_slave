class apb_seq_item extends uvm_sequence_item;

  // Master-side stimulus signals (rand)
  rand  bit         transfer;           // Transfer enable from system
  rand  bit         READ_WRITE;         // 0 = read, 1 = write
  rand  bit [8:0]   apb_read_paddr;     // Read address
  rand  bit [8:0]   apb_write_paddr;    // Write address
  rand  bit [7:0]   apb_write_data;     // Write data

  // Output from master
  bit   [7:0]       apb_read_data_out;  // Data read out from slave

  // Factory registration
  `uvm_object_utils_begin(apb_seq_item)
    `uvm_field_int(transfer,           UVM_ALL_ON)
    `uvm_field_int(READ_WRITE,         UVM_ALL_ON)
    `uvm_field_int(apb_read_paddr,     UVM_ALL_ON)
    `uvm_field_int(apb_write_paddr,    UVM_ALL_ON)
    `uvm_field_int(apb_write_data,     UVM_ALL_ON)
    `uvm_field_int(apb_read_data_out,  UVM_ALL_ON)
  `uvm_object_utils_end

  // Constructor
  function new(string name = "apb_seq_item");
    super.new(name);
  endfunction

  // Readable format
  function string convert2string();
    return $sformatf("transfer=%0b, READ_WRITE=%0b, R_ADDR=0x%0h, W_ADDR=0x%0h, W_DATA=0x%0h, R_DATA_OUT=0x%0h",
                      transfer, READ_WRITE, apb_read_paddr, apb_write_paddr, apb_write_data, apb_read_data_out);
  endfunction

endclass
