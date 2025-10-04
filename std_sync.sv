module std_sync #(
    parameter integer STAGES = 2
) (
    input  wire clk,
    input  wire arst_n, // asynchronous active-low reset
    input  wire din,
    output wire dout
);

    reg [STAGES-1:0] sync_reg;

    always @(posedge clk or negedge arst_n) begin
        if (!arst_n)
            sync_reg <= {STAGES{1'b0}};
        else
            sync_reg <= {sync_reg[STAGES-2:0], din};
    end

    assign dout = sync_reg[STAGES-1];

endmodule