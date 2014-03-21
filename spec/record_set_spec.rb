require 'record_set'

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

  context 'with test.csv data' do
    let(:extension) { '.csv' }
    let(:by_birthdate) do
      [
        "Last Name: Darwin, First Name: Charles, Gender: Male, Date of Birth: 02/12/1809, Favorite Color: Blue",
        "Last Name: Lovelace, First Name: Ada, Gender: Female, Date of Birth: 12/10/1815, Favorite Color: Purple",
        "Last Name: Curie, First Name: Marie, Gender: Female, Date of Birth: 11/07/1867, Favorite Color: Yellow",
        "Last Name: Einstein, First Name: Albert, Gender: Male, Date of Birth: 03/14/1879, Favorite Color: Green",
        "Last Name: Turing, First Name: Alan, Gender: Male, Date of Birth: 06/03/1912, Favorite Color: Green"
      ]
    end
    let(:by_last_name) do
      [
        "Last Name: Curie, First Name: Marie, Gender: Female, Date of Birth: 11/07/1867, Favorite Color: Yellow",
        "Last Name: Darwin, First Name: Charles, Gender: Male, Date of Birth: 02/12/1809, Favorite Color: Blue",
        "Last Name: Einstein, First Name: Albert, Gender: Male, Date of Birth: 03/14/1879, Favorite Color: Green",
        "Last Name: Lovelace, First Name: Ada, Gender: Female, Date of Birth: 12/10/1815, Favorite Color: Purple",
        "Last Name: Turing, First Name: Alan, Gender: Male, Date of Birth: 06/03/1912, Favorite Color: Green"
      ]
    end
    let(:by_gender) do
      [
        "Last Name: Curie, First Name: Marie, Gender: Female, Date of Birth: 11/07/1867, Favorite Color: Yellow",
        "Last Name: Lovelace, First Name: Ada, Gender: Female, Date of Birth: 12/10/1815, Favorite Color: Purple",
        "Last Name: Darwin, First Name: Charles, Gender: Male, Date of Birth: 02/12/1809, Favorite Color: Blue",
        "Last Name: Einstein, First Name: Albert, Gender: Male, Date of Birth: 03/14/1879, Favorite Color: Green",
        "Last Name: Turing, First Name: Alan, Gender: Male, Date of Birth: 06/03/1912, Favorite Color: Green"
      ]
    end

    it 'has as many elements as there are records' do
      expect(record_set.length).to be 5
    end

    it 'contains only Records' do
      only_records = record_set.inject(true) {|_,r| _ && r.is_a?(Record)}
      expect(only_records).to be_true
    end

    describe '#display' do
      it 'defaults to displaying records in birth order' do
        expect(record_set.display).to eq by_birthdate
      end

      it 'can be explicitly ordered by birth' do
        expect(record_set.display(order: :birthdate)).to eq by_birthdate
      end

      it 'can be ordered by last name' do
        expect(record_set.display(order: :last_name)).to eq by_last_name
      end

      it 'can be ordered by gender (then last name)' do
        expect(record_set.display(order: :gender)).to eq by_gender
      end
    end
  end

  describe '#save!' do
    after(:each) { File.open(path, 'w'){} }

    let(:bobby) { Record.new('DropTables Bobby Male Blue 2000-12-12') }
    let(:updated_records) { record_set << bobby }
    it 'writes to the file' do
      expect(updated_records.save!).to be_true
      expect(RecordSet.new(path)).to include(bobby)
    end
  end
end