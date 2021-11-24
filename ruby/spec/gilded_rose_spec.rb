require './lib/gilded_rose'

describe GildedRose do

  describe "#update_quality" do
  #special items = aged brie, sulfuras, backstage passes
  #normal items = +5 vest, elixir

    describe "all items" do

      before(:each) do
        @items_qual_0 = [
          Item.new(name="+5 Dexterity Vest", sell_in=10, quality=0),
          Item.new(name="Aged Brie", sell_in=2, quality=0),
          Item.new(name="Elixir of the Mongoose", sell_in=5, quality=0),
          Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=0),
          Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=-1, quality=0),
          Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=0),
          Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=0),
          Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=5, quality=0),
          # This Conjured item does not work properly yet
          # Item.new(name="Conjured Mana Cake", sell_in=3, quality=6), # <-- :O
        ]
      end

      it "quality is never negative" do
        GildedRose.new(@items_qual_0).update_quality()

        @items_qual_0.each do |item| 
          expect(item.quality).to be >= 0
        end
      end
    end

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
    end
  end

end
