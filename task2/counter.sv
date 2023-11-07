module counter #(
    parameter WIDTH = 8
)(
    //interface signals 
    input logic             clk,        //clock
    input logic             rst,        //reset
    input logic             en,         //counter enable
    input logic [WIDTH-1:0] incr,
    output logic [WIDTH-1:0] count      //count ouput
);

always_ff @ (posedge clk) begin
    if(rst) count <= {WIDTH{1'b0}};
    if(en)    count <= count + incr;
    end
endmodule
