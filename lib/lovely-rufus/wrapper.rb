# encoding: UTF-8

module LovelyRufus class Wrapper

  NBSP = ' '

  def initialize text
    @paras = text.split(/\n[\/#> ]*\n/).map &:strip
  end

  def wrapped max_width = 72
    @paras.map do |para|
      best = wrap_para_to_width para, max_width
      (max_width - 1).downto 1 do |width|
        shorter = wrap_para_to_width para, width
        break if shorter.lines.count           > best.lines.count
        break if shorter.lines.map(&:size).max > best.lines.map(&:size).max
        best = shorter
      end
      best
    end.join "\n\n"
  end

  private

  def remove_hangouts para, width
    lines = para.split "\n"

    hangout_line = lines.each.with_index do |line, i|
      next unless space = line.rindex(/[ #{NBSP}]/) and i < lines.size - 1
      break i if i > 0              and space + 1 >= lines[i - 1].size
      break i if i < lines.size - 2 and space + 1 >= lines[i + 1].size
      break i if lines.size == 2    and space + 1 >= lines[i + 1].size
    end

    if hangout_line.is_a? Integer
      lines[hangout_line] << NBSP
      fixed = lines.join(' ').gsub "#{NBSP} ", NBSP
      para.replace wrap_para_to_width fixed, width
    end
  end

  def wrap_para_to_width para, width
    quotes = para[/^([\/#> ]*)/]
    leader = quotes.empty? ? '' : quotes.tr(' ', '') + ' '
    width -= leader.size if width > leader.size
    para
      .lines.map { |line| line[quotes.size..-1] }.join  # drop quotes
      .tr("\n", ' ')                                    # unwrap para
      .gsub(/ ([^ ]) /, " \\1#{NBSP}")                  # glue 1-letter words
      .gsub(/(.{1,#{width}})( |$\n?)/, "\\1\n")         # wrap to width
      .tap { |para| remove_hangouts para, width }       # handle hangouts
      .lines.map { |line| line.insert 0, leader }.join  # re-insert leader
      .tr(NBSP, ' ')                                    # drop glue spaces
      .chomp                                            # final touch
  end

end end
