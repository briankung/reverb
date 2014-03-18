require 'record_set'
require 'record'

describe RecordSet do
  let(:path) { Dir.pwd + '/spec/samples/test' + extension }
  let(:extension) { '' }
  let(:record_set) { RecordSet.new(path) }

  subject { record_set }

  it { should be_a RecordSet }
  it { should be_an Array }
  it { should be_empty }

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
  end
end

# Convenience
# rs.each
# rs[0]
# is enumerable

# Output
# rs = RecordSet.new('file')
# rs.list // Defaults to (by: :last_name)
# rs.list(by: :gender)
# rs.list(by: :birth_date)