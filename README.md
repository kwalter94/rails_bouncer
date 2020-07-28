![Build Status](https://gitlab.com/kwalter94/rails-bouncer/badges/master/pipeline.svg) ![Coverage](https://gitlab.com/kwalter94/rails-bouncer/badges/master/coverage.svg)

# RailsBouncer

An authorisation plugin for Rails inspired by https://github.com/varvet/pundit
and https://github.com/kwalter94/RailsBindPrivileges.

## Usage

```ruby
  # In your controllers base class (normally app/controllers/application_controller.rb).
  class ApplicationController < ActionController::Base
    include RailsBouncer::Bouncer  # Add this line

    def current_user
      # Define method that returns currently logged in user.
      # If you are using devise for authentication then you don't need
      # to define this.
      # ...
    end
  end

  # Define a policy for foobar resource (preferably in app/controller/policies/foobar_policy.rb)
  module FoobarPolicy
    # Restrict create action to admin users only
    def create?(user)
      user.admin? 
    end
  end

  # Attach FoobarPolicy to FoobarController
  class FoobarController < ApplicationController
    # fallback_policy is used for actions without a corresponding predicate in
    # the policy object. Allowed values are :allow and :deny (default) which
    # respectively mean allow all requests to actions without a policy predicate
    # and deny all requests to actions without a policy predicate.
    authorise_through FoobarPolicy, fallback_policy: :allow

    def create
      # ...
    end
  end
```

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'rails_bouncer', git: "https://gitlab.com/kwalter94/rails-bouncer.git"
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install rails_bouncer
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
