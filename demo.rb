root = Dir.pwd
lib = Dir.new(root + '/lib/')

lib.select {|file| file =~ /.rb\z/}.each do |f_path| 
  require_relative "lib/#{f_path}"
  puts "$ require #{f_path}"
end

puts "Press any key to continue."
gets

%w[csv psv ssv].each do |format|
  records = RecordSet.new(root + "/spec/samples/test.#{format}")

  puts "#{format.upcase} sample file loaded\n\n"
  puts "In default (birth) order:\n"
  puts records.list
  puts
  puts "In explicit birth order:\n"
  puts records.list(by: :birthdate)
  puts
  puts "In ascending last name order:\n"
  puts records.list(by: :last_name)
  puts
  puts "In order of gender, then last name:\n"
  puts records.list(by: :gender)
  puts
  puts "Press any key to continue."
  gets
end