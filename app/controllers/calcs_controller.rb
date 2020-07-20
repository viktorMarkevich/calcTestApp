class CalcsController < ApplicationController
  before_action :set_calc, only: [:show, :edit, :update, :destroy]

  # GET /calcs
  # GET /calcs.json
  def index
    @calcs = Calc.all
  end

  # GET /calcs/1
  # GET /calcs/1.json
  def show
  end

  # GET /calcs/new
  def new
    @calc = Calc.new
  end

  # GET /calcs/1/edit
  def edit
  end

  # POST /calcs
  # POST /calcs.json
  def create
    @calc = Calc.new(calc_params)

    respond_to do |format|
      if @calc.save
        format.html { redirect_to @calc, notice: 'Calc was successfully created.' }
        format.json { render :show, status: :created, location: @calc }
      else
        format.html { render :new }
        format.json { render json: @calc.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /calcs/1
  # PATCH/PUT /calcs/1.json
  def update
    respond_to do |format|
      if @calc.update(calc_params)
        format.html { redirect_to @calc, notice: 'Calc was successfully updated.' }
        format.json { render :show, status: :ok, location: @calc }
      else
        format.html { render :edit }
        format.json { render json: @calc.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /calcs/1
  # DELETE /calcs/1.json
  def destroy
    @calc.destroy
    respond_to do |format|
      format.html { redirect_to calcs_url, notice: 'Calc was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_calc
      @calc = Calc.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def calc_params
      params.require(:calc).permit(:index)
    end
end
