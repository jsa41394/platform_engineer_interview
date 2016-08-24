require 'sinatra'
require "sinatra/reloader" if development?
require_relative "spec/captcha"

set :port, 8000

#  globals
exclude = nil
source_text = nil
src_txt_map = nil

get '/' do
  files = %w(texts/0 texts/1 texts/2 texts/3 texts/4 texts/5)

  text_file = files.sample
  source_text = File.read(text_file).strip
  src_txt_map = Hash.new  # word count of freqs.
  text_array = source_text.split.shuffle  # shuffled
  
  for i in ((0)...(text_array.length))
    temp = cleanChars( text_array[i] )
	src_txt_map[ temp ] = src_txt_map.fetch(temp, -1) + 1;  # increment count
  end

  exclude = []
  for i in ((text_array.length - 5)...(text_array.length))
	exclude << cleanChars(text_array[i])
	src_txt_map[ cleanChars(text_array[i]) ] = -1  # overwrite excluded
  end

  puts "Word counts:"
  puts src_txt_map.to_s
   
  status 200
  erb :"get.json", locals: { source_text: source_text, exclude: exclude, src_txt_map: src_txt_map }
end

post '/' do
  result = captcha(src_txt_map, exclude, src_txt_map)  # check user from passed obj.
  # skip, (pass twice) instead of recalculating based on client input
  # calculation was done as src_txt_map for this demo get request
  # for actual client, would pass source_text instead of src_txt_map

  if(!result)
    status 400
    body '400 Bad Request'
	erb :"post.json", locals: { response: "Sorry, that\'s wrong. Nice try space troll." }
  else
    status 200
    erb :"post.json", locals: { response: "Looks great." }
  end
end