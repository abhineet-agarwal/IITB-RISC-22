# IITB-RISC-22: 16-bit Pipelined RISC Processor

A fully functional 16-bit RISC CPU with a 6-stage pipeline implemented in VHDL as part of the EE309 (Microprocessors) course project at IIT Bombay.

## 📋 Project Overview

This project implements a complete 16-bit RISC (Reduced Instruction Set Computer) processor featuring a 6-stage pipeline architecture. The design includes comprehensive hazard detection, data forwarding mechanisms, and branch prediction to optimize performance.

**Course:** EE309 - Microprocessors (Spring 2024)
**Instructor:** Prof. Virendra Singh
**Institution:** Indian Institute of Technology Bombay

## 👥 Team Members (Team ID: 6)

- **Anshu Arora** (22B1207)
- **Sachi Deshmukh** (22B1213)
- **Abhineet Agarwal** (22B1219)
- **Garima Goplani** (22B3958)

## 🏗️ Architecture

### Pipeline Stages

The processor implements a classic 6-stage pipeline:

1. **IF (Instruction Fetch)** - Fetches instruction from memory and updates instruction pointer
2. **ID (Instruction Decode)** - Decodes the instruction and identifies operands
3. **RR (Register Read)** - Reads operands from the register file
4. **EX (Execute)** - Performs ALU operations
5. **MR (Memory Read/Write)** - Accesses data memory if needed
6. **WB (Write Back)** - Writes results back to register file

### Key Features

- **16-bit Data Path** - All operations and data transfers use 16-bit words
- **26 Instruction ISA** - Comprehensive instruction set covering arithmetic, logical, memory, and control flow operations
- **8 General Purpose Registers** - R0 through R7 for data storage
- **Hazard Detection & Resolution**
  - Data forwarding logic for consecutive and 2-step dependent instructions
  - Pipeline stall insertion when forwarding is not possible
- **Branch Prediction** - History-based branch prediction with FSM implementation
- **Multiple ALUs** - Dedicated ALU units for different pipeline stages
- **Pipeline Registers** - IR-ID, IR-RR, IR-EX, IR-MR, IR-WB for instruction flow

## 📝 Instruction Set Architecture (ISA)

The processor supports 26 instructions across multiple categories:

### Arithmetic Instructions
- **ADA, ADC, ADZ** - Add operations (unconditional, on carry, on zero)
- **AWC, ACA, ACC, ACZ, ACW** - Add with complement operations
- **ADI** - Add immediate

### Logical Instructions
- **NDU, NDC, NDZ** - NAND operations
- **NCU, NCC, NCZ** - NAND with complement operations

### Memory Instructions
- **LLI** - Load lower immediate
- **LW** - Load word from memory
- **SW** - Store word to memory
- **LM** - Load multiple registers
- **SM** - Store multiple registers

### Branch & Jump Instructions
- **BEQ** - Branch if equal
- **BLT** - Branch if less than
- **BLE** - Branch if less than or equal
- **JAL** - Jump and link
- **JLR** - Jump to location in register
- **JRI** - Jump to register indirect

## 🔧 Implementation Details

### Hazard Handling

#### Data Hazards
- **Data Forwarding**: Implements forwarding paths from EX and MR stages to RR stage
- **Consecutive Dependencies**: Direct forwarding from T3 (EX output) to T1/T2 (RR inputs)
- **Two-Step Dependencies**: Forwarding from T20 (MR output) to T1/T2

#### Control Hazards
- **Branch Prediction**: History bit-based prediction in ID stage
- **Branch Verification**: Comparison of predicted vs. actual branch target in EX stage
- **Pipeline Flush**: Invalidates 3 pipeline stages on misprediction by disabling write signals

### Memory Organization
- **Instruction Memory**: Stores program instructions
- **Data Memory**: Stores data for load/store operations
- **Register File**: 8 general-purpose 16-bit registers (R0-R7)
- **Special Registers**: Carry and Zero flags

### Control Unit
- Generates control signals based on instruction opcode
- Manages:
  - ALU operation selection
  - MUX controls for data path routing
  - Register write enables
  - Memory read/write signals

## 📁 File Structure

```
.
├── iitb_cpu.vhd              # Top-level CPU module
├── alu.vhd                   # Arithmetic Logic Unit
├── rf_file.vhd               # Register File
├── memory_unit.vhd           # Memory interface
├── register1.vhd             # Pipeline registers
├── sixteen_bit_*.vhd         # 16-bit arithmetic components
├── Mux*.vhd, Demux*.vhd      # Multiplexers and demultiplexers
├── sign_extend*.vhd          # Sign extension units
├── Gates.vhdl                # Basic logic gates
├── tb.vhd                    # Testbench
└── EE309- Report.pdf         # Detailed project report
```

## 🔬 Testing & Verification

The design has been thoroughly tested using:
- **RTL Simulation** - Functional verification of the VHDL code
- **Gate-Level Simulation** - Post-synthesis verification
- **Testbench** - Comprehensive test cases covering all instructions
- **Synthesis Check** - Verified synthesizability of the design

## 📊 Performance Characteristics

- **CPI (Cycles Per Instruction)**: Approaches 1 for straight-line code (ideal pipeline behavior)
- **Branch Misprediction Penalty**: 3 cycles (pipeline flush)
- **Data Hazard Stalls**: Minimized through forwarding; occasional 1-cycle stalls when forwarding unavailable

## 🛠️ Tools Used

- **HDL**: VHDL
- **Simulation**: ModelSim / Vivado Simulator
- **Synthesis**: Xilinx Vivado

## 📖 Documentation

For detailed information about:
- Individual instruction execution flow
- Control signal specifications
- Pipeline register contents
- Datapath diagrams
- RTL netlist

Please refer to the [Project Report](EE309-%20Report.pdf) included in this repository.

## 🎯 Learning Outcomes

This project provided hands-on experience with:
- Computer architecture design principles
- Pipelined processor implementation
- Hazard detection and resolution techniques
- HDL design and verification
- Digital system synthesis and optimization

## 📄 License

This project was completed as part of academic coursework at IIT Bombay.

## 🙏 Acknowledgments

We would like to thank Prof. Virendra Singh for his guidance throughout this project, and the EE309 teaching team for their support.

---

**Note**: This is an educational project demonstrating fundamental concepts in computer architecture and digital design.
