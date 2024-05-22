class RankKeywords
  attr_reader :keyword_data

  STOP_WORDS = %w[
    a about above after again against all am an and any are aren't as at be because been before
    being below between both but by can't cannot could couldn't did didn't do does doesn't doing
    don't down during each few for from further had hadn't has hasn't have haven't having he he'd
    he'll he's her here here's hers herself him himself his how how's i i'd i'll i'm i've if in
    into is isn't it it's its itself let's me more most mustn't my myself no nor not of off on once
    only or other ought our ours ourselves out over own same shan't she she'd she'll she's should
    shouldn't so some such than that that's the their theirs them themselves then there there's
    these they they'd they'll they're they've this those through to too under until up very was
    wasn't we we'd we'll we're we've were weren't what what's when when's where where's which while
    who who's whom why why's with won't would wouldn't you you'd you'll you're you've your yours
    yourself yourselves
  ].freeze

  def initialize(queries)
    @queries = queries
    @keyword_counts = Hash.new(0)
    @keyword_queries = Hash.new {
      |hash, key| hash[key] = []
    }
  end

  def rank_keywords
    @queries.each do |query|
      keywords = extract_keywords(query)
      keywords.each do |keyword|
        @keyword_counts[keyword] += 1
        @keyword_queries[keyword] << query
      end
    end
    @keyword_data = @keyword_counts.sort_by {
      |_, count| -count
    }.map do |keyword, count|{
      keyword: keyword, 
      count: count,
      queries: @keyword_queries[keyword]
    }
    end
  end

  private

  def extract_keywords(query)
    keywords = query.downcase.scan(/\b[a-z]+\b/)

    filtered_keywords = keywords.reject {
      |word| STOP_WORDS.include?(word)
    }
    stemmed_keywords = filtered_keywords.map {
      |word| word
    }
    stemmed_keywords
  end
end