#Symbol Table

class SymbolTable
	@used_symbols = {
		"SP"     => 0x0000,
		"LCL"    => 0x0001,
		"ARG"    => 0x0002,
		"THIS"   => 0x0003,
		"THAT"   => 0x0004,
		"R0"     => 0x0000,
		"R1"     => 0x0001,
		"R2"     => 0x0002,
		"R3"     => 0x0003,
		"R4"     => 0x0004,
		"R5"     => 0x0005,
		"R6"     => 0x0006,
		"R7"     => 0x0007,
		"R8"     => 0x0008,
		"R9"     => 0x0009,
		"R10"    => 0x000a,
		"R11"    => 0x000b,
		"R12"    => 0x000c,
		"R13"    => 0x000d,
		"R14"    => 0x000e,
		"R15"    => 0x000f,
		"SCREEN" => 0x4000,
		"KBD"    => 0x6000
	}

	def initialize # Creates an empty hash table
		#@hashTable = {}
	end

	def addEntry(symbol, address) # Adds a new symbol to the table
		fail "Symbol already in use" if contains(symbol)
		#@hashTable[symbol] = address
	end

	def contains(symbol) # Checks to see if the symbol is already in use
		#getAddress(symbol) != nil
	end

	def getAddress(symbol) 
		#@used_symbols[symbol] || @hashTable[symbol]
	end
end
