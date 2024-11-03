`timescale 1ns / 1ps
module ALU( 
    input [31:0] ScrA,
    input [31:0] ScrB,
    input [1:0]  aluOp,
    output reg [31:0] ALUResult

);

always @(*)
begin

    case(aluOp)
        2'b00: ALUResult = ScrA + ScrB;      // add
        2'b01: ALUResult = ScrA - ScrB;      // sub
        2'b10: ALUResult = ScrA << ScrB;     // left shift
        2'b11: ALUResult = ScrA & ScrB;      // AND    
    endcase  
    $display("output ALUResult = %h", ALUResult);
    $display("aluOp = %h", aluOp);
end 

endmodule
