require 'spec_helper'

describe "Static pages" do
  let(:title) { 'Ruby on Rails Tutorial Sample App' }

  describe "Home page" do
    before(:each) { visit '/static_pages/home' }

    it { expect(page).to have_content('Sample App')}
    it { expect(page).to have_title("#{title}") }
    it { expect(page).not_to have_title(" | Home") }
  end

  describe "Help page" do
    before(:each) { visit '/static_pages/help' }

    it { expect(page).to have_content('Help') }
    it { expect(page).to have_title("#{title} | Help") }
  end

  describe "About page" do
    before(:each) { visit '/static_pages/about' }

    it { expect(page).to have_content('About Us') }
    it { expect(page).to have_title("#{title}  | About Us") }
  end

  describe "Contact" do
    before(:each) { visit '/static_pages/contact' }

    it { expect(page).to have_title("#{title}  | Contact") }
    it { expect(page).to have_content('Contact') }
  end

end
