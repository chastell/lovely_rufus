module LovelyRufus class Wrapper
  NBSP = ' '

  def initialize text
    @paras = text.split(/\n[\/#> ]*\n/).map { |para| Para.new para.strip }
  end

  def wrapped max_width = 72
    return '' if paras.all?(&:empty?)

    paras.map do |para|
      para.wrap_para_recursively max_width
    end.join "\n\n"
  end

  attr_reader :paras
  private     :paras

  private

  class Para < SimpleDelegator
    def find_hangout_line lines
      lines.find.with_index do |line, i|
        i < lines.size - 1 and
        space = hangout_last_space(line) and
        (hangout_to_previous_line i, lines, space or
        hangout_to_next_line i, lines, space)
      end
    end

    def hangout_last_space line
      line.rindex(/[ #{NBSP}]/)
    end

    def hangout_to_next_line i, lines, space
      (i < lines.size - 2 or lines.size == 2) and space + 1 >= lines[i + 1].size
    end

    def hangout_to_previous_line i, lines, space
      i > 0 and space + 1 >= lines[i - 1].size
    end

    def remove_hangouts para, width
      lines = para.split "\n"
      hangout_line = find_hangout_line lines
      if hangout_line
        hangout_line << NBSP
        fixed = self.class.new lines.join(' ').gsub "#{NBSP} ", NBSP
        para.replace fixed.wrap_para_to_width width
      end
    end

    def wrap_para_recursively max_width
      best = wrap_para_to_width max_width
      (max_width - 1).downto 1 do |width|
        shorter = wrap_para_to_width width
        break if shorter.lines.count           > best.lines.count
        break if shorter.lines.map(&:size).max > best.lines.map(&:size).max
        best = shorter
      end
      best
    end

    def wrap_para_to_width width
      quotes = self[/^([\/#> ]*)/]
      leader = quotes.empty? ? '' : quotes.tr(' ', '') + ' '
      width -= leader.size if width > leader.size
      lines
        .map { |line| line[quotes.size..-1] }.join        # drop quotes
        .tr("\n", ' ')                                    # unwrap para
        .gsub(/ ([^ ]) /, " \\1#{NBSP}")                  # glue 1-letter words
        .gsub(/(.{1,#{width}})( |$\n?)/, "\\1\n")         # wrap to width
        .tap { |par| remove_hangouts par, width }         # handle hangouts
        .lines.map { |line| line.insert 0, leader }.join  # re-insert leader
        .tr(NBSP, ' ')                                    # drop glue spaces
        .chomp                                            # final touch
    end
  end
end end
