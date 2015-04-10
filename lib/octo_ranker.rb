require 'octo_ranker/version'
require 'octo_ranker/user'
require 'octo_ranker/repository'

require 'octokit'

module OctoRanker
  class << self
    # Rank the members of +organization+ according to their scores.
    # The score for a user on a repo is computed by some function of
    # the number of commits the user has on the repo and the number of
    # stars the repo has (contributions to more popular repos should be
    # significant). See OctoRanker::User#add_repo for how this function
    # is defined. The user's total score is the sum of the user's score
    # on each repo owned by +organization+.
    #
    # Returns an array of OctoRanker::User objects.
    def rank_members(organization)
      users = Hash.new { |h, k| h[k] = OctoRanker::User.new }
      Octokit.organization_repositories(organization).each do |repo|
        stars = Octokit.stargazers(repo.full_name).size
        ranker_repo = OctoRanker::Repository.new(stars)
        Octokit.contributor_stats(repo.full_name).each do |contributor_stat|
          user = users[contributor_stat.author.id]
          user.login = contributor_stat.author.login
          user.add_repo(contributor_stat.total, ranker_repo)
        end
      end
      users.values.sort_by { |u| -u.score }
    end
  end
end
