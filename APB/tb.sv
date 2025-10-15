`timescale 1ns/1ps
`include "apb_interface.sv"
`include "apb_master.sv"

module tb_apb();
    logic clk, reset, rdata;
    apb_interface apb_if();

    initial begin
        clk = 0;
        reset = 0;
        #20 reset = 1;
        forever #5 clk = ~clk;
    end

    assign apb_if.PCLK = clk;
    assign apb_if.PRESETn = reset;

    apb_slave apb_slave (apb_if.slave_mp);
    apb_master apb_master (apb_if.master_mp);
    
   initial begin
	@(posedge reset);

	$display("\n\t=====[TEST] test 1. Write and Read =====");
	apb_master.write(0, 17);
	apb_master.read(0);
	$display("\n\t=====[TEST] test 2. Write =====");
	apb_master.write(8, "APB");
	$display("\n\t=====[TEST] test 3. Read =====");
	apb_master.read(8);
	#15;
    end

endmodule

