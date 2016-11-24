require 'redditkit'
require 'pry'
require 'erb'
require_relative './lib/tablebot.rb'


File.open(ARGV[0], 'r') { |f|
  a = f.read()
  tb = Tables.new(a)
  renderer = ERB.new(File.read('./table.erb.html'))
  output = renderer.result(binding)
  File.write('./output.html', output)
}
