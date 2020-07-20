class Calc
  include Mongoid::Document
  field :a, type: String
  field :b, type: String
  field :operator, type: String
  field :result, type: String

  before_create :make_calculation

  def make_calculation
    self.result = self.make_result
  end

  private

    def make_result
      a = self.a.to_i; b = self.b.to_i;

      case operator
      when '+'
        a + b
      when '-'
        a - b
      when '*'
        a * b
      else
        a / b
      end
    end
end
