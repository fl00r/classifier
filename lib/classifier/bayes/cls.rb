module Classifier
  # Bayes Class
  class Bayes::Cls
    def initialize(classifier, name)
      @classifier = classifier
      @name = name
    end

    def teach(str)
      @classifier.teach(self, str)
    end
  end
end