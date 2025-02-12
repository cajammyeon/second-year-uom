#include <cassert>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include "instructions.h"

// ========== InstructionBase ==========
void InstructionBase::execute(ProcessorState& state) const {
  // virtual call that implements the actual functionality of the instruction
  _execute(state);

  // move the pc forward
  state.pc += INSTRUCTION_SIZE;

  // trim the accumulator and the PC to fit in number of bits of the architecture
  state.acc &= ARCH_BITMASK;
  state.pc &= ARCH_BITMASK;
}

addr_t InstructionBase::get_address() const {
  return _address;
}

void InstructionBase::_set_address(addr_t address) {
  _address = address & ARCH_BITMASK;
}

std::string InstructionBase::to_string() const {
  
  std::string buffer;
  std::stringstream app;

  // Figure out what the instruction actually is based on the return value of name()
  // and then generate an appropriate instruction-specific string
  if (name() == "ADD") {
    app << name() << ": ACC <- ACC + [" << get_address() << "]";
    buffer = app.str();
  }
  else if (name() == "AND") {
    app << name() << ": ACC <- ACC & [" << get_address() << "]";
    buffer = app.str();
  }
  else if (name() == "ORR") {
    app << name() << ": ACC <- ACC | [" << get_address() << "]";
    buffer = app.str();
  }
  else if (name() == "XOR") {
    app << name() << ": ACC <- ACC ^ [" << get_address() << "]";
    buffer = app.str();
  } 
  else if (name() == "LDR") {
    app << name() << ": ACC <- [" << get_address() << "]";
    buffer = app.str();
  }
  else if (name() == "STR") {
    app << name() << ": ACC -> [" << get_address() << "]";
    buffer = app.str();
  }
  else if (name() == "JMP") {
    app << name() << ": PC  <- " << get_address();
    buffer = app.str();
  }
  else if (name() == "JNE") {
    app << name() << ": PC  <- " << get_address() << " if ACC != 0";
    buffer = app.str();
  }
  else
    // This should never happen unless we have an error in name() or one of the strncmp's above
    // i.e. the tests will never try to trigger this code
    assert(0);
  return buffer;
}

std::unique_ptr<InstructionBase> InstructionBase::generateInstruction(InstructionData data) {
  // create a new item and return its unique_pointer, through ownership transfer  
  switch (data.opcode) {
    case ADD :
      return std::move(std::make_unique<Iadd>(data.address));
      break;
    case AND :
      return std::move(std::make_unique<Iand>(data.address));
      break;
    case ORR :
      return std::move(std::make_unique<Iorr>(data.address));
      break;
    case XOR :
      return std::move(std::make_unique<Ixor>(data.address));
      break;
    case LDR :
      return std::move(std::make_unique<Ildr>(data.address));
      break;
    case STR :
      return std::move(std::make_unique<Istr>(data.address));
      break;
    case JMP :
      return std::move(std::make_unique<Ijmp>(data.address));
      break;
    case JNE :
      return std::move(std::make_unique<Ijne>(data.address));
      break;
    default :
      return nullptr;
  }
  return nullptr;
}

// ========== ADD Instruction ==========
Iadd::Iadd(addr_t address) {
  _set_address(address);
}

void Iadd::_execute(ProcessorState& state) const {
  state.acc += state.memory.at(get_address());
}

std::string Iadd::name() const {
  return "ADD";
}

// ========== AND Instruction ==========
Iand::Iand(addr_t address) {
  _set_address(address);
}

void Iand::_execute(ProcessorState& state) const {
  state.acc &= state.memory.at(get_address());
}

std::string Iand::name() const {
  return "AND";
}

// ========== ORR Instruction ==========
Iorr::Iorr(addr_t address) {
  _set_address(address);
}

void Iorr::_execute(ProcessorState& state) const {
  state.acc |= state.memory.at(get_address());
}

std::string Iorr::name() const {
  return "ORR";
}

// ========== XOR Instruction ==========
Ixor::Ixor(addr_t address) {
  _set_address(address);
}


void Ixor::_execute(ProcessorState& state) const {
  state.acc ^= state.memory.at(get_address());
}

std::string Ixor::name() const {
  return "XOR";
}

// ========== LDR Instruction ==========
Ildr::Ildr(addr_t address) {
  _set_address(address);
}

void Ildr::_execute(ProcessorState& state) const {
  state.acc = state.memory.at(get_address());
}

std::string Ildr::name() const {
  return "LDR";
}

// ========== STR Instruction ==========
Istr::Istr(addr_t address) {
  _set_address(address);
}

void Istr::_execute(ProcessorState& state) const {
  state.memory.at(get_address()) = state.acc;
}

std::string Istr::name() const {
  return "STR";
}

// ========== JMP Instruction ==========
Ijmp::Ijmp(addr_t address) {
  _set_address(address);
}

void Ijmp::_execute(ProcessorState& state) const {
  // Why minus two? Because execute() will increment PC by two,
  // so to make the PC take (eventually) the value `address`
  // I need to subtract two here. Same applies for JNE below
  // This kind of unintuitive behaviour is a clear sign of bad
  // class hierarchy design 
  state.pc = get_address() - 2;
}

std::string Ijmp::name() const {
  return "JMP";
}

// ========== JNE Instruction ==========
Ijne::Ijne(addr_t address) {
  _set_address(address);
}

void Ijne::_execute(ProcessorState& state) const {
  // Same hack as above
  if (state.acc != 0)
    state.pc = get_address() - 2;
}

std::string Ijne::name() const {
  return "JNE";
}

