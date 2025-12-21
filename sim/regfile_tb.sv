//==============================================================================
// File        : regfile_tb.sv
// Author      : Aarón Salas Alvarado
// Description : Este testbench para un archivo de 32 registros busca validar 
//               la lectura combinacional y la escritura sincronica.
// Date        : 2025-12-14
//==============================================================================

module regfile_tb;

    // CLOCK: T=10ns, f=100MHz
    logic clk;
    initial clk = 0;
    always #5 clk = ~clk;

    // WRITE ENABLE, DATA, ADDRESS AND READ ADDRESS
    logic we3;
    logic [31:0] wd3, wa3;

    // READ ADDRESS
    logic [31:0] ra1, ra2;

    // READ DATA
    logic [31:0] rd1, rd2;

    regfile regfile_inst (
        .clk(clk),
        .ra1(ra1),
        .ra2(ra2),
        .wa3(wa3),
        .wd3(wd3),
        .we3(we3),
        .rd1(rd1),
        .rd2(rd2)
    );

    initial begin
        // ONDAS
        $dumpfile("regfile_tb.vcd");
        $dumpvars(0, regfile_tb);

        // INICIALIZAR SEÑALES
        we3 = 0;
        wa3 = 0;
        wd3 = 0;
        ra1 = 0;
        ra2 = 0;
        #10;

        // TEST 1: Escribir en reg[1] mientras se lee de reg[0]
        $display("TEST 1: Escritura en reg[1] y lectura simultanea de reg[0]");
        we3 = 1;
        wa3 = 1;
        wd3 = 32'hAAAA_BBBB;
        ra1 = 0;  // Leer reg[0] (debe ser 0)
        ra2 = 1;  // Leer reg[1] (aun no escrito, debe ser 0)
        #1;       // Pequeño delay para ver lectura combinacional
        $display("  Antes del flanco: rd1=%h (reg[0]), rd2=%h (reg[1])", rd1, rd2);
        #9;       // Completar el ciclo de reloj
        $display("  Despues del flanco: rd1=%h (reg[0]), rd2=%h (reg[1])", rd1, rd2);

        // TEST 2: Escribir en reg[2] mientras se lee reg[1] recien escrito
        $display("\nTEST 2: Escritura en reg[2] y lectura simultanea de reg[1]");
        wa3 = 2;
        wd3 = 32'h1234_5678;
        ra1 = 1;  // Leer reg[1] (debe tener 0xAAAABBBB)
        ra2 = 2;  // Leer reg[2] (aun no escrito)
        #1;
        $display("  Lectura combinacional: rd1=%h (reg[1]), rd2=%h (reg[2])", rd1, rd2);
        #9;

        // TEST 3: Escribir en reg[5] mientras se leen reg[1] y reg[2]
        $display("\nTEST 3: Escritura en reg[5] y lectura simultanea de reg[1] y reg[2]");
        wa3 = 5;
        wd3 = 32'hDEAD_BEEF;
        ra1 = 1;  // Debe leer 0xAAAABBBB
        ra2 = 2;  // Debe leer 0x12345678
        #1;
        $display("  Lectura combinacional: rd1=%h (reg[1]), rd2=%h (reg[2])", rd1, rd2);
        #9;

        // TEST 4: Escritura deshabilitada, lectura de reg[5] y reg[0]
        $display("\nTEST 4: Sin escritura, lectura de reg[5] y reg[0]");
        we3 = 0;
        ra1 = 5;  // Debe leer 0xDEADBEEF
        ra2 = 0;  // Debe leer 0
        #1;
        $display("  Lectura combinacional: rd1=%h (reg[5]), rd2=%h (reg[0])", rd1, rd2);
        #9;

        // TEST 5: Cambio inmediato de direcciones de lectura (combinacional)
        $display("\nTEST 5: Cambio rapido de direcciones de lectura");
        ra1 = 1; ra2 = 2;
        #1;
        $display("  t=1ns: rd1=%h (reg[1]), rd2=%h (reg[2])", rd1, rd2);
        ra1 = 5; ra2 = 1;
        #1;
        $display("  t=2ns: rd1=%h (reg[5]), rd2=%h (reg[1])", rd1, rd2);
        ra1 = 2; ra2 = 5;
        #1;
        $display("  t=3ns: rd1=%h (reg[2]), rd2=%h (reg[5])", rd1, rd2);
        #7;

        $display("\n=== Simulacion completada ===");
        $finish;
    end
endmodule