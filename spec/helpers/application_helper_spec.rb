require 'spec_helper'

describe ApplicationHelper do
  describe 'full_title' do
    it { expect(full_title('foo')).to match(/foo/) }
    it { expect(full_title('foo')).to match(/^Ruby on Rails Tutorial Sample App/) }
    it { expect(full_title('')).not_to match(/\|/) }
  end
end

RSpec::Matchers.define :have_error_message do |message|
  match do |page|
    expect(page).to have_selector('div.alert.alert-error', text: message)
  end
end

