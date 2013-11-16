=begin
  Bayes Model API:

    inc_freq(cls_name):
      increment frequency of `cls_name` class
    inc_token(cls_name, token):
      increment frequency of `token` in `cls_name` class

    total_cls_docs(cls_name):
      get total amount of documents of `cls_name` class in learning sample
    total_docs:
      get total amount of docs in learning sample
    total_tokens:
      amount of uniq tokens
    uniq_cls_tokens(cls_name):
      amount of uniq tokens among `cls_name` class documents
    total_cls_tokens(cls_name):
      amount of all tokens (freq) among `cls_name` class documents
    cls_token(cls_name, token):
      frequency of token presence in `cls_name` class documents

=end
module Classifier
  # Simple Hash implementation of Bayes Model
  #
  class Bayes::Model
    attr_reader :freq, :vocabular, :class_vocabular

    def initialize
      @freq = {}
      @class_vocabular = {}
      @vocabular = {}
    end

    # API

    def inc_freq(cls_name)
      # [uniq_tokens, total_tokens, total_docs]
      @freq[cls_name] ||= [0, 0, 0]
      @freq[cls_name][2] += 1
    end

    def inc_token(cls_name, token)
      @vocabular[token] ||= true
      cv = @class_vocabular[cls_name] ||= {}
      if cv[token]
        cv[token] += 1
      else
        @freq[cls_name][0] += 1
        cv[token] = 1
      end
      @freq[cls_name][1] += 1
    end

    def total_cls_docs(cls_name)
      @freq[cls_name][2]
    end

    def total_docs
      @freq.values.map(&:last).inject(:+)
    end

    def total_tokens
      @vocabular.size
    end

    def uniq_cls_tokens(cls_name)
      @freq[cls_name][1]
    end

    def total_cls_tokens(cls_name)
      @freq[cls_name][0]
    end

    def cls_token(cls_name, token)
      @class_vocabular.fetch(cls_name, {}).fetch(token, 0)
    end

    # HELPERS

    private


  end
end