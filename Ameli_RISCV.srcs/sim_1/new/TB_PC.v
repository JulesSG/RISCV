`timescale 1ns/1ps

module TB_PC;
    // Señales del testbench
    reg CLK;
    reg RST;
    reg [31:0] pcUpdate;
    reg pcScr;
    wire [31:0] pc;

    // Instancia del módulo programCounter
    programCounter uut (
        .CLK(CLK),
        .RST(RST),
        .pcUpdate(pcUpdate),
        .pcScr(pcScr),
        .pc(pc)
    );

    // Generación del reloj (CLK)
    initial begin
        CLK = 0;
        forever #10 CLK = ~CLK; // Reloj de 10ns de periodo (50 MHz)
    end

    // Generación de la secuencia de pruebas
    initial begin
        // Inicialización de señales
        RST = 1;
        pcUpdate = 32'h00000020;
        pcScr = 0;

        // Mantener reset activo por un ciclo de reloj
        #15;
        RST = 0;

        // Prueba: Incrementar el contador (pcScr = 0)
        #20;
        pcScr = 0;

        // Prueba: Actualizar el contador con pcUpdate (pcScr = 1)
        #20;
        pcScr = 1;

        // Esperar y cambiar pcUpdate para probar el siguiente valor
        #20;
        pcUpdate = 32'h00000040;
        pcScr = 1;

        // Volver a incrementar
        #20;
        pcScr = 0;

        // Terminar la simulación después de algunos ciclos
        #100;
        $stop;
    end
endmodule
