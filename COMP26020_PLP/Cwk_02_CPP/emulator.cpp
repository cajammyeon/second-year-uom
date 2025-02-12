#include <cassert>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <utility>
#include "emulator.h"

// ============= Breakpoint ==============

Breakpoint::Breakpoint(addr_t address, std::string name) : 
  _address(address & ARCH_BITMASK),
  _name(name)
{
}

// Copy constructor
Breakpoint::Breakpoint(const Breakpoint& other) :
  _address(other._address),
  _name(other._name)
{
}

// Move constructor
Breakpoint::Breakpoint(Breakpoint&& other) noexcept :
  _address(std::move(other._address)),
  _name(std::move(other._name))
{
}

// Copy assignment
Breakpoint& Breakpoint::operator=(const Breakpoint& other) {
  if (this == &other)
    return *this;
  _address = other._address;
  _name = other._name;
  return *this;
}

// Move assignment operator
Breakpoint& Breakpoint::operator=(Breakpoint&& other) noexcept {
  // _address = std::move(other._address);
  // _name = std::move(other._name);
  std::swap(_address, other._address);
  std::swap(_name, other._name);
  return *this;
}

addr_t Breakpoint::get_address() const {
  return _address;
}

const std::string& Breakpoint::get_name() const {
  return _name;
}

int Breakpoint::has(addr_t address) const {
  return _address == (address & ARCH_BITMASK);
}

int Breakpoint::has(std::string name) const {
  return (name == _name);
}

// ============= Emulator ==============

// ----------> Initialisation
Emulator::Emulator() {
  state = ProcessorState();
}

// Copy Constructor
Emulator::Emulator(const Emulator& other) :
  state(other.state),
  breakpoints_sz(other.breakpoints_sz),
  total_cycles(other.total_cycles),
  breakpoints(other.breakpoints)
{
}

// Move Constructor
Emulator::Emulator(Emulator&& other) noexcept : 
  breakpoints(std::move(other.breakpoints))
{
  std::swap(state, other.state);
  std::swap(breakpoints_sz, other.breakpoints_sz);
  std::swap(total_cycles, other.total_cycles);
}

// Copy Assignment Operator
Emulator& Emulator::operator=(const Emulator& other) {
  if (this == &other)
    return *this;

  state = other.state;
  breakpoints_sz = other.breakpoints_sz;
  total_cycles = other.total_cycles;
  breakpoints = other.breakpoints;
  return *this;
}

// Move Assignment Operator
Emulator& Emulator::operator=(Emulator&& other) noexcept {
  if (this == &other)
    return *this;

  std::swap(state, other.state);
  breakpoints = std::move(other.breakpoints);
  std::swap(breakpoints_sz, other.breakpoints_sz);
  std::swap(total_cycles, other.total_cycles);

  return *this;
}

// ----------> Main emulation loop

InstructionData Emulator::fetch() const {
  InstructionData data = {
    state.memory.at(state.pc),
    state.memory.at(state.pc + 1)
  };
  return data;
}

std::unique_ptr<InstructionBase> Emulator::decode(InstructionData data) const {
  // decode here is just a thin wrapper around generateInstruction()
  // In a more complex emulator, more things would happen here
  return std::move(InstructionBase::generateInstruction(data));
}

int Emulator::execute(InstructionBase* instr) {
  // Again this is just a thin wrapper,
  // but this is a side-effect of having a simple emulator
  instr->execute(state);
  return 1;
}

int Emulator::run(int steps) {
  // No steps to execute
  if (steps == 0)
    return 1;

  // Repeat for the given number of steps
  // Break with return code 0, if we find an error
  // Break with return code 1, if we find a breakpoint
  // Keep track of the total number of cycles we've executed successfully
  for (; steps > 0; --steps) {
    // Instructions are supposed to be aligned on two-byte offsets:
    // PC should be even. Terminate if PC is odd.
    if ((state.pc % 2) == 1)
      return 0;

    // Fetch the next instruction from memory and transform it into an InstructionBase-derived object
    // release pointer here
    std::unique_ptr<InstructionBase> instr = decode(fetch());

    if (instr == nullptr)
      return 0;

    // What the function name says
    int success = execute(instr.get());

    // Terminate if we didn't execute the instruction successfully
    if (success == 0)
      return 0;

    ++total_cycles;
    
    if (is_breakpoint() == 1)
      return 1;
  }

  return 1;
}

// ----------> Breakpoint management

int Emulator::insert_breakpoint(addr_t address, std::string name) {
  // breakpoints is full (should never happen though!)
  if (breakpoints_sz == MAX_INSTRUCTIONS)
    return 0;

  // Breakpoint already exists
  if (find_breakpoint(address) != nullptr)
    return 0;

  // Breakpoint name already used
  if (find_breakpoint(name) != nullptr)
    return 0;

  // Insert breakpoint and increment breakpoints_sz in a single step
  breakpoints_sz++;
  breakpoints.push_back(Breakpoint(address, name));
  return 1;
}

