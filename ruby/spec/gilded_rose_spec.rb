require './lib/gilded_rose'

describe GildedRose do

  describe "#update_quality" do
  #special items = aged brie, sulfuras, backstage passes
  #normal items = +5 vest, elixir

    describe "normal items reduce quality and sell_in date" do
      it "reduces quality by 1" do
        items = [Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 19
      end

      it "reduces sell_in by 1" do
        items = [Item.new(name="+5 Dexterity Vest", sell_in=10, quality=20)]
        GildedRose.new(items).update_quality()

        expect(items[0].sell_in).to eq 9
      end
    end
  end

end
