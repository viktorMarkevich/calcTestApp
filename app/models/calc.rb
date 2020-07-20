class Calc
  include Mongoid::Document
  field :a, type: String
  field :b, type: String
  field :action, type: String
  attr_readonly :result
end
