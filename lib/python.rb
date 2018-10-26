require "fileutils"

$files.keep_if do |f|
  f =~ $languages[:python]
end

if !system("python3 -m py_compile *.py")
  exit 1
else
  FileUtils.remove_dir "__pycache__"
end

File.open(File.basename(Dir.pwd), "w+", 0755) do |out|
  out.puts "#!/usr/bin/env python3"
  combine out, $files
end