const Breakpoint* Emulator::find_breakpoint(addr_t address) const {
  // iterate over all breakpoints
  for (const auto& elem : breakpoints) {
    if (elem.has(address)) {
      return &elem;
    }
  }
  // indicates failure to find a breakpoint
  return nullptr;
}

// Basically the same as above, but for the name
const Breakpoint* Emulator::find_breakpoint(std::string name) const {
  for (const auto& elem : breakpoints) {
    if (elem.has(name)) {
      return &elem;
    }
  }
  return nullptr;
}

int Emulator::delete_breakpoint(addr_t address) {
  const Breakpoint* found = find_breakpoint(address);

  if (found == nullptr)
    return 0;

  // Remove one breakpoint
  --breakpoints_sz;

  // Urghh: C pointer magic to find the index of the breakpoint from its pointer
  // `found` is a pointer in the `breakpoints` array, so the difference of
  // `found` and `breakpoints` is the index of `found` in the array.
  auto found_idx = found - breakpoints.data();
  breakpoints.erase(breakpoints.begin() + found_idx);

  return 1;
}

// Oh, look, this function is practically identical to the one above
int Emulator::delete_breakpoint(std::string name) {
  const Breakpoint* found = find_breakpoint(name);

  if (found == nullptr)
    return 0;

  --breakpoints_sz;

  auto found_idx = found - breakpoints.data();
  breakpoints.erase(breakpoints.begin() + found_idx);

  return 1;
}

int Emulator::num_breakpoints() const {
  return breakpoints_sz;
}

// ----------> Manage state

int Emulator::cycles() const {
  return total_cycles;
}

data_t Emulator::read_acc() const {
  return state.acc;
}

addr_t Emulator::read_pc() const {
  return state.pc;
}

addr_t Emulator::read_mem(addr_t address) const {
  // limit address to the allowed range of values
  address &= ARCH_BITMASK;
  return state.memory.at(address);
}

// ----------> Utilities

int Emulator::is_zero() const {
  return state.acc == 0;
}

int Emulator::is_breakpoint() const {
  return find_breakpoint(state.pc) != nullptr;
}

int Emulator::print_program() const {
  for (int offset = 0; offset < MEMORY_SIZE; offset += INSTRUCTION_SIZE) {
    InstructionData data = {
      state.memory.at(offset),
      state.memory.at(offset + 1)
    };

    // release pointer here
    std::unique_ptr<InstructionBase> instr = decode(data);

    std::string buffer;
    std::stringstream app;

    // convert to int, to make sure cpp write the as integer, not object
    int opcode = data.opcode;
    int address = data.address;

    if ((instr == nullptr) || (data.opcode == 0 && data.address == 0)) {
      app << offset << ":\t" << opcode << "\t" << address << "\n";
      buffer = app.str();
      std::cout << buffer;
    }
    else {
      app << offset << ":\t" << opcode << "\t" << address << "\t:\t" << instr->to_string() << "\n";
      buffer = app.str();
      std::cout << buffer;
    }
  }
  return 1;
}

int Emulator::load_state(const char* filename) {
  // Delete all breakpoints
  breakpoints_sz = 0;

  int read = 0;
  std::ifstream file(filename);

  if (file.fail())
    return 0;

  // Make sure that each ifstream reads the right number of items
  file >> total_cycles;
  if ((file.fail()) || (total_cycles < 0))
    return 0;

  file >> state.acc;
  if ((file.fail()) || (state.acc > ARCH_MAXVAL) || (state.acc < 0))
    return 0;

  file >> state.pc;
  if ((file.fail()) || (state.pc >= MEMORY_SIZE) || (state.pc < 0))
    return 0;

  int num = 0;
  for (byte_t& element : state.memory) {
    file >> num;
    if ((file.fail()) || (num > ARCH_MAXVAL) || (num < 0))
      return 0;
    element = num;
  }
  
  while (1) {
    std::string name;
    file >> num >> name;
    // End of the file
    if (file.fail())
      break;

    // Wrong data (num is supposed to be an address)
    if ((num < 0) || (num >= MEMORY_SIZE))
      return 0;

    // Try to insert the breakpoint and return fail if unsuccessful
    if (!insert_breakpoint(num, name))
      return 0;
  }

  return 1;
}

int Emulator::save_state(const char* filename) const {
  std::ofstream file(filename);

  if (file.fail())
    return 0;

  file << total_cycles << "\n";
  file << state.acc << "\n";
  file << state.pc << "\n";

  for (byte_t elements : state.memory) {
    int num = elements;
    file << num << "\n";
  }
  
  for (Breakpoint element: breakpoints) {
    file << element.get_address() << " " << element.get_name() << "\n";
  }
  
  return 1;
}
