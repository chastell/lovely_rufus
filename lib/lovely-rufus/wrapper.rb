# encoding: UTF-8

module LovelyRufus

  class Wrapper

    NBSP = ' '

    def initialize(text)
      @paras = text.split("\n\n")
    end

    def wrapped(max_width = 72)
      @paras.map do |para|
        best_wrap = wrap_para_to_width(para, max_width)
        (max_width - 1).downto(1) do |width|
          shorter = wrap_para_to_width(para, width)
          break if shorter.count("\n") > best_wrap.count("\n")
          best_wrap = shorter
        end
        best_wrap
      end.join("\n\n")
    end

    private

    def wrap_para_to_width(para, width)
      if para.lines.map { |line| line[0..1] }.uniq == ['> ']
        para = para.lines.map { |line| line[2..-1] }.join
        para = para.tr("\n", ' ').gsub(/ ([^ ]) /, " \\1#{NBSP}").gsub(/(.{1,#{width - 2}})( |$\n?)/, "\\1\n").tr(NBSP, ' ').chomp
        para.lines.map { |line| line.insert(0, '> ') }.join
      else
        para.tr("\n", ' ').gsub(/ ([^ ]) /, " \\1#{NBSP}").gsub(/(.{1,#{width}})( |$\n?)/, "\\1\n").tr(NBSP, ' ').chomp
      end
    end

  end

end
