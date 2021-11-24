require './lib/gilded_rose'

describe GildedRose do

  describe "#update_quality" do
  #special items = aged brie, sulfuras, backstage passes
  #normal items = +5 vest, elixir

    describe "normal items" do
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

      it "reduces quality by 2 once sell_in < 1" do
        items = [Item.new(name="+5 Dexterity Vest", sell_in=-1, quality=20)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 18
      end

      it "quality is never negative" do
        items = [Item.new(name="+5 Dexterity Vest", sell_in=-1, quality=0)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 0
      end
    end
  end

end
