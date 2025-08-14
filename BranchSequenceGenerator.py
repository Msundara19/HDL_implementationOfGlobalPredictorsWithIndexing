##Python script to generate the branch sequence
#!/usr/bin/env python3
import argparse
def main():
 p = argparse.ArgumentParser(
 description="Generate nestedloop branch sequence")
 p.add_argument("--inner-pc", type=lambda x: int(x, 0),
 required=True, help="Innerloop branch PC (hex or dec)")
 p.add_argument("--outer-pc", type=lambda x: int(x, 0),
 required=True, help="Outerloop branch PC (hex or dec)")
 p.add_argument("--inner-count", type=int, default=5,
 help="Iterations of inner loop (default 5)")
 p.add_argument("--outer-count", type=int, default=1000)