# Classifier

Inspired by [Denis Bazhenov](http://bazhenov.me/)

	* http://bazhenov.me/blog/2012/06/11/naive-bayes.html
	* http://bazhenov.me/blog/2013/04/23/maximum-entropy-classifier.html

[Naive Bayes classifier](http://en.wikipedia.org/wiki/Naive_Bayes_classifier) and [Principle of maximum entropy classifier](http://en.wikipedia.org/wiki/Principle_of_maximum_entropy) implementations on Ruby.

## Usage

```ruby
require 'classifier'

@bayes = Classifier::Bayes.new(["SPAM", "HAM"])

spam = @bayes.cls("SPAM")
ham = @bayes.cls("HAM")

spam.teach("Buy viagra free without a reciepe")
spam.teach("Enlarge your mojo twice for free")
spam.teach("Total sale! Last autumn collection!")
spam.teach("Mojo and Evil for free!")

ham.teach("Hi Peter! Let's go to sale in the moll?")
ham.teach("Buy some lemonade for party!")
ham.teach("It's a party time!")
ham.teach("Waiting in the moll")

res = @bayes.classify("Buy some viagra please!")
p res
#=> [["SPAM", 0.8], ["HAM", 0.19999999999999998]]

res = @bayes.classify("It is party in the mall")
p res
#=> [["HAM", 0.9818181818181818], ["SPAM", 0.018181818181818146]]

res = @bayes.classify("New tokens presented")
p res
#=> [["SPAM", 0.5], ["HAM", 0.5]]
```

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
