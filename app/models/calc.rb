class Calc
  include Mongoid::Document
  field :a, type: String
  field :b, type: String
  field :operator, type: String
  field :result, type: String
  field :number_of_calcs, type: Integer, default: 0

  before_save :manage_number_of_calcs
  before_save :make_calculation


  def manage_number_of_calcs
    self.number_of_calcs += 1 if self.id.present?
  end

  def make_calculation
    self.result = self.make_result
  end

  def set_operation
    "#{a} #{operator} #{b}"
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
