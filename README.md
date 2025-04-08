# Computer_Architecture_Lab

## RV32I Instruction Set
![RV32I_Instruction_Set](./docs/images/RV32I_Instruction_Set.png)

### ALU Operation Table

| Operation Name         | Description                  | ALU Opcode  |
|------------------------|------------------------------|-------------|
| ADD                    | Addition                     | 4'b0000     |
| SUB                    | Subtraction                  | 4'b0001     |
| AND                    | Bitwise AND                  | 4'b0010     |
| OR                     | Bitwise OR                   | 4'b0011     |
| XOR                    | Bitwise XOR                  | 4'b0100     |
| SHL_LOGICAL            | Shift Left Logical           | 4'b0110     |
| SHR_LOGICAL            | Shift Right Logical          | 4'b0111     |
| SHR_ARITHMETIC         | Shift Right Arithmetic       | 4'b1000     |
| LESS_THAN              | Compare Less Than (Signed)   | 4'b1001     |


## Instruction Format 

### R-Format
```
| 31–25  | 24–20 | 19–15 |  14–12 | 11–7 |  6–0   |    
| funct7 |  rs2  |  rs1  | funct3 |  rd  | opcode |
```
### I-Format 
```
|    31-20   | 19-15 | 14-12 | 11-7 |  6-0   |   
|  imm[11:0] |  rs1  | func3 |  rd  | opcode |
```
### B-Format    
```
|  31   |  30–25  | 24–20 | 19–15 | 14–12 |  11–8  |   7   | 6–0  |   
|imm[12]|imm[10:5]|  rs2  |  rs1  |funct3 |imm[4:1]|imm[11]|opcode|
```
### S-Format
```
| 31–25     | 24–20 | 19–15 | 14–12  |   11–7   |   6–0   |   
| imm[11:5] | rs2   | rs1   | funct3 | imm[4:0] | opcode  |
```
### U-Format
```
|   31–12    | 11–7 |  6–0   |    
| imm[31:12] |  rd  | opcode |
```

### J-Format
```
|    31   |   30–21   |    20   |    19–12   | 11–7 |   6–0   |  
| imm[20] | imm[10:1] | imm[11] | imm[19:12] |  rd  | opcode  |
```
## Datapath

## Immediate Generator
### I-Format & S-Format
The immediate field is a 12-bit signed value.
The output immediate is formed by copying the most significant bit (bit 11) to fill the upper 20 bits (sign-extending):
```
imm[11:0] → {20{imm[11]}, imm[11:0]}
```
### B-Format & J-Format
The immediate field is a 12-bit signed value. But it encodes 13-bit signed offset. This is because RISC-V wants to support the possibility of 2-byte instruction, therefore the LSB bit is always 0.
The output immediate is formed by:
1. Appending 1'b0 to the right (shift-left by 1),
2. Then sign-extending from bit 12 to the upper 19 bits.
```
imm[12:1] → {19{imm[12]}, imm[12:1], 1'b0}
```
### U-Format
The immediate field is a 20-bit signed value. It represents the value of 20 MSB bit of the output immediate.
The output immediate is formed by filling '0s to the lower 12-bit.
```
imm[31:12] → {imm[31:12], 12'b0}
```
## Branch comparator
Input signal: 
1. BrUN
2. Operand_0
3. Operand_1
Output signal:
1. BrEq: = 1 when Operand_0 = Operand_1
2. BrLT: = 1 when Operand_0 < Operand_1. The unsigned/signed comparison is based on BrUn(1 for unsigned, 0 for signed) 
## Reference

RISC-V ISA Page: 
https://msyksphinz-self.github.io/riscv-isadoc/html/rvi.html#
