# Replace with path to local compilation tools
# Asendage kohalike kompileerimistööriistade asukohaga

RISCV_AS = /opt/riscv/riscv32-unknown-elf/bin/as
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

# Linker script
# Linker skript
LINKER_SCRIPT = linker.ld

# Target files
# Sihtfailid
TEXT_TARGET := $(BUILD_DIR)/$(PROGRAM_NAME)_text$(BINEXT)
DATA_TARGET := $(BUILD_DIR)/$(PROGRAM_NAME)_data$(BINEXT)

# Finds all ASM files
# Leiab kõik assembli failid
SRC_FILES := $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.S))

# Object file
# Objekti fail
OBJ_FILE := $(BUILD_DIR)/$(PROGRAM_NAME)$(OBJEXT)

# Final ELF
FINAL_ELF := $(BUILD_DIR)/$(PROGRAM_NAME)$(ELFEXT)

# Phony targets
.PHONY: all clean disassemble

# Default target
all: $(TEXT_TARGET) $(DATA_TARGET)

# Assemble all source files into a single object file
$(OBJ_FILE): $(SRC_FILES) | $(BUILD_DIR)
	$(RISCV_AS) -o $@ --gdwarf-2 -march=rv32i $^

# Link all sections into a single ELF file
$(FINAL_ELF): $(OBJ_FILE) $(LINKER_SCRIPT)
	$(RISCV_LD) -nostdlib -T $(LINKER_SCRIPT) $(OBJ_FILE) -o $@

# Extract text and data sections
$(TEXT_TARGET): $(FINAL_ELF)
	$(RISCV_OBJCOPY) -O binary -j .text $< $@

$(DATA_TARGET): $(FINAL_ELF)
	$(RISCV_OBJCOPY) -O binary -j .data $< $@

# Generate disassembly for debugging
disassemble: $(FINAL_ELF)
	$(RISCV_OBJDUMP) -d $< > $(BUILD_DIR)/$(PROGRAM_NAME)$(DUMPEXT)

clean:
	rm -rf $(BUILD_DIR)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
