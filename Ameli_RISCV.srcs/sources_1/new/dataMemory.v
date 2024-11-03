`timescale 1ns / 1ps

module dataMemory(
    input wire CLK,             
    input wire RST,             
    input wire [31:0] aluResult, // Dirección de memoria (obtenida del ALU)
    input wire [31:0] writeData, // Dato a escribir
    input wire memWrite,         // Señal para habilitar la escritura
    input wire sbScr,            // en caso de un sb
    output [31:0] readData       // Dato leído
);

    // Declaración de memoria: 256 palabras de 32 bits
    reg [31:0] memory [0:63]; 

    // Resetear la memoria al inicio
    integer i;
    always @(posedge RST) begin
        for (i = 0; i < 64; i = i + 1) begin
            memory[i] <= 32'b0; 
        end
    end

    // Escritura en memoria con soporte para sb
    always @(posedge CLK) begin
        if (memWrite) begin
            if (!sbScr) begin
                // Escribir palabra completa en la dirección (divide entre 4 para guardar en palabras)
                memory[aluResult >> 2] <= writeData;
            end else begin
                // Escribir solo un byte en la dirección especificada
                case (aluResult[1:0])
                    2'b00: memory[aluResult >> 2][7:0]   <= writeData[7:0];  // Byte 0
                    2'b01: memory[aluResult >> 2][15:8]  <= writeData[7:0];  // Byte 1
                    2'b10: memory[aluResult >> 2][23:16] <= writeData[7:0];  // Byte 2
                    2'b11: memory[aluResult >> 2][31:24] <= writeData[7:0];  // Byte 3
                endcase
            end
        end
    end

    // Lectura desde la dirección
    assign readData = memory[aluResult >> 2];
    
    /* 
    always @(posedge CLK) begin
        $writememh("dump_memory.hex", memory);
    end
    */
endmodule
