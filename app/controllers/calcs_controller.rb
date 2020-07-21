class CalcsController < ApplicationController

  def index
  end

  def create
    @calc = Calc.find_or_initialize_by(calc_params)
    unless @calc.save
      render json: { errors: 'error' }, status: 422
    end
  end

  private
    def calc_params
      params.require(:calc).permit(:a, :b, :operator)
    end
end
