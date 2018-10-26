$files.keep_if do |f|
  f =~ $languages[:python3]
end

if !system("python3 -m py_compile *.py*")
  exit 1
else
  File.delete "__pycache__"
end

File.open(File.basename(Dir.pwd), "w+", 0755) do |out|
  out.puts "#!/usr/bin/env python3"
  combine out, $files
end
