This is a (partial) [orm_adapter](https://github.com/ianwhite/orm_adapter) backend for [ActiveStash](https://cipherstash.com/activestash), the ActiveRecord adapter for the [CipherStash encrypted, searchable data store](https://cipherstash.com).
Only those methods which have been needed for real-world ActiveStash usage to date have been implemented.
PRs for the remaining methods are appreciated, and should be fairly straightforward.


# Installation

The basic option is to install it as a gem directly:

    gem install orm_adapter-activestash

There's also the wonders of [the Gemfile](http://bundler.io):

    gem 'orm_adapter-activestash'

If you're the sturdy type that likes to run from git:

    rake install

Or, if you've eschewed the convenience of Rubygems entirely, then you
presumably know what to do already.


# Usage

In general, it should be sufficient to load the ActiveStash `orm_adapter` backend:

```ruby
require "orm_adapter/activestash"
```

Then use your `ActiveStash::Search`-enabled models in the usual way, mixing encrypted and plaintext fields as you wish:

```ruby
class User < ActiveRecord::Base
  include ActiveStash::Search

  has_encrypted :first_name, type: :string
  has_encrypted :last_name, type: :string

  stash_index :first_name, :last_name
end

# Can query on indexed, encrypted fields
User.to_adapter.find_first(first_name: "Jean", last_name: "Doe")

# Can query on unencrypted fields
User.to_adapter.find_first(employee: true)

# Can also query on a *mix* of encrypted and unencrypted fields
User.to_adapter.find_first(employee: true, first_name: "Jean")
```


# Contributing

Please see [CONTRIBUTING.md](CONTRIBUTING.md) for general contribution guidelines.


## Making a Release

If you have push access to the GitHub repository, you can make a release by doing the following:

1. Run `git version-bump <major|minor|patch>` (see [the semver spec](https://semver.org) for what each of major, minor, and patch version bumps represent).

2. Write a changelog for the release, in Git commit style (headline on the first line, blank line, then Markdown text as you see fit).
   Save/exit your editor.
   This will automatically push the newly-created annotated tag, which will in turn kick off a release build of the gem and push it to [RubyGems.org](https://rubygems.org/gem/orm_adapter-activestash).

3. Run `rake release` to automagically create a new [GitHub release](https://github.com/cipherstash/orm_adapter-activestash/releases) for the project.

... and that's it!


# Licence

Unless otherwise stated, everything in this repo is covered by the following
copyright notice:

    Copyright (C) 2022  CipherStash Inc.

    This program is free software: you can redistribute it and/or modify it
    under the terms of the GNU General Public License version 3, as
    published by the Free Software Foundation.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program.  If not, see <http://www.gnu.org/licenses/>.
