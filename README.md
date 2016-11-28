# Infinum::Accounts

## Usage
### Setup
Configure app specific properties:
```ruby
# config/initializers/accounts_client.rb
Infinum::Accounts.setup do |config|
  config.url = 'https://example.com'
  config.app_id = 'app-id'
end
```
### Client
Authorize users with credentials:
```ruby
Infinum::Accounts.client.check_credentials('harry.hole@example.com', 'oslo')
# => #<Infinum::Accounts::User  @id=1, @email="harry.hole@example.com", ...>
```

## Development
### Setup
Run
```bash
bin/setup
```
### Test
Run
```bash
rspec
```
