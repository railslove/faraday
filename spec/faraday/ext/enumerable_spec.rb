require "spec_helper"

describe "Enumberable ext" do
  describe "#to_param" do
    describe "basic hash" do
      let(:hash) { @hash = {:a => "b"} }
      subject { hash.to_param }

      it { should eql("a=b") }
    end

    describe "nested hash" do
      let(:hash) { @hash = {:a => {:b => "c"}} }
      subject { hash.to_param }

      it { should eql("a[b]=c") }
    end

    describe "multiple nested" do
      let(:hash) { @hash = {:a => {:b => {:c => "d"}}} }
      subject { hash.to_param }

      it { should eql("a[b][c]=d") }
    end

    describe "multiple params" do
      let(:hash) { @hash = {:a => "b", :c => "d"} }
      subject { hash.to_param }

      it { should eql("a=b&c=d") }
    end

    describe "hash containing an array" do
      let(:hash) { @hash = {:a => ["b", "c"]} }
      subject { hash.to_param }

      it { should eql("a=b,c") }
    end
  end
end