`timescale 1ns / 1ps

module registerFile(
    input CLK,
    input RST,
    input [4:0] A1,         // Dirección registro 1 a leer
    input [4:0] A2,         // Dirección registro 2 a leer
    input [4:0] A3,         // Dirección registro a escribir
    input [31:0] WD3,       // Valor a escribir
    input WE3,              // Flag de control de escritura
    output [31:0] RD1,      // Salida valor reg1
    output [31:0] RD2      // Salida valor reg2

);
 
reg [31:0] registers [31:0];  // 32 registros de 32 bits

// Inicialización del stack pointer (sp)
always @(posedge CLK or posedge RST) begin
    if (RST) begin
        // Inicializar los registros con valores predeterminados
        registers[2] <= 32'd64;  // Inicializa el registro x2 (sp)
    end else if (WE3) begin
        registers[A3] <= WD3;  // Escribir en el registro si WE3 está activo
    end
end
 
// Lecturas de los registros
assign RD1 = (A1 == 0) ? 32'b0 : registers[A1];  // Si es x0, siempre devuelve 0
assign RD2 = (A2 == 0) ? 32'b0 : registers[A2];

endmodule
