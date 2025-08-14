timescale 1ns/1ps
module gshare_tb;
 reg clk = 0;
 reg reset_n = 0;
 reg [7:0] pc;
 reg actual_taken;
 wire pred_taken;
 wire [31:0] mispredict_count;
 gshare uut (
 .clk(clk),
 .reset_n(reset_n),
 .pc(pc),
 .actual_taken(actual_taken),
 .pred_taken(pred_taken),
 .mispredict_count(mispredict_count)
 );
 always #5 clk = ~clk;
 initial begin
 #1 reset_n = 0;
 #20 reset_n = 1;
 end
 integer fh, r;
 integer tmp_pc;
 reg [8*1-1:0] ch;
 initial begin
 fh = $fopen("branch_seq.txt","r");
 if (fh == 0) begin
 $display("ERROR: Cannot open branch_seq.txt");
 $finish;
 end
 @(posedge reset_n);
 while (!$feof(fh)) begin
 r = $fscanf(fh, "%h %c\n", tmp_pc, ch);
 pc = tmp_pc[7:0];
 actual_taken = (ch == "T");
 @(posedge clk);
 end
 #10;
 $display("\n=== GSHARE mispredicts = %0d ===\n", mispredict_count);
 $dumpfile("gshare.vcd");
 $dumpvars(0, gshare_tb);
 $fclose(fh);
 $finish;