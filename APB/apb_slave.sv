module apb_slave(apb_interface apb_if);

    logic [7:0] memory [0:15]; 
  
    always_ff @(posedge apb_if.PCLK or negedge apb_if.PRESETn) begin
        if (!apb_if.PRESETn) begin
            reg_data <= '0;
	    reg_adr <= '0;
            apb_if.PREADY <= 1'b0; 
            apb_if.PSLVERR <= 1'b0;
	    foreach (memory[i]) memory[i] = 0;
		
        end
	if (apb_if.PSEL && apb_if.PENABLE && apb_if.PWRITE) begin
	    	apb_if.PSLVERR <= 1'b0; 
		apb_if.PREADY <= 1'b1;

		if(abp_if.PADDR!=0 || abp_if.PADDR!=4 || abp_if.PADDR!=8 || abp_if.PADDR!=12) begin
			$display("[APB_SLAVE] ERROR: d addr=%05d isn't in range", reg_adr);
			apb_if.PSLVERR <= 1;
		end

		memory[abp_if.PADDR][0:7] <= apb_if.PWDATA[7:0];
		memory[abp_if.PADDR+1][0:7] <= apb_if.PWDATA[15:8];
		memory[abp_if.PADDR+2][0:7] <= apb_if.PWDATA[23:16];
		memory[abp_if.PADDR+3][0:7] <= apb_if.PWDATA[31:24];

            end // PSEL && PENABLE && PWRITE
            

            if (apb_if.PSEL && apb_if.PENABLE && !apb_if.PWRITE) begin
		apb_if.PREADY <= 1'b1;
		apb_if.PRDATA[7:0] <= memory[apb_if.PADDR][0:7]; 
		apb_if.PRDATA[15:8] <= memory[apb_if.PADDR+1][8:15]; 
		apb_if.PRDATA[23:16] <= memory[apb_if.PADDR+2][16:23]; 
		apb_if.PRDATA[31:24] <= memory[apb_if.PADDR+3][24:31]; 

            end // PSEL && PENABLE && !PWRITE

	if (!apb_if.PSEL) apb_if.PREADY <= 1'b0;
    end //always
endmodule 

