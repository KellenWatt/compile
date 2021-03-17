# It is VERY possible that all of the methods in this file are either incomplete or
# just entirely broken.
#
# Keep an eye out for broken compilation, and fix the issues if/when it becomes a problem

$languages = {
  "c++" => /\.(c|h)(pp)?$/,
  java: /\.java$/,
  go: /\.go$/,
  python: /\.py(3)?$/,
  cython: /\.pyx$/,
  "C#" => /\.cs$/,
  assembly: /\.(s|S|asm)$/,
  d: /\.d$/,
  ruby: /\.rb$/,
  lisp: /\.lisp$/,
  python2: /\.py$/,
  crystal: /\.cr$/,
  haskell: /\.(l)?hs$/,
  rust: /\.rs$/,
  latex: /\.tex$/
}

$exclusions = [
  /rails/
]

def get_dependencies(files) 
  dependency_list = Hash.new {|hash,k| hash[k] = []}
  files.each do |file|
    dependency_list[file]
    File.open(file) do |fin|
      fin.readline
      while (line = fin.readline) =~ /^#/
        dependency_list[file] << line.split[1].chomp if line =~ /depends/
        dependency_list[file] << "main" if line =~ /main/
      end
    end
  end
  dependency_list
end

# Possible bug when only one file is included that is main
def dependency_sort(files, dependencies)
  ordered_files = []
  main = nil
  dependencies.each do |file, depends|
    catch :included do
      ordered_files.each.with_index do |of, i|
        if depends.include?("main")
          main = file
          throw :included
        elsif depends.include?(of)
          ordered_files.insert(i, file)
          throw :included
        end
      end
      ordered_files.push(file)
    end
  end
  ordered_files.reverse!.push main if main
  ordered_files
end

def combine(out, files)
  dependencies = get_dependencies(files)
  files = dependency_sort(files, dependencies)
  files.each do |f|
    File.open(f) do |fin|
      while line = fin.gets do
        out.puts line if line !~ /^#/
      end
    end
  end
end
