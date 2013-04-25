class RegressionsController < ApplicationController
  before_action :set_regression, only: [:show, :edit, :update, :destroy]

  # GET /regressions
  # GET /regressions.json
  def index
    @regressions = Regression.all
  end

  # GET /regressions/1
  # GET /regressions/1.json
  def show
  end

  # GET /regressions/new
  def new
    @regression = Regression.new
  end

  # GET /regressions/1/edit
  def edit
  end

  # POST /regressions
  # POST /regressions.json
  def create
    @regression = Regression.new(regression_params)

    respond_to do |format|
      if @regression.save
        format.html { redirect_to @regression, notice: 'Regression was successfully created.' }
        format.json { render action: 'show', status: :created, location: @regression }
      else
        format.html { render action: 'new' }
        format.json { render json: @regression.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /regressions/1
  # PATCH/PUT /regressions/1.json
  def update
    respond_to do |format|
      if @regression.update(regression_params)
        format.html { redirect_to @regression, notice: 'Regression was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @regression.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /regressions/1
  # DELETE /regressions/1.json
  def destroy
    @regression.destroy
    respond_to do |format|
      format.html { redirect_to regressions_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_regression
      @regression = Regression.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def regression_params
      params.require(:regression).permit(:constant, :bedroom_coefficient, :minutes_coefficient)
    end
end
