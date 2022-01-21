# Kakeibo (API)

## Ruby version

Check `.ruby-version` file. Should be the same as the Ruby version in the `Gemfile` file.

## System dependencies

N/A

## Configuration

WIP

## Database creation/initialization

```
bundle exec ridgepole -c config/database.yml --apply
bundle exec ridgepole -c config/database.yml --apply --env test
```

## Run the test suite

```
bundle exec rspec
```

## Services (job queues, cache servers, search engines, etc.)

N/A

## Deployment instructions

For now, deployment has to be done manually (capistrano setup is low priority for now).

1. Install using:

```
bundle install
```

2. Create a file called `.env`, copy the content of `.env.template` and edit accordingly.
3. Edit the `config/database.yml` file.
4. Execute database changes:

```
bundle exec ridgepole -c config/database.yml --apply -E production
```

5. Deploy the server:

```
RAILS_ENV=production bundle exec rails s -b 0.0.0.0 -p APP_PORT
```

## Tools used

1. GraphQL
2. Devise (JWT)
3. Ridgepole
4. Rspec
5. RuboCop & RubyCritic

And others.
