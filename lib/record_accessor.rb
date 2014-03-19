require 'grape'

module RecordAccessor
  class API < Grape::API
    resource :records do
      desc 'Returns records sorted by gender (and then last name).'
      get :gender
    end
  end
end