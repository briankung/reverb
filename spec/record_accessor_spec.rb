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
        expect(JSON.parse(last_response.body)).to eq records.list(by: :gender)
      end
    end

    describe 'GET /records/name' do
      it 'returns records sorted by last name' do
        get '/records/name'
        expect(last_response.status).to eq 200
        expect(JSON.parse(last_response.body)).to eq records.list(by: :last_name)
      end
    end

    describe 'GET /records/birthdate' do
      it 'returns records sorted by birthdate' do
        get '/records/birthdate'
        expect(last_response.status).to eq 200
        expect(JSON.parse(last_response.body)).to eq records.list(by: :birthdate)
      end
    end
  end
end