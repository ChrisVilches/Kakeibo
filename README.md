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

WIP
