data = [
  {
    id: 1,
    name: "Harry Potter and the Sorcerer's Stone",
    author: "J. K. Rowling"
  },
  {
    id: 2,
    name: "Harry Potter and the Sorcerer's Stane",
    author: "J. K. Rawling"
  },
  {
    id: 2,
    name: "Some fake book from a scrub faking ISBNs",
    author: "Jake Rowling"
  },
  {
    id: 3,
    name: "Harry Potter y el stono de sorcereros",
    author: "J. K. Rowling"
  },
  {
    id: 4,
    name: "Harry Potter and the Chamber of Commerce",
    author: "J. K. Rowling"
  },
  {
    id: 5,
    name: "Harry Potter and the Sorcerer's Stone",
    author: "J.K. Rowling"
  },
]

require './lib'
require 'pry'

puts "Initializing ES"
s = es = ExistentialSet.new

puts "Adding data to the ES"
data.each { |datum| es.add(datum) }

binding.pry

puts "Metadata:"
puts "Count: #{es.count}"
puts "Actual count tho: #{es.actual_count}"

binding.pry