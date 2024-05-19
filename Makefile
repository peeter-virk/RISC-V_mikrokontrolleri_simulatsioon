# Replace with path to local compilation tools
# Asendage kohalike kompileerimistööriistade asukohaga

RISCV_AS = /opt/riscv/riscv32-unknown-elf/bin/as
RISCV_OBJCOPY = /opt/riscv/riscv32-unknown-elf/bin/objcopy
RISCV_OBJDUMP = /opt/riscv/riscv32-unknown-elf/bin/objdump
RISCV_LD = /opt/riscv/riscv32-unknown-elf/bin/ld


OBJEXT := .o

BINEXT := .bin

LINKER_SCRIPT = linker_script.ld


BUILD_DIR := build

PROGRAM_NAME ?= tarkvara


TEXT_TARGET := $(PROGRAM_NAME)_text$(BINEXT)
DATA_TARGET := $(PROGRAM_NAME)_data$(BINEXT)

SRC_DIRS := src

# Leiab kõik assembli failid
# Finds all ASM files
SRC_FILES := $(foreach dir,$(SRC_DIRS),$(wildcard $(dir)/*.S))

KEEP_OBJECTS ?= yes
TEXT_OBJ_FILE := $(BUILD_DIR)/$(PROGRAM_NAME)_text$(OBJEXT)
DATA_OBJ_FILE := $(BUILD_DIR)/$(PROGRAM_NAME)_data$(OBJEXT)


all: $(TEXT_TARGET) $(DATA_TARGET)


$(TEXT_OBJ_FILE): $(SRC_FILES) | $(BUILD_DIR)
	$(RISCV_AS) -o $(TEXT_OBJ_FILE) --gdwarf-2 -march=rv32i $^

$(DATA_OBJ_FILE): $(SRC_FILES) | $(BUILD_DIR)
	$(RISCV_AS) -o $(DATA_OBJ_FILE) --gdwarf-2 -march=rv32i $^


$(TEXT_TARGET): $(TEXT_OBJ_FILE) $(LINKER_SCRIPT)
	$(RISCV_LD) -nostdlib -T $(LINKER_SCRIPT) $(TEXT_OBJ_FILE) -o $(BUILD_DIR)/$(TEXT_TARGET).elf
	$(RISCV_OBJCOPY) -O binary --only-section=.text $(BUILD_DIR)/$(TEXT_TARGET).elf $(BUILD_DIR)/$(TEXT_TARGET)

$(DATA_TARGET): $(DATA_OBJ_FILE) $(LINKER_SCRIPT)
	$(RISCV_LD) -nostdlib -T $(LINKER_SCRIPT) $(DATA_OBJ_FILE) -o $(BUILD_DIR)/$(DATA_TARGET).elf
	$(RISCV_OBJCOPY) -O binary --only-section=.data $(BUILD_DIR)/$(DATA_TARGET).elf $(BUILD_DIR)/$(DATA_TARGET)


disassemble: $(TEXT_OBJ_FILE) $(DATA_OBJ_FILE)
	$(RISCV_OBJDUMP) -d $(TEXT_OBJ_FILE) > $(BUILD_DIR)/$(PROGRAM_NAME)_text.dump
	$(RISCV_OBJDUMP) -d $(DATA_OBJ_FILE) > $(BUILD_DIR)/$(PROGRAM_NAME)_data.dump

clean:
	rm -rf $(BUILD_DIR)

$(BUILD_DIR):
	mkdir -p $(BUILD_DIR)

.PHONY: all clean disassemble
