# 4-Stage Pipelined Processor Project

This project focuses on designing, implementing, and simulating a **4-stage pipelined processor** using **VHDL** and **ModelSim**. The processor is designed to demonstrate the flow of instructions through a pipelined architecture, ensuring efficient execution while maintaining correctness.

---

## Project Overview

The primary goals of this project are:

- Design a 4-stage pipelined processor using VHDL.
- Simulate the processor in ModelSim to verify functional correctness.
- Analyze the processor's **data path** and **control logic** using RTL diagrams.
- Document and validate each pipeline stage to ensure proper instruction execution.

The project is structured into the following components:

1. **Design Implementation** – Developing the VHDL code for the processor stages.
2. **Simulation** – Using ModelSim to compile, run, and verify the VHDL design.
3. **Documentation** – Detailed explanation of each pipeline stage, data path, and control logic.

---

## Pipeline Stages

The processor consists of 4 main stages:

| Stage | Name | Description |
|-------|------|-------------|
| 1 | **Instruction Fetch (IF)** | Fetches instructions from memory. |
| 2 | **Instruction Decode (ID)** | Decodes instructions and reads registers. |
| 3 | **Execute (EX)** | Performs arithmetic, logic, or memory address computation. |
| 4 | **Write Back (WB)** | Writes results back to the register file. |

Each stage is carefully designed and simulated to ensure correct pipeline behavior, including proper handling of data hazards and control signals.

### Pipeline Flow Diagram

```
Clock Cycle →    1      2      3      4      5      6
Instruction 1:  [IF]   [ID]   [EX]   [WB]
Instruction 2:         [IF]   [ID]   [EX]   [WB]
Instruction 3:                [IF]   [ID]   [EX]   [WB]
```

---

## Installation Instructions

### Prerequisites

- [ModelSim](https://www.intel.com/content/www/us/en/software/programmable/quartus-prime/model-sim.html) (Intel or Mentor Graphics edition)
- Git

### Steps

1. Clone the repository:

```bash
git clone https://github.com/mariamqiix/red.git
```

2. Navigate to the project directory:

```bash
cd red
```

3. Open the project in ModelSim for simulation.

---

## Usage Instructions

### Example 1: Simulate the Processor

1. Open the project in ModelSim.
2. Compile all VHDL files:

```bash
vcom *.vhd
```

3. Run the simulation:

```bash
vsim tb_processor
run -all
```

4. Observe the RTL and waveform outputs to ensure correctness.

### Example 2: Analyze Data Flow

1. Use the RTL viewer in ModelSim to examine how data moves between registers.
2. Verify that control signals are correctly activating each pipeline stage.
3. Adjust test benches as needed to validate different instruction sequences.



---

## Tools Used

| Tool | Purpose |
|------|---------|
| **VHDL** | Hardware description and design implementation |
| **ModelSim** | Compiling, simulating, and debugging the VHDL design |

---

## Project Outcomes

By completing this project, you will have:

- A fully functional 4-stage pipelined processor implemented in VHDL.
- Simulation results verifying correct execution of instructions.
- RTL representations of the processor demonstrating data flow and control logic.
- Practical understanding of pipeline hazard handling and control signal management.

---

## License

This project is open source and available under the [MIT License](LICENSE).
