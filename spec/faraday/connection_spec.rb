require "spec_helper"

describe Faraday::Connection do
  describe "#replace_query" do
    before do
      @connection = Faraday::Connection.new
      @uri = Addressable::URI.parse("http://testtest.com/")
    end

    subject { uri }

    context "when using a basic hash" do
      let(:uri) { @connection.replace_query(@uri, {:a => "b"}) }

      its(:query) { should eql("a=b") }
    end

    context "when a nested hash" do
      let(:uri) { @connection.replace_query(@uri, {:a => {:b => "c"}}) }

      its(:query) { should eql("a[b]=c") }
    end
  end
end