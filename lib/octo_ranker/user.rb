module OctoRanker
  class User
    attr_reader :score

    def initialize(score = 0)
      @score = score
    end

    def add_repo(commits, stars)
      @score += commits * stars
    end
  end
end
