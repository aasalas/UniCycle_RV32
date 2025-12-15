// Sumador PC+4: Incrementa dirección de PC en 4 bytes
module adder (
    input  logic [31:0] pc_in,   // Dirección actual
    output logic [31:0] pc_out   // Dirección + 4
);
    assign pc_out = pc_in + 4;   // Lógica combinacional
endmodule