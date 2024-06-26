#!/bin/sh

cairo-native-dump example.cairo > example.mlir

mlir-opt example.mlir -convert-to-llvm -o example_llvm.mlir
mlir-translate -mlir-to-llvmir example_llvm.mlir -o example.ll

llc -march=riscv32 -mattr=+d -mcpu=generic-rv32 -filetype=asm example.ll -o example.s

riscv32-unknown-elf-as example.s -o example.o
riscv32-unknown-elf-ld example.o -o example.elf

# riscv64-unknown-elf-gcc -v example.s -o example -lc
