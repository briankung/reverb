require 'grape'
require_relative 'record_set'

module RecordAccessor
  class API < Grape::API
    format :json

    helpers do
      def records
        @records ||= RecordSet.new(Dir.pwd + '/spec/samples/test.csv')
      end
    end

    resource :records do
      desc 'Returns records sorted by gender (and then last name).'
      get :gender do
        records.list(order: :gender)
      end

      desc 'Returns records sorted by last name'
      get :name do
        records.list(order: :last_name)
      end

      desc 'Returns records sorted by birthdate'
      get :birthdate do
        records.list(order: :birthdate)
      end
    end
  end
end