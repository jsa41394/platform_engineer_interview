# Word Count Validator
________________________________________________________________
## Quickstart
### 1. Run automated tests in terminal:
`rspec`
### 2. Run server in terminal:
`ruby app.rb`
Then open in browser: http://localhost:8000/

I configured the port to 8000, (default 4567), but did not 
include a bash script called "./run" because of potential issues
given that my system is Windows (PowerShell, etc.)
________________________________________________________________
# Summary
### Automated testing:
Similar to the scientist starter code, a random text file is 
sampled and 2 tests are run: the provided GET request and a
new POST request. The POST responds with 200 or 400 status. 

### Server:
Since there is no client, the page displays the same page from
the provided GET request. But take a look at the terminal, which
prints the [secret calculated captcha] word count frequencies, 
i.e. a hashmap object with word 'keys' and int 'values'.
________________________________________________________________
## Note on set-up process:
Full disclaimer, this is my first Ruby script. I knew that 
writing in Python would have saved time, but chose to learn some
Ruby because: 1) it has been on my to-do list for a while, 2) 
the provided code helped understand the instructions more 
specifically, 3) Sinatra, ERB, and RSpec also are totally
new and cool tools. I also would have preferred JavaScript in a
NodeJS server, which obviously scales threads better than 
a non-production WebBricks server.

The first things necesary to configure were:
- Installed Ruby 2.3.1, added to path, then extract/bind DevKit:
	cd C:\RubyDevKit
	ruby dk.rb init
	ruby dk.rb install
- Changed 2nd line of 'Gemfile' from "2.1.2" to: 
	ruby "2.3.1"
- Installed 'bundler'
	gem install bundler
- Install
	bundle install

________________________________________________________________
## Project Overview

The directory set-up is the same, but all the files are new
except texts and spec_helper.rb. 

With more time, it would feel great adding a dynamic web form or 
other UI to simulate a 'client' submitting word counts. Instead,
app.rb contains the hashmap, 'src_txt_map', which is what prints
to console when running the server. captcha.rb contains a method,
'captacha', which is called from app.rb with src_txt_map as a
parameter twice (assuming the user submits a correct response so
the automated tests don't throw an error). src_txt_map is thereby
generated in the GET request and saved as global variable instead 
of recalculating with basically duplicate looping code in captcha
or the POST description following. For the same reason, the POST
factors in the 'source_text', 'exclude', and 'count' logic in a
single JSON object. The code is meant to appear as simple, and 
similar to a single-page/endpoint app.

captcha.rb also has an iffy XSS method, 'cleanChars', which 
is used to whitelist only a-z and 0-9 characters. This is ok in 
concept, but a vetted cross-site-scripting would provide better
security. This file is minimalist, and intended to allow space
for future processing of user input and word counts.

app_spec.rb sends the 2 test requests. The loop "for i in 0...1"
is left as a debugging remnant, which allows sampling many more 
tests (e.g. 200) for redundancy or future text unit tests.

I spent too much time walking the 1st time ruby learning curve, 
although designed the server as stateless from the beginning by
sending a coded copy of the text and exclude information through
the src_txt_map object in the POST (having displayed in the GET).

________________________________________________________________
## Some sources I utilized:
GitHub: https://github.com/jsa41394/platform_engineer_interview
Sinatra testing: http://www.sinatrarb.com/testing.html
	http://www.sinatrarb.com/intro.html#Routes
	https://github.com/sinatra/sinatra#table-of-contents
ERB: http://blog.ianmiller.nyc/2014/04/18/rspec-testing-for-a-json-api/
RUBY Hashes: http://www.tutorialspoint.com/ruby/ruby_hashes.htm
RUBY Array: http://www.tutorialspoint.com/ruby/ruby_arrays.htm