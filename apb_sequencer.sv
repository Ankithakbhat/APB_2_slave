//======================================================//
//              APB Sequencer Definition                //
//======================================================//

// This class is the sequencer in UVM. It controls the flow of apb_seq_item
// objects from the sequence to the driver.

class apb_sequencer extends uvm_sequencer#(apb_seq_item);

  //==================================================//
  // UVM Factory Registration                         //
  // Allows this component to be created using type names
  `uvm_component_utils(apb_sequencer)

  //==================================================//
  // Constructor                                      //
  // Initializes the sequencer and connects it to its parent in hierarchy
  function new(string name, uvm_component parent);
    super.new(name, parent); // Call the base class constructor
  endfunction

endclass
