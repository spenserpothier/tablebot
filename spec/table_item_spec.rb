require 'spec_helper'

require 'tablebot/table_item'

describe "Table Item" do
  context "Given a table item of '1 Nothing'" do
    before(:each) do
      @ti = TableItem.new('1 Nothing')
    end
    
    it "Should not be nil" do
      expect(@ti).to_not be nil
    end

    it "Weight should be 1" do
      expect(@ti.weight).to eq 1
    end

    it "Outcome should be 'Nothing'" do
      expect(@ti.outcome).to eq 'Nothing'
    end
  end
end

