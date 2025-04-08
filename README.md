# Computer_Architecture_Lab

## RV32I Instruction Set

## Instruction Format 

### R-Format
| 31–25  | 24–20 | 19–15 |  14–12 | 11–7 |  6–0   | 
| funct7 |  rs2  |  rs1  | funct3 |  rd  | opcode |

### I-Format 
|    31-20   | 19-15 | 14-12 | 11-7 |  6-0   | 
|  imm[11:0] |  rs1  | func3 |  rd  | opcode |

### B-Format    
|  31   |  30–25  | 24–20 | 19–15 | 14–12 |  11–8  |   7   | 6–0  | 
|imm[12]|imm[10:5]|  rs2  |  rs1  |funct3 |imm[4:1]|imm[11]|opcode|

### S-Format
| 31–25     | 24–20 | 19–15 | 14–12  |   11–7   |   6–0   | 
| imm[11:5] | rs2   | rs1   | funct3 | imm[4:0] | opcode  |

### U-Format
|   31–12    | 11–7 |  6–0   |
| imm[31:12] |  rd  | opcode |

### J-Format
|    31   |   30–21   |    20   |    19–12   | 11–7 |   6–0   | 
| imm[20] | imm[10:1] | imm[11] | imm[19:12] |  rd  | opcode  |

## Datapath

## Immediate Generator

## Branch comparator
