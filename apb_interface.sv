interface apb_master_if(input bit PCLK, input bit PRESETn);

  //----------- Parameter Definitions -------------//
  // Define address and data widths used throughout the interface
  localparam int AW = 9;  // Address width = 9 bits
  localparam int DW = 8;  // Data width = 8 bits

  //----------- Master Control Inputs -------------//
  // These signals are driven by the testbench (master)
  logic transfer;                       // Master asserts this to start a transaction
  logic READ_WRITE;                     // 0 = Read transaction, 1 = Write transaction
  logic [AW-1:0] apb_read_paddr;        // Address used during read operation
  logic [AW-1:0] apb_write_paddr;       // Address used during write operation
  logic [DW-1:0] apb_write_data;        // Data to be written during a write operation

  //----------- Master Output ---------------------//
  // Data read from the APB slave, provided to the master
  logic [DW-1:0] apb_read_data_out;     // Output of read data (slave to master)

  //----------- Driver Clocking Block -------------//
  // This clocking block is used in the driver to control signal timing
  clocking drv_cb @(posedge PCLK or negedge PRESETn);
    default input #1 output #1;  // Delay of 1 time unit for both input and output

    // Output signals to be driven by the testbench driver
    output transfer;
    output READ_WRITE;
    output apb_read_paddr;
    output apb_write_paddr;
    output apb_write_data;

    // Input signal to capture the data read from the slave
    input  apb_read_data_out;
  endclocking

  //----------- Monitor Clocking Block ------------//
  // This clocking block is used by the monitor to observe signals passively
  clocking mon_cb @(posedge PCLK or negedge PRESETn);
    default input #1 output #1;  // Delay of 1 time unit for both input and output

    // Input signals observed by the monitor (monitor never drives signals)
    input transfer;
    input READ_WRITE;
    input apb_read_paddr;
    input apb_write_paddr;
    input apb_write_data;
    input apb_read_data_out;
  endclocking

  //----------- Modport Declarations --------------//
  // Define modports to restrict access to signals and enforce direction rules

  // DRV modport: allows driver to drive output signals and read read_data
  modport DRV (clocking drv_cb);

  // MON modport: allows monitor to observe all relevant signals
  modport MON (clocking mon_cb);

  //----------- Master Signal Assertion ------------//
  // [Optional space to add assertions to verify protocol correctness]
  // You can write SystemVerilog assertions here to check protocol compliance,
  // e.g., check that apb_write_data is valid only when transfer is high, etc.

endinterface
