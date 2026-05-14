// HDL placeholder for a streaming remote-sensing quality-mask filter.
// This is a conceptual scaffold only.

module quality_mask_filter (
    input wire clk,
    input wire rst,
    input wire valid_in,
    input wire cloud_mask,
    input wire shadow_mask,
    input wire invalid_retrieval,
    output reg valid_out,
    output reg quality_pass
);

always @(posedge clk) begin
    if (rst) begin
        valid_out <= 1'b0;
        quality_pass <= 1'b0;
    end else begin
        valid_out <= valid_in;
        quality_pass <= valid_in && !cloud_mask && !shadow_mask && !invalid_retrieval;
    end
end

endmodule
