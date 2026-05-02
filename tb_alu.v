`timescale 1ns/1ps

module tb_alu;

reg [7:0] a, b;
reg [2:0] sel;

wire [7:0] result;
wire carry, zero, negative, overflow;

// Instantiate ALU
alu uut (
    .a(a),
    .b(b),
    .sel(sel),
    .result(result),
    .carry(carry),
    .zero(zero),
    .negative(negative),
    .overflow(overflow)
);

initial begin
    $monitor("Time=%0t | sel=%b | a=%d b=%d | result=%d | C=%b Z=%b N=%b V=%b",
              $time, sel, a, b, result, carry, zero, negative, overflow);

    // ================= BASIC OPERATIONS =================
    a = 10; b = 5;

    sel = 3'b000; #100; // ADD
    sel = 3'b001; #100; // SUB
    sel = 3'b010; #100; // AND
    sel = 3'b011; #100; // OR
    sel = 3'b100; #100; // XOR
    sel = 3'b101; #100; // SHIFT LEFT
    sel = 3'b110; #100; // SHIFT RIGHT

    // ================= EDGE CASE TESTING =================

    // 🔴 Overflow case (signed)
    a = 127; b = 1;     // 127 + 1 = -128 (overflow)
    sel = 3'b000; #100;

    // 🔴 Carry case (unsigned)
    a = 255; b = 1;     // 255 + 1 = 0 with carry
    sel = 3'b000; #100;

    // 🔴 Negative result
    a = 5; b = 10;
    sel = 3'b001; #100; // SUB → negative result

    // 🔴 Zero result
    a = 5; b = 5;
    sel = 3'b001; #100; // 5 - 5 = 0

    $finish;
end

endmodule