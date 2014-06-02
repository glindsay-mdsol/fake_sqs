require 'builder'
require 'securerandom'

module FakeSQS
  class Responder

    def call(name, &block)
      xml = Builder::XmlMarkup.new(:indent => 4)
      xml.tag!("#{name}Response", "xmlns" => "http://queue.amazonaws.com/doc/2012-11-05/" ) do
        if block
          xml.tag! "#{name}Result" do
            yield xml
          end
        end
        xml.ResponseMetadata do
          xml.RequestId SecureRandom.uuid
        end
      end
    end

  end
end
