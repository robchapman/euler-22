require 'names_scores'

describe NamesScores do
  describe '#total_score' do
    single_name = ['COLIN']
    three_names = ['MARY', 'PATRICIA', 'LINDA']

    context 'given a non-array variable' do
      it 'raises the argument error' do
        expect { NamesScores.total_score("COLIN") }.to raise_error(ArgumentError)
      end
    end

    context 'given an array of non-strings' do
      it 'raises the argument error' do
        expect { NamesScores.total_score([1, 2, 3]) } .to raise_error(ArgumentError)
      end
    end

    context 'given an empty array' do
      it 'returns zero' do
        expect(NamesScores.total_score([])).to eq(0)
      end
    end

    context 'given an array of empty strings' do
      it 'returns zero' do
        expect(NamesScores.total_score(['', '', ''])).to eq(0)
      end
    end

    context 'given a single name' do
      it 'returns an integer' do
        actual = NamesScores.total_score(single_name)
        expect(actual).to be_a(Integer)
      end

      it 'returns a non-negative score' do
        actual = NamesScores.total_score(single_name)
        expected = 0
        expect(actual).to be >= expected
      end

      it 'returns the correct score' do
        actual = NamesScores.total_score(single_name)
        expected = 53
        expect(actual).to eq(expected)
      end
    end

    context 'given multiple names' do
      it 'returns an integer' do
        actual = NamesScores.total_score(three_names)
        expect(actual).to be_a(Integer)
      end

      it 'returns a non-negative score' do
        actual = NamesScores.total_score(three_names)
        expected = 0
        expect(actual).to be >= expected
      end

      it 'name order does not matter' do
        mixed = ['LINDA', 'PATRICIA', 'MARY']
        score = NamesScores.total_score(three_names)
        score_mixed = NamesScores.total_score(mixed)
        expect(score).to eq(score_mixed)
      end

      it 'returns the correct score' do
        actual = NamesScores.total_score(three_names)
        expected = 385
        expect(actual).to eq(expected)
      end
    end

    context 'should be case insesitive' do
      diff_case = ['Mary', 'patricia', 'LiNdA']
      it 'character case does not matter' do
        score = NamesScores.total_score(three_names)
        score_diff_case = NamesScores.total_score(diff_case)
        expect(score).to eq(score_diff_case)
      end
    end

    context 'should ignore non alphabet characters' do
      it 'non alphabet characters do not matter' do
        non_letter = ['#LiNDa', '*_*_Pa    TRiCIA__3484', 'MARY!!!;))))']
        score = NamesScores.total_score(three_names)
        score_mixed = NamesScores.total_score(non_letter)
        expect(score).to eq(score_mixed)
      end
    end

    context 'given an empty File' do
      empty_file = File.open(File.dirname(__FILE__) + '/empty.txt')
      it 'returns zero' do
        actual = NamesScores.total_score(empty_file)
        expected = 0
        expect(actual).to eq(expected)
      end
    end

    context 'given a file' do
      it 'returns an integer' do
        file = File.open(File.dirname(__FILE__) + '/test_names.txt')
        actual = NamesScores.total_score(file)
        expect(actual).to be_a(Integer)
      end

      it 'returns a non-negative score' do
        file = File.open(File.dirname(__FILE__) + '/test_names.txt')
        actual = NamesScores.total_score(file)
        expected = 0
        expect(actual).to be >= expected
      end

      it 'returns the correct score' do
        file = File.open(File.dirname(__FILE__) + '/test_names.txt')
        actual = NamesScores.total_score(file)
        expected = 385
        expect(actual).to eq(expected)
      end
    end

    # context 'should handle large file' do
    #   file_names = File.open(File.dirname(__FILE__) + '/../lib/names.txt')
    #   it 'returns an integer' do
    #     actual = NamesScores.total_score(file_names)
    #     expect(actual).to be_a(Integer)
    #   end

    #   it 'returns a non-negative score' do
    #     actual = NamesScores.total_score(file_names)
    #     expected = 0
    #     expect(actual).to be >= expected
    #   end
    # end
  end
end
