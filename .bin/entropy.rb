#!/usr/bin/env ruby

def shannon_entropy(s)
  d = {}
  s.each_char do |c|
    d[c] ||= 0.0
    d[c] += 1
  end

  res = 0.0
  d.each_value do |v|
    freq = v / s.length
    res -= freq * (Math.log(freq) / Math.log(2))
  end

  res
end

if __FILE__ == $0
  $stdin.each_line do |line|
    e = shannon_entropy(line)
    puts format("%.4f\t%s", e, line)
  end
end
