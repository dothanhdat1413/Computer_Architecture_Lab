import os
import random

# ----------------- Utility Functions -----------------

# Chuyển giá trị Python int (có thể ngoài phạm vi 32-bit) về hex đúng định dạng 32-bit unsigned
def to_32bit_signed_hex(value):
    return f'{value & 0xFFFFFFFF:08X}'

# Ép một số bất kỳ về dạng signed 32-bit (giống như trong phần cứng)
def to_signed32(val):
    val = val & 0xFFFFFFFF
    return val if val < 0x80000000 else val - 0x100000000

# Sinh ngẫu nhiên số signed 32-bit
def generate_random_int():
    return random.randint(-2**31, 2**31 - 1)

# Phép toán tương thích RV32I
def add(a, b): return (to_signed32(a + b))
def sub(a, b): return (to_signed32(a - b))
def and_op(a, b): return a & b
def or_op(a, b): return a | b
def xor_op(a, b): return a ^ b
def shl(a, b): return (a << (b & 0x1F)) & 0xFFFFFFFF
def shr_logical(a, b): return (a & 0xFFFFFFFF) >> (b & 0x1F)
def shr_arith(a, b): return to_signed32(a) >> (b & 0x1F)
def slt(a, b): return 1 if to_signed32(a) < to_signed32(b) else 0

# Ghi file
def write_file(filename, values):
    with open(filename, 'w') as f:
        for val in values:
            f.write(to_32bit_signed_hex(val) + '\n')

# ----------------- Setup -----------------
num_cases = 1000
output_dir = "./input_data"
os.makedirs(output_dir, exist_ok=True)

def path(name):
    return os.path.join(output_dir, name)

# ----------------- Generate Operands -----------------
operand_0 = [generate_random_int() for _ in range(num_cases)]
operand_1 = [generate_random_int() for _ in range(num_cases)]

# ----------------- Write to Files -----------------
# ADD
write_file(path("ADD_OPERAND_0.txt"), operand_0)
write_file(path("ADD_OPERAND_1.txt"), operand_1)
write_file(path("ADD_RESULT.txt"), [add(a, b) for a, b in zip(operand_0, operand_1)])

# SUB
write_file(path("SUB_OPERAND_0.txt"), operand_0)
write_file(path("SUB_OPERAND_1.txt"), operand_1)
write_file(path("SUB_RESULT.txt"), [sub(a, b) for a, b in zip(operand_0, operand_1)])

# BITWISE
write_file(path("BITWISE_OPERAND_0.txt"), operand_0)
write_file(path("BITWISE_OPERAND_1.txt"), operand_1)
write_file(path("AND_RESULT.txt"), [and_op(a, b) for a, b in zip(operand_0, operand_1)])
write_file(path("OR_RESULT.txt"), [or_op(a, b) for a, b in zip(operand_0, operand_1)])
write_file(path("XOR_RESULT.txt"), [xor_op(a, b) for a, b in zip(operand_0, operand_1)])

# SHL (logical left shift)
write_file(path("SHL_LOGICAL_OPERAND_0.txt"), operand_0)
write_file(path("SHL_LOGICAL_OPERAND_1.txt"), operand_1)
write_file(path("SHL_LOGICAL_RESULT.txt"), [shl(a, b) for a, b in zip(operand_0, operand_1)])

# SHR logical
write_file(path("SHR_LOGICAL_OPERAND_0.txt"), operand_0)
write_file(path("SHR_LOGICAL_OPERAND_1.txt"), operand_1)
write_file(path("SHR_LOGICAL_RESULT.txt"), [shr_logical(a, b) for a, b in zip(operand_0, operand_1)])

# SHR arithmetic
write_file(path("SHR_ARITHMETIC_OPERAND_0.txt"), operand_0)
write_file(path("SHR_ARITHMETIC_OPERAND_1.txt"), operand_1)
write_file(path("SHR_ARITHMETIC_RESULT.txt"), [shr_arith(a, b) for a, b in zip(operand_0, operand_1)])

# SLT
write_file(path("LESS_THAN_OPERAND_0.txt"), operand_0)
write_file(path("LESS_THAN_OPERAND_1.txt"), operand_1)
write_file(path("LESS_THAN_RESULT.txt"), [slt(a, b) for a, b in zip(operand_0, operand_1)])

print("✅ Test data generation complete with 32-bit signed correctness.")
