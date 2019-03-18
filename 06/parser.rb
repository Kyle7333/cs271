#Parser
require_relative 'code'


class Parser

	L_COMMAND = 0
	A_COMMAND = 1
	C_COMMAND = 2

	def initialize(input)
		@input = input# 'input' is an array
		@cur_line = 0 
		# @cur_match = nil # Checks to see if A,B,or L Pattern
	end

	def hasMoreCommands # Checks to see if there is anymore commands in the file
		if @cur_line != @input.length # If you currrent pos != length of the line, end
			return true
		end
	end

	def advance # Advance to next line
		@line = @input[@cur_line]
		if hasMoreCommands == true
			@cur_line += 1 # Move to next line
		end
		# cur_line = input.readline.strip.gsub(EMPTY_SPACE,"") # gets rid of blank lines and comments while moving down a line
	end

	@a_pattern = /@[0-9a-zA-Z]/ # @R66, @A
	# c_pattern = // #dest = comp;jump. Don't need anymore. If not A or L, then C
	@l_pattern = /^\(/ # (LOOP), (THIS) Finds only "(" and assume it is l_pattern

	def commandType # checks to see what type of command is in the current line
		 return nil if @line.empty?

		 if @line.include?('(') == true 
		 	return L_COMMAND
		 else
		 	if @line.include?('@') == true
		 		return A_COMMAND
		 	else
		 		return C_COMMAND # If not L or A, then must be C
		 	end
		 end
		 
	
		# @cur_match = L_PATTERN.match(line) and return L_COMMAND
		# @cur_match = A_PATTERN.match(line) and return A_COMMAND
		# @cur_match = C_PATTERN.match(line) and return C_COMMAND
	end
	
	@const_pat = /\A\d+\z/

	def constant?
		symbol =~ @const_pat
	end

	def symbol
		if commandType == A_COMMAND
			return @line.delete!('@') #&& @line.delete!('R') # Removes the @, R
		end
		if commandType == L_COMMAND
			return @line.delete!('(') && @line.delete!(')') # Removes ()
		end
	end

	def dest
		if commandType == C_COMMAND
			if @line.include?('=')
				lnSplit = @line.split('=') # Split the string at the '=' and place them in array
				return lnSplit[0] # Grabs the item in the first position. Should be the dest command. LnSplit = ['dest', 'comp;jump']
			else
				if @line.include?(';')
					lnSplit = @line.split(';')
					return lnSplit[0]
			end
		end
			 
	end

	def comp 
		if commandType == C_COMMAND
			if @line.include?('=') && @line.include?(';') # D = C ; j
				lnSplit = @line.split('=', ';')
				return lnSplit[1]
				else 
					if @line.include?('=') # D = C
						lnSplit = @line.split('=')
						return lnSplit[1]
					else 
						return "0" # No comp command
					end
				end
			end
		end
	end

	def jump
		if commandType == C_COMMAND
			if @line.include?('=') && @line.include?(';')
				lnSplit = @line.split('=', ';')
				return lnSplit[2]
				else
					if @line.include?(';') # doesnt always need a jump command. Checking to see if it is there.
						lnSplit = @line.split(';') # Split the string at the '=' and ';' and place them in array
						return lnSplit[1] # Grabs the item in the third position. Should be the jump command. LnSplit = ['dest', 'comp', 'jump']
					end
				end
		end
	end
end