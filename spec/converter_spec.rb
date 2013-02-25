require 'spec_helper'

describe Pdf2Csv::Converter do
  it "converts pdf to csv" do
    expect { Pdf2Csv::Converter.new }.to raise_error
  end

  it "takes a string as dir path" do
    converter = Pdf2Csv::Converter.new 'BAM'
    converter.dirpath.should eq 'BAM'
  end

  describe "#convert_files!" do
    def setup_pdf
      FileUtils.cp "./spec/test_input/sample.pdf", "./spec/pdfs/sample.pdf"
      @dirpath = "./spec/pdfs/"
    end

    before(:each) do
      setup_pdf
      @converter = Pdf2Csv::Converter.new @dirpath
    end

    it "throws error if dir does not exist" do
      converter = Pdf2Csv::Converter.new "BAM"
      expect {converter.convert_files!}.to raise_error
    end

    it "does not throw errors if folder has files" do
      expect {@converter.convert_files!}.to_not raise_error
    end

    it "converts file in directory #convert_file" do
      @converter.convert_files!
      Dir.entries("spec/csvs").count.should > 2
    end
  end
end

