require 'spec_helper'

describe RecordAccessor::API do
  include Rack::Test::Methods
  
  def app
    RecordAccessor::API
  end

  describe RecordAccessor::API do
    describe 'GET records/gender' do
      it 'returns records sorted by gender' do
        get '/records/gender'
        expect(last_response.status).to eq 200
      end
    end
  end
end