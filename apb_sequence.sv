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

//------------------WRITE SEQUENCE------------------//
class write_seq extends uvm_sequence#(apb_seq_item);

  // Registering the class with UVM factory for object creation and management
  `uvm_object_utils(write_seq)

  // Constructor for initializing the write sequence with a given name (default is "write_seq")
  function new(string name = "write_seq");
    super.new(name); // Call to parent class constructor
  endfunction

  // Main sequence body: Logic for APB write transaction
  virtual task body();
    // Define and implement write transaction logic here
  endtask

endclass


//------------------READ SEQUENCE------------------//
class read_seq extends uvm_sequence#(apb_seq_item);

  // Registering the class with UVM factory for object creation and management
  `uvm_object_utils(read_seq)

  // Constructor for initializing the read sequence with a given name (default is "read_seq")
  function new(string name = "read_seq");
    super.new(name); // Call to parent class constructor
  endfunction

  // Main sequence body: Logic for APB read transaction
  virtual task body();
    // Define and implement read transaction logic here
  endtask

endclass
