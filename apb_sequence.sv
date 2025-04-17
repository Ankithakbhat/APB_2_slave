class apb_sequence extends uvm_sequence#(apb_seq_item);

  `uvm_object_utils(apb_sequence)
  function new(string name = "apb_sequence");
    super.new(name);
  endfunction

 // `uvm_declare_p_sequencer(sequencer)

  virtual task body();
    req = apb_seq_item::type_id::create("req");
    wait_for_grant();
    req.randomize();
    send_request(req);
    wait_for_item_done();
  endtask
endclass

//------------------WRITE SEQ------------------//
class write_seq extends uvm_sequence#(apb_seq_item);
  `uvm_object_utils(write_seq)
  function new(string name = "write_seq");
    super.new(name);
  endfunction

  virtual task body();
    // write transaction
  endtask
endclass


//------------------READ SEQ------------------//
class read_seq extends uvm_sequence#(apb_seq_item);
  `uvm_object_utils(read_seq)
  function new(string name = "read_seq");
    super.new(name);
  endfunction

  virtual task body();
    // read transaction
  endtask
endclass
