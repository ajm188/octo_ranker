module OctoRanker
  class User
    attr_reader :score
    attr_writer :login

    def initialize(login = nil)
      @login, @score = login, 0
    end

    # Add the score for a repo to the score for this user.
    # Currently, the score for a repo is defined as the product
    # of the number of commits the user has on the repo and the
    # number of stars on the repo.
    def add_repo(commits, stars)
      @score += commits * stars
    end
  end
end
