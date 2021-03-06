require 'spec_helper'

describe "Authentication" do
  subject { page }

  describe 'sign in page' do
    before { visit signin_path }

    it { expect(subject).to have_content('Sign in') }
    it { expect(subject).to have_title('Sign in') }

    describe 'with invalid information' do
      before { click_button 'Sign in' }

      it { expect(subject).to have_title('Sign in') }
      it { expect(subject).to have_error_message('Invalid') }

      describe 'after visiting another page' do
        before { click_link 'Home' }

        it { expect(subject).not_to have_error_message('Invalid') }
      end
    end

    describe 'with valid information' do
      let(:user) { FactoryGirl.create(:user) }
      before { sign_in(user) }

      it { expect(subject).to have_title(user.name) }
      it { expect(subject).to have_link('Users',       href: users_path) }
      it { expect(subject).to have_link('Profile',     href: user_path(user)) }
      it { expect(subject).to have_link('Settings',    href: edit_user_path(user)) }
      it { expect(subject).to have_link('Sign out',    href: signout_path) }
      it { expect(subject).not_to have_link('Sign in', href: signin_path) }
    end
  end

  describe 'Authentication' do
    describe 'description' do
      let(:user) { FactoryGirl.create(:user) }
      let(:non_admin) { FactoryGirl.create(:user) }

      before { sign_in non_admin, no_capybara: true }
      describe 'submitting DELETE to destroy action' do
        before { delete user_path(user) }
        it { expect(response).to redirect_to(root_url) }
      end
    end
    describe 'for non signed users' do
      let(:user) { FactoryGirl.create(:user) }

      describe 'when attempting to visit a protected page' do
        before do
          visit edit_user_path(user)
          fill_in 'Email', with: user.email
          fill_in 'Password', with: user.password
          click_button 'Sign in'
        end

        describe 'after signin in' do
          it { expect(subject).to have_title('Edit user') }
        end
      end

      describe 'in the user controller' do
        describe 'visiting the user index' do
          before { visit users_path }
          it { expect(subject).to have_title('Sign in') }
        end

        describe 'visiting the edit page' do
          before { visit edit_user_path(user) }
          it { expect(subject).to have_title('Sign in') }
        end

        describe 'submiting to the update action' do
          before { patch user_path(user) }
          specify { expect(response).to redirect_to(signin_path) }
        end
      end
    end

    describe 'as wrong user' do
      let(:user) { FactoryGirl.create(:user) }
      let(:wrong_user) { FactoryGirl.create(:user, email: 'wrong@example.com') }

      before { sign_in(user, no_capybara: true) }

      describe 'submitting a GET to User#edit action' do
        before { get edit_user_path(wrong_user) }

        it { expect(response.body).not_to match(full_title('Edit user')) }
        it { expect(response).to redirect_to(root_url) }
      end

      describe 'submitting a PATCH to user#update action' do
        before { patch user_path(wrong_user) }

        it { expect(response).to redirect_to(root_url) }
      end
    end
  end
end

