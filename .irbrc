require 'irb/completion'

# Some improvements to irb (coloring + ???)
require 'wirb'
Wirb.start

# A history of commands separated by lines.
#  @param hist_file the path to the history file (like ~/.bash_history)
#  @param hist_src the 'backend' that records the history.
#                  Must respond to #to_a and #push.
class StoredHistory
  def initialize hist_file, hist_src=Readline::HISTORY
    @history = hist_file
    @src     = hist_src
    
    @last_history = File.read(@history).lines.map(&:strip) rescue []
    @last_history.each do |line|
      @src.push line
    end
    
    at_exit do
      unless @last_history == @src.to_a.reverse.uniq.reverse
        puts "Writing changed history back to #{@history}"
        File.write @history, @src.to_a.reverse.uniq.reverse.reduce { |x,y| "#{x}\n#{y}" }
      end
    end
  end
end

StoredHistory.new File.join(Dir.home, ".irbhistory")
