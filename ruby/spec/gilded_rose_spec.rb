require './lib/gilded_rose'

describe GildedRose do

  describe "#update_quality" do
  # special items = aged brie, sulfuras, backstage passes, conjured items
  # normal items = +5 vest, elixir

    describe "grouped items (except sulfuras)" do
      before(:each) do
        min_quality = GildedRose::MIN_QUALITY
        max_quality = GildedRose::MAX_QUALITY

        @items_qual_min = [
          Item.new(name = "+5 Dexterity Vest", sell_in = 10, quality = min_quality),
          Item.new(name = "Aged Brie", sell_in = 2, quality = min_quality),
          Item.new(name = "Elixir of the Mongoose", sell_in = 5, quality = min_quality),
          Item.new(name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 15, quality = min_quality),
          Item.new(name = "Conjured Mana Cake", sell_in = 3, quality = min_quality)
        ]

        @items_qual_max = [
          Item.new(name = "+5 Dexterity Vest", sell_in = 10, quality = max_quality),
          Item.new(name = "Aged Brie", sell_in = 2, quality = max_quality),
          Item.new(name = "Elixir of the Mongoose", sell_in = 5, quality = max_quality),
          Item.new(name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 15, quality = max_quality),
          Item.new(name = "Conjured Mana Cake", sell_in = 3, quality = max_quality)
        ]
      end

      it "quality is never negative" do
        GildedRose.new(@items_qual_min).update_quality()

        @items_qual_min.each do |item| 
          expect(item.quality).to be >= 0
        end
      end

      it "quality is never more than 50" do
        GildedRose.new(@items_qual_max).update_quality()

        @items_qual_max.each do |item| 
          expect(item.quality).to be <= 50
        end
      end
    end

    describe "Sufuras" do
      it 'quality never changes' do
        items = [Item.new(name = "Sulfuras, Hand of Ragnaros", sell_in = 0, quality = 80)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 80
      end

      it "sell_in never changes" do
        items = [Item.new(name = "Sulfuras, Hand of Ragnaros", sell_in = 0, quality = 80)]
        GildedRose.new(items).update_quality()

        expect(items[0].sell_in).to eq 0
      end
    end

    describe "Backstage passes" do
      it "quality increases by 2 when 10 days or less but more than 5 days to sell_in" do
        items = [Item.new(name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 10, quality = 10)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 12
      end

      it "quality increases by 3 when 5 days or less to sell_in" do
        items = [Item.new(name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 5, quality = 10)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 13
      end

      it "resets quality after sell_in date" do
        items = [Item.new(name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 0, quality = 49)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 0
      end

      describe "quality edge cases" do
        describe "doesn't go above the max quality" do
          it "gets capped at 50 with sell_in 10 days left" do
            items = [Item.new(name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 10, quality = 49)]
            GildedRose.new(items).update_quality()
    
            expect(items[0].quality).to be <= 50
          end

          it "gets capped at 50 with sell_in 5 days left" do
            items = [Item.new(name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 5, quality = 49)]
            GildedRose.new(items).update_quality()
    
            expect(items[0].quality).to be <= 50
          end

          it "continues to count down sell_in with max quality (10 days)" do
            items = [Item.new(name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 10, quality = 50)]
            GildedRose.new(items).update_quality()
    
            expect(items[0].sell_in).to be < 10
          end

          it "continues to count down sell_in with max quality (5 days)" do
            items = [Item.new(name = "Backstage passes to a TAFKAL80ETC concert", sell_in = 5, quality = 50)]
            GildedRose.new(items).update_quality()
    
            expect(items[0].sell_in).to be < 5
          end
        end
      end
    end

    describe "Aged Brie" do
      it "increase in quality faster past sell_in date" do
        items = [Item.new(name = "Aged Brie", sell_in = -1, quality = 0)]
        GildedRose.new(items).update_quality()
        expect(items[0].quality).to eq 2
      end

      describe "quality edge cases" do
        it "doesn't increase past 50 when sell_in greater than 0" do
          items = [Item.new(name = "Aged Brie", sell_in = 10, quality = 49)]
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to be <= 50
        end

        it "doesn't increase past 50 when sell_in less than 0" do
          items = [Item.new(name = "Aged Brie", sell_in = -1, quality = 49)]
          GildedRose.new(items).update_quality()
          expect(items[0].quality).to be <= 50
        end
      end
    end

    describe "conjured items" do
      describe "decreases in quality twice as fast as normal items" do
        it "normally reduces quality by 2" do
          items = [Item.new(name = "Conjured Mana Cake", sell_in = 3, quality = 6)]
          GildedRose.new(items).update_quality()
  
          expect(items[0].quality).to eq 4
        end

        it "reduces quality by 4 when below 0 sell_in" do
          items = [Item.new(name = "Conjured Mana Cake", sell_in = -1, quality = 6)]
          GildedRose.new(items).update_quality()
  
          expect(items[0].quality).to eq 2
        end
      end
    end

    describe "normal items" do
      it "reduces quality by 1" do
        items = [Item.new(name = "+5 Dexterity Vest", sell_in = 10, quality = 20)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 19
      end

      it "reduces sell_in by 1" do
        items = [Item.new(name = "+5 Dexterity Vest", sell_in = 10, quality = 20)]
        GildedRose.new(items).update_quality()

        expect(items[0].sell_in).to eq 9
      end

      it "reduces quality by 2 once sell_in < 0" do
        items = [Item.new(name = "+5 Dexterity Vest", sell_in = -1, quality = 20)]
        GildedRose.new(items).update_quality()

        expect(items[0].quality).to eq 18
      end

      describe "quality edge cases" do
        it "quality does not go below 0" do
          items = [Item.new(name = "+5 Dexterity Vest", sell_in = -1, quality = 0)]
          GildedRose.new(items).update_quality()
  
          expect(items[0].quality).to be >= 0
        end
      end
    end
  end

  describe 'just for simplecov 100%' do
    it 'formats correctly' do
      item = Item.new(name = "+5 Dexterity Vest", sell_in = -1, quality = 20)

      expect(item.to_s).to eq "+5 Dexterity Vest, -1, 20"
    end
  end
end
