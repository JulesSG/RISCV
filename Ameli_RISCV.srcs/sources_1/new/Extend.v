`timescale 1ns / 1ps

module Extend(
    input [31:0] data,      // Entrada de datos que contiene el inmediato
    input [2:0] immSrc,     // Selector para el tipo de inmediato
    output reg [31:0] immExtend // Salida de inmediato extendido
);

always @(*) 
begin
    case (immSrc)
        3'b000: immExtend = {{20{data[31]}}, data[31:20]}; // I-type: Sign extend the top 12 bits
        3'b001: immExtend = {{20{data[31]}}, data[31:25], data[11:7]}; // S-type
        3'b010: immExtend = {{19{data[31]}},data[31] ,data[7],data[30:25], data[11:8],1'b0}; // B-type
        3'b011: immExtend = {data[31:12], 12'b0}; // U-type (LUI)
        3'b100: immExtend = {{12{data[31]}},data[31],data[19:12],data[20],data[30:21], 1'b0}; // J-type (JAL)
        default: immExtend = 32'b0; // Valor por defecto
    endcase
end    

endmodule