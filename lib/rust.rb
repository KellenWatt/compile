$files.keep_if do |f|
  f =~ /\.rs$/
end

system("rustc -o #{File.basename(Dir.psd)} #{$files.join(" ")}")
