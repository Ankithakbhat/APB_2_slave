interface apb_if(input bit PCLK, input bit PRESETn);

  //----------- Parameter Definitions -------------//
  localparam int AW = 9;  // Address width
  localparam int DW = 8;  // Data width

  //----------- APB Interface Signals -------------//
  logic transfer;              // APB enable from system bus
  logic [AW-1:0] PADDR;        // APB address
  logic         PWRITE;       // Write enable
  logic         PSEL1;        // Slave1 select
  logic         PENABLE;      // Enable signal
  logic [DW-1:0] PWDATA;      // Write data
  logic [DW-1:0] PRDATA;      // Read data
  logic         PREADY;       // Ready signal
  logic         PSLVERR;      // Slave error

  //----------- Driver Clocking Block -------------//
  clocking drv_cb @(posedge PCLK or negedge PRESETn);
    default input #1 output #1;

    output transfer, PADDR, PWRITE, PSEL1, PENABLE, PWDATA;
    input  PREADY, PRDATA, PSLVERR;
  endclocking

  //----------- Monitor Clocking Block ------------//
  clocking mon_cb @(posedge PCLK or negedge PRESETn);
    default input #1 output #1;

    input transfer, PADDR, PWRITE, PSEL1, PENABLE, PWDATA;
    input PRDATA, PREADY, PSLVERR;
  endclocking

  //----------- Modport Declarations --------------//
  modport DRV (clocking drv_cb);
  modport MON (clocking mon_cb);

  //----------- APB Protocol Assertions ------------//

  // Assertion: PENABLE should be high one cycle after PSEL1 goes high
  property psel_enable;
    @(posedge PCLK) disable iff (!PRESETn)
    $rose(PSEL1) |-> ##1 PENABLE;
  endproperty
  apb_enable_chk: assert property(psel_enable)
    else $error("ASSERTION FAILED: PENABLE not high one cycle after PSEL1");

endinterface
