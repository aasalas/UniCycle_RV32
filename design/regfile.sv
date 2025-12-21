//==============================================================================
// File        : regfile.sv
// Author      : Aarón Salas Alvarado
// Description : Archivo de 32 registros, lectura combinacional y escritura sincronica
// Date        : 2025-12-14
//==============================================================================

module regfile (
    input logic clk, we3,
    input logic [31:0] ra1, ra2, wa3, 
    input [31:0] wd3,
    output logic [31:0] rd1, rd2
);

    reg [31:0] regfile [31:0];

    // ESCRITURA SINCRONICA
    always_ff @(posedge clk)
        if(we3) regfile[wa3] = wd3;

    // LECTURA COMBINACIONAL
    assign rd1 = (ra1 != 0) ? regfile[ra1] : 0;
    assign rd2 = (ra2 != 0) ? regfile[ra2] : 0;

endmodule