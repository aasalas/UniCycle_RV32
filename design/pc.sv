// Program Counter: Registro de 32 bits para direcciones de instrucción
module pc (
    input  logic        clk,      // Reloj del sistema
    input  logic [31:0] pc_in,    // PC + 4 (nueva dirección)
    output logic [31:0] pc_out = '0  // PC (inicia en 0)
);
    // Actualiza PC en flanco positivo del reloj
    always_ff @(posedge clk) begin
        pc_out <= pc_in;
    end
endmodule