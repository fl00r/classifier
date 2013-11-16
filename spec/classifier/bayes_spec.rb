require 'spec_helper'

describe Classifier::Bayes do
  before do
    @bayes = Classifier::Bayes.new(["SPAM", "HAM"])
  end

  it "should teach" do
    spam = @bayes.cls("SPAM")
    ham = @bayes.cls("HAM")

    spam.teach("Buy viagra free without a reciepe")
    spam.teach("Enlarge your mojo twice for free")
    spam.teach("Total sale! Last autumn collection!")
    spam.teach("Total sale! Mojo and viagra for free!")

    ham.teach("Hi Peter! Let's go to sale in the moll?")
    ham.teach("Buy some lemonade for party!")
    ham.teach("It's a party time!")
    ham.teach("Waiting in the moll")

    res = @bayes.classify("Buy some viagra please!")
    res.first.first.must_equal "SPAM"

    res = @bayes.classify("It is party in the mall")
    res.first.first.must_equal "HAM"
  end 
end