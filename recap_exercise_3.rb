require "byebug"

def no_dupes?(arr)
    uniq = Hash.new(0)
    uniq_arr = []

    arr.each { |ele| uniq[ele] += 1 }

    uniq.each { |k, v| uniq_arr << k if v == 1 }

    uniq_arr

end 

# p no_dupes?([1, 1, 2, 1, 3, 2, 4])         # => [3, 4]
# p no_dupes?(['x', 'x', 'y', 'z', 'z'])     # => ['y']
# p no_dupes?([true, true, true])            # => []

def no_consecutive_repeats?(arr)
    arr.each_with_index { |ele, idx| return false if ele == arr[idx+1] }

    true
end

# p no_consecutive_repeats?(['cat', 'dog', 'mouse', 'dog'])     # => true
# p no_consecutive_repeats?(['cat', 'dog', 'dog', 'mouse'])     # => false
# p no_consecutive_repeats?([10, 42, 3, 7, 10, 3])              # => true
# p no_consecutive_repeats?([10, 42, 3, 3, 10, 3])              # => false
# p no_consecutive_repeats?(['x'])                              # => true

def char_indices(str)
    char_hash = Hash.new { |h, k| h[k] = Array.new }

    str.each_char.with_index { |char, i| char_hash[char] << i }

    char_hash
end 

# p char_indices('mississippi')   # => {"m"=>[0], "i"=>[1, 4, 7, 10], "s"=>[2, 3, 5, 6], "p"=>[8, 9]}
# p char_indices('classroom')     # => {"c"=>[0], "l"=>[1], "a"=>[2], "s"=>[3, 4], "r"=>[5], "o"=>[6, 7], "m"=>[8]}

def longest_streak(str)
    longest = ""
    streak = ""

    (0...str.length).each do |i|
        if str[i] == str[i -1] || i == 0
            streak += str[i]
        else
            streak = str[i]
        end

        if streak.length >= longest.length
            longest = streak
        end
    end

    longest
end

# p longest_streak('a')           # => 'a'
# p longest_streak('accccbbb')    # => 'cccc'
# p longest_streak('aaaxyyyyyzz') # => 'yyyyy
# p longest_streak('aaabbb')      # => 'bbb'
# p longest_streak('abc')         # => 'c'

def bi_prime?(int)
    primes = []

    (2...int).each do |i|
        primes << i if int % i == 0
    end

    return true if primes.length == 2 || primes.first * primes.first == int
    false
end


# p bi_prime?(14)   # => true
# p bi_prime?(22)   # => true
# p bi_prime?(25)   # => true
# p bi_prime?(94)   # => true
# p bi_prime?(24)   # => false
# p bi_prime?(64)   # => false

def vigenere_cipher(str, arr)
    alph = ("a".."z").to_a
    cipher = ""

    (0...str.length).each do |i|
        old = alph.index(str[i])
        new_idx = old + arr.first
        arr = arr.rotate!
        cipher += alph[new_idx % 26]
    end

    cipher
end

# p vigenere_cipher("toerrishuman", [1])        # => "upfssjtivnbo"
# p vigenere_cipher("toerrishuman", [1, 2])     # => "uqftsktjvobp"
# p vigenere_cipher("toerrishuman", [1, 2, 3])  # => "uqhstltjxncq"
# p vigenere_cipher("zebra", [3, 0])            # => "ceerd"
# p vigenere_cipher("yawn", [5, 1])             # => "dbbo"

def vowel_rotate(str)
    vowels = "aeiou"
    vowels_arr = []

    str.each_char { |char| vowels_arr << char if vowels.include?(char) }
    
    (vowels_arr.length - 1).times do
        vowels_arr = vowels_arr.rotate!
    end

    (0...str.length).each do |i|
        if vowels.include?(str[i])
            str[i] = vowels_arr.first
            vowels_arr = vowels_arr.rotate!
        end
    end

    str
end

# p vowel_rotate('computer')      # => "cempotur"
# p vowel_rotate('oranges')       # => "erongas"
# p vowel_rotate('headphones')    # => "heedphanos"
# p vowel_rotate('bootcamp')      # => "baotcomp"
# p vowel_rotate('awesome')       # => "ewasemo"

class String

    def select(&prc)
        return "" if prc.nil?

        select_str = ""

        (0...self.length).each do |i|
            select_str += self[i] if prc.call(self[i])
        end

        select_str
    end

    def map!(&prc)

        self.each_char.with_index do |char, i|
            self[i] = prc.call(char, i)
        end

        self
    end


end

# p "app academy".select { |ch| !"aeiou".include?(ch) }   # => "pp cdmy"
# p "HELLOworld".select { |ch| ch == ch.upcase }          # => "HELLO"
# p "HELLOworld".select          # => ""

# word_1 = "Lovelace"
# word_1.map! do |ch| 
#     if ch == 'e'
#         '3'
#     elsif ch == 'a'
#         '4'
#     else
#         ch
#     end
# end
# p word_1        # => "Lov3l4c3"

# word_2 = "Dijkstra"
# word_2.map! do |ch, i|
#     if i.even?
#         ch.upcase
#     else
#         ch.downcase
#     end
# end
# p word_2        # => "DiJkStRa"

