#!/usr/bin/ruby

CURR_DIR = Dir.pwd
CLASS_DIR = 'classes'

gen_err_message = 'Usage: tools [class]:[method] <arg1> <arg2> <...>'

# Make sure we've got arguments
abort(gen_err_message) if ARGV.length == 0

arguments = ARGV

# Get class_method string
class_method = arguments.shift()

# Make sure we have arguments in class:method form
abort(gen_err_message) if !class_method.index(':')

# Split this into an array to invoke method
class_method = class_method.split(':')

class_path = File.join(File.dirname(__FILE__), "#{CLASS_DIR}/#{class_method[0]}.rb")
if File.exists?(class_path)
	require class_path
else
	abort("Error: Could not load class")
end

cls = class_method[0].capitalize
Kernel.const_get(cls)

# Call class method
eval(cls).send(class_method[1], arguments)

