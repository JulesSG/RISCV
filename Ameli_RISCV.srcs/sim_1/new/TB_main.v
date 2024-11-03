module TB_main;

    reg CLK;
    reg RST;
    integer cycle_count = 0; 

   
    main main_tb(
        .CLK(CLK),
        .RST(RST)
    );

    initial begin
        CLK = 0;
        RST = 0;
        #10 RST = 1;
        #10 RST = 0;
    end

    // Clock
    always #10 CLK = ~CLK;

    // cycle counter
    always @(posedge CLK) begin
        if (RST)
            cycle_count <= 0;
        else
            cycle_count <= cycle_count + 1;
         
        // memory dump
        if (cycle_count == 48) begin
            $writememh("memory_dump.hex", main_tb.DM.memory);
            $display("Memory dump completed at cycle %d", cycle_count);
        end
    end
endmodule
