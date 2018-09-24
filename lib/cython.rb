$files.keep_if do |f|
  f =~ $languages[:cython]
end

if !system("cython *.pyx")
  exit 1
end

# Probably do something fancy here to create the executable
# like compile all of the cython libraries and generate a python script
# with a shebang that imports all the libraries and does basic config and 
# execution
