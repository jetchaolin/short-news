require 'rails_helper'

describe "Author creates article" do
  it 'successfully' do
    user = User.create(username: 'test_author', email: 'test@test.com', password: '123456', author: true)
    category = Category.find_or_create_by(name: 'Test category')
    article = { title: 'Test title', published_at: Date.today, category_id: category.id, body: 'Test body' }
    login_as user, scope: :user
    visit root_path
    click_link 'Profile'
    click_link 'Write Article'
    within 'main' do
      within 'form' do
        fill_in 'Title',	with: article[:title]
        fill_in 'Published At',	with: article[:published_at]
        select "Test category", from: 'article[category_id]'
        fill_in 'Body',	with: article[:body]
        click_button 'Post'
      end
    end
    click_link article[:title]
    generated_article = Article.last
    expect(current_path).to eq article_path(generated_article)
    expect(page).to have_content(article[:title])
    expect(page).to have_content(user[:username])
    expect(page).to have_content(article[:published_at])
    expect(page).to have_content(article[:category])
    expect(page).to have_content(article[:body])
    expect(page).to have_link('Edit', href: edit_article_path(generated_article))
    expect(page).to have_button('Delete')
  end
  it 'and regular users can`t write articles' do
    user = User.create(username: 'test', email: 'test@test.com', password: '123456', author: false)
    login_as user, scope: :user
    visit root_path
    click_link 'Profile'
    expect(page.body).not_to include('Write Article')
  end
  context 'and then edits it' do
    it 'successfully' do
      user = User.create(username: 'test_author', email: 'test@test.com', password: '123456', author: true)
      category = Category.find_or_create_by(name: 'Test category')
      category2 = Category.find_or_create_by(name: 'Test category 2')
      article = { title: 'Test title', author: 'test_author', published_at: Date.today, category_id: category.id, body: 'Test body' }
      Article.create(article)
      login_as user, scope: :user
      visit root_path
      click_link 'Test title'
      click_link 'Edit'
      within 'main' do
        within 'form' do
          fill_in 'Title',	with: 'Changed title test'
          select category2[:name], from: 'article[category_id]'
          fill_in 'Body',	with: 'Changed body test'
          click_button 'Edit'
        end
      end
      expect(current_path).to eq root_path
      expect(page).to have_content(category2[:name])
      click_link 'Changed title test'
      generated_article = Article.last
      expect(current_path).to eq article_path(generated_article)
      expect(page).to have_content('Changed title test')
      expect(page).to have_content(user[:username])
      expect(page).to have_content(article[:published_at])
      expect(page).to have_content('Changed body test')
      expect(page).to have_link('Edit', href: edit_article_path(generated_article))
      expect(page).to have_button('Delete')
    end
    it 'but fails due to missing fields' do
      user = User.create(username: 'test_author', email: 'test@test.com', password: '123456', author: true)
      category = Category.find_or_create_by(name: 'Test category')
      article = { title: 'Test title', author: 'test_author', published_at: Date.today, category_id: category.id, body: 'Test body' }
      Article.create(article)
      login_as user, scope: :user
      visit root_path
      click_link 'Test title'
      click_link 'Edit'
      within 'main' do
        within 'form' do
          find_field(id: 'article_title').fill_in(with: '')
          click_button 'Edit'
        end
      end
      expect(current_path).to eq root_path
      expect(page).to have_content('Test title')
    end
  end
end
