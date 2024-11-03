`timescale 1ns / 1ps

module TB_instrMen;
   
    reg [31:0] pc;
    wire [31:0] instruction;

 
    InstructionMemory uut (
        .CLK(), 
        .pc(pc),
        .instruction(instruction)
    );

    // Inicialización de la prueba
    initial begin
        pc = 0; 
        #10;    

      
        repeat (5) begin
            #10 pc = pc + 4; 
        end
    end
endmodule
