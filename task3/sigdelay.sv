module sigdelay  #(
    parameter   WIDTH = 8,
                ADDRESS_WIDTH = 9
)(
    //interface signals
    input logic                 clk,
    input logic                 rst,
    input logic [ADDRESS_WIDTH-1:0]     offset, //offset between read and write of RAM
    input logic                 wr, //write into ram enable
    input logic                 rd,
    input logic [WIDTH-1:0]     mic_signal,
    output logic [WIDTH-1:0]    delayed_signal
);

    logic [ADDRESS_WIDTH-1:0]             wire1;
    logic [ADDRESS_WIDTH-1:0]             wire2;

always_ff @ (posedge clk)
    wire2 <= wire1+offset;

counter #(9) myCounter (
    .clk(clk),
    .rst(rst),
    .count(wire1)
);

ram2ports #(9,8) myRam (
    .clk(clk),
    .wr(wr),
    .rd(rd),
    .wr_addr(wire1),
    .rd_addr(wire2),
    .din(mic_signal),
    .dout(delayed_signal)
);
endmodule
