module counter #(
    parameter WIDTH = 8
)(
    //interface signals 
    input logic             clk,        //clock
    input logic             rst,        //reset
    output logic [WIDTH:0] count      //count ouput
);

always_ff @ (posedge clk) begin
    //$display(count);
    if(rst) count <= {(WIDTH+1){1'b0}};
    else    count <= count + {{WIDTH{1'b0}}, 1'b1};
end
endmodule
