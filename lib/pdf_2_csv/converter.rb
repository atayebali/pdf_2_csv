module Pdf2Csv
  class Converter
    require 'csv'
    attr_reader :dirpath

    def initialize(input_dirpath, instruction = nil)
      @dirpath = input_dirpath
      @instruction = instruction
    end

    def pdf_file? filename
      !filename.scan(/\.pdf$/).empty?
    end

    def invalid_file? filename
      filename == '.' || filename == ".."
    end

    def convert_files!
      validate_directory
      Dir.entries(@dirpath).each do |file|
        next if invalid_file? file
        if pdf_file? file
          csv = convert_file file
          write_to_file csv,file
        end
      end
    end

    private

    def convert_file(file)
      reader = PDF::Reader.new @dirpath + "/#{file}"
      build_csv reader
    end

    def write_to_file csv, filename
      name = @dirpath +"/#{Time.now.strftime("%m-%d-%y-%I:%M_%p")}_#{filename}.csv"
      File.open(name, 'w') { |f| f.write csv }
    end


    def build_csv reader
      csv= ''
      lines = reader.pages.map do |page|
        page.text.split(/\n/)
      end

      if @instruction.nil?
        lines.each do |line|
          line.each {|sentence| csv += sentence.split(' ').to_csv}
        end
      else
        csv = @instruction.to_csv(lines)
      end

      csv
    end

    def validate_directory
      raise "Directory does not exist" unless Dir.exist?(@dirpath)
      raise "Directory is empty" unless Dir.entries(@dirpath).count > 2
    end

  end
end