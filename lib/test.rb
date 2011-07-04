require './lib/jis2euc'
#require 'jis2euc'
require 'test/unit'

#THIS IS MUST
if RUBY_VERSION < "1.9"
#no use in ruby 1.9
$KCODE = "UTF8"
end

class TC_JIS2EUC < Test::Unit::TestCase

def setup
  
@raw1 = "32 2d 46 6c cb fb 1b 7c b5 d0 cb fc 1b 7d c8 a4 a6 45 41 45 7d ce 3e 2e 3d 2e c7 e 33 37 f 2d 52 e2 ce 35 77 4e 25 f2 41 66 a4 c7 3f 4a e0 32 61 39 73 ca 1b 7c ec f9 b9 1b 7d ac a2 eb fa b3 ce 1b 7c ec f9 b9 1b 7d cb 3b 32 32 43 b9 eb e 35 30 f 42 65 ce 43 4b bf c1 ac 4d 27 3e 70 f2 49 70 34 6f cb 42 4e 4e 4f ce 4a 49 f2 3e 68 ea 31 5b a8 eb 3b 51 f2 44 49 c3 bf fa "
@raw2 = "1b 24 3b 7a 56 1b 24 39 34 6f 21 21 4c 34 39 29 4b 3c fb 35 35 4e 76 ac 3f 25 ea ca b9 37 4a 3f 27 fc "
@raw3 = "1b 24 2a 3b fa d7 1b 7c ab f3 cb f3 b0 1b 2a 30 1b 7d ce e 44 41 49 f 30 42 35 48 46 7c 21 2a "
@raw4 = "48 56 41 48 46 62 4d 46 e 32 89 2d 8a 1b 24 3b "
@raw5 =  [0xe,0x51,0x56,0x43,0xf,0x21,0x21,0x5f,0x37,0x3a,0x6a,0x89,0x20,0x8a,0x4e,0x34,0x3f,0x4d,0xce,0x1b,0x7c,0xc9].inject("")  {|s,c| s << c.chr}

end
def test_arib_jis_to_euc_2

puts_jis(@raw1)
puts_jis(@raw2)
puts_jis(@raw3)
puts_jis(@raw4)
puts_jis(@raw5)

end


def puts_jis raw
  
   s = raw.split.map  {|t| ("0x"+t).to_i(16)}.inject("") {|p,c| p << c.chr} 
   euc_s = Jis2euc.jis2euc(s)
   puts Jis2euc.euc2utf8(euc_s)
end

def test_euc_to_utf8
  #Refer to : http://www.rikai.com/library/kanjitables/kanji_codes.euc.shtml
  #s = [0xa3,0xb0,0xa5,0xc0,0x8f,0xe6,0xc0,0x8f,0xe6,0xd0].inject("")  {|s ,b| s << b.chr}
  s = [0xa1,0xa1,0xdf,0xb7,0xba,0xea].inject("")  {|p ,b| p << b.chr} 
  puts Jis2euc.euc2utf8(s)
end


end

#test_iconv_euc_to_utf8
#test_display_eisu
#test_arib_jis_to_euc_2
