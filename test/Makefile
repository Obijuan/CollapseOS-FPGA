TARGET = os.bin
ZASM = ./zasm.sh
KERNEL = ./

.PHONY: all
all: $(TARGET)
$(TARGET): serial-glue.asm
	$(ZASM) $(KERNEL) < $< > $@

clean:
	rm $(TARGET)
