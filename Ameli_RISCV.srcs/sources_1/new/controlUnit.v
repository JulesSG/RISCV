`timescale 1ns / 1ps
 
module controlUnit(
    input [6:0] opcode,     // Opcode de la instrucción
    input [2:0] funct3,
    input [31:0] RD1,
    input [31:0] RD2,
    output reg regWrite,     // Señal para escribir en los registros
    output reg memToReg,     // Señal para controlar el mux de la memoria
    output reg memWrite,     // Señal para escribir en la memoria
    output reg aluSrc, 
    output reg [2:0] immSrc, // Señal para seleccionar entre inmediato o registro
    output reg [1:0] aluOp,  // Señal para la operación de la ALU
    output reg pcScr,             // Señal que decide si se realiza el salto condicional
    output reg sbScr
    
);

    // Lógica combinacional para generar las señales de control
    always @(*) begin
        case (opcode)
            7'b0000011: begin // Instrucciones de carga (LW)
                regWrite = 1'b1;
                memToReg = 1'b1;
                aluSrc = 1'b1;
                pcScr = 0;
                immSrc = 3'b000;
                aluOp = 2'b00; // ALU realiza suma para dirección
                memWrite = 0;
                sbScr = 0;
            end
            7'b0100011: begin // Instrucciones de almacenamiento 
                case(funct3)
                3'b000:begin //sb
                    memWrite = 1;
                    regWrite = 1'b0;
                    immSrc = 3'b001;
                    aluSrc = 1;
                    pcScr = 0;
                    aluOp = 2'b00; // ALU realiza suma para dirección  
                    sbScr = 1;             
                end
                3'b010:begin //sw
                    memWrite = 1;//(SW)
                    aluSrc = 1;
                    regWrite = 1'b0;
                    pcScr = 0;
                    immSrc = 3'b001;
                    aluOp = 2'b00; // ALU realiza suma para dirección
                    sbScr = 0; 
                end

                endcase 
            end
            
            7'b1100011: begin // Instrucciones branch 
                case(funct3)
                    3'b101://BGE
                    begin 
                        if(RD1>=RD2)
                        begin 
                            immSrc = 3'b010;
                            regWrite = 1'b0;
                            memWrite = 0;
                            pcScr = 1;
                            aluOp    = 2'b00; 
                            aluSrc = 1; // Suma pc + address relativa 
                            sbScr = 0; 
                        end
                        else 
                         begin
                            immSrc = 3'b010;
                            regWrite = 1'b0;
                            memWrite = 0;
                            pcScr = 0;
                            aluSrc = 1; // Suma pc + address relat 
                            sbScr = 0; 
                         end
                   end
                   3'b001://NEZ
                    begin 
                     if(RD1 != 0)
                        begin
                            immSrc = 3'b010;
                            regWrite = 1'b0;
                            memWrite = 0;
                            pcScr = 1;
                            aluOp    = 2'b00; 
                            aluSrc = 1;  // Suma pc + address relativa   
                            sbScr = 0; 
                        end 
                        else 
                         begin
                            immSrc = 3'b010;
                            regWrite = 1'b0;
                            memWrite = 0;
                            pcScr = 0;
                            aluSrc = 1; // Suma pc + address relat 
                            sbScr = 0; 
                         end
                   end
                   
                endcase 
            end
           
            7'b0010011: begin // Instrucciones I-type 
                regWrite = 1;
                aluSrc = 1; // Usar inmediato
                immSrc = 3'b000;
                pcScr = 0;
                memWrite = 0;
                memToReg = 0;
                sbScr = 0;
                case (funct3)
                    3'b000: aluOp = 2'b00; // ADDI // li // suma
                    3'b001: aluOp = 2'b10; // a<<b 
                    3'b111: aluOp = 2'b11; // ANDI // AND
                endcase
            end
            7'b0110111: begin // Instrucciones U-type 
                regWrite = 1;
                pcScr = 0;
                aluOp    = 2'b00; 
                aluSrc = 1; // Usar inmediato
                immSrc = 3'b011;
                memToReg = 0;
                memWrite = 0;
                sbScr = 0;
                
            end
        7'b1101111: begin // J type
          immSrc = 3'b100;
          pcScr = 1;
          memWrite = 0;
          regWrite = 1'b0;
          aluOp    = 2'b00; 
          aluSrc = 1;  // Suma pc + address relativa 
          sbScr = 0;
        
        end     
        endcase
    end
endmodule
