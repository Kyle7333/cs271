#Assembler
require_relative 'symbol_table'
require_relative 'code'
require_relative 'parser'

class Assembler

	def initialize(input_path)
		@input = File.open(input_path, "r+") # Read/write the input
		output_path = input_path.gsub(/.asm/, ".hack") # Copying and changing .asm to .hack
		@output = File.open(output_path, "w") # writing the output(.hack) file
		@symbol_table = SymbolTable.new
	end

	def assemble!
		# symbol_table = analyze(@input) # First Pass and placing them in the symbol_table
		# @input.rewind	#Going back to beginning
		create(@input, @output, @symbol_table)
		@input.close
		@output.close
	end

	def analyze(input) # Makes the first pass through and collects all of the symbols
		rom_ad = 0
		parser = Parser.new(input) # Creates a new parser object with the file input
		while parser.hasMoreCommands # Checks to see if the input has any more commands in it
			parser.advance # advances to the next line

			case parser.commandType # Checks the command type (A,C,L)
				when A_COMMAND, C_COMMAND # When A or C commands, add add one to ROM MEMORY
					rom_ad += 1
				when L_COMMAND # If L_COMMAND, addit to the symbol_table and mark its address
					@symbol_table.addEntry(parser.symbol, rom_ad)
			end
		end
	end

	def create(input, output, symbol_table) # Makes the second pass through and translates all of the symbols into binary. Placing them into the .hack file
		next_avail_ram = 16
		code = Code.new # Code object
		parser = Parser.new(input)

		while parser.hasMoreCommands # If there are more commands continue
			parser.advance
			case parser.commandType
				when A_COMMAND # When a command
					if parser.constant?
						address = parser.symbol.to_i # Turns to int
			
					elsif symbol_table.contains?(parser.symbol) # Check if already in table
						address = symbol_table.address(parser.symbol)

					else 
						address = next_avail_ram # Takes next avail ram and adds it to table
						symbol_table.addEntry(parser.symbol, address)
						next_avail_ram += 1
					end
					output.puts "%016b" % address # puts in .hack file
				when C_COMMAND # Obtains all portions of the c command
					comp = code.comp(parser.comp)
					dest = code.dest(parser.dest)
					jump = code.jump(parser.jump)
					output.puts "111#{comp}#{dest}#{jump}" # Puts them in .hack file
			end
		end
	end
end


input_path = ARGV[0]
if File.exist?(input_path) 
	a = Assembler.new(input_path) # if it is then create a new .hack file to write in.
	a.assemble!
else
	puts "File Does Not Exits"
end
