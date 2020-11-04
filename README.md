[![Build Status](https://travis-ci.org/aarongodin/jwks-cr.svg?branch=master)](https://travis-ci.org/aarongodin/jwks-cr)
![GitHub last commit](https://img.shields.io/github/last-commit/aarongodin/jwks-cr?style=flat-square)

# jwks-cr

Utility for retrieving signing keys from a JWKS endpoint. Primarily a port of [node-jwks-rsa](https://github.com/auth0/node-jwks-rsa).

## Installation

1. Add the dependency to your `shard.yml`:

```yaml
dependencies:
  jwks-cr:
    github: aarongodin/jwks-cr
```

2. Run `shards install`

## Usage

```crystal
require "jwks-cr"
```

TODO: Document usage once API is complete

## Contributing

1. Fork it (<https://github.com/aarongodin/jwks-cr/fork>)
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request

## Contributors

- [Aaron Godin](https://github.com/aarongodin) - creator and maintainer
