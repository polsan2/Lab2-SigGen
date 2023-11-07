module sinegen #(
    parameter WIDTH = 8
)(
    input logic             clk,
    input logic             en,
    input logic             rst,
    input logic [WIDTH-1:0] incr,
    input logic [WIDTH-1:0] offset,
    output logic [WIDTH-1:0] dout1,
    output logic [WIDTH-1:0] dout2

);

    logic [WIDTH-1:0]       address1; //interconnecting wire
    logic [WIDTH-1:0]       address2; //interconnecting wire that is going to be offseted

    always_ff @ (posedge clk)
        address2 <= address1 + offset;

counter myCounter (
    .clk(clk),
    .en(en),
    .rst(rst),
    .incr(incr),
    .count(address1)
);

rom myRom (
    .clk(clk),
    .addr1(address1),
    .dout1(dout1),
    .addr2(address2),
    .dout2(dout2)
);
endmodule
