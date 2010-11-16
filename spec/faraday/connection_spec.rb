require "spec_helper"

describe Faraday::Connection do
  describe "#build_url" do
    before do
      @connection = Faraday::Connection.new
      @url = "http://testtest.com/"
    end

    subject { uri }

    context "when using a basic hash" do
      let(:uri) { @connection.build_url(@url, {:a => "b"}) }

      its(:query) { should eql("a=b") }
    end

    context "when a nested hash" do
      let(:uri) { @connection.build_url(@url, {:a => {:b => "c"}}) }

      its(:query) { should eql("a[b]=c") }
    end
  end
end