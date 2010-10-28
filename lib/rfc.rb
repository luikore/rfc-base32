# coding: binary

# A popular base32 algorithm by RFC4648. (not the Crockford one)
# Ruby 1.9.x Only.
# Reference - http://tools.ietf.org/html/rfc4648#section-6
module RFC
  module Base32

    ENCODE  = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ234567'
    DECODE = Hash[ENCODE.chars.each_with_index.to_a]
    # remain => pad
    PAD = ['', '======', '====', '===', '=']
  
    def encode32 str
      remain = str.bytesize % 5
      str += "\0" * (5 - remain)
      str.gsub!(/.{5}/mn) do |s|
        # split 40bits into [unsigned big endian int] + [unsigned byte]
        d, r = s.unpack 'NC'
        d = (d << 8) | r
        8.times.inject '' do |acc|
          d, r = d.divmod 32
          "#{ENCODE[r]}#{acc}"
        end
      end
      str << PAD[remain]
    end

    def decode32 str
      pad = str[/=*$/]
      str = str[0..(-1-pad.bytesize)]
      str.gsub!(/.{8}/mn) do |s|
        d = s.chars.inject(0) {|s, c| (s << 5) | DECODE[c]}
        r = d & 255
        d >>= 8
        [d, r].pack 'NC'
      end
      str[0..(PAD.index(pad) - 6)]
    end
  end

  extend Base32
end

# test
if $0 == __FILE__
  s = 100.times.map{rand 256}.pack('C*') + "hello_w\r\norld"

  0.upto 10 do |i|
    a = s[0..i]
    b = RFC.decode32 RFC.encode32 a
    raise a if a != b
  end

  require "benchmark"
  puts Benchmark.measure {
    100.times{ RFC.encode32 s }
  }

  puts RFC.encode32 'hello world'

end

