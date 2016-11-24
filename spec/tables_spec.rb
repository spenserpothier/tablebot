require 'spec_helper'
require 'tablebot/tables'

describe "Given a set of tables" do
  before(:all) do
    input_tables = <<-EOD

**Random Barbarian Warriors**
---

Use these for inspiration or roll them up randomly. Some of the tables could be rolled more than once.

**d8  The warrior is armored in...**

1.  Nothing.
2.  Tattered leather.
3.  Blood-stained leather.
4.  Boiled leather.
5.  The hides of scaly beasts.
6.  The hides of furry beasts.
7.  The hides of exotic beasts.
8.  A helm and breastplate taken from a fallen enemy.

**d12 The warrior is wielding...**

1.  A spear and a hunting knife.
2.  A spear and a shield.
3.  An exotic, curved blade.
4.  A huge, curved blade.
5.  An over-sized hammer.
6.  An enormous club.
7.  A greataxe.
8.  A battleaxe and a shield.
9.  Several handaxes.
10. A greatsword.
11. A pair of long knives.
12. A longspear and hunting knife.


EOD
    @tb = Tables.new(input_tables)
  end
                           
  context "There should be tables" do
    it "should not be nil" do
      expect(@tb.tables).to_not be_nil
    end

    it "should have two tables in it" do
      skip 'this should give 2 but currently gives 1.'
      expect(@tb).to eq 2
    end
  end
end
