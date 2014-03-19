require 'spec_helper'

describe RecordAccessor::API do
  include Rack::Test::Methods
  
  def app
    RecordAccessor::API
  end

  describe RecordAccessor::API do
    let(:records) { RecordSet.new(Dir.pwd + '/spec/samples/test.csv') }

    describe 'GET /records/gender' do
      it 'returns records sorted by gender' do
        get '/records/gender'
        expect(last_response.status).to eq 200
        expect(last_response.body).to eq records.list(order: :gender).to_json
      end
    end

    describe 'GET /records/name' do
      it 'returns records sorted by last name' do
        get '/records/name'
        expect(last_response.status).to eq 200
        expect(last_response.body).to eq records.list(order: :last_name).to_json
      end
    end

    describe 'GET /records/birthdate' do
      it 'returns records sorted by birthdate' do
        get '/records/birthdate'
        expect(last_response.status).to eq 200
        expect(last_response.body).to eq records.list(order: :birthdate).to_json
      end
    end
  end
end