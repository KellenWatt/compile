$files.keep_if do |f|
  f =~ $languages[:haskell]
end

system("ghc -o #{File.basename(Dir.pwd)} #{$files.join(" ")}")
