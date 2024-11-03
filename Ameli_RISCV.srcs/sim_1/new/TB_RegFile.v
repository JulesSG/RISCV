`timescale 1ns / 1ps

module TB_RegFile;
    // Señales de entrada
    reg CLK;
    reg RST;
    reg [4:0] A1;
    reg [4:0] A2;
    reg [4:0] A3;
    reg [31:0] WD3;
    reg WE3;

    // Señales de salida
    wire [31:0] RD1;
    wire [31:0] RD2;

    // Instancia del módulo registerFile
    registerFile uut (
        .CLK(CLK),
        .RST(RST),
        .A1(A1),
        .A2(A2),
        .A3(A3),
        .WD3(WD3),
        .WE3(WE3),
        .RD1(RD1),
        .RD2(RD2)
    );

    // Generación de reloj
    initial begin
        CLK = 0;
        forever #5 CLK = ~CLK;  // Periodo de reloj de 10 ns
    end

    // Inicialización y pruebas
    initial begin
        // Resetear el registro
        RST = 1;
        WE3 = 0;
        #10;
        RST = 0;

        // Leer el registro x2 (debería tener el valor 64 después del reset)
        A1 = 5'd2;
        #10;
        $display("Lectura inicial de x2 (sp), RD1 = %d (esperado: 64)", RD1);

        // Escribir en el registro x3
        A3 = 5'd3;
        WD3 = 32'h12345678;
        WE3 = 1;
        #10;

        // Leer el valor escrito en el registro x3
        WE3 = 0;
        A1 = 5'd3;
        #10;
        $display("Lectura de x3, RD1 = %h (esperado: 12345678)", RD1);

        // Intentar escribir en el registro x0 (debe permanecer en 0)
        A3 = 5'd0;
        WD3 = 32'hFFFFFFFF;
        WE3 = 1;
        #10;

        // Leer el registro x0 (debe ser 0)
        WE3 = 0;
        A1 = 5'd0;
        #10;
        $display("Lectura de x0, RD1 = %h (esperado: 0)", RD1);

        // Leer otro registro, x2, para verificar que se mantiene el valor de stack pointer
        A1 = 5'd2;
        #10;
        $display("Lectura de x2 después de operaciones, RD1 = %d (esperado: 64)", RD1);

    end
endmodule
