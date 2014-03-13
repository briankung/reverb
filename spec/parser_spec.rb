require 'parser'

describe Parser do
  let(:keys) { %i[last_name first_name gender favorite_color birthdate] }

  describe '#parse' do
    it 'should return a hash with keys' do
      expect(Parser.parse.keys).to eq(keys)
    end

    subject { Parser.parse(input) }

    context 'CSV' do
      let(:input) { "Kung, Brian, Male, Green, 12/28/1987" }

      it 'should return a hash with given values' do
        expect(subject).to eq({last_name: 'Kung', first_name: 'Brian', gender: 'Male', favorite_color: 'Green', birthdate: '12/28/1987'})
      end
    end
  end

  describe '#sanitize' do
    context 'CSV string' do
      let(:string) { 'LastName, FirstName, Gender, FavoriteColor, DateOfBirth' }
      it 'should return only data' do
        expect(Parser.sanitize(string)).to eq(%w{LastName FirstName Gender FavoriteColor DateOfBirth})
      end
    end
  end
end