# Watson Language Translator gem

Wlt is a command line application and API to translate text using the Watson
Language Translator service.

Before you can use Wlt you need to create a set of credentials see:
https://console.bluemix.net/docs/services/watson/getting-started-credentials.html#getting-credentials-manually

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'wlt'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install wlt

## Usage

You can do translations via the CLI or using the Wlt API

### CLI

Translate a file:

    $ wlt --username=<your-watson-username> --password=<your-watson-password> --file=path/to/file

Save your credentials locally in order not to pass them every time you want to do a translation:

    $ wlt --username=<your-watson-username> --password=<your-watson-password> --save-credentials

Choose different source and target languages:

    $ wlt --source=es --target=en --file=path/to/file

Use process substitution to pass your text directly in the command line:

    $ wlt --file=<(echo "Hello world!")

Print out the help message

    $ wlt --help

### API

```ruby
require 'wlt'

creds_manager = Wlt::CredsManager.new('<your-watson-username>', '<your-watson-password>')
translate_args = { text: 'Hello world!', source: 'en', target: 'es' }
result = Wlt::Translator.new(creds_manager).translate(translate_args)
```

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/mauromorales/wlt.

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
