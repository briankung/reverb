require 'grape'
require_relative 'record_set'

module RecordAccessor
  class API < Grape::API
    format :json

    helpers do
      def records
        @records ||= RecordSet.new(Dir.pwd + '/db/records.list')
      end
    end

    resource :records do
      desc 'Adds a record'
      post do
        records << Record.new(params['record']['new'])
        records.save!
        records
      end

      desc 'Returns records in order of retrieval from file'
      get do
        records.list(order: nil)
      end

      desc 'Returns records sorted by last name'
      get :name do
        records.list(order: :last_name)
      end

      desc "Returns records sorted by parameter"
      get ':order' do
        records.list(order: params[:order].to_sym)
      end
    end
  end
end