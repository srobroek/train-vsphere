basename = File.basename(__FILE__, ".rb")
libdir = File.expand_path("../#{basename}",__FILE__)
puts basename
puts libdir
