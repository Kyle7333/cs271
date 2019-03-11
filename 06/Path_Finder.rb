# Path_Finder
# Checks to see if the path is valid before running the rest of the prog.
require_relative "Assembler"

input_path = ARGV[0]
if File.exist?(input_path) 
	Assembler.new(input_path) # if it is then create a new .hack file to write in.
else
	puts "File Does Not Exits"
end