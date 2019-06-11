require_relative '../rails_helper'
# require_relative '../../app/models/user'

describe Video do
  context 'associations' do
    it { should belong_to(:user) }
  end




end