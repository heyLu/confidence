#!/usr/bin/env ruby

require 'json'

def ask_for_task()
  `zenity --forms --add-entry 'Task name' --add-list 'Task duration' --list-values='15min|30min|1h|2h'`
end

def parse_task(task_answer)
  task_name, task_duration = task_answer.strip().split('|')
  duration = parse_duration(task_duration)
  {name: task_name, end: Time.now + duration}
end

def parse_duration(duration)
  case duration
  when '15min'
    15 * 60
  when '30min'
    30 * 60
  when '1h'
    60 * 60
  when '2h'
    2 * 60 * 60
  else
    15 * 60
  end
end

class File
  def self.append(name, str)
    write(name, str, {mode: 'a'})
  end
end

def answer_once()
  answer = ask_for_task()
  task = parse_task(answer)
  puts("-- working on '#{task[:name]}' until #{task[:end]}")
  File.append("#{File.join(Dir.home, ".deadlines.json")}", JSON.dump(task) + "\n")
  sleep(task[:end] - Time.now)
end

if __FILE__ == $0
  while true
    answer_once()
  end
end
