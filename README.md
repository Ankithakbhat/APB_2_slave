# APB_2_slave
APB is low bandwidth and low performance bus. So, the components requiring lower bandwidth like the peripheral devices such as UART, Keypad, Timer and PIO (Peripheral Input Output) devices are connected to the APB. The bridge connects the high performance AHB or ASB bus to the APB bus. So, for APB the bridge acts as the master and all the devices connected on the APB bus acts as the slave.
APB Specification
The design consists of a single APB master controlled by external signals, communicating with two connected slaves. The master selects one slave at a time based on the least significant bit of the paddress. The APB is enabled only when the transfer signal is high; otherwise, it remains disabled.
1.	Parallel bus operation. All the data will be captured at rising edge clock.
2.	Two slave design based on 9th bit of apb_write_paddress bit it will elect the slave1 and slave2.
3.	Signal priority: 1.PRESET (active low) 2. PSEL (active high) 3. PENABLE (active high) 4. PREADY (active high) 5. PWRITE
4.	Data width 8 bit and address width 9 bit.
5.	PWRITE=1 indicates write PWDATA to slave. PWRITE=0 indicates read PRDATA from slave.
6.	Start of data transmission is indicated when PENABLE changes from low to high. End of transmission is indicated by PREADY changes from high to low.
Top Module Name: apb_protocol.v 
APB Interface Block Diagram:
![image](https://github.com/user-attachments/assets/001a39ed-1c4a-43aa-8d63-b77a16339d32)


 
Operation Of APB
 
APB PIN Description:

SIGNAL	SOURCE	Description	WIDTH(Bit)
Transfer	System Bus	APB enable signal. If high APB is activated else APB is disabled	1
PCLK	Clock Source	All APB functionality occurs at a rising edge.	1
PRESETn	System Bus	An active low signal.	1
PADDR	APB bridge	The APB address bus can be up to 32 bits.	8
PSEL1	APB bridge	There is a PSEL for each slave. It’s an active high signal.	1
PENABLE	APB bridge	It indicates the 2nd cycle of a data transfer. It’s an active high signal.	1
PWRITE	APB bridge	Indicates the data transfer direction. PWRITE=1 indicates APB write access(Master to slave) PWRITE=0 indicates APB read access(Slave to master)	1
PREADY	Slave Interface	This is an input from Slave. It is used to enter the access state.	1
PSLVERR	Slave Interface	This indicates a transfer failure by the slave.	1
PRDATA	Slave Interface	Read Data. The selected slave drives this bus during reading operation	8
PWDATA	Slave Interface	Write data. This bus is driven by the peripheral bus bridge unit during write cycles when PWRITE is high.	8

 
