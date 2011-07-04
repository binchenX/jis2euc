#!/usr/bin/env ruby 
# encoding: utf-8

require 'iconv'
require 'jis8ctl.rb'
=begin
Dir.foreach("sample")  do  |f|
	puts "->#{f}";
	f.each_byte  {|b| puts b}

end
=end




#puts "中文"
#puts "Résumés"
#puts "講座は4つの分野で"

if RUBY_VERSION < "1.9"
#no use in ruby 1.9
$KCODE = "UTF8"
end


def test_1
ch = "中文"
fr = "Résumés"
jp = "講座は4つの分野で"
eng = "Hello"
a = [eng,ch, fr, jp].each do |s|

	puts "->#{s}"
	if RUBY_VERSION > "1.9"
	puts RUBY_VERSION 
	puts s.encoding.name
	#s.each_char {|c| puts c}

	else	
	puts RUBY_VERSION 
	puts %w|->scan(/./u):|
	p s.scan(/./u)
	puts "->size = #{s.size}"
	puts "->length = #{s.length}"
	puts "->each_char :"
	s.each_char {|c| print c , ","}
	print "\n"
	puts "->each_byte :"
	s.each_byte {|b| print b , ","} 
	print "\n"
	end
	#puts s.encode("UTF-8")
end


#convert EUC-JP to UTF-8 so that Terminal can display it

utf8_jp = "講座は4つの分野で"   #as the source coding is UTF8 , it will be UTF8
puts utf8_jp.size
utf8_jp.each_byte {|b| print b , ","} ;print "\n"
euc_jp = Iconv.conv("EUCJP","UTF8",utf8_jp)
puts "ouput euc_jp coding :"
puts euc_jp  #Terminal can not understand EUC-JP ,so only garbage ouput
puts euc_jp.size
euc_jp.each_byte {|b| print b , ","} ; print "\n"
puts "convert back to utf-8"
utf8_jp_again = Iconv.conv("UTF8","EUCJP",euc_jp) 
puts utf8_jp_again

end

$eisu_to_euc = [
     0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000,
     0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000 ,
     #        !       "       #       $       %       &       '       (       )       *       +       ,       -       .       /         
     0xA1A0, 0xA1AA, 0xA1ED, 0xA1F4, 0xA1F0, 0xA1F3, 0xA1F5, 0xA1EC, 0xA1CA, 0xA1CB, 0xA1F6, 0xA1DC, 0xA1A4, 0xA1BD, 0xA1A5, 0xA1BF ,
     #0       1       2       3       4       5       6       7       8       9       :       ;       <       =       >       ?         
     0xA3B0, 0xA3B1, 0xA3B2, 0xA3B3, 0xA3B4, 0xA3B5, 0xA3B6, 0xA3B7, 0xA3B8, 0xA3B9, 0xA1A7, 0xA1A8, 0xA1E3, 0xA1E1, 0xA1E4, 0xA1A9 ,
     #@       A       B       C       D       E       F       G       H       I       J       K       L       M       N       O
     0xA1F7, 0xA3C1, 0xA3C2, 0xA3C3, 0xA3C4, 0xA3C5, 0xA3C6, 0xA3C7, 0xA3C8, 0xA3C9, 0xA3CA, 0xA3CB, 0xA3CC, 0xA3CD, 0xA3CE, 0xA3CF ,
     #P       Q       R       S       T       U       V       W       X       Y       Z       [       \       ]       ^       _
     0xA3D0, 0xA3D1, 0xA3D2, 0xA3D3, 0xA3D4, 0xA3D5, 0xA3D6, 0xA3D7, 0xA3D8, 0xA3D9, 0xA3DA, 0xA1CE, 0xA1EF, 0xA1CF, 0xA1B0, 0xA1A1 ,
     #`       a       b       c       d       e       f       g       h       i       j       k       l       m       n       o
     0xA1AE, 0xA3E1, 0xA3E2, 0xA3E3, 0xA3E4, 0xA3E5, 0xA3E6, 0xA3E7, 0xA3E8, 0xA3E9, 0xA3EA, 0xA3EB, 0xA3EC, 0xA3ED, 0xA3EE, 0xA3EF ,
     #p       q       r       s       t       u       v       w       x       y       z       {       |       }       ~
     0xA3F0, 0xA3F1, 0xA3F2, 0xA3F3, 0xA3F4, 0xA3F5, 0xA3F6, 0xA3F7, 0xA3F8, 0xA3F9, 0xA3FA, 0xA1D0, 0xA1C3, 0xA1D1, 0xA1B1, 0x0000 
	] 



