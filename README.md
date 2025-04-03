# RISC-V-Pipeline-Architecture
This project implements a RISC-V processor with a pipeline architecture that supports arithmetic, store, and load instructions. It effectively manages structural and data hazards to optimize execution.  

### 5-Stage Pipeline Implementation
The processor follows five-stage pipeline architecture, improving instruction throughput and minimizing execution time. The stages include:  
**Instruction Fetch (IF):** Fetches the instruction from memory.  
**Instruction Decode (ID):** Decodes the instruction and reads necessary registers.  
**Execute (EX):** Performs arithmetic and logic operations.  
**Memory Access (MEM):** Accesses memory for load/store operations.  
**Write Back (WB):** Writes the computed results back to the register file.  

### Support for Arithmetic, Store, and Load Instructions
This processor supports:  
**Arithmetic operations:** Addition, subtraction, and logical operations like AND and OR.  
**Load operations:** Loading data from memory into registers.  
**Store operations:** Writing register data back to memory.  
