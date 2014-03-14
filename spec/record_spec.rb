require 'record'

describe Record do
  let(:keys) { %i[last_name first_name gender favorite_color birthdate] }
  let(:parsed_values) { {last_name: 'Kung', first_name: 'Brian', gender: 'Male', favorite_color: 'Green', birthdate: '1987-12-28'} }

  describe '#parse' do
    subject { Record.parse(input) }

    context 'Comma Separated Values (CSV)' do
      let(:input) { "Kung, Brian, Male, Green, 1987-12-28" }

      it { should eq(parsed_values) }
    end

    context 'Pipe Separated Values (PSV)' do
      let(:input) { "Kung | Brian | Male | Green | 1987-12-28" }

      it { should eq(parsed_values) }
    end

    context 'Space Separated Values (SSV)' do
      let(:input) { "Kung Brian Male Green 1987-12-28" }

      it { should eq(parsed_values) }
    end
  end

  describe '#sanitize' do
    subject { Record.sanitize(string) }

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