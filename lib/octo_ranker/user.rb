module OctoRanker
  class User
    attr_reader :score
    attr_writer :login

    def initialize(login = nil)
      @login, @score = login, 0
    end

    # Add the score for +repo+ to the score for this user.
    # Currently, the score for a repo is defined as the product
    # of the number of commits the user has on the repo and the
    # weight of that repo. See OctoRanker::Repository for how
    # the weight is defined.
    def add_repo(commits, repo)
      @score += commits * repo.weight
    end
  end
end
