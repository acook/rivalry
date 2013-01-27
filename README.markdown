# Rivalry

Rivalry is the (fast!) duplicate file finder written in Ruby.

It supports specifically targeting audio and image files and ignores SCM folders such as `.git` and `.hg` by default.

## Installation

Using rubygems just:

    $ gem install rivalry

If you wish to use Rivalry's functionality inside your app your can instead add this line to your application's Gemfile:

    gem 'rivalry'

And then execute:

    $ bundle

## Usage

On the commandline the most basic usage is:

```ruby
$ rivalry ~/directory/with/duplicates
```

It will display the duplicate files on the screen, which can then be grepped or otherwise used to remove the unwanted duplicates.

Example output:

```ruby
$ rivalry ..
Scanning all files...
-- Total Size  : 173 MB
-- Total Count : 95 files
-- Similar     : 34 files with the same size

Determining duplicates...
-- Dupes Count : 2 files

/Users/acook/Dropbox/Projects/Negutyv Xeiro/Audio/Cytokine Storm/Negutyv Xeiro - Cytokine Storm [Mørch Mix].mp3
/Users/acook/Dropbox/Projects/Negutyv Xeiro/Audio/Cytokine Storm/alexcyto/Cytokine Storm m.mp3
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
