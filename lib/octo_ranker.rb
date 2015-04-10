require 'octo_ranker/version'
require 'octo_ranker/user'

require 'octokit'

module OctoRanker
  class << self
    def rank_members(organization)
      users = Hash.new { |h, k| h[k] = OctoRanker::User.new }
      Octokit.organization_repositories(organization).each do |repo|
        stars = Octokit.stargazers(repo.full_name).size
        Octokit.contributor_stats(repo.full_name).each do |contributor_stat|
          user = users[contributor_stat.author.id]
          user.login = contributor_stat.author.login
          user.add_repo(contributor_stat.total, stars)
        end
      end
      users.values.sort_by { |u| -u.score }
    end
  end
end
