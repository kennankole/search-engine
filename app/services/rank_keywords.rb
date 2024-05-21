class RankKeywords
  attr_reader :keyword_data

  def initialize(queries)
    @queries = queries
    @keyword_data = Hash.new { |hash, key|
      hash[key] = {
        count: 0,
        queries: []
      }
    }
  end

  def rank_keywords
    @queries.each do |query|
      keywords = extract_keywords(query)
      keywords.each do |keyword|
        @keyword_data[keyword][:count] += 1
        @keyword_data[keyword][:queries] << query
      end
    end
    @keyword_data = @keyword_data.sort_by { |_, data|
      -data[:count]
    }.to_h
  end

  private

  def extract_keywords(query)
    stop_words = %w[a an and are as at be by for from has he in its i is of on that the to was were will with]
    query.downcase.split.reject { |word|
      stop_words.include?(word)
    }
  end
end
