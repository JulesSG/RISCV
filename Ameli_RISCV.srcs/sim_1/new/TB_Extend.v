//`timescale 1ns / 1ps

module TB_Extend;

    // Parámetros
    reg [31:0] data;
    reg [2:0] immSrc;
    wire [31:0] immExtend;

    // Instanciar el módulo Extend
    Extend uut (
        .data(data),
        .immSrc(immSrc),
        .immExtend(immExtend)
    );

    // Procedimiento de prueba
    initial begin
        // Monitor para ver los resultados
        $monitor("Time: %0t | immSrc: %b | data: %b | immExtend: %b", $time, immSrc, data, immExtend);

        // Caso I-type: Número positivo
        data = 32'h06300793;//99 
        immSrc = 3'b000; // I-type
        #10; // Esperar 10 ns

        // Caso I-type: Número negativo
        data = 32'hfe010113; //-32
        immSrc = 3'b000; // I-type
        #10; // Esperar 10 ns

        // Caso S-type: Número positivo
        data = 32'h00812e23; // 28
        immSrc = 3'b001; // S-type
        #10; // Esperar 10 ns

        // Caso S-type: Número negativo
        data = 32'hfef42423 ; // -24
        immSrc = 3'b001; // S-type
        #10; // Esperar 10 ns

        // Caso B-type: Número positivo
        data = 32'h00079863; // 
        immSrc = 3'b010; // B-type
        #10; // Esperar 10 ns

        // Caso B-type: Número negativo
        data = 32'hfce7d0e3; // 
        immSrc = 3'b010; // B-type
        #10; // Esperar 10 ns

        // Caso U-type: Número positivo
        data = 32'h0000c7b7; // 12
        immSrc = 3'b011; // U-type
        #10; // Esperar 10 ns

        // Caso U-type: Número negativo
        data = 32'hf000c7b7; // 
        immSrc = 3'b011; // U-type
        #10; // Esperar 10 ns

        // Caso J-type: Número positivo
        data = 32'h01c0006f ; // 
        immSrc = 3'b100; // J-type
        #10; // Esperar 10 ns

        // Caso J-type: Número negativo
        data = 32'b11111111111111111111111111111110; // 
        immSrc = 3'b100; // J-type
        #10; // Esperar 10 ns

        // Fin de la simulación
        $finish;
    end

endmodule
