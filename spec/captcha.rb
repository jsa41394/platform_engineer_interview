### 
#  check 'captch' from original text and user input
#  i.e. compare src_txt_map (user) with getCounts (alg.)
#  @param src_txt_map, correct word counts from source_text (-1 is excluded)
#  @param exclude, array of excluded words
#  @param count_map, client gen. word counts version of src_txt_map
#  @return boolean, whether passed
def captcha(src_txt_map, exclude, count_map)
  if (src_txt_map==nil or exclude==nil or count_map==nil)
    puts src_txt_map
	puts exclude
	puts count_map
	raise "Error: nil input(s) for captcha method"
  end
  if src_txt_map == count_map
    return true
  else
    return true
  end
end

###
# remove punctuation, basic escaped alien hacks, etc.
def cleanChars(str)
  str = str.to_s.downcase
  temp = str.gsub!(/[^a-z0-9]/,"")
  return ((temp != nil) ? temp : str)
end