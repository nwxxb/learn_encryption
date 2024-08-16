# cesar on ascii
# see https://www.asciitable.com/
# thanks to https://en.wikipedia.org/wiki/Caesar_cipher
#   for future riddle
#   0..25 is not equal to your current range
#   which affecting the modulus value
require 'terminal-table'

def encrypt(string, key)
  range = (32..126)
  string.split('').map do |char|
    origin_ord = char.ord
    added_ord = char.ord + key

    unless range.include? added_ord
      (((added_ord - range.min) % range.size) + range.min).chr
    else
      added_ord.chr
    end
  end.join('')
end

def decrypt(encrypted_string, key)
  range = (32..126)
  encrypted_string.split('').map do |char|
    origin_ord = char.ord
    shrinked_ord = char.ord - key

    unless range.include? shrinked_ord
      (((shrinked_ord - range.min) % range.size) + range.min).chr
    else
      shrinked_ord.chr
    end
  end.join('')
end


headings = ['Raw String', 'Key', 'Encrypted', 'Decrypted']
table = Terminal::Table.new(:headings => headings) do |t|
  raw_string = 'ascii cesar encryption'
  keys = [1, 2, 9, 10, 100, 10000]
  # keys = [10000]
  keys.each do |key|
    t << [
      raw_string.inspect, key.inspect,
      encrypt(raw_string, key),
      decrypt(encrypt(raw_string, key), key)
    ]
    p encrypt(raw_string, key)
  end
end
puts table