$hiragana_to_euc = [
     #0       1       2       3       4       5       6       7       8       9       10      11      12      13      14      15
     0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000 ,
     0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000 ,
     0xA1A0, 0xA4A1, 0xA4A2, 0xA4A3, 0xA4A4, 0xA4A5, 0xA4A6, 0xA4A7, 0xA4A8, 0xA4A9, 0xA4AA, 0xA4AB, 0xA4AC, 0xA4AD, 0xA4AE, 0xA4AF ,
     0xA4B0, 0xA4B1, 0xA4B2, 0xA4B3, 0xA4B4, 0xA4B5, 0xA4B6, 0xA4B7, 0xA4B8, 0xA4B9, 0xA4BA, 0xA4BB, 0xA4BC, 0xA4BD, 0xA4BE, 0xA4BF ,
     0xA4C0, 0xA4C1, 0xA4C2, 0xA4C3, 0xA4C4, 0xA4C5, 0xA4C6, 0xA4C7, 0xA4C8, 0xA4C9, 0xA4CA, 0xA4CB, 0xA4CC, 0xA4CD, 0xA4CE, 0xA4CF ,
     0xA4D0, 0xA4D1, 0xA4D2, 0xA4D3, 0xA4D4, 0xA4D5, 0xA4D6, 0xA4D7, 0xA4D8, 0xA4D9, 0xA4DA, 0xA4DB, 0xA4DC, 0xA4DD, 0xA4DE, 0xA4DF ,
     0xA4E0, 0xA4E1, 0xA4E2, 0xA4E3, 0xA4E4, 0xA4E5, 0xA4E6, 0xA4E7, 0xA4E8, 0xA4E9, 0xA4EA, 0xA4EB, 0xA4EC, 0xA4ED, 0xA4EE, 0xA4EF ,
     0xA4F0, 0xA4F1, 0xA4F2, 0xA4F3, 0x0000, 0x0000, 0x0000, 0xA1B5, 0xA1B6, 0xA1BC, 0xA1A3, 0xA1D6, 0xA1D7, 0xA1A2, 0xA1A6, 0x0000  
	]

$katakana_to_euc = [
    #0       1       2       3       4       5       6       7       8       9       10      11      12      13      14      15
     0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000 ,
     0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000, 0x0000 ,
     0xA1A0, 0xA5A1, 0xA5A2, 0xA5A3, 0xA5A4, 0xA5A5, 0xA5A6, 0xA5A7, 0xA5A8, 0xA5A9, 0xA5AA, 0xA5AB, 0xA5AC, 0xA5AD, 0xA5AE, 0xA5AF ,
     0xA5B0, 0xA5B1, 0xA5B2, 0xA5B3, 0xA5B4, 0xA5B5, 0xA5B6, 0xA5B7, 0xA5B8, 0xA5B9, 0xA5BA, 0xA5BB, 0xA5BC, 0xA5BD, 0xA5BE, 0xA5BF ,
     0xA5C0, 0xA5C1, 0xA5C2, 0xA5C3, 0xA5C4, 0xA5C5, 0xA5C6, 0xA5C7, 0xA5C8, 0xA5C9, 0xA5CA, 0xA5CB, 0xA5CC, 0xA5CD, 0xA5CE, 0xA5CF ,
     0xA5D0, 0xA5D1, 0xA5D2, 0xA5D3, 0xA5D4, 0xA5D5, 0xA5D6, 0xA5D7, 0xA5D8, 0xA5D9, 0xA5DA, 0xA5DB, 0xA5DC, 0xA5DD, 0xA5DE, 0xA5DF ,
     0xA5E0, 0xA5E1, 0xA5E2, 0xA5E3, 0xA5E4, 0xA5E5, 0xA5E6, 0xA5E7, 0xA5E8, 0xA5E9, 0xA5EA, 0xA5EB, 0xA5EC, 0xA5ED, 0xA5EE, 0xA5EF ,
     0xA5F0, 0xA5F1, 0xA5F2, 0xA5F3, 0xA5F4, 0xA5F5, 0xA5F6, 0xA1B3, 0xA1B4, 0xA1BC, 0xA1A3, 0xA1D6, 0xA1D7, 0xA1A2, 0xA1A6, 0x0000  
	]


