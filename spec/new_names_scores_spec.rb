require 'new_names_scores'

describe NewNamesScores do
  let(:names_scores) { described_class.new(names: names) }
  describe '#sorted_names' do
    subject { names_scores.sorted_names }
    context 'given an array of names' do
      let(:names) { ['MARY', 'PATRICIA', 'LINDA'] }
      it 'should return an alphabetically sorted array' do
        expect(subject).to eq(['LINDA', 'MARY', 'PATRICIA'])
      end
    end
  end
end
