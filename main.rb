require 'redditkit'
require 'pry'
require 'erb'
require_relative './lib/tablebot.rb'


Header_regex = /^(\d+)?[dD](\d+)(.*)/
Line_regex = /^(\d+)(\s*-+\s*\d+)?(.*)/

File.open('streetfood', 'r') { |f|
  a = f.read()
  tb = Tables.new(a)
  renderer = ERB.new(File.read('./table.erb.html'))
  output = renderer.result(binding)
  File.write('./output.html', output)
}
