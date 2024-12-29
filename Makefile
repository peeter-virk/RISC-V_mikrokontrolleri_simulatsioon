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

# remenents of older versions of the makefile
#STARTUP_FILE := src/startup.S
#STARTUP_OBJ := $(BUILD_DIR)/startup$(OBJEXT)


# Target files
# Sihtfailid
TEXT_TARGET := $(BUILD_DIR)/$(PROGRAM_NAME)_text
DATA_TARGET := $(BUILD_DIR)/$(PROGRAM_NAME)_data


# Finds all ASM files
# Leiab kõik assembli failid
SRC_FILES := $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.S))

# Object file
# Objekti fail
OBJ_FILE := $(BUILD_DIR)/$(PROGRAM_NAME)$(OBJEXT)

# Final binary
FINAL_BINARY := $(BUILD_DIR)/$(PROGRAM_NAME)$(BINEXT)


# Phony targets
.PHONY: all clean disassemble


# Default target
all: $(FINAL_BINARY)

# Assemble the startup file first
$(STARTUP_OBJ): $(STARTUP_FILE) | $(BUILD_DIR)
	$(RISCV_AS) -o $@ --gdwarf-2 -march=rv32i $<

# Assemble all source files into a single object file
$(OBJ_FILE): $(SRC_FILES) | $(BUILD_DIR)
	$(RISCV_AS) -o $@ --gdwarf-2 -march=rv32i $^

# Link all sections into a single ELF file and generate a final binary
$(FINAL_BINARY): $(OBJ_FILE) $(LINKER_SCRIPT)
	$(RISCV_LD) -nostdlib -T $(LINKER_SCRIPT) $(OBJ_FILE) -o $(BUILD_DIR)/$(PROGRAM_NAME)$(ELFEXT)
	$(RISCV_OBJCOPY) -O binary $(BUILD_DIR)/$(PROGRAM_NAME)$(ELFEXT) $@


# Generate disassembly for debugging
disassemble: $(OBJ_FILE)
	$(RISCV_OBJDUMP) -d $(OBJ_FILE) > $(BUILD_DIR)/$(PROGRAM_NAME)$(DUMPEXT)

clean:
	rm -rf $(BUILD_DIR)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)
