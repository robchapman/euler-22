require 'names_scores'

describe NamesScores do
  let(:names_scores) { described_class.new(names: names) }

  context 'using default sorting/scoring/totalling' do
    describe '#sorted_names' do
      subject { names_scores.sorted_names }
      context 'given an array of names' do
        let(:names) { ['MARY', 'PATRICIA', 'LINDA'] }
        it 'should return an alphabetically sorted array (DEFAULT)' do
          expect(subject).to eq( ['LINDA', 'MARY', 'PATRICIA'])
        end
      end
    end
    describe '#score' do
      subject { names_scores.score_name('COLIN') }
      context 'given a name string' do
        let(:names) { [] }
        it 'should return the correct score' do
          expect(subject).to eq(53)
        end
      end
      context 'given variable cases strings' do
        subject { names_scores.score_name('CoLiN') }
        let(:names) { [] }
        it 'character case does not matter' do
          expect(subject).to eq(53)
        end
      end
      context 'given strings with non alphabet characters' do
        subject { names_scores.score_name('"#COLIN123___"') }
        let(:names) { [] }
        it 'non alphabet characters do not matter' do
          expect(subject).to eq(53)
        end
      end
    end
    describe '#total_score' do
      subject { names_scores.total_score }
      context 'given an empty array' do
        let(:names) { [] }
        it 'returns zero' do
          expect(subject).to eq(0)
        end
      end
      context 'given an array of empty strings' do
        let(:names) { ['', '', ''] }
        it 'returns zero' do
          expect(subject).to eq(0)
        end
      end
      context 'given an array of names' do
        let(:names) { ['MARY', 'PATRICIA', 'LINDA'] }
        it 'should return the correct score (DEFAULT)' do
          expect(subject).to eq(385)
        end
      end
    end

    describe 'Argument Error Throwing' do
      subject { names_scores.total_score }
      context 'given a non-array, non-File variable' do
        let(:names) { "COLIN" }
        it 'raises the argument error' do
          expect { subject }.to raise_error(ArgumentError)
        end
      end
    end

    describe 'File Reading' do
      subject { names_scores.total_score }
      context 'given an empty File' do
        let(:names) { File.open(File.dirname(__FILE__) + '/empty.txt') }
        it 'returns zero' do
          expect(subject).to eq(0)
        end
      end

      context 'given a file' do
        let(:names) { File.open(File.dirname(__FILE__) + '/test_names.txt') }
        it 'returns the correct score' do
          expect(subject).to eq(385)
        end
      end
    end
  end

  context 'given user defined sorting function(reverse alphabetically)' do
    sort = ->(a, b) { b <=> a }
    let(:names_scores) { described_class.new(names: names, sort: sort) }
    describe '#sorted_names' do
      subject { names_scores.sorted_names }
      context 'given an array of names' do
        let(:names) { ['MARY', 'PATRICIA', 'LINDA'] }
        it 'should return a correctly sorted array (reverse alphabetically)' do
          expect(subject).to eq(['PATRICIA', 'MARY', 'LINDA'])
        end
      end
    end
    describe '#total_score' do
      subject { names_scores.total_score }
      context 'given an array of names' do
        let(:names) { ['MARY', 'PATRICIA', 'LINDA'] }
        it 'should return the correct score (Reverse alpha sort)' do
          expect(subject).to eq(311)
        end
      end
    end
  end

  context 'given user defined score function (Character value squared (A=1, B=4, C=9...)' do
    score = ->(name) { name.scan(/[a-zA-Z]/).sum { |chr| (chr.upcase.ord - 64)**2 } }
    let(:names_scores) { described_class.new(names: names, score: score) }
    describe '#score' do
      subject { names_scores.score_name('COLIN') }
      context 'given a name string' do
        let(:names) { [] }
        it 'should return an alphabetically sorted array (value squared)' do
          expect(subject).to eq(655)
        end
      end
    end
    describe '#total_score' do
      subject { names_scores.total_score }
      context 'given an array of names' do
        let(:names) { ['MARY', 'PATRICIA', 'LINDA'] }
        it 'should return the correct score' do
          expect(subject).to eq(6135)
        end
      end
    end
  end

  context "given user defined totalling function (multiply by square of name's sorted position" do
    total = lambda { |names, score|
      sum = 0
      names.each_with_index { |name, index| sum += score.call(name) * ((index + 1)**2) }
      sum
    }
    let(:names_scores) { described_class.new(names: names, total: total) }
    describe '#total_score' do
      subject { names_scores.total_score }
      context 'given an array of names' do
        let(:names) { ['MARY', 'PATRICIA', 'LINDA'] }
        it 'should return the correct score' do
          expect(subject).to eq(961)
        end
      end
    end
  end
end
