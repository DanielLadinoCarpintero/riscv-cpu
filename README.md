# RV32I Pipelined RISC-V CPU

32-bit pipelined RV32I RISC-V processor written in SystemVerilog featuring forwarding, hazard detection, and a verification environment using ModelSim.

## Planned Features
- 5-stage pipeline
- Forwarding unit
- Hazard detection
- Branch handling
- Assertions
- Randomized testing
- Functional coverage

## Tools
- Quartus Prime
- ModelSim
- SystemVerilog
- Git/GitHub

---

### Day 1
- Implemented ALU and self-checking testbench

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
- Integrated single-cycle CPU datapath and executed first RV32I program

## RTL Architecture

![Single Cycle Datapath](docs/diagrams/single_cycle_datapath.jpg)

## Verification Waveforms

### ALU Testbench

![ALU Waveform](docs/waveforms/alu.jpg)

### Control Unit Testbench

![Control Unit Waveform](docs/waveforms/control_unit.jpg)

### CPU Execution

![CPU Execution](docs/waveforms/cpu.jpg)

### Immediate Generator Testbench

![IMM_GEN Waveform](docs/waveforms/imm_gen.jpg)

### Instruction Memory Testbench

![Instruction Memory Waveform](docs/waveforms/instr_mem.jpg)

### Program Counter Testbench

![PC Waveform](docs/waveforms/pc.jpg)

### Register File Testbench

![Register File Waveform](docs/waveforms/register.jpg)
