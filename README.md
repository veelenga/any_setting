# Any Setting
[![Build Status](https://travis-ci.org/veelenga/any_setting.svg?branch=master)](https://travis-ci.org/veelenga/any_setting)

Load your settings with ease.

* [x] ECR support
* [x] yaml files
* [ ] json files
* [ ] toml files
* [ ] ini files

## Installation

Add this to your application's `shard.yml`:

```yaml
dependencies:
  any_setting:
    github: veelenga/any_setting
```

## Usage

Settings file `config/site.yml`:

```yml
default: &default
  title: My Super Site
  description: It just so cool and powerful.
  made_by: John Doe
  year: <%= Time.now.year %>

development:
  <<: *default
  url: http://localhost:3000

production:
  <<: *default
  url: https://example.com
```

Your loader:

```crystal
require "any_setting"

class SiteSettings < AnySetting
  source "config/site.yml"
  namespace "production"

  mapping(
    title: String,
    description: String,
    url: String,
    year: Int32,
    author: {
      type:     String,
      key:      "made_by",
      nillable: true,
    }
  )
end

site = SiteSettings.load
site.title       #=> My Super Site
site.description #=> It just so cool and powerful.
site.made_by     #=> John Doe
site.year        #=> 2017
site.url         #=> https://example.com

```

## Contributing

1. Fork it ( https://github.com/veelenga/any_setting/fork )
2. Create your feature branch (git checkout -b my-new-feature)
3. Commit your changes (git commit -am 'Add some feature')
4. Push to the branch (git push origin my-new-feature)
5. Create a new Pull Request
