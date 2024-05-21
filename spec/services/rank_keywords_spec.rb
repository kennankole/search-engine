require 'rails_helper'

RSpec.describe RankKeywords do
  let(:queries) {
    [
      "The quick brown fox jumps over the lazy dog",
      "Quick brown fox",
      "Lazy dog and quick fox",
      "The quick brown fox"
    ]
  }

  subject { described_class.new(queries) }

  describe '#rank_keywords' do
    before { subject.rank_keywords }

    it 'counts the occurences of each keyword' do
      expect(subject.keyword_data['quick'][:count]).to eq(4)
      expect(subject.keyword_data['brown'][:count]).to eq(3)
      expect(subject.keyword_data['fox'][:count]).to eq(4)
      expect(subject.keyword_data['lazy'][:count]).to eq(2)
      expect(subject.keyword_data['dog'][:count]).to eq(2)
    end

    it 'associates the correct queries with each keyword' do
      expect(subject.keyword_data['quick'][:queries]).to match_array(queries)
      expect(subject.keyword_data['brown'][:queries]).to match_array([
                                                                       'The quick brown fox jumps over the lazy dog',
                                                                       'Quick brown fox',
                                                                       'The quick brown fox'
                                                                     ])
      expect(subject.keyword_data['fox'][:queries]).to match_array([
                                                                     "The quick brown fox jumps over the lazy dog",
                                                                     "Quick brown fox",
                                                                     "Lazy dog and quick fox",
                                                                     "The quick brown fox"
                                                                   ])
      expect(subject.keyword_data['lazy'][:queries]).to match_array([
                                                                      "The quick brown fox jumps over the lazy dog",
                                                                      "Lazy dog and quick fox"
                                                                    ])
      expect(subject.keyword_data['dog'][:queries]).to match_array([
                                                                     "The quick brown fox jumps over the lazy dog",
                                                                     "Lazy dog and quick fox"
                                                                   ])
    end

    it 'sorts the keywords by their count in descending order' do
      sorted_keywords = subject.keyword_data.keys
      expect(sorted_keywords).to eq(['quick', 'fox', 'brown', 'lazy', 'dog', 'jumps', 'over'])
    end
  end

  describe '#extract_keywords' do
    it 'extracts keywords from a query string' do
      query = 'The quick brown fox jumps over the lazy dog'
      keywords = subject.send(:extract_keywords, query)
      expect(keywords).to match_array(['quick', 'brown', 'fox', 'jumps', 'over', 'lazy', 'dog'])
    end

    it 'removes stop words from the query string' do
      query = 'A quick brown fox and a lazy dog'
      keywords = subject.send(:extract_keywords, query)
      expect(keywords).to match_array(['quick', 'brown', 'fox', 'lazy', 'dog'])
    end
  end
end
