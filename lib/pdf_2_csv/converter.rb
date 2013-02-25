module Pdf2Csv
  class Converter
    require 'csv'
    attr_reader :dirpath

    def initialize(dirpath, instruction = nil)
      @dirpath = dirpath
      @instruction = instruction
    end

    def convert_files!
      validate_directory
      Dir.entries(@dirpath).each do |file|
        next if file == '.' || file == ".."
        convert_file file
      end
    end

    def processed_folder

    end

    private

    def convert_file(file)
      reader = PDF::Reader.new @dirpath + "/#{file}"
      build_csv reader
    end


    def build_csv reader
      csv, lines = '', []
      reader.pages.each do |page|
       lines << page.text.split(/\n/)
      end

      lines.each do |line|
         line.each do |sentence|
           csv += sentence.split(' ').to_csv
         end
      end
      csv
    end

    def validate_directory
      raise "Directory does not exist" unless Dir.exist?(@dirpath)
      raise "Directory is empty" unless Dir.entries(@dirpath).count > 2
    end

  end
end