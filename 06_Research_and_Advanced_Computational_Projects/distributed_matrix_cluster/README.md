# 🔢 Distributed Matrix Computation Cluster

## Overview
A master–worker distributed computing prototype designed to parallelize large matrix operations across multiple worker processes. Built and tested in a Linux (WSL Ubuntu) environment to explore workload partitioning, inter-process/network communication, and parallel computation concepts.

## Project Structure
* **`master.py`**: Coordinator node responsible for partitioning input matrices into sub-blocks, dispatching tasks to workers, and aggregating partial results.
* **`worker.py`**: Compute node script that receives matrix sub-blocks, executes local numerical multiplication/computation, and returns results to the master node.

## Methodology & Concepts
* **Master–Worker Architecture:** Decouples task scheduling and data aggregation from parallel numerical execution.
* **Matrix Partitioning:** Decomposes matrix operations into independent sub-problems suitable for distributed execution.

## How to Run
Start one or more worker instances first, then launch the master coordinator (in separate terminal sessions):
```bash
# Terminal 1 (Worker Node)
python3 worker.py

# Terminal 2 (Master Coordinator)
python3 master.py
```
