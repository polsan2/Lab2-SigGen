module sinegen #(
    parameter WIDTH = 8
)(
    input logic             clk,
    input logic             en,
    input logic             rst,
    input logic [WIDTH-1:0] incr,
    output logic [WIDTH-1:0] dout
);

    logic [WIDTH-1:0]       adress; //interconnecting wire

counter myCounter (
    .clk(clk),
    .en(en),
    .rst(rst),
    .incr(incr),
    .count(adress)
);

rom myRom (
    .clk(clk),
    .addr(adress),
    .dout(dout)
);
endmodule
