require 'thailang4r'
require "rexml/document"

include REXML

LEN_CONST = 1.2

if ARGV.length != 2
  puts "Usage: ruby #{$0} <English strings.xml> <Thai strings.xml>"
  exit 1
end

def read_strings(path)
  strings = Hash.new
  doc = Document.new(File.new(path))
  XPath.each(doc, "/resources/string").each do |string_|
    strings[string_.attribute('name').value] = string_.text
  end
  strings
end

english_strings = read_strings(ARGV[0])
thai_strings = read_strings(ARGV[1])

thai_strings.each do |name, th_val|
  en_val = english_strings[name]
  if not en_val.nil?
    if ThaiLang::exclude_thai_lower_upper(th_val).length > en_val.length * LEN_CONST
      puts "#{name} ||| #{en_val} ||| #{th_val}"
    end
  end
end