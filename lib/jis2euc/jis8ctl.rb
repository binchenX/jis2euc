#!/usr/bin/ruby -w

=begin

Two area : GL , GR  
For each area it could be ONE of the following 4 value ,that could be  G0 ,G1, G2 and G3.
	GL was init to G0
	GR was init to G2
For G0..G3 ,it could be assigned to different character set. 
	G0 was init to KANJI_1
	G1 was init to EISU
	G2 was init to HIRAGANA
	G3 was init to KATAKANA

How to decide the character set we are using is :
1. which area we are using?
2. what's the value of the that area? Say Gx
3. what is the character was assigned to Gx

Q:what is single shift?
A:We have to restore back to previous code set after finis processing following character. 

Q:How to determine current area?
A:  if current_char > 0x80 
		"GR"
    else 
		"GL"
=end

#To understand how ctl code works

def is_ctl_code? b

	return true if b <= 0x20 or b == 0x7f or (b >0x80 and b < 0xa0) or b == 0xff
	false 
end

=begin
	Table 7-1 Invocation of code elements
	{{0x0f,},      CODE_SET_G0, CODE_AREA_GL, LOCKING_SHIFT},    //LS0 set GL to G0
    {{0x0e,},      CODE_SET_G1, CODE_AREA_GL, LOCKING_SHIFT},    //LS1 set GL to G1
    {{0x1b,0x6e,}, CODE_SET_G2, CODE_AREA_GL, LOCKING_SHIFT},    //LS2 set GL to G2
    {{0x1b,0x6f,}, CODE_SET_G3, CODE_AREA_GL, LOCKING_SHIFT},    //LS3 set GL to G3
    {{0x1b,0x7e,}, CODE_SET_G1, CODE_AREA_GR, LOCKING_SHIFT},    //LS1R set GR to G1
    {{0x1b,0x7d,}, CODE_SET_G2, CODE_AREA_GR, LOCKING_SHIFT},    //LS2R set GR to G2
    {{0x1b,0x7c,}, CODE_SET_G3, CODE_AREA_GR, LOCKING_SHIFT},    //LS3R set GR to G3
    {{0x19,},      CODE_SET_G2, CODE_AREA_GL, SINGLE_SHIFT },    //SS2  set GL to G2 ,single shift
    {{0x1d,},      CODE_SET_G3, CODE_AREA_GL, SINGLE_SHIFT }     //SS3  set GL to G3 ,single shift
=end

$esc_invok = {
	0x6e=>"LS2  : GL=>G2 , locking shift",
	0x6f=>"LS3  : GL=>G3 , locking shift",
	0x7e=>"LS1R : GR=>G1 , locking shift",
	0x7d=>"LS2R : GR=>G2 , locking shift",
	0x7c=>"LS3R : GR=>G3 , locking shift",
	0x7b=>"Confused... "
}
$other_invok = {
	0x0f=>"LS0 : GL=>G0, locking shift",
	0x0e=>"LS1 : GL=>G1, locking shift",
	0x19=>"SS2 : GL=>G2, single shift",
	0x1d=>"SS3 : GL=>G3, single shift",
	#0x20=>"SP",  #means space " "
	#0x0d=>"APR", #means "\n"
	#0x89=>"MSZ", #specify the character size is Middle
}
#?

#Table 7-2 B24
#All start with ESC (0x1B)
$set_designation = [0x24,0x28,0x29,0x2a,0x2b]

$designation_action={
"0x24"		=>"set 2 bytes Graphic set to G0",
"0x24,0x29" =>"set 2 bytes Graphic set to G1",
"0x24,0x2a" =>"set 2 bytes Graphic set to G2",
"0x24,0x2b" =>"set 2 bytes Graphic set to G3",
"0x28"		=>"set 1 bytes Graphic set to G0",
"0x29"		=>"set 1 bytes Graphic set to G1",
"0x2a"		=>"set 1 bytes Graphic set to G2",
"0x2b"		=>"set 1 bytes Graphic set to G3",
}
ESC = 0x1b
$encoding_mapping = {
	"0x39"=>"kanji1",
	"0x3a"=>"kanji2",
	"0x4a"=>"eisu",
	"0x30"=>"hira",
	"0x31"=>"kata",
	"0x3b"=>"tusika",
}

#
#
#
#



class Jis8charset

	
  include Singleton
  
def initialize

	@areas= {"GL"=> "G0" , "GR" => "G2"}
	@sets = {"G0"=> "kanji1" , "G1" => "eisu", "G2"=>"hira","G3"=>"kata"}
	@last_gl = "G0"
	@single_shift = false
end

def reset 
	@areas= {"GL"=> "G0" , "GR" => "G2"}
	@sets = {"G0"=> "kanji1" , "G1" => "eisu", "G2"=>"hira","G3"=>"kata"}
	@last_gl = "G0"
	@single_shift = false
end

def verbose s
	#puts s
end

def get_current_charset area
	charset = @sets[@areas[area]] 
	bytes = if charset.eql?("kanji1") or charset.eql?("tusika") then 2 else 1 end

	return charset , bytes , @single_shift
end

def set_area area ,graphic_set ,single_shift=false
	raise ArgumentError, "unknow #{area} , illeale key" if !@areas.key?(area)
	if single_shift
		raise ArgumentError if !area.eql?("GL")
		@last_gl = @areas["GL"]
		@single_shift = true
	end
	@areas[area] = graphic_set
end

def set_graphicset graphic_set, character_set
	raise ArgumentError, "unknow #{graphic_set} , illeale key" if !@sets.key?(graphic_set)
	verbose "set #{graphic_set} to #{character_set}"
	@sets[graphic_set] = character_set
end

def show
	p @areas
	p @sets
end

def restore 
	#TODO: restore previous value if current is single shift 
	#
	#only to restore @areas["GL"]
	@areas["GL"]=@last_gl
	@single_shift = false
end


def do action
	matches = /.*(\w{2})=>(\w{2}).*/.match(action)
	shift = (action.include?("single") ? true :false)
	set_area(matches[1],matches[2],shift)
end


def do_b action , para
	verbose "action #{action}"
	action =~ /to\s(.*)/
	set=$1
	raise ArgumentError , "unknow encoding format #{para}" unless $encoding_mapping.key?(para)
	log = action + " using " +  "[#{$encoding_mapping[para]}]"
	verbose "-> Action : #{log}"
	@sets[set]=$encoding_mapping[para]
end

end

def test_jis8charset


j = Jis8charset.new

puts j.get_current_charset "GL"

puts j.get_current_charset "GR"

j.show
j.set_area("GL","G1")
j.set_graphicset("G0" ,"eisu")
j.set_graphicset("G1" ,"kanji")
j.show


#matches = /.*(\w{2})=>(\w{2}).*/.match("xxxxxx GL=>G0 yyyyy ")
puts  action = $esc_invok[0x6e]
j.do(action)

c , b , shift = j.get_current_charset("GL")
puts c
puts b
puts shift

end

#test_jis8charset
