require 'spec_helper'

require 'tablebot/table'

describe "A single table" do
  context "Given a specific table" do
    before(:each) do
      input_table = <<-EOD
**d8  The warrior is armored in...**

1.  Nothing.
2.  Tattered leather.
3.  Blood-stained leather.
4.  Boiled leather.
5.  The hides of scaly beasts.
6.  The hides of furry beasts.
7.  The hides of exotic beasts.
8.  A helm and breastplate taken from a fallen enemy.
EOD
      @t = Table.new(input_table)
    end

    it "Should specify a d8" do
      expect(@t.die).to eq 8
    end

    it "Should have 8 outcomes" do
      expect(@t.outcomes.length).to eq 8
    end

    it "Should have a header of 'The warrior is armored in'" do
      expect(@t.header).to eq 'The warrior is armored in'
    end

    it "Should have 'Boiled leather' as the 4th entry" do
      expect(@t.outcomes[3].outcome).to eq 'Boiled leather'
    end
  end
end
