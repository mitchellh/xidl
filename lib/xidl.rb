module XIDL
  autoload :Document, 'xidl/document'

  # Parse the given XIDL file and return the parsed version
  # of it.
  #
  # @param [String] file
  # @return Object
  def self.parseFile(file)
    # Lazy load nokogiri here
    require 'nokogiri'

    # Parse the XIDL file using an event-driven parser
    doc = Document.new
    parser = Nokogiri::XML::SAX::Parser.new(doc)
    parser.parse(File.read(file))
    doc
  end
end
