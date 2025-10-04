module tap_test #(
    parameter WIDTH_1 = 32;
    parameter WIDTH_2 = 16;
)(
    input logic clk,
    input logic rst_n,
    input logic [WIDTH_1-1:0] in_data1,
    input logic [WIDTH_2-1:0] in_data2,
    output logic [WIDTH_1-1+8:0] out_data1,
    output logic [WIDTH_2-1+8:0] out_data2
);
    always @(posedge clk or negedge rst_n) begin
        
    end
    
endmodule