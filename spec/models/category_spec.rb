require 'rails_helper'

RSpec.describe Category, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context 'should test categories' do
    before do
      [ "category_sample_1", "category_sample_2", "category_sample_3" ].each do |name|
        Category.find_or_create_by(name: name)
      end
      def category_sample(number)
        Category.find(number)
      end
      Article.create(title: 'test', author: 'test', published_at: Date.today, category_id: category_sample(1).id, body: 'test')
    end
    it 'the length of categories should equals 3 ' do
      expect(Category.count).to eq(3)
    end
    it 'category test1 should include test_article' do
      expect(Category.find(1).articles.count).to eq(1)
    end
  end
end
