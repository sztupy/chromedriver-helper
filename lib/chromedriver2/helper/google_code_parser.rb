require 'nokogiri'
require 'open-uri'

module Chromedriver
  class Helper
    class GoogleCodeParser
      BUCKET_URL = 'http://chromedriver.storage.googleapis.com'

      attr_reader :source, :platform

      def initialize(platform)
        @platform = platform
        @source = open(BUCKET_URL)
      end

      def downloads
        doc = Nokogiri::XML.parse(source)
        items = doc.css("Contents Key").collect {|k| k.text }
        items.reject! {|k| !(/chromedriver_#{platform}/===k) }
        items.sort! { |k1, k2| k1.split('/').first.split('.').map(&:to_i) <=> k2.split('/').first.split('.').map(&:to_i) }
        items.map {|k| "#{BUCKET_URL}/#{k}"}
      end

      def newest_download
        downloads.last
      end
    end
  end
end
