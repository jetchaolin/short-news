require 'rails_helper'

RSpec.describe Article, type: :model do
  # pending "add some examples to (or delete) #{__FILE__}"
  context 'should test articles validation' do
    let(:category) { Category.find_or_create_by(name: "test") }
    it 'should not create article without proper data' do
      expect { Article.new(
        title: 'test',
        author: 'test',
        category_id: category.id
      ).save! }.to raise_error("Validation failed: Published at can't be blank, Body can't be blank")
    end
    it 'should create article' do
        expect { Article.new(
          title: 'test',
          author: 'test',
          published_at: Date.today,
          category_id: category.id,
          body: 'test'
        ).save! }.to change { Article.count }.by(1)
    end
    it 'should edit article`s title' do
      Article.new(
        title: 'test',
        author: 'test',
        published_at: Date.today,
        category_id: category.id,
        body: 'test'
      ).save!
      expect { Article.find(1).update(title: 'changed title') }.to change { Article.find(1).title }.from('test').to('changed title')
    end
    it 'should delete article' do
      Article.new(
        title: 'test',
        author: 'test',
        published_at: Date.today,
        category_id: category.id,
        body: 'test'
      ).save!
      expect { Article.find(1).destroy }.to change { Article.count }.by(-1)
    end
  end
end