$debug = false 
def verbose s
	puts s if $debug 
end
$eucjp_to_utf8 = Iconv.new("UTF8//TRANSLIT//IGNORE","EUCJP")

def test_iconv_euc_to_utf8
	puts "=================="
	#Refer to : http://www.rikai.com/library/kanjitables/kanji_codes.euc.shtml
	#s = [0xa3,0xb0,0xa5,0xc0,0x8f,0xe6,0xc0,0x8f,0xe6,0xd0].inject("")  {|s ,b| s << b.chr}
	s = [0xa1,0xa1,0xdf,0xb7,0xba,0xea].inject("")  {|s ,b| s << b.chr}
	#display ０ダ闟阺  
	puts $eucjp_to_utf8.iconv(s)
end

def to_euc from ,a ,b = 0x00
	special = [0x2d,0x7a,0x7b,0x7c,0x7e,0x7f]
v =	case from
	when "eisu" then $eisu_to_euc[a & 0x7F]	
	when "hira" then $hiragana_to_euc[a & 0x7F]	
	when "kata" then $katakana_to_euc[a & 0x7F]
	#Hack. Icon can not handle 0x2Dxx ,which is leagal in JIS-X-0213
	when "kanji1" then if special.index(a) != nil then 0xa1a1 else ((a|0x80) << 8 )+ (b|0x80) end
	when "tusika" then ((a|0x80) << 8 )+ (b|0x80)  #these are character in 91-93 , we may not be able to show  correctly in desktop
	else raise ArgumentError , "unknow encoding  #{from}"
	end	
	s = ""
	s << ((v & 0xFF00) >> 8 ).chr << (v & 0x00FF).chr
end
def test_display_eisu
	s_euc = ""
	0x23.upto(0x7e) do  |eisu|
		s_euc << to_euc("eisu",eisu)
	end	
	0x23.upto(0x7e) do  |b|
		s_euc << to_euc("hira",b)
	end	
	0x23.upto(0x7e) do  |b|
		s_euc << to_euc("kata",b)
	end
	#Kanji1
	s_euc << to_euc("kanji1",0x5f,0x37)	
	puts $eucjp_to_utf8.iconv(s_euc)
end

