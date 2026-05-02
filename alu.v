module alu (
    input [7:0] a, b,
    input [2:0] sel,
    output reg [7:0] result,
    output reg carry,
    output reg zero,
    output reg negative,
    output reg overflow
);

always @(*) begin
    // Default values
    carry = 0;
    overflow = 0;

    case(sel)

        // ADD
        3'b000: begin
            {carry, result} = a + b;
            overflow = (a[7] == b[7]) && (result[7] != a[7]);
        end

        // SUB
        3'b001: begin
            {carry, result} = a - b;
            overflow = (a[7] != b[7]) && (result[7] != a[7]);
        end

        // AND
        3'b010: result = a & b;

        // OR
        3'b011: result = a | b;

        // XOR
        3'b100: result = a ^ b;

        // SHIFT LEFT
        3'b101: begin
            result = a << 1;
            carry = a[7];
        end

        // SHIFT RIGHT
        3'b110: begin
            result = a >> 1;
            carry = a[0];
        end

        default: result = 8'b00000000;

    endcase

    // FLAGS
    zero = (result == 8'b00000000);
    negative = result[7];

end

endmodule