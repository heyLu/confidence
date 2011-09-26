require 'irb/completion'

# Some improvements to irb (coloring + ???)
require 'wirb'
Wirb.start

# Make irb's history persistent
irbhistory = File.join Dir.home, ".irbhistory"

last_history = File.read irbhistory rescue ""
last_history.lines.each do |line|
  Readline::HISTORY.push line.strip
end

def save_history
  puts "Writing history back..."
  File.write irbhistory, Readline::HISTORY.to_a.uniq.reduce { |x,y| "#{x}\n#{y}" }
end

at_exit do
  save_history
end
