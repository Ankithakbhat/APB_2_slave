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


![image](https://github.com/user-attachments/assets/ac5502b9-80ab-4490-bb9d-5f608a7522b9)



 
Operation Of APB




 


 
