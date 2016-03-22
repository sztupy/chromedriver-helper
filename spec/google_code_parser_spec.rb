require 'spec_helper'

describe Chromedriver::Helper::GoogleCodeParser do
  before(:each) do
    Chromedriver::Helper::GoogleCodeParser.any_instance.stub(:open).and_return(File.read(File.join(File.dirname(__FILE__), 'assets/google-code-bucket.xml')))
  end
  let(:platform) { 'mac' }
  let!(:parser) { Chromedriver::Helper::GoogleCodeParser.new(platform) }

  describe '#downloads' do
    it 'returns an array of URLs for the platform' do
      downloads = parser.downloads
      downloads.length.should == 22
      downloads.each_with_index do |url, index|
        url.should == "http://chromedriver.storage.googleapis.com/2.#{index}/chromedriver_#{platform}32.zip"
      end
    end
  end

  describe '#newest_download' do
    it 'returns the last URL for the platform' do
      parser.newest_download.should == 'http://chromedriver.storage.googleapis.com/2.21/chromedriver_mac32.zip'
    end
  end
end

