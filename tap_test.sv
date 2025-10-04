//attach module to every module that creates a data point that needs to be synced to global ping
module tap_test #(
    parameter WIDTH_1 = 32;
    parameter WIDTH_2 = 16;
    parameter TIMER_WIDTH = 8;
)(
    //module might incur synchronization latency, might need handle from algo side?
    input logic clk,
    input logic rst_n,
    //global ping can be on different clock than clk, must be the slowest frequency clock in the system
    input logic global_ping,
    input logic [WIDTH_1-1:0] in_data,
    output logic [WIDTH_1-1+TIMER_WIDTH:0] out_data,
);
    //sync global ping to clk domain
    logic sync_global_ping;
    std_sync #(
        .STAGES(2)
    ) u_std_sync (
        .clk(clk),
        .arst_n(rst_n),
        .din(global_ping),
        .dout(sync_global_ping)
    );
    logic [TIMER_WIDTH-1:0] counter;
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= '0;
        end else begin
            counter <= counter + 1'b1;
        end
    end
    //attach counter to in_data when sync_global_ping is high
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            out_data <= '0;
        end else if (sync_global_ping) begin
            out_data <= {in_data, counter};
        end
    end
    
endmodule