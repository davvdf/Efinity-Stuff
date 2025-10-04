module tb();
    logic clk;
    logic rst_n;
    logic global_ping;
    logic [31:0] in_data;
    logic [39:0] out_data;

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 100MHz clock
    end

    // Reset generation
    initial begin
        rst_n = 0;
        #20;
        rst_n = 1;
    end

    // Global ping generation (for testing)
    initial begin
        global_ping = 0;
        #50;
        forever begin
            #100 global_ping = ~global_ping; // Toggle every 100 time units
        end
    end

    // Input data generation (for testing)
    initial begin
        in_data = 0;
        forever begin
            #10 in_data = in_data + 1; // Increment every 10 time units
        end
    end

    // Instantiate the tap_test module
    tap_test #(
        .WIDTH_1(32),
        .WIDTH_2(16),
        .TIMER_WIDTH(8)
    ) uut (
        .clk(clk),
        .rst_n(rst_n),
        .global_ping(global_ping),
        .in_data(in_data),
        .out_data(out_data)
    );

    // Monitor output data (for testing)
    initial begin
        $monitor("Time: %0t | in_data: %h | out_data: %h", $time, in_data, out_data);
    end
endmodule