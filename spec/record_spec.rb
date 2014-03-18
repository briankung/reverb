require 'record'

describe Record do
  let(:keys) { %i[last_name first_name gender favorite_color birthdate] }
  let(:parsed_values) { {last_name: 'Kung', first_name: 'Brian', gender: 'Male', favorite_color: 'Green', birthdate: '1987-12-28'} }
  let(:csv) { "Kung, Brian, Male, Green, 1987-12-28" }

  describe '#new' do
    let(:record) { Record.new(csv) }

    it 'is a Hash' do 
      expect(record).to be_a Hash
    end

    it 'can read data' do
      expect(record[:last_name]).to eq "Kung"
      expect(record[:first_name]).to eq "Brian"
      expect(record[:gender]).to eq "Male"
      expect(record[:favorite_color]).to eq "Green"
      expect(record[:birthdate]).to eq "1987-12-28"
    end
  end

  describe '#parse' do
    subject { Record.parse(input) }

    context 'Comma Separated Values (CSV)' do
      let(:input) { csv }

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

      context 'with newline' do
        let(:string) { "LastName, FirstName, Gender, FavoriteColor, DateOfBirth\n" }

        it { should eq(sanitized) }
      end
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