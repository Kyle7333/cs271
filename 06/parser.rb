#Parser
require_relative "CodeMod"

class Parser
	def initialize(input)
		@input = input.readlines
		# @cur_line = nil 
		# @cur_match = nil # Checks to see if A,B,or L Pattern
	end

	def hasMoreCommands # Checks to see if there is anymore commands in the file
		!@input.eof? # Not End Of File?
	end

	def advance # Advance to next line
		@line = input[i]
		if hasMoreCommands == true
			i += 1
		end
		# cur_line = input.readline.strip.gsub(EMPTY_SPACE,"") # gets rid of blank lines and comments while moving down a line
	end

	a_pattern = /@[0-9a-zA-Z]/ # @66, @A
	# c_pattern = // #dest = comp;jump. Don't need anymore. If not A or L, then C
	l_pattern = /[(][a-bA-B][)]/ # (LOOP), (THIS)

	def commandType # checks to see what type of command is in the current line
		 return nil if line.empty

		 if l_pattern.match(line) == true 
		 	return L_COMMAND
		 else
		 	if a_pattern.match(line) == true
		 		return A_COMMAND
		 	else
		 		return C_COMMAND # If not L or A, then must be C
		 	end
		 end
		 
	
		# @cur_match = L_PATTERN.match(line) and return L_COMMAND
		# @cur_match = A_PATTERN.match(line) and return A_COMMAND
		# @cur_match = C_PATTERN.match(line) and return C_COMMAND
	end
	
	const_pat = /\A\d+\z/

	def constant?
		symbol =~ const_pat
	end

	def symbol
		if commandType == A_COMMAND or L_COMMAND
			return line.delete!(['@','R','(',], [')','']) # Removes the @, R, and () that are not needed
		end
	end

	def dest
		if commandType == C_COMMAND
			lnSplit = line.split('=') # Split the string at the '=' and place them in array
			return lnSplit[0] # Grabs the item in the first position. Should be the dest command. LnSplit = ['dest', 'comp;jump']
		end
			 
	end

	def comp 
		if commandType == C_COMMAND
			if line.include?(';') and ('=')
				lnSplit = line.split('=', ';') # Split the string at the '=' and ';' and place them in array
			else
				lnSplit = line.split('=') # should always have '='
			end
			return lnSplit[1] # Grabs the item in the second position. Should be the comp command. LnSplit = ['dest', 'comp', 'jump']
		end
	end

	def jump
		if commandType == C_COMMAND
			if line.include?(';') # doesnt always need a jump command. Checking to see if it is there.
				lnSplit = line.split('=', ';') # Split the string at the '=' and ';' and place them in array
				return lnSplit[2] # Grabs the item in the third position. Should be the jump command. LnSplit = ['dest', 'comp', 'jump']
			end
		end
	end
end