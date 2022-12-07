require 'pry'

Folder = Struct.new(:name, :directories, :files, :parent, :total_size, keyword_init: true) do
  MAX_SIZE = 100000

  def initialize(name:, directories: [], files: [], parent: nil, total_size: 0) 
    super 
  end

  def add_file(file:)
    files << file
    increase_total_size(size: file.total_size)
  end

  def increase_total_size(size:)
    self.total_size += size
    parent.increase_total_size(size: size) if parent
  end

  def print(spaces: "")
    puts "#{spaces}- #{name} (dir, size: #{total_size})"
    directories.each do |directory|
      directory.print(spaces: spaces + "  ")
    end
    files.each do |file|
      file.print(spaces: spaces + "  ")
    end
  end

  def calculate_size(sum: 0)
    directories.each do |directory|
      if directory.total_size < MAX_SIZE
        sum += directory.total_size
      end
      sum = directory.calculate_size(sum: sum)
    end
    sum
  end
end

MyFile = Struct.new(:name, :total_size, keyword_init: true) do
  def print(spaces:)
    puts "#{spaces}- #{name} (file, size=#{total_size})"
  end
end

root_folder = Folder.new(name: "/", directories: [], files: [])

current_path = []
current_folder = root_folder

def find_or_create_empty_dir(folder: , name:)
  child_directory = folder.directories.detect {|d| d.name == name }
  return child_directory if child_directory

  child_folder = Folder.new(name: name, parent: folder)
  folder[:directories] << child_folder
  child_folder
end

File.readlines('input', chump: true).each_with_index do |line, i|
  line = line.gsub("\n", "")
  if line.start_with?("$ ")
    line = line.gsub("$ ", "")
    if line == "cd .."
      current_path.pop
      current_folder = current_folder.parent
    elsif line == "cd /"
      current_path = ["/"]
      current_folder = root_folder
    elsif line.include?("cd ")
      line = line.gsub("cd ", "")
      current_path.push(line)
      current_folder = find_or_create_empty_dir(folder: current_folder, name: line)
    end
  else
    if line.start_with?("dir ")
      line = line.gsub("dir ", "")
      find_or_create_empty_dir(folder: current_folder, name: line)
    else
      size, name = line.split(" ")
      current_folder.add_file(file: MyFile.new(name: name, total_size: size.to_i))
    end
  end
end

# root_folder.print

puts root_folder.calculate_size(sum: 0)
