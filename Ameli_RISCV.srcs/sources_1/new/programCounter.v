module programCounter(
    input wire CLK,             // Reloj
    input wire RST,             // Reset
    input wire [31:0] pcUpdate, // Valor nuevo para el PC
    input wire pcScr,           // Señal de selección: 0 = incrementar, 1 = actualizar con pcUpdate
    output reg [31:0] pc        // Salida: valor del PC actual
);
 always @(posedge CLK)
    begin
        if (RST) begin
            pc <= 32'b0;
            end
         else if (pcScr)
           pc <= pcUpdate;
         else
           pc <= pc + 4;   
    end 


endmodule



