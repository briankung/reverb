require 'spec_helper'

describe RecordAccessor::API do
  include Rack::Test::Methods
  
  def app
    RecordAccessor::API
  end

  describe RecordAccessor::API do
    let(:records) { RecordSet.new(Dir.pwd + '/spec/samples/test.csv') }

    describe 'POST /records' do
      original_records = RecordSet.new(Dir.pwd + '/spec/samples/test.csv')
      after(:each) { original_records.save! }
      let(:bobby) { 'DropTables, Bobby, Male, Blue, 2000-12-12' }
      let(:updated_records) { (original_records+[Record.new(bobby)]).to_json }

      it 'adds a record to the file' do
        post '/records', { 'record[new]' => bobby }
        expect(last_response.status).to eq 201
        expect(last_response.body).to eq updated_records
        get '/records/'
        expect(last_response.status).to eq 200
        expect(last_response.body).to eq updated_records
      end
    end

    describe 'GET /records/' do
      it 'returns records order of retrieval from file' do
        get '/records/'
        expect(last_response.status).to eq 200
        expect(last_response.body).to eq records.list(order: nil).to_json
      end
    end

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