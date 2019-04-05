require 'spec_helper'
require 'rails_helper'

feature 'the signup process' do
  scenario 'has a new user page' do
    visit new_user_path
    expect(page).to have_content ("New User")
  end

  feature 'signing up a user' do
    before(:each) do
        visit new_user_path
        fill_in 'username', with: 'test_username'
        fill_in 'password', with: 'password'
        click_on 'Create User'
    end

    scenario 'redirects to user index page after signup' do
        expect(page).to have_content("Profile")
    end

    scenario 'shows username on the homepage after signup' do
        visit users_path
        expect(page).to have_content ("test_username")
    end

  end
end

feature 'logging in' do
    before(:each) do
        User.create(username: 'test_username', password: 'password')
        visit new_session_path
        fill_in 'username', with: 'test_username'
        fill_in 'password', with: 'password'
        click_on 'Log In'
    end

    scenario 'redirects to user profile after logging in' do
        expect(page).to have_content ("Profile")
    end

    scenario 'shows username on the homepage after log in' do 
        visit users_path
        expect(page).to have_content ("logged in as test_username")
    end
end

feature 'logging out' do
    before(:each) do
        User.create(username: 'test_username', password: 'password')
        visit new_session_path
        fill_in 'username', with: 'test_username'
        fill_in 'password', with: 'password'
        click_on 'Log In'
        click_on 'Log Out'
    end

    # scenario 'begins with a logged out state' do
    #     expect(session[session_token]).to be(nil)
    # end

    scenario 'doesn\'t show username on the page after logout' do
        expect(page).to_not have_content ("logged in as test_username")
    end

    scenario 'it shows a login and sign up link on the homepage after logout' do
        expect(page).to have_content ("Sign In")
        expect(page).to have_content ("Sign Up")
    end

end