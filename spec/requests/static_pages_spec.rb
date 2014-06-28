require 'spec_helper'

describe "Static pages" do
  before { visit root_path }

  subject { page }

  shared_examples_for 'all static pages' do
    it { should have_selector('h1', text: heading) }
    it { should have_title(full_title(page_title)) }
  end

  describe "Home page" do
    let(:heading) { 'Sample App'}
    let(:page_title) { '' }

    it_should_behave_like 'all static pages'
    it { should_not have_title(" | Home") }
  end

  describe "Help page" do
    before { click_link 'Help' }
    let(:heading)    { 'Help'}
    let(:page_title) { 'Help' }

    it_should_behave_like 'all static pages'
  end

  describe "About page" do
    before { click_link 'About' }
    let(:heading)    { 'About Us'}
    let(:page_title) { 'About Us' }

    it_should_behave_like 'all static pages'
  end

  describe "Contact" do
    before { click_link 'Contact' }
    let(:heading)    { 'Contact'}
    let(:page_title) { 'Contact' }

    it_should_behave_like 'all static pages'
  end
end
