require 'spec_helper'

describe "User Pages" do
  let(:title) { 'Ruby on Rails Tutorial Sample App' }

  subject { page }

  describe "signup page" do
    before { visit signup_path }

    it { should have_content('Sign up') }
    it { should have_title(full_title("Sign up")) }
  end

  describe 'Profile Page' do
    let(:user) { FactoryGirl.create(:user) }

    before { visit user_path(user) }

    it { should have_content(user.name) }
    it { should have_title(user.name) }
  end
end
