module OctoRanker
  class User
    attr_reader :score
    attr_writer :login

    def initialize(login = nil)
      @login, @score = login, 0
    end

    def add_repo(commits, stars)
      @score += commits * stars
    end
  end
end
