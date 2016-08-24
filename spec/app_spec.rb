require "./spec/spec_helper"
require "json"
require "captcha"

puts "Starting testing..."
parsed_response = nil
parsed_response2 = nil
src_txt_map = nil

describe 'The Word Counting App' do
  def app
    Sinatra::Application
  end

  for i in 0...1
	it "returns 200 and has the right keys" do
	  get '/'
	  expect(last_response).to be_ok
	  parsed_response = JSON.parse(last_response.body)
	  expect(parsed_response).to have_key("text")
	  expect(parsed_response).to have_key("exclude")
	end
  
	it "has the right count" do
	  post '/', params = {'count_map': src_txt_map }
	  expect(last_response).to be_ok
	  parsed_response2 = JSON.parse(last_response.body)
	  expect(parsed_response2['response']).to eq("Looks great.");
	end
  end
end