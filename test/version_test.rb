require 'test_helper'

describe Hanami::Controller::VERSION do
  it 'returns the current version' do
    Hanami::Controller::VERSION.must_equal '0.7.0'
  end
end
