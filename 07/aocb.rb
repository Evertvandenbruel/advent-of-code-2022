require 'pry'

Folder = Struct.new(:name, :directories, :files, :parent, :total_size, keyword_init: true) do
  TOTAL_SIZE = 70_000_000
  NEEDED_SPACE_FOR_UPDATE = 30_000_000

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

  def current_free_space
    TOTAL_SIZE - self.total_size
  end

  def extra_space_needed
    NEEDED_SPACE_FOR_UPDATE - current_free_space
  end

  def smallest_deletable_directory(current_smallest: 0, needed_size: 0)
    directories.each do |directory|
      if needed_size < directory.total_size
        if directory.total_size < current_smallest 
          current_smallest = directory.total_size
        end
      end
      current_smallest = directory.smallest_deletable_directory(current_smallest: current_smallest, needed_size: needed_size)
    end
    current_smallest
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

puts root_folder.smallest_deletable_directory(current_smallest: root_folder.total_size, needed_size:root_folder.extra_space_needed)