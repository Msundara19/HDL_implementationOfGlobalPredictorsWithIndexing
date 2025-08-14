timescale 1ns/1ps
//======================================================
// gselect.v
// 4bit GSelect predictor using {PC[1:0], GHR[1:0]}
//======================================================
module gselect (
 input clk,
 input reset_n,
 input [7:0] pc,
 input actual_taken,
 output reg pred_taken,
 output reg [31:0] mispredict_count
);
 reg [3:0] ghr;
 reg [1:0] bht [0:15];
 integer i;
 reg [3:0] idx;
 always @(posedge clk or negedge reset_n) begin
 if (!reset_n) begin
 ghr <= 4'b0000;
 mispredict_count <= 0;
 pred_taken <= 0;
 for (i = 0; i < 16; i = i + 1)
 bht[i] <= 2'b01;
 end else begin
 idx = { pc[1:0], ghr[1:0] };
 pred_taken <= bht[idx][1];
 if (bht[idx][1] != actual_taken)
 mispredict_count <= mispredict_count + 1;
if (actual_taken) begin
 if (bht[idx] != 2'b11)
 bht[idx] <= bht[idx] + 1;
 end else begin
 if (bht[idx] != 2'b00)
 bht[idx] <= bht[idx] - 1;
 end
 ghr <= {ghr[2:0], actual_taken};
 end
 end
endmodule