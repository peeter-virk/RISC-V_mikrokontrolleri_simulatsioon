# Replace with path to local compilation tools
# Asendage kohalike kompileerimistööriistade asukohaga
RISCV_AS = /opt/riscv/riscv32-unknown-elf/bin/as
RISCV_CC = /opt/riscv/bin/riscv32-unknown-elf-gcc
RISCV_CPP = /opt/riscv/bin/riscv32-unknown-elf-g++
RISCV_OBJCOPY = /opt/riscv/riscv32-unknown-elf/bin/objcopy
RISCV_OBJDUMP = /opt/riscv/riscv32-unknown-elf/bin/objdump
RISCV_LD = /opt/riscv/riscv32-unknown-elf/bin/ld

# File extensions
# Faililaiendid
OBJEXT := .o
BINEXT := .bin
ELFEXT := .elf
DUMPEXT := .dump

# Directories
# Kaustad
BUILD_DIR := build
SRC_DIRS := src

# Program name
# Programmi nimi
PROGRAM_NAME ?= tarkvara

OPT_LEVEL =  -Os
ARCHITECTURE_TYPE = rv32im

# Linker script
# Linker skript
LINKER_SCRIPT = linker.ld

# Target files
# Sihtfailid
TEXT_TARGET := $(BUILD_DIR)/$(PROGRAM_NAME)_text$(BINEXT)
DATA_TARGET := $(BUILD_DIR)/$(PROGRAM_NAME)_data$(BINEXT)

# Finds all ASM files
# Leiab kõik assembli failid
SRC_ASM := $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.S))
SRC_C := $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.c))
SRC_CPP := $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.cpp))

# Object file
# Objekti fail
OBJ_ASM := $(patsubst $(SRC_DIRS)/%.S, $(BUILD_DIR)/%.o, $(SRC_ASM))
OBJ_C := $(patsubst $(SRC_DIRS)/%.c, $(BUILD_DIR)/%.o, $(SRC_C))
OBJ_CPP := $(patsubst $(SRC_DIRS)/%.cpp, $(BUILD_DIR)/%.o, $(SRC_CPP))

# Final ELF
FINAL_ELF := $(BUILD_DIR)/$(PROGRAM_NAME)$(ELFEXT)

# Phony targets
.PHONY: all clean disassemble debug

# Default target
all: $(TEXT_TARGET) $(DATA_TARGET) $(OBJ_C)

# Compile C files into object files
$(BUILD_DIR)/%.o: $(SRC_DIRS)/%.c | $(BUILD_DIR)
	$(info Compiling $< to $@)
	$(RISCV_CC) -c -o $@ -march=$(ARCHITECTURE_TYPE) -mabi=ilp32 -mno-strict-align $(OPT_LEVEL) $<

# Compile CPP files into object files
$(BUILD_DIR)/%.o: $(SRC_DIRS)/%.cpp | $(BUILD_DIR)
	$(info Compiling $< to $@)
	$(RISCV_CPP) -c -o $@ -march=$(ARCHITECTURE_TYPE) -mabi=ilp32 -mno-strict-align $(OPT_LEVEL) $<

# Assemble assembly files
$(BUILD_DIR)/%.o: $(SRC_DIRS)/%.S | $(BUILD_DIR)
	$(RISCV_AS) -o $@ --gdwarf-2 -march=$(ARCHITECTURE_TYPE) $^

# Link all sections into a single ELF file
$(FINAL_ELF): $(OBJ_ASM) $(OBJ_C) $(OBJ_CPP) | $(BUILD_DIR)
	$(RISCV_LD) -nostdlib -T $(LINKER_SCRIPT) $^ -o $@ -e _start


# Extract text and data sections
$(TEXT_TARGET): $(FINAL_ELF)
	$(RISCV_OBJCOPY) -O binary -j .text $< $@

$(DATA_TARGET): $(FINAL_ELF)
	$(RISCV_OBJCOPY) -O binary -j .data $< $@

# Generate disassembly for debugging
disassemble: $(FINAL_ELF)
	$(RISCV_OBJDUMP) -D $< > $(BUILD_DIR)/$(PROGRAM_NAME)$(DUMPEXT)

clean:
	rm -rf $(BUILD_DIR)

debug:
	$(info SRC_C = $(SRC_C))
	$(info SRC_CPP = $(SRC_CPP))
	$(info OBJ_C = $(OBJ_C))
	$(info OBJ_CPP = $(OBJ_CPP))
	$(RISCV_CC) -c -o build/bubble.o -march=$(ARCHITECTURE_TYPE) -mabi=ilp32 src/bubble.c

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
