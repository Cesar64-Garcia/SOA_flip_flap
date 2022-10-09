# frozen_string_literal: true

# Module that can be included (mixin) to take and output TSV data
module TsvBuddy
  # take_tsv: converts a String with TSV data into @data
  # parameter: tsv - a String in TSV format
  def take_tsv(tsv)
    lines = tsv.split("\n").map { |line| split_by_tab(line) }
    headers = get_header_arr(lines)
    @data = lines[1..].map { |line| create_header_line_hash(headers, line) }
  end

  def get_header_arr(lines)
    raise 'No header detected' if lines.empty?

    lines.first
  end

  def create_header_line_hash(header, line)
    header.zip(line).to_h
  end

  def split_by_tab(text)
    text.strip.split(/\t/)
  end

  # to_tsv: converts @data into tsv string
  # returns: String in TSV format
  def to_tsv
    "#{data_to_tsv_header}\n#{data_to_tsv_lines}\n"
  end

  def data_to_tsv_header
    raise 'No header detected' if @data.empty?

    @data[0].keys.join("\t")
  end

  def data_to_tsv_lines
    @data.map { |item| item.values.join("\t") }.join("\n")
  end
end
