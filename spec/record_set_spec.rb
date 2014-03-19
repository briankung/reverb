require 'record_set'
require 'record'

describe RecordSet do
  let(:path) { Dir.pwd + '/spec/samples/test' + extension }
  let(:extension) { '' }
  let(:record_set) { RecordSet.new(path) }

  it "is empty" do
    expect(record_set).to be_empty
  end

  it 'has as many elements as there are records' do
    expect(record_set.length).to be 0
  end

  context 'with csv data' do
    let(:extension) { '.csv' }
    it 'has as many elements as there are records' do
      expect(record_set.length).to be 5
    end

    it 'contains only Records' do
      only_records = record_set.inject(true) {|_,r| _ && r.is_a?(Record)}
      expect(only_records).to be_true
    end

    describe '#list_by_birthdate' do
      let(:output) do
        [
          "Last Name: Darwin, First Name: Charles, Gender: Male, Date of Birth: 02/12/1809, Favorite Color: Blue",
          "Last Name: Lovelace, First Name: Ada, Gender: Female, Date of Birth: 12/10/1815, Favorite Color: Purple",
          "Last Name: Curie, First Name: Marie, Gender: Female, Date of Birth: 11/07/1867, Favorite Color: Yellow",
          "Last Name: Einstein, First Name: Albert, Gender: Male, Date of Birth: 03/14/1879, Favorite Color: Green",
          "Last Name: Turing, First Name: Alan, Gender: Male, Date of Birth: 06/03/1912, Favorite Color: Green"
        ]
      end

      it 'displays records in  birth order' do
        expect(record_set.list_by_birthdate).to eq output
      end
    end

    describe '#list_by_last_name' do
      let(:output) do
        [
          "Last Name: Curie, First Name: Marie, Gender: Female, Date of Birth: 11/07/1867, Favorite Color: Yellow",
          "Last Name: Darwin, First Name: Charles, Gender: Male, Date of Birth: 02/12/1809, Favorite Color: Blue",
          "Last Name: Einstein, First Name: Albert, Gender: Male, Date of Birth: 03/14/1879, Favorite Color: Green",
          "Last Name: Lovelace, First Name: Ada, Gender: Female, Date of Birth: 12/10/1815, Favorite Color: Purple",
          "Last Name: Turing, First Name: Alan, Gender: Male, Date of Birth: 06/03/1912, Favorite Color: Green"
        ]
      end

      it 'displays records in  last name order' do
        expect(record_set.list_by_last_name).to eq output
      end
    end

    describe '#list_by_gender' do
      let(:output) do
        [
          "Last Name: Curie, First Name: Marie, Gender: Female, Date of Birth: 11/07/1867, Favorite Color: Yellow",
          "Last Name: Lovelace, First Name: Ada, Gender: Female, Date of Birth: 12/10/1815, Favorite Color: Purple",
          "Last Name: Darwin, First Name: Charles, Gender: Male, Date of Birth: 02/12/1809, Favorite Color: Blue",
          "Last Name: Einstein, First Name: Albert, Gender: Male, Date of Birth: 03/14/1879, Favorite Color: Green",
          "Last Name: Turing, First Name: Alan, Gender: Male, Date of Birth: 06/03/1912, Favorite Color: Green"
        ]
      end

      it 'can be ordered by gender (then last name)' do
        expect(record_set.list_by_gender).to eq output
      end
    end
  end
end