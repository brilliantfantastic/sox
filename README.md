Sox
====

A RubyMotion wrapper for the Freshbooks API.

## Installation

Add this to your RubyMotion application's `Gemfile`:

```ruby
gem 'sox'
```

And then execute:

```sh
bundle
```

Then add this to your RubyMotion application's `Rakefile`:

```ruby
require 'sox'
```

## Usage

All requests can go through the `Sox::Client` object. To create a client object, you pass it your authorization credentials.
Currenly Sox only supports basic authentication using your Freshbooks API token but we there is a plan to add OAuth support.

You can retrieve your Freshbooks API token from the 'My Account' page on Freshbooks.

```ruby
@client = Sox::Client 'your-freshbooks-subdomain', 'api-token'
```

You can then use your client object to perform the CRUD operations on Freshbooks.

```ruby
projects = @client.projects.all
```

Sox will convert the XML that is returned from the Freshbooks API into modern day hashes. Yay!

```ruby
puts projects[:response][:projects][:project][0][:client_id]
```

## TODO

This is a very early release. All the base classes and supporting classes should be in place to easily add the additional proxies and API calls (specifically find, update, create, and delete).

* Currently only setup for OSX
* Add integration tests for real API data
* Support for OAuth authentication

* Clients (create, update, get, delete)
* Projects (create, update, get, delete)
* Categories (create, update, get, delete, list)
* Estimates (create, update, get, delete, list, sendByEmail)
* Categories (create, update, get, delete, list)
* Expenses (create, update, get, delete, list)
* Gateways (list)
* Invoices (create, update, get, delete, list, sendByEmail, sendbySnailMail)
* Invoice Items (add, delete, update)
* Items (create, update, get, delete, list)
* Languages (list)
* Payments (create, update, get, delete, list)
* Receipts (create, update, get, delete)
* Recurring (create, update, get, delete, list)
* Recurring Items (add, delete, update)
* Staff (current, get, list)
* Tasks (create, update, get, delete, list)
* Taxes (create, update, get, delete, list)
* Time entries (create, update, get, delete)

## Contributing

1. Fork it
1. Run `bundle` to get the Gem dependency
1. Run `rake spec` to run all of the tests to ensure they pass
1. Create your feature branch (`git checkout -b my-awesome-sauce`)
1. Write your specs
1. Code!
1. Commit your changes (`git commit -am 'Added some awesome sauce'`)
1. Push your new branch (`git push origin my-awesome-sauce`)
1. Create a pull request (`hub pull-request -b brilliantfantastic:master -h yourrepo:my-awesome-sauce`)

## License

MIT. See [LICENSE](LICENSE)
