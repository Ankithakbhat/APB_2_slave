class apb_seq_item extends uvm_sequence_item;

  //------------------- Master-side stimulus signals -------------------//
  // These are the signals that will be randomized to generate transactions

  rand  bit         transfer;           // 1 = Start transaction, 0 = Idle
  rand  bit         READ_WRITE;         // 1 = Read operation, 0 = Write operation
  rand  bit [8:0]   apb_read_paddr;     // Address for Read operation
  rand  bit [8:0]   apb_write_paddr;    // Address for Write operation
  rand  bit [7:0]   apb_write_data;     // Data to be written during Write

  //------------------- Master-side output signals --------------------//
  // These are set by the slave and captured by master after a read

  bit   [7:0]       apb_read_data_out;  // Data received from slave (after Read)

  //------------------- UVM Factory Registration ----------------------//
  // This helps UVM register and create objects of this class dynamically
  `uvm_object_utils_begin(apb_seq_item)
    `uvm_field_int(transfer,           UVM_ALL_ON)        // Register 'transfer' for copy, print, compare
    `uvm_field_int(READ_WRITE,         UVM_ALL_ON)        // Register 'READ_WRITE'
    `uvm_field_int(apb_read_paddr,     UVM_ALL_ON)        // Register 'apb_read_paddr'
    `uvm_field_int(apb_write_paddr,    UVM_ALL_ON)        // Register 'apb_write_paddr'
    `uvm_field_int(apb_write_data,     UVM_ALL_ON)        // Register 'apb_write_data'
    `uvm_field_int(apb_read_data_out,  UVM_ALL_ON)        // Register 'apb_read_data_out'
  `uvm_object_utils_end

  //------------------- Constructor ----------------------//
  // Special function to create a new object of this sequence item
  function new(string name = "apb_seq_item");
    super.new(name);  // Call parent class constructor
  endfunction

  //------------------- Human-Readable Format ----------------------//
  // This function provides a nice, printable string showing current field values
  function string convert2string();
    return $sformatf("transfer=%0b, READ_WRITE=%0b, R_ADDR=0x%0h, W_ADDR=0x%0h, W_DATA=0x%0h, R_DATA_OUT=0x%0h",
                      transfer, READ_WRITE, apb_read_paddr, apb_write_paddr, apb_write_data, apb_read_data_out);
  endfunction

endclass
