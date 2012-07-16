require 'spec_helper'

describe Recommender do
  let(:user) { FactoryGirl.create(:user) }
  let(:recommender) { Recommender.new(user) }

end