# OctoRanker

Git ranked.

OctoRanker can rank the members of an organization based on their contributions
to the organization's public repositories. You should probably read the whole
README, but at the very least, please read the
[organizational usage](#organizational).

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'octo_ranker'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install octo_ranker

## Usage

### Programmatic

Using OctoRanker is very straightforward. It goes like this:
```ruby
require 'octo_ranker'
OctoRanker.rank_members('name-of-my-org')
```
This will give you an array of [`OctoRanker::User`](lib/octo_ranker/user.rb)
objects. You can read the docs to find out how the rankings are calculated.

#### Rate Limiting
GitHub uses rate limiting. You can read about their policies
[here](https://developer.github.com/v3/rate_limit/). Depending on the size of
your organization, this may cause some errors to be thrown once GitHub starts
responding with 429s.

To increase your rate limit, you can configure
[octokit](https://github.com/octokit/octokit.rb) (which is what OctoRanker 
uses to get data from GitHub) to authorize with your GitHub credentials like so:
```ruby
require 'octo_ranker'
Octokit.configure do |c|
  c.login = 'ajm188'
  c.password = 'password' # Obviously not my real password (or is it?), but you get the idea.
end
# Now make your queries as normal
OctoRanker.rank_members('name-of-my-org')
```

If your organization is so large that you're maxing out the authenticated rate
limit (wow, good for you!), create an issue in here, and I'll try to come up
with a good batch processing solution.

### Organizational

OctoRanker is intended to be a fun way to encourage members of your organization
to contribute to your repos. The rankings should provide **friendly** competition
and motivation to get more involved with your organization's open source software.

Things you **should not do** if your organization uses rankings:
* "Dood, you suck. You have, like, the worst ranking in our org."
* Make a bunch of really small commits to boost your ranking. That's not the point.

Things you should do instead:
* Be kind and encouraging to your fellow teammates. You're on the same team after all.
* Focus on making contributions to your organization, and not on your ranking. After all,
the more you focus on making contributions, the better your ranking will be as a result.

## Contributing

1. Fork it ( https://github.com/ajm188/octo_ranker/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Potential Features
These are some things I'm considering adding to the project. If you want to
work on one (or any) of them, feel free. Just let me know so I don't
duplicate your effort (duplicated effort is lame). Also see
[contributing](#contributing) for the workflow.

1. Batch processing of org repos. See [rate limiting](#rate-limiting).
1. Option to count private repos. Note that this will require authentication
from a member of the organization.
1. Add some tests. I've seen the code work, but why should you trust me?
  1. This isn't a "feature" per se, but I might as well stick this here and hope
  someone else does it for me.