$jis8 = Jis8charset.new
def arib_jis_to_euc s

	#convert string to array , so that we can index it freely
	src = []
    out = ""
	s.each_byte {|c| src << c} 
	#each message is independent of each other
	$jis8.reset	
	
	if $debug	
		puts "convert following string to euc :"
		src.each_with_index do |c , index|
			print  "#{c.to_s(16)} " 
		end

		puts "\n"
	end

	while !src.empty?
			c1 = src.shift
			if $debug
				print "c1 : #{c1.to_s(16)}     "
				if is_ctl_code?(c1) then puts "->Is CTL" else print "->Char" end
			end
			if is_ctl_code?(c1)
					#may need to get c2, c3 to determine what to do.
					if c1 == ESC
						verbose "ESC .."
						c2 = src.shift
						if $esc_invok.key?(c2)
							action = $esc_invok[c2]
							verbose  action
							$jis8.do(action)
						elsif $set_designation.index(c2) != nil
							#raise StandardError , "this case no implemented yet"
							#Let's check follwing 3 bytes,using powerful regex!
							c3 = src[1].nil? ? nil : src[1].to_s(16)
							s = [c2.to_s(16),  src[0].to_s(16) , c3 ].join(',')
							#puts "following 3 string #{s}"
							if s =~ /(24,29,|24,2a,|24,2b,)([0-9a-f]{1,})/ 
								cmd , para = $1 , $2
							elsif s =~ /(24,|28,|29,|2a,|2b,)([0-9a-f]{1,})/ 
								cmd , para = $1 , $2
							else 
								raise ArgumentError , "unknow ctrl command"
							end
							verbose "-> CTL #{cmd.split(",").map{|t| "0x"+t}.join(",")}  Type #{para}"
							action = $designation_action[cmd.split(",").map {|t| "0x"+t}.join(",")]
							$jis8.do_b(action ,"0x"+para)
							c = cmd.split(",").size 
							c.times {|i| src.shift}
							#may need to take two more
						end
					elsif $other_invok.key?(c1)
							action = $other_invok[c1]
							verbose  action
							$jis8.do(action)
					elsif c1 == 0x20
						out << " "
					elsif c1 == 0x0d
						out << "\n"
					elsif c1 == 0x89
						verbose "ingor"
					else 
						verbose "ignor"	
					end
			else
				#depend on what current charaset is using , we will get one or two characters
				area = (c1 > 0x80) ? "GR" : "GL"
				charset , bytes , single_shift = $jis8.get_current_charset(area)
				#ignor tusika character
				verbose "-> #{charset.ljust(10)} , #{bytes}"
				if charset.eql?("tusika")
						c2 = src.shift
						out << "~~"
				else
					if bytes == 1
						out << to_euc(charset, c1)
					elsif bytes == 2
						c2 = src.shift
						if c2.nil?
							#It is an error. Just ignor it
							out << "??"
							puts "Error: No more bytes for 2 bytes character."
						else
							out << to_euc(charset, c1, c2 )
						end
						#used to locate error when iconv
						verbose euc_to_utf8(out)	
					end
				end
				$jis8.restore if single_shift

			end

	end


	out	
end

def euc_to_utf8 euc

 $eucjp_to_utf8.iconv(euc)
end

def test_arib_jis_to_euc
s = [0xe,0x51,0x56,0x43,0xf,0x21,0x21,0x5f,0x37,0x3a,0x6a,0x89,0x20,0x8a,0x4e,0x34,0x3f,0x4d,0xce,0x1b,0x7c,0xc9].inject("")  {|s,c| s << c.chr}

euc_s = arib_jis_to_euc(s)
puts euc_to_utf8(euc_s)

end
 
def test_arib_jis_to_euc_2
raw = "32 2d 46 6c cb fb 1b 7c b5 d0 cb fc 1b 7d c8 a4 a6 45 41 45 7d ce 3e 2e 3d 2e c7 e 33 37 f 2d 52 e2 ce 35 77 4e 25 f2 41 66 a4 c7 3f 4a e0 32 61 39 73 ca 1b 7c ec f9 b9 1b 7d ac a2 eb fa b3 ce 1b 7c ec f9 b9 1b 7d cb 3b 32 32 43 b9 eb e 35 30 f 42 65 ce 43 4b bf c1 ac 4d 27 3e 70 f2 49 70 34 6f cb 42 4e 4e 4f ce 4a 49 f2 3e 68 ea 31 5b a8 eb 3b 51 f2 44 49 c3 bf fa "
raw = "1b 24 3b 7a 56 1b 24 39 34 6f 21 21 4c 34 39 29 4b 3c fb 35 35 4e 76 ac 3f 25 ea ca b9 37 4a 3f 27 fc "
raw = "1b 24 2a 3b fa d7 1b 7c ab f3 cb f3 b0 1b 2a 30 1b 7d ce e 44 41 49 f 30 42 35 48 46 7c 21 2a "
raw = "48 56 41 48 46 62 4d 46 e 32 89 2d 8a 1b 24 3b "
s = raw.split.map  {|t| ("0x"+t).to_i(16)}.inject("") {|s,c| s << c.chr}
 
euc_s = arib_jis_to_euc(s)
puts euc_to_utf8(euc_s)
end
#test_iconv_euc_to_utf8
#test_display_eisu
test_arib_jis_to_euc_2
