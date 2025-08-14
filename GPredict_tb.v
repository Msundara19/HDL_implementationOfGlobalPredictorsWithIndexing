timescale 1ns/1ps
module gpredict_tb;
 // clock & reset
 reg clk = 1'b0;
 reg reset_n = 1'b0;
 // DUT inputs
 reg [7:0] pc;
 reg actual_taken;
 // DUT outputs
 wire pred_taken;
 wire [31:0] mispredict_count;
 // instantiate the predictor
 gpredict uut (
 .clk(clk),
 .reset_n(reset_n),
 .pc(pc),
 .actual_taken(actual_taken),
 .pred_taken(pred_taken),
 .mispredict_count(mispredict_count)
 );
 // clock generator: 10 ns period
 always #5 clk = ~clk;
 // apply reset
 initial begin
 #1 reset_n = 1'b0;
 #20 reset_n = 1'b1;
 end
 // file I/O
 integer fh;
 integer r;
 integer tmp_pc;
 reg [7:0] ch;
 initial begin
 // open the sequence file
 fh = $fopen("branch_seq.txt", "r");
 if (fh == 0) begin
 $display("ERROR: Cannot open branch_seq.txt");
 $finish;
 end