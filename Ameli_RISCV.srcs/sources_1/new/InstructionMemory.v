`timescale 1ns / 1ps


module InstructionMemory(
    input wire CLK, 
    input wire [31:0] pc, 
    output reg [31:0] instruction
);

reg [31:0] memory [0:255];

// ROM
initial begin
   //$readmemh("instructions.mem", memory);
   $readmemh("testMem.mem", memory);

end

 // read memory
always @(*) 
begin
    instruction = memory[pc >> 2];
end

endmodule
