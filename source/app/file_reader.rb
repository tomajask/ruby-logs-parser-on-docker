# frozen_string_literal: true

class FileReader
  def initialize(filepath)
    @file = File.new(filepath).tap do |io|
      io.advise(:sequential)
    end
  end

  def each(&block)
    file.each do |line|
      block.call(line.gsub(%r{\n$}, ""))
    end
    file.close
  end

  private

  attr_reader :file
end
