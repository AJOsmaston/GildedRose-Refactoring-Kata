require './lib/gilded_rose'

describe GildedRose do

  describe "#update_quality" do
  #special items = aged brie, sulfuras, backstage passes
  #normal items = +5 vest, elixir

    describe "all items (except sulfuras)" do
      before(:each) do
        min_quality = GildedRose::MIN_QUALITY
        max_quality = GildedRose::MAX_QUALITY

        @items_qual_MIN = [
          Item.new(name="+5 Dexterity Vest", sell_in=10, quality=min_quality),
          Item.new(name="Aged Brie", sell_in=2, quality=min_quality),
          Item.new(name="Elixir of the Mongoose", sell_in=5, quality=min_quality),
          Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=min_quality),
          # This Conjured item does not work properly yet
          # Item.new(name="Conjured Mana Cake", sell_in=3, quality=6), # <-- :O
        ]

        @items_qual_MAX = [
          Item.new(name="+5 Dexterity Vest", sell_in=10, quality=max_quality),
          Item.new(name="Aged Brie", sell_in=2, quality=max_quality),
          Item.new(name="Elixir of the Mongoose", sell_in=5, quality=max_quality),
          Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=15, quality=max_quality),
          # This Conjured item does not work properly yet
          # Item.new(name="Conjured Mana Cake", sell_in=3, quality=6), # <-- :O
        ]
      end

      it "quality is never negative" do
        GildedRose.new(@items_qual_MIN).update_quality()

        @items_qual_MIN.each do |item| 
          expect(item.quality).to be >= 0
        end
      end

      it "quality is never more than 50" do
        GildedRose.new(@items_qual_MAX).update_quality()

        @items_qual_MAX.each do |item| 
          expect(item.quality).to be <= 50
        end
      end
    end

    describe "Sufuras" do
      it 'quality never changes' do
        items = [Item.new(name="Sulfuras, Hand of Ragnaros", sell_in=0, quality=80)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 80
      end
    end

    describe "Backstage passes" do
      it "quality increases by 2 when 10 days or less but more than 5 days to sell_in" do
        items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=10, quality=10)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 12
      end

      it "resets quality after sell_in date" do
        items = [Item.new(name="Backstage passes to a TAFKAL80ETC concert", sell_in=0, quality=49)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end
    end

    describe "Aged Brie" do
      it "increase in quality faster past sell_in date" do
        items = [Item.new(name="Aged Brie", sell_in=-1, quality=0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
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

  describe 'just for simplecov 100%' do
    it 'formats correctly' do
      item = Item.new(name="+5 Dexterity Vest", sell_in=-1, quality=20)

      expect(item.to_s).to eq "+5 Dexterity Vest, -1, 20"
    end
  end
end
