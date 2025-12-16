module imem (
    input logic [31:0] pc_in,
    output logic [31:0] instruction
);
    logic [31:0] imem [0:63]; // Memoria de instrucciones de 64 palabras

    always_comb begin
        instruction = imem[pc_in[7:2]]; // Acceso a memoria usando bits [7:2] de pc_in
    end

    initial begin
        // Cargar instrucciones desde un archivo (formato hexadecimal)
        $readmemh("instructions.mem", imem);
    end
endmodule