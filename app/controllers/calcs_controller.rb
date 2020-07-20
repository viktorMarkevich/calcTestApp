class CalcsController < ApplicationController

  def index
    @calcs = Calc.all
  end

  def create
    @calc = Calc.find_or_initialize_by(calc_params)
    unless @calc.save
      render json: { errors: @calc.errors }, status: 422
    end
  end

  private
    def calc_params
      params.require(:calc).permit(:a, :b, :operator)
    end
end
