`timescale 1ns / 1ps

module TB_ALU;
    // Señales de entrada
    reg [31:0] ScrA;
    reg [31:0] ScrB;
    reg [1:0] aluOp;

    // Señal de salida
    wire [31:0] ALUResult;

    // Instancia del módulo ALU
    ALU uut (
        .ScrA(ScrA),
        .ScrB(ScrB),
        .aluOp(aluOp),
        .ALUResult(ALUResult)
    );

    // Secuencia de pruebas
    initial begin
        // Prueba de suma (aluOp = 00)
        aluOp = 2'b00;
        ScrA = 32'h00000010;
        ScrB = 32'h00000020;
        #10;
        
        // Prueba de resta (aluOp = 01)
        aluOp = 2'b01;
        ScrA = 32'h00000030;
        ScrB = 32'h00000010;
        #10;

        // Prueba de desplazamiento a la izquierda (aluOp = 10)
        aluOp = 2'b10;
        ScrA = 32'h00000001;
        ScrB = 32'h00000004; // Desplazar ScrA por 4 bits
        #10;

        // Prueba de AND (aluOp = 11)
        aluOp = 2'b11;
        ScrA = 32'h000000FF;
        ScrB = 32'h0000FF10;
        #10;

        // Prueba de valor por defecto (aluOp = 11 pero con ScrA y ScrB en 0)
        aluOp = 2'b11;
        ScrA = 32'h00000000;
        ScrB = 32'h00000000;
        #10;


    end
endmodule
