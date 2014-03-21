require 'record_accessor'
require 'rack/test'

describe RecordAccessor::API do
  include Rack::Test::Methods
  
  def app
    RecordAccessor::API
  end

  describe RecordAccessor::API do
    let(:path) { Dir.pwd + '/spec/samples/test' + extension }
    let(:extension) { '' }
    let(:records) { RecordSet.new(path) }

    describe 'POST /records' do
      after { File.open(path, 'w'){} }
      let(:bobby) { 'DropTables, Bobby, Male, Blue, 2000-12-12' }
      let(:records) { [Record.new(bobby)].to_json }

      it 'adds a record to the file' do
        RecordAccessor::API.helpers do
          def records; @records ||= RecordSet.new(Dir.pwd + '/spec/samples/test'); end
        end

        get '/records/'
        expect(last_response.status).to eq 200
        expect(last_response.body).to eq [].to_json
        
        post '/records', { 'record[new]' => bobby }
        expect(last_response.status).to eq 201
        expect(last_response.body).to eq records
        
        get '/records/'
        expect(last_response.status).to eq 200
        expect(last_response.body).to eq records
      end
    end

    context 'GET' do
      before(:all) do
        RecordAccessor::API.helpers do
          def records; @records ||= RecordSet.new(Dir.pwd + '/spec/samples/test.csv'); end
        end
      end

      let(:extension) { '.csv' }
      describe '/records/' do
        it 'returns records order of retrieval from file' do
          get '/records/'
          expect(last_response.status).to eq 200
          expect(last_response.body).to eq records.list(order: nil).to_json
        end
      end

      describe '/records/gender' do
        it 'returns records sorted by gender' do
          get '/records/gender'
          expect(last_response.status).to eq 200
          expect(last_response.body).to eq records.list(order: :gender).to_json
        end
      end

      describe '/records/name' do
        it 'returns records sorted by last name' do
          get '/records/name'
          expect(last_response.status).to eq 200
          expect(last_response.body).to eq records.list(order: :last_name).to_json
        end
      end

      describe '/records/birthdate' do
        it 'returns records sorted by birthdate' do
          get '/records/birthdate'
          expect(last_response.status).to eq 200
          expect(last_response.body).to eq records.list(order: :birthdate).to_json
        end
      end
    end
  end
end