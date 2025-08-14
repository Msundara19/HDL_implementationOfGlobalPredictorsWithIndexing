# HDL_implementationOfGlobalPredictorsWithIndexing

 Implemented three dynamic branch predictors in Verilog:
  • GPredict: PC[3:0]-indexed 2-bit counters
  • GShare: PC[3:0] XOR 4-bit GHR
  • GSelect: {PC[1:0], GHR[1:0]} indexing
- Used 2-bit saturating counters and a 4-bit global history register
- Generated 6,000-branch synthetic “TTTT N” nested-loop trace via Python
- Simulated in ModelSim on a Linux-based ECE 586 lab server (Dasan) using shell/TCL scripts
- Results:
  • GPredict: 1,002 mispredictions (baseline, ~1 per loop iteration)
  • GShare: 1,007 mispredictions (history split between two PCs reduced accuracy)
  • GSelect: 1,005 mispredictions (2-bit history caused aliasing)
- Debugged Verilog-2001 compatibility issues (removed SystemVerilog `logic`/`always_ff`)
- Fixed testbench I/O mismatch (“NT” vs “N”) and automated waveform capture
- Insights:
  • History improves single-site loops but can hurt multi-site loops if not adaptive
  • GShare’s XOR works well for single-branch but suffers with history spread
  • GSelect’s fixed split can introduce aliasing
- Future work:
  • Use real traces (SPEC, MiBench)
  • Increase table/history size
  • Explore hybrid/tournament and TAGE predictors
  • Prototype on FPGA for real-world metrics
