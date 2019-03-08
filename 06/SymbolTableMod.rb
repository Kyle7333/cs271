#Symbol Table

class SymbolTable
	USED_SYMBOLS = {
		"SP"     => 0x0000,
		"LCL"    => 0x0001,
		"ARG"    => 0x0002,
		"THIS"   => 0x0003,
		"THAT"   => 0x0004,
		"R0"     => ,
		"R1"     => ,
		"R2"     => ,
		"R3"     => ,
		"R4"     => ,
		"R5"     => ,
		"R6"     => ,
		"R7"     => ,
		"R8"     => ,
		"R9"     => ,
		"R10"    => ,
		"R11"    => ,
		"R12"    => ,
		"R13"    => ,
		"R14"    => ,
		"R15"    => ,
		"SCREEN" => 0x4000,
		"KBD"    => 0x6000
	}

	def initialize # Creates an empty hash table
		@hashTable = {}
	end

	def addEntry(symbol, address) # Adds a new symbol to the table
		fail "Symbol already in use" if contains(symbol)
		@hashTable[symbol] = address
	end

	def contains(symbol) # Checks to see if the symbol is already in use
		address(symbol) != nil
	end

	def getAddress(symbol) 
		USED_SYMBOLS[symbol] || @hash_table[symbol]
	end
end
