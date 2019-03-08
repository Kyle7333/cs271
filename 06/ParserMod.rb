#Parser
load 'CodeMod'

class Parser
	def initialize(input)
		@input = input.readline
		# @cur_line = nil 
		# @cur_match = nil # Checks to see if A,B,or L Pattern
	end

	def hasMoreCommands # Checks to see if there is anymore commands in the file
		!input.eof? # Not End Of File?
	end

	def advance # Advance to next line. Non-blank or end of file
		if hasMoreCommands == true
				@line = input[i]
				i++

		end
	
		# cur_line = input.readline.strip.gsub(EMPTY_SPACE,"") # gets rid of blank lines and comments while moving down a line
	end

	A_PATTERN = /@[0-9a-zA-Z]/ # @66, @A
	# C_PATTERN = // #dest = comp;jump. Don't need anymore. If not A or L, then C
	L_PATTERN = /[(][a-bA-B][)]/ # (LOOP), (THIS)

	def commandType # checks to see what type of command is in the current line
		 return nil if line.empty

		 if L_PATTERN.match(line) == true 
		 	return L_COMMAND
		 else
		 	if A_PATTERN.match(line) == true
		 		return A_COMMAND
		 	else
		 		return C_COMMAND # If not L or A, then must be C
		 	end
		 end
		end
	
		# @cur_match = L_PATTERN.match(line) and return L_COMMAND
		# @cur_match = A_PATTERN.match(line) and return A_COMMAND
		# @cur_match = C_PATTERN.match(line) and return C_COMMAND


	end
	
	CONST_PAT = /\A\d+\z/

	def constant?
		symbol =~ CONST_PAT

	def symbol
		if commandType == A_COMMAND, L_COMMAND
			return line.delete!('@', '(', ')') # Removes the @ and () that are not needed
		end
	end

	def dest
		if commandType == C_COMMAND
			LnSplit = line.split('=') # Split the string at the '=' and place them in array
			return LnSplit[0] # Grabs the item in the first position. Should be the dest command. LnSplit = ['dest', 'comp;jump']
		end
			 
	end

	def comp 
		if commandType == C_COMMAND
			if line.include?(';') and ('=')
				LnSplit = line.split('=', ';') # Split the string at the '=' and ';' and place them in array
			else
				LnSplit = line.split('=') # should always have '='
			end

			return LnSplit[1] # Grabs the item in the second position. Should be the comp command. LnSplit = ['dest', 'comp', 'jump']
			end
		end
	end

	def jump
		if commandType == C_COMMAND
			if line.include?(';') # doesnt always need a jump command. Checking to see if it is there.
				LnSplit = line.split('=', ';') # Split the string at the '=' and ';' and place them in array
				return LnSplit[2] # Grabs the item in the third position. Should be the jump command. LnSplit = ['dest', 'comp', 'jump']
			end
		end
	end

end



