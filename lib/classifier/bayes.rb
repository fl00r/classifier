require 'unicode'

module Classifier
  class Bayes
    require File.expand_path("../bayes/model", __FILE__)
    DEFAULT_VOCABULARY_MODEL_CLASS = ::Classifier::Bayes::Model

    BMODELS = [:multinomial, :binomial].freeze
    DEFAULT_BMODEL = :multinomial
    DEFAULT_NORMALIZE = true
    DEFAULT_SMOOTHING = 1

    attr_reader :model

    def initialize(classes, opts = {})
      @model = opts[:model] || DEFAULT_VOCABULARY_MODEL_CLASS.new

      @classes = {}
      @rclasses = {} # reverse index

      classes.each do |cls|
        c = ::Classifier::Bayes::Cls.new(self, cls)
        @classes[cls] = c
        @rclasses[c] = cls
      end
    end

    def cls(cls_name)
      @classes[cls_name]
    end

    def teach(cls, str)
      tokens = tokenize_str(str)
      cls_name = @rclasses[cls]

      @model.inc_freq(cls_name)
      tokens.each do |token|
        @model.inc_token(cls_name, token)
      end
    end

    def classify(str, opts = {})
      if opts[:bmodel] && !BMODELS.include?(opts[:bmodel])
        raise ":multinomial and :binomial Bayes Models supported, not #{opts[:bmodel]}"
      end
      normalize = opts[:normalize] == false ? false : DEFAULT_NORMALIZE
      smoothing = opts[:smoothing] || DEFAULT_SMOOTHING
      bmodel    = opts[:bmodel]    || DEFAULT_BMODEL

      bayes = []
      @classes.keys.each do |cls_name|
        cls_bayes = case bmodel
        when :multinomial
          multinomial_bayes(str, cls_name, smoothing)
        when :binomial
          binomial_bayes(str, cls_name, smoothing)
        end

        bayes << [cls_name, cls_bayes]
      end
      bayes = normalize(bayes)  if normalize
      bayes.sort_by{ |cls_name, b| -b }
    end

    def multinomial_bayes(str, cls_name, smoothing)
      total_cls_docs = @model.total_cls_docs(cls_name)
      total_docs = @model.total_docs
      total_tokens = @model.total_tokens
      total_cls_tokens = @model.total_cls_tokens(cls_name)

      bayes = Math.log(total_cls_docs.to_f / total_docs)
      tokenize_str(str).each do |token|
        cls_token = @model.cls_token(cls_name, token)
        val = (cls_token + smoothing).to_f / (total_tokens + total_cls_tokens)
        bayes += Math.log(val)
      end
      bayes
    end

    def binomial_bayes(str, cls_name, smoothing)
      
    end

    def normalize(bayes)
      normalized = []
      values = 0
      bayes.each do |cls_name, v|
        values += Math.exp(v)
      end
      bayes.each do |cls_name, v|
        res = Math.exp(v) / values
        normalized << [cls_name, res]
      end
      normalized
    end

    # Simplest tokenizer ever.
    # 
    def tokenize_str(str)
      Unicode.downcase(str).scan(/[[:word:]]+/).select{ |t| t.size > 1 }
    end
  end
end