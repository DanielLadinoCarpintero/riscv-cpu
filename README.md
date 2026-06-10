# RV32I RISC-V CPU
32-bit RV32I RISC-V processor written in SystemVerilog featuring a modular datapath, 5-stage pipeline skeleton, and self-checking verification environment using ModelSim.

---

## Status
✅ Completed Portfolio Version

Future enhancements include forwarding, hazard detection, branch flushing, assertions, and constrained-random verification.

---

## Features

### Implemented

- RV32I instruction support (subset)
- Modular datapath architecture
- Register file with x0 protection
- Program Counter (PC)
- Instruction Memory
- Data Memory
- Immediate Generator
- Control Unit
- ALU Control Unit
- Arithmetic Logic Unit (ALU)
- Self-checking verification testbenches
- Pipeline execution tracing
- 5-stage pipeline skeleton

### Future Enhancements

- Forwarding Unit
- Hazard Detection Unit
- Pipeline Stalling
- Branch Flushing
- SystemVerilog Assertions
- Functional Coverage
- Constrained-Random Verification
- FPGA Deployment

---

## Tools

- Quartus Prime
- ModelSim
- SystemVerilog
- Git/GitHub

---

# Development Log

### Day 1

- Implemented ALU
- Added self-checking ALU testbench

### Day 2

- Implemented RV32I register file
- Added self-checking register file testbench
- Implemented synchronous writes and combinational reads
- Added x0 protection logic

### Day 3

- Implemented Program Counter (PC)
- Added self-checking PC testbench
- Implemented instruction memory module
- Added instruction fetch verification testbench
- Loaded initial RV32I test instructions into memory

### Day 4

- Implemented RV32I control unit
- Added instruction decode logic
- Implemented immediate generator
- Added self-checking verification testbenches

### Day 5

- Implemented ALU control unit
- Added top-level CPU module
- Connected instruction fetch, decode, and execute stages
- Integrated single-cycle CPU datapath
- Executed first RV32I test program

### Day 6

- Implemented data memory module
- Added load/store support
- Integrated memory access into CPU datapath
- Added self-checking memory verification
- Verified memory subsystem functionality

### Day 7

- Implemented IF/ID pipeline register
- Added staged instruction transfer between fetch and decode
- Added self-checking IF/ID verification

### Day 8

- Implemented ID/EX pipeline register
- Added datapath and control signal propagation
- Separated decode and execute stages
- Added self-checking ID/EX verification

### Day 9

- Implemented EX/MEM pipeline register
- Added execute-to-memory stage separation
- Added self-checking EX/MEM verification

### Day 10

- Implemented MEM/WB pipeline register
- Completed 5-stage pipeline skeleton
- Added pipeline execution tracing and debug instrumentation
- Verified instruction flow through IF, ID, EX, MEM, and WB stages

---

## Current Architecture

### Initial Single-Cycle Datapath
![Single Cycle Datapath](docs/diagrams/single_cycle_datapath.jpg)

### Memory-Integrated Datapath
![Memory Integrated Datapath](docs/diagrams/single_cycle_cpu_with_memory.jpg)

### 5-Stage Pipeline Skeleton
![Pipeline Skeleton](docs/diagrams/pipeline_skeleton.jpg)

---

## Verification Waveforms

### ALU Testbench
![ALU Waveform](docs/waveforms/alu.jpg)

### Register File Testbench
![Register File Waveform](docs/waveforms/register.jpg)

### Program Counter Testbench
![PC Waveform](docs/waveforms/pc.jpg)

### Instruction Memory Testbench
![Instruction Memory Waveform](docs/waveforms/instr_mem.jpg)

### Immediate Generator Testbench
![IMM_GEN Waveform](docs/waveforms/imm_gen.jpg)

### Control Unit Testbench
![Control Unit Waveform](docs/waveforms/control_unit.jpg)

### Data Memory Testbench
![Data Memory Waveform](docs/waveforms/data_mem.jpg)

### CPU Execution
![CPU Execution](docs/waveforms/cpu.jpg)

---

## Repository Structure

```
rtl/
├── core/
├── control/
├── memory/
├── pipeline/

tb/
├── tests/

docs/
├── diagrams/
├── waveforms/
```

---

## Skills Demonstrated

- RTL Design
- SystemVerilog
- Computer Architecture
- CPU Datapath Design
- Pipeline Design
- Verification Methodology
- Testbench Development
- Waveform Analysis
- FPGA Development Workflow
- Git Version Control
- Hardware Debugging

---

## Resume Summary
Designed and verified a modular 32-bit RV32I RISC-V processor in SystemVerilog featuring instruction/data memory subsystems, self-checking ModelSim testbenches, and a 5-stage pipelined architecture skeleton.
