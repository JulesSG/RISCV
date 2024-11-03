`timescale 1ns / 1ps

module TB_controlUnit;
    // Señales de entrada
    reg [6:0] opcode;
    reg [2:0] funct3;
    reg [31:0] RD1;
    reg [31:0] RD2;

    // Señales de salida
    wire regWrite;
    wire memToReg;
    wire memWrite;
    wire aluSrc;
    wire [2:0] immSrc;
    wire [1:0] aluOp;
    wire pcScr;
    wire sbScr;

    // Instancia del módulo controlUnit
    controlUnit uut (
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

    // Secuencia de pruebas
    initial begin
        // Test para LW (opcode 0000011)
        opcode = 7'b0000011;
        funct3 = 3'b000;
        #10;
        
        // Test para SW (opcode 0100011, funct3 = 3'b010)
        opcode = 7'b0100011;
        funct3 = 3'b010;
        #10;

        // Test para SB (opcode 0100011, funct3 = 3'b000)
        opcode = 7'b0100011;
        funct3 = 3'b000;
        #10;

        // Test para BGE (opcode 1100011, funct3 = 3'b101, RD1 >= RD2)
        opcode = 7'b1100011;
        funct3 = 3'b101;
        RD1 = 32'h00000010;
        RD2 = 32'h00000008;
        #10;

        // Test para BGE (opcode 1100011, funct3 = 3'b101, RD1 < RD2)
        RD1 = 32'h00000008;
        RD2 = 32'h00000010;
        #10;

        // Test para NEZ (opcode 1100011, funct3 = 3'b001, RD1 != 0)
        funct3 = 3'b001;
        RD1 = 32'h00000001;
        #10;

        // Test para NEZ (opcode 1100011, funct3 = 3'b001, RD1 == 0)
        RD1 = 32'h00000000;
        #10;

        // Test para I-type ADDI (opcode 0010011, funct3 = 3'b000)
        opcode = 7'b0010011;
        funct3 = 3'b000;
        #10;

        // Test para I-type SLLI (opcode 0010011, funct3 = 3'b001)
        funct3 = 3'b001;
        #10;

        // Test para I-type ANDI (opcode 0010011, funct3 = 3'b111)
        funct3 = 3'b111;
        #10;

        // Test para U-type LUI (opcode 0110111)
        opcode = 7'b0110111;
        #10;

        // Test para J-type (opcode 1101111)
        opcode = 7'b1101111;
        #10;


    end
endmodule
