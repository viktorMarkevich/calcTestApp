class Calc
  include Mongoid::Document
  field :a, type: String
  field :b, type: String
  field :result, type: String
  field :action, type: String
end
