require 'rails_helper'

feature 'Posts' do
  let!(:user) { create :user, email: 'example@example.com', password: 'password' }

  scenario 'Displaying the posts on the homepage', js: true do
    post_1 = create :post
    post_2 = create :post

    visit root_path

    expect(page).to have_content post_1.title
    expect(page).to have_content post_2.title
  end

  scenario 'Displaying the post detail page', js: true do
    post = create :post

    visit root_path
    click_on post.title

    expect(page).to have_content 'comments'
    expect(page).to have_content post.title
    expect(page).to have_content post.tagline
  end

  scenario 'simulate upvote', js: true do
    post = create :post

    visit new_user_session_path

    fill_in 'Email', with: 'example@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'

    click_on post.title

    click_on post.votes_count

    #expect(page).to have_selector(:link_or_button, '🔼 1')
    #expect(page).to have_button('🔼 1')
    #expect(page).to have_button(value: '🔼 1')


    expect(page).to have_content "🔼 1"
  end

  scenario 'simulate remove vote', js: true do
    post = create :post
    post.votes.create(user: user)

    visit new_user_session_path

    fill_in 'Email', with: 'example@example.com'
    fill_in 'Password', with: 'password'
    click_on 'Log in'

    click_on post.title

    click_on post.votes_count

    #expect(page).to have_button('🔼 0')
    #expect(page).to have_selector(:link_or_button, '🔼 0')
    expect(page).to have_content "🔼 0"
  end
end
