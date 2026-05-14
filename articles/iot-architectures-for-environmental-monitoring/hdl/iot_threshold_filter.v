// HDL placeholder for an environmental IoT threshold and quality filter.
module iot_threshold_filter (
    input wire clk,
    input wire rst,
    input wire valid_in,
    input wire [15:0] value_in,
    input wire [15:0] min_allowed,
    input wire [15:0] max_allowed,
    output reg valid_out,
    output reg quality_pass,
    output reg threshold_high
);
always @(posedge clk) begin
    if (rst) begin
        valid_out <= 1'b0;
        quality_pass <= 1'b0;
        threshold_high <= 1'b0;
    end else begin
        valid_out <= valid_in;
        quality_pass <= valid_in && (value_in >= min_allowed) && (value_in <= max_allowed);
        threshold_high <= valid_in && (value_in > max_allowed);
    end
end
endmodule
