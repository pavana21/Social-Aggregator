ROOT_DIR = File.dirname(File.expand_path('./',__FILE__))
puts ROOT_DIR
puts "#{ROOT_DIR}/config/god/*.god"
God.load "#{ROOT_DIR}/config/god/*.god"