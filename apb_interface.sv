interface apb_master_if(input bit PCLK, input bit PRESETn);

  //----------- Parameter Definitions -------------//
  localparam int AW = 9;  // Address width
  localparam int DW = 8;  // Data width

  //----------- Master Control Inputs -------------//
  logic transfer;                       // Initiate transfer
  logic READ_WRITE;                     // 0 = read, 1 = write
  logic [AW-1:0] apb_read_paddr;        // Read address
  logic [AW-1:0] apb_write_paddr;       // Write address
  logic [DW-1:0] apb_write_data;        // Write data

  //----------- Master Output ---------------------//
  logic [DW-1:0] apb_read_data_out;     // Read data output

  //----------- Driver Clocking Block -------------//
  clocking drv_cb @(posedge PCLK or negedge PRESETn);
    default input #1 output #1;

    output transfer, READ_WRITE, apb_read_paddr, apb_write_paddr, apb_write_data;
    input  apb_read_data_out;
  endclocking

  //----------- Monitor Clocking Block ------------//
  clocking mon_cb @(posedge PCLK or negedge PRESETn);
    default input #1 output #1;

    input transfer, READ_WRITE, apb_read_paddr, apb_write_paddr, apb_write_data;
    input apb_read_data_out;
  endclocking

  //----------- Modport Declarations --------------//
  modport DRV (clocking drv_cb);
  modport MON (clocking mon_cb);

  //----------- Master Signal Assertion ------------//

 
endinterface
