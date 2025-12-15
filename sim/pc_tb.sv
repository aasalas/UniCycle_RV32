//==============================================================================
// File        : pc_tb.sv
// Author      : Aarón Salas Alvarado
// Description : Testbench para verificar PC + Adder (contador automático PC+4)
// Date        : 2025-12-14
//==============================================================================

module pc_tb;
    // Señales del testbench
    logic        clk;
    logic [31:0] pc_in, pc_out;
    
    // Generador de reloj: T=10ns, f=100MHz
    initial clk = 0;
    always #5 clk = ~clk;

    // Instancia del Program Counter
    pc pc_inst (
        .clk(clk),
        .pc_in(pc_in),
        .pc_out(pc_out)
    );

    // Instancia del sumador PC+4
    adder adder_inst (
        .pc_in(pc_out),
        .pc_out(pc_in)
    );

    // Estímulos y monitoreo
    initial begin
        // Configuración de waveforms
        $dumpfile("pc_tb.vcd");
        $dumpvars(0, pc_tb);
        
        // Monitoreo de 10 ciclos
        $display("PC: %0d", pc_out);  // Valor inicial (t=0)
        repeat (10) begin
            #10;
            $display("PC: %0d", pc_out);
        end

        $finish;
    end
endmodule