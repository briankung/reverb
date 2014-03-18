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

    describe '#list' do
      let(:output) do
        [
          "Last Name: Einstein, First Name: Albert, Gender: Male, Date of Birth: 03/14/1879, Favorite Color: Green",
          "Last Name: Darwin, First Name: Charles, Gender: Male, Date of Birth: 02/12/1809, Favorite Color: Blue",
          "Last Name: Curie, First Name: Marie, Gender: Female, Date of Birth: 11/07/1867, Favorite Color: Yellow",
          "Last Name: Lovelace, First Name: Ada, Gender: Female, Date of Birth: 12/10/1815, Favorite Color: Purple",
          "Last Name: Turing, First Name: Alan, Gender: Male, Date of Birth: 06/03/1912, Favorite Color: Green"
        ]
      end
      
      it 'outputs an array of properly formatted strings' do
        expect(record_set.list).to eq output
      end
    end
  end
end