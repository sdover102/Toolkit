require 'fileutils'
require 'pathname'

=begin
 * Simple file manager. Sole purpose for now is to organize files in current working directory
=end
class Files

	@file_map = [
					{
						:file_types => ['jpg','gif','png','jpeg'],
						:directory => 'images'
					},
					{
						:file_types => ['doc','docx','pdf','txt','rtf','xls','xlsx','mdown','md'],
						:directory => 'docs'
					},
					{
						:file_types => ['sql'],
						:directory => 'db_exports'
					},
					{
						:file_types => ['psd'],
						:directory => 'psds'
					},
					{
						:file_types => ['css','html','htm','php','rb','py','xml','js'],
						:directory => 'code'
					}
				]

	def self.cleanup(args = [])
		# Specify destination organization directory
		dir_name = 'organized' 
		if args.length > 0 
			dir_name = args[0]
		end

		# Make the destination directory
		FileUtils.mkdir_p dir_name

		# Destination Path
		dest_path = File.join(CURR_DIR, dir_name)

		# Remove Screenshots
		Dir[File.join(CURR_DIR, 'Screen\ Shot*')].each { |f| File.delete(f) }

		# Loop through files and organize as necessary
		Dir[File.join(CURR_DIR, '*')].each do |file|
			filename = Pathname.new(file).basename
			ext = File.extname(file).gsub('.','')
			dest_folder = ''

			# Don't move our organized folder
			next if dest_path == file

			# puts "found: #{file}"
			if File.directory?(file)
				dest_folder = 'folders'
			else
				moved = false
				# Find out where the file should be moved to
				@file_map.each do |fm|
					if fm[:file_types].include?(ext)
						dest_folder = fm[:directory]
						moved = true
						break
					end
				end
				# If not organized, put it in the misc folder
				dest_folder = !moved ? 'misc' : dest_folder
			end

			# Move the folder
			FileUtils.mkdir_p(File.dirname(File.join(dest_path, dest_folder, filename)))
			FileUtils.mv(file, File.join(dest_path, dest_folder, filename))
		end

		puts "Files Organized at #{dest_path}. Opening Folder."
		exec("open '#{dest_path}'")
	end
end