// Sequence for general APB request
class apb_sequence extends uvm_sequence#(apb_seq_item);

  // Registering the class with UVM factory for object creation and management
  `uvm_object_utils(apb_sequence)

  // Constructor for initializing the sequence with a given name (default is "apb_sequence")
  function new(string name = "apb_sequence");
    super.new(name); // Call to parent class constructor
  endfunction

  // Main sequence body: This is the core logic of the APB sequence
  virtual task body();
    // Create a new request object (type apb_seq_item)
    req = apb_seq_item::type_id::create("req");

    // Wait for the grant signal to proceed with transaction
    wait_for_grant();

    // Randomize the request item fields (if applicable)
    req.randomize();

    // Send the request over the bus
    send_request(req);

    // Wait for the item to be completed (done signal)
    wait_for_item_done();
  endtask

endclass

class write_seq extends uvm_sequence#(apb_seq_item);
 
  `uvm_object_utils(write_seq)
  
  function new(string name = "write_seq");
    super.new(name);
  endfunction

  virtual task body();
    req = apb_seq_item::type_id::create("req");
    wait_for_grant();
    req.randomize()with{ req.transfer && req.READ_WRITE == 1 && req.apb_write_paddr[8]==1;};
    send_request(req);
    wait_for_item_done();
  endtask
endclass



