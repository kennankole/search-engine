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
      keyword_data = subject.keyword_data.find { |data| data[:keyword] == 'quick' }
      expect(keyword_data[:count]).to eq(4)

      keyword_data = subject.keyword_data.find { |data| data[:keyword] == 'brown' }
      expect(keyword_data[:count]).to eq(3)

      keyword_data = subject.keyword_data.find { |data| data[:keyword] == 'fox' }
      expect(keyword_data[:count]).to eq(4)

      keyword_data = subject.keyword_data.find { |data| data[:keyword] == 'lazy' }
      expect(keyword_data[:count]).to eq(2)

      keyword_data = subject.keyword_data.find { |data| data[:keyword] == 'dog' }
      expect(keyword_data[:count]).to eq(2)
    end

    it 'associates the correct queries with each keyword' do
      keyword_data = subject.keyword_data.find { |data| data[:keyword] == 'quick' }
      expect(keyword_data[:queries]).to match_array(queries)

      keyword_data = subject.keyword_data.find { |data| data[:keyword] == 'brown' }
      expect(keyword_data[:queries]).to match_array([
                                                      'The quick brown fox jumps over the lazy dog',
                                                      'Quick brown fox',
                                                      'The quick brown fox'
                                                    ])

      keyword_data = subject.keyword_data.find { |data| data[:keyword] == 'fox' }
      expect(keyword_data[:queries]).to match_array([
                                                      "The quick brown fox jumps over the lazy dog",
                                                      "Quick brown fox",
                                                      "Lazy dog and quick fox",
                                                      "The quick brown fox"
                                                    ])

      keyword_data = subject.keyword_data.find { |data| data[:keyword] == 'lazy' }
      expect(keyword_data[:queries]).to match_array([
                                                      "The quick brown fox jumps over the lazy dog",
                                                      "Lazy dog and quick fox"
                                                    ])

      keyword_data = subject.keyword_data.find { |data| data[:keyword] == 'dog' }
      expect(keyword_data[:queries]).to match_array([
                                                      "The quick brown fox jumps over the lazy dog",
                                                      "Lazy dog and quick fox"
                                                    ])
    end

    it 'sorts the keywords by their count in descending order' do
      sorted_keywords = subject.keyword_data.map { |data| data[:keyword] }
      expect(sorted_keywords).to eq(['quick', 'fox', 'brown', 'lazy', 'dog', 'jumps'])
    end
  end

  describe '#extract_keywords' do
    it 'extracts keywords from a query string' do
      query = 'The quick brown fox jumps over the lazy dog'
      keywords = subject.send(:extract_keywords, query)
      expect(keywords).to match_array(['quick', 'brown', 'fox', 'jumps', 'lazy', 'dog'])
    end

    it 'removes stop words from the query string' do
      query = 'A quick brown fox and a lazy dog'
      keywords = subject.send(:extract_keywords, query)
      expect(keywords).to match_array(['quick', 'brown', 'fox', 'lazy', 'dog'])
    end
  end
end
