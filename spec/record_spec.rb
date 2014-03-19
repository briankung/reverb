require 'spec_helper'

describe Record do
  let(:parsed_data) { {last_name: 'Kung', first_name: 'Brian', gender: 'Male', favorite_color: 'Green', birthdate: '1987-12-28'} }
  let(:record) { Record.new(input) }
  let(:input) { "Kung%sBrian%sMale%sGreen%s1987-12-28" % ([separator]*4) }
  let(:separator) { ', ' }

  it 'is equivalent to the parsed values' do
    expect(record).to eq parsed_data
  end

  describe '#parse' do
    subject { Record.parse(input) }

    context 'Comma Separated Values (CSV)' do
      let(:separator) { ', ' }
      it { should eq(parsed_data) }
    end

    context 'Pipe Separated Values (PSV)' do
      let(:separator) { " | " }
      it { should eq(parsed_data) }
    end

    context 'Space Separated Values (SSV)' do
      let(:separator) { " " }
      it { should eq(parsed_data) }
    end
  end

  describe '#sanitize' do
    subject { Record.sanitize(input) }
    let(:sanitized) { parsed_data.values }

    context 'CSV' do
      let(:separator) { ', ' }
      it { should eq(sanitized) }
    end

    context 'PSV' do
      let(:separator) { ' | ' }
      it { should eq(sanitized) }
    end

    context 'SSV' do
      let(:separator) { ' ' }
      it { should eq(sanitized) }
    end
  end

  describe '#display' do
    it 'is correctly formatted' do
      expect(record.display).to eq "Last Name: Kung, First Name: Brian, Gender: Male, Date of Birth: 12/28/1987, Favorite Color: Green"
    end
  end

  describe '#birthdate' do
    it 'is correctly formatted' do
      expect(record.send(:birthdate)).to eq '12/28/1987'
    end
  end
end