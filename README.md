# 8-Bit CPU Design and Verification in SystemVerilog

An accumulator-based 8-bit CPU designed, implemented, and verified using SystemVerilog.

This project explores fundamental concepts in **digital logic design, computer architecture, sequential circuits, finite state machines (FSMs), and hardware verification**.

The CPU supports basic arithmetic operations, instruction decoding, program execution, and controlled halting.

## Project Highlights

- Designed a custom 8-bit accumulator-based CPU using SystemVerilog.
- Implemented an ALU, accumulator, Program Counter, instruction memory, and Control Unit.
- Developed a two-state execution controller using EXECUTE and WRITEBACK states.
- Supported four instructions: LDI, ADD, SUB, and HLT.
- Built six self-checking testbenches covering individual components and CPU integration.
- Successfully passed **32 verification checks** in simulation.

## CPU Architecture

The CPU consists of the following components:

| Component | Description |
|---|---|
| ALU | Performs arithmetic and logical operations using 8-bit operands. |
| Accumulator | Stores intermediate values and arithmetic results. |
| Program Counter | Tracks the current instruction address and supports increment, jump, and hold behavior. |
| Instruction Memory | Stores the program instructions executed by the CPU. |
| Control Unit | Decodes instruction opcodes and generates control signals. |
| CPU Top | Integrates the components and manages instruction execution. |

### Execution Process

The CPU uses a two-state finite state machine:

**1. EXECUTE**

The CPU decodes the current instruction and initiates the required operation.

**2. WRITEBACK**

The CPU stores the registered ALU result in the accumulator and advances execution as appropriate.

This separation accounts for the clocked behavior of the ALU and accumulator.

## Instruction Set

| Instruction | Operation |
|---|---|
| LDI | Load an immediate value into the accumulator |
| ADD | Add an immediate value to the accumulator |
| SUB | Subtract an immediate value from the accumulator |
| HLT | Halt CPU execution |

The current instruction format uses a 16-bit instruction containing an 8-bit opcode and an 8-bit operand.

## Example Program

The following program was used during CPU integration testing:

| Address | Instruction | Accumulator after execution |
|---|---|---|
| 0 | LDI 5 | 5 |
| 1 | ADD 3 | 8 |
| 2 | SUB 2 | 6 |
| 3 | HLT | 6 |

**Expected final state:**
- Accumulator: 6
- Program Counter: 3
- HALT signal: asserted

The integration test also verifies that the accumulator and Program Counter remain unchanged for additional clock cycles after HALT.

## Verification and Testing

A coordinated SystemVerilog test suite was developed to verify the individual hardware modules and integrated CPU.

| Testbench | Passing checks |
|---|---:|
| ALU | 13 |
| Accumulator | 4 |
| Program Counter | 4 |
| Instruction Memory | 3 |
| Control Unit | 4 |
| CPU Integration | 4 |
| **Total** | **32** |

**Result: 32/32 checks passed in the final simulation.**

The verification suite includes tests for arithmetic and logic operations, reset behavior, register loading and holding, instruction decoding, Program Counter control, and CPU halting.

These results demonstrate successful execution of the implemented test cases; they do not represent exhaustive verification of every possible CPU state or input.

## Repository Structure

```text
8-bit-cpu-systemverilog/
├── rtl/
│   ├── accumulator.sv
│   ├── alu.sv
│   ├── control_unit.sv
│   ├── cpu_top.sv
│   ├── instruction_memory.sv
│   └── program_counter.sv
├── tb/
│   └── testbench.sv
└── README.md
```

## Tools and Technologies

- **SystemVerilog:** RTL design and testbench development
- **EDA Playground:** HDL simulation environment
- **GitHub:** Source code organization and project documentation

## Running the Simulation

1. Open EDA Playground and select a simulator compatible with the SystemVerilog constructs used in this project.
2. Load the RTL modules from the `rtl/` directory into the design source.
3. Load `tb/testbench.sv` as the testbench source.
4. Set `cpu_test_suite` as the top-level simulation module.
5. Run the simulation and review the results.

The master test controller executes all six testbench sections sequentially and terminates the simulation after completion.

## Key Learning Outcomes

Through this project, I gained hands-on experience with:

- Designing and connecting modular digital hardware components.
- Implementing synchronous and asynchronous control behavior.
- Understanding clock timing and nonblocking assignments.
- Designing finite state machines for instruction execution.
- Debugging RTL simulation issues.
- Developing self-checking testbenches and verifying integrated hardware.

## Future Improvements

The next planned development milestone is upgrading the current 8-bit CPU architecture to a 32-bit data path.

Potential future extensions include:

- Additional instructions and arithmetic operations.
- A general-purpose register file.
- Expanded instruction encoding.
- Branching and more advanced control flow.
- More extensive automated verification.

## Project Status

**8-bit CPU: Completed and verified against the current test suite.**

**32-bit upgrade: Planned.**
