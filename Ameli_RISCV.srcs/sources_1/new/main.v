`timescale 1ns / 1ps

module main(
    input CLK,
    input RST
);






    wire [31:0] pcUpdate;
    wire pcScr;
    // Decodificar la instrucción
    wire [31:0] instruction;
    wire [6:0] opcode;
    wire regWrite, memToReg, memWrite, aluSrc;
    wire [1:0] aluOp;
    wire [2:0] funct3;
    wire [2:0] immSrc;
    assign opcode = instruction[6:0];
    wire [31:0] aluResult;
    wire [31:0] pc;
    wire [31:0] readData;
    wire [31:0] WD3;
    wire [31:0] RD1;
    wire [31:0] RD2;
    wire sbScr;
    programCounter PC_System(
        .CLK(CLK),
        .RST(RST),
        .pcUpdate(pcUpdate),
        .pcScr(pcScr),  // La señal pcScr ahora viene de la controlUnit
        .pc(pc)
    );    


    InstructionMemory ROM_1(
        .CLK(CLK),
        .pc(pc),
        .instruction(instruction)
    );

    // Señales de la Unidad de Control

    assign funct3 = instruction[14:12];

    // Salida de la señal pcScr desde la controlUnit
    controlUnit CU(
        .opcode(opcode),
        .funct3(funct3),
        .RD1(RD1),
        .RD2(RD2),
        .regWrite(regWrite),
        .memToReg(memToReg),
        .memWrite(memWrite),
        .aluSrc(aluSrc),
        .immSrc(immSrc),
        .aluOp(aluOp),
        .pcScr(pcScr),
        .sbScr(sbScr)  
    );




    
    // hardcodear el 0 en una Tipo U
    wire [4:0] A1;
    assign A1 = (immSrc == 3'b011)? 5'b00000:instruction[19:15];// tipo U
    // Banco de registros
    registerFile registers(
        .CLK(CLK),
        .RST(RST),
        .A1(A1), 
        .A2(instruction[24:20]),
        .A3(instruction[11:7]),
        .WD3(WD3),
        .WE3(regWrite),
        .RD1(RD1),
        .RD2(RD2)

    );




    wire [31:0] immExtend;
    // Eximm
    Extend ExIMM(
    .data(instruction),
    .immSrc(immSrc),
    .immExtend(immExtend)
    );   
    // ALU
    wire [31:0] B;
    wire [31:0] A;
    // Mux para operaciones tipo J y B
    assign A = (pcScr == 0) ? RD1:pc; 
    // Mux para operaciones tipo I 
    assign B = (aluSrc == 0)? RD2:immExtend;
    
    ALU alu_1(
        .ScrA(A),
        .ScrB(B),           // Comparación en RD1 y RD2
        .aluOp(aluOp), // Decodificado desde la controlUnit
        .ALUResult(aluResult)
    );

 
 assign pcUpdate = aluResult;  
    
dataMemory DM(
 .CLK(CLK),
 .RST(RST),
 .aluResult(aluResult),
 .writeData(RD2),
 .memWrite(memWrite),
 .readData(readData),
 .sbScr(sbScr)
); 


assign WD3 = (memToReg == 0)? aluResult:readData;


endmodule
