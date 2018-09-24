$files.keep_if do |f|
  f =~ $langauges[:haskell]
end

system("ghc -o #{File.basename(Dir.pwd)} #{files.join(" ")}")
