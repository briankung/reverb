require 'parser'

describe Parser do
  let(:keys) { %i[last_name first_name gender favorite_color birthdate] }
  let(:parsed_values) { {last_name: 'Kung', first_name: 'Brian', gender: 'Male', favorite_color: 'Green', birthdate: '12/28/1987'} }

  describe '#parse' do
    subject { Parser.parse(input) }

    context 'Comma Separated Values (CSV)' do
      let(:input) { "Kung, Brian, Male, Green, 12/28/1987" }

      it { should eq(parsed_values) }
    end

    context 'Pipe Separated Values (PSV)' do
      let(:input) { "Kung | Brian | Male | Green | 12/28/1987" }

      it { should eq(parsed_values) }
    end

    context 'Space Separated Values (SSV)' do
      let(:input) { "Kung Brian Male Green 12/28/1987" }

      it { should eq(parsed_values) }
    end
  end

  describe '#sanitize' do
    subject { Parser.sanitize(string) }

    let(:sanitized) { %w{LastName FirstName Gender FavoriteColor DateOfBirth} }

    context 'CSV' do
      let(:string) { 'LastName, FirstName, Gender, FavoriteColor, DateOfBirth' }

      it { should eq(sanitized) }
    end

    context 'PSV' do
      let(:string) { 'LastName | FirstName | Gender | FavoriteColor | DateOfBirth' }

      it { should eq(sanitized) }
    end

    context 'SSV' do
      let(:string) { 'LastName FirstName Gender FavoriteColor DateOfBirth' }

      it { should eq(sanitized) }
    end
  end
end