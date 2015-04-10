module OctoRanker
  class Repository
    def initialize(stars)
      @stars = stars
    end

    # Defines how heavily a repository should be counted when determining
    # scores for a user. Currently defined to be the number of stars on the
    # repository (plus 1, because users should still get points for
    # contributing, even if the repo has no stars).
    def weight
      @stars + 1
    end
  end
end
