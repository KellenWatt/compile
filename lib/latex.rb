$files.keep_if do |f|
  f =~ $languages[:latex]
end

system("pdflatex #{$files.join("")}")
