class CalcsController < ApplicationController

  def index
    @calcs = Calc.all
  end

  def create
    @calc = Calc.new(calc_params)
    unless @calc.save
      render json: { errors: object }, status: 422
    end
  end

  private
    def calc_params
      params.require(:calc).permit(:a, :b, :operator)
    end
end
