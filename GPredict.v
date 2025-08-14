`timescale 1ns/1ps
module gpredict (
 input clk,
 input reset_n, // active-low reset
 input [7:0] pc, // branch PC
 input actual_taken, // 1 = taken, 0 = not taken
 output reg pred_taken, // 1 = predict taken
 output reg [31:0] mispredict_count
);
 // 4-bit Global History Register (not used for indexing here)
 reg [3:0] ghr;
 // 16 entries of 2-bit saturating counters
 reg [1:0] bht [0:15];
 integer i;
 reg [3:0] idx;
 // on posedge clk or negedge reset
 always @(posedge clk or negedge reset_n) begin
 if (!reset_n) begin
 // initialize on reset
 ghr <= 4'b0000;
 mispredict_count <= 32'd0;
 pred_taken <= 1'b0;
 for (i = 0; i < 16; i = i + 1)
 bht[i] <= 2'b01; // weakly not-taken
 end
 else begin
// compute index
 idx = pc[3:0];
 // prediction = MSB of counter
 pred_taken <= bht[idx][1];
 // count a mispredict if prediction actual
 if (bht[idx][1] != actual_taken)
 mispredict_count <= mispredict_count + 1;
 // update saturating counter
 if (actual_taken) begin
 if (bht[idx] != 2'b11)
 bht[idx] <= bht[idx] + 1;
 end else begin
 if (bht[idx] != 2'b00)
 bht[idx] <= bht[idx] - 1;
 end
 // shift GHR (not used for gpredict, but kept for consistency)
 ghr <= {ghr[2:0], actual_taken};
end
 end
endmodule