# Classifier

[Naive Bayes classifier](http://en.wikipedia.org/wiki/Naive_Bayes_classifier) and [Principle of maximum entropy classifier](http://en.wikipedia.org/wiki/Principle_of_maximum_entropy) implementations on Ruby.

## Usage

```ruby
require 'classifier'
bayes = Classifier::Bayes.new("SPAM", "HAM", normalize: true)
bayes.cls("SPAM").teach("Buy some viagra")
bayes.cls("SPAM").teach("Get million dollars for free")
bayes.cls("SPAM").teach("Enlarge your mojo!")
bayes.cls("HAM").teach("Party this evening! Buy some lemonade!")

bayes.classify("Buy some lemonade for free! Total sale!")
#=> [["HAM", 0.684], ["SPAM", 0.321]]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
