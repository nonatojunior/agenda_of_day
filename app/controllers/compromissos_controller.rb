class CompromissosController < ApplicationController
  before_action :set_compromisso, only: [:show, :edit, :update, :destroy]

  # GET /compromissos
  # GET /compromissos.json
  def index
    @compromissos = Compromisso.all
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
  end

  # GET /compromissos/1
  # GET /compromissos/1.json
  def show
  end

  # GET /compromissos/new
  def new
    @compromisso = Compromisso.new
  end

  # GET /compromissos/1/edit
  def edit
  end

  # POST /compromissos
  # POST /compromissos.json
  def create
    @compromisso = Compromisso.new(compromisso_params)

    if @compromisso.save
      redirect_to action: :index
      flash[:notice] = "Compromisso adicionado com sucesso."
    else
      redirect_to action: :index
      flash[:notice] = "Não foi possível adicionar o compromisso."
    end

    # respond_to do |format|
    #   if @compromisso.save
    #     format.html { redirect_to @compromisso, notice: 'Compromisso was successfully created.' }
    #     format.json { render :show, status: :created, location: @compromisso }
    #   else
    #     format.html { render :new }
    #     format.json { render json: @compromisso.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /compromissos/1
  # PATCH/PUT /compromissos/1.json
  def update
    respond_to do |format|
      if @compromisso.update(compromisso_params)
        format.html { redirect_to @compromisso, notice: 'Compromisso atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @compromisso }
      else
        format.html { render :edit }
        format.json { render json: @compromisso.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /compromissos/1
  # DELETE /compromissos/1.json
  def destroy
    @compromisso.destroy
    respond_to do |format|
      format.html { redirect_to compromissos_url, notice: 'Compromisso deletado com sucesso.' }
      format.json { head :no_content }
    end
  end

  def meus_compromissos
    if params[:data]
      @compromissos = Compromisso.where("date = ?", params[:data])
      @compromissos = @compromissos.group_by(&:date)
      if @compromissos.empty?
        data = l(params[:data].to_date, format: :long)
        flash[:notice] = "Não consta compromissos para o dia #{data}"
      end
    else
      @compromissos = Compromisso.all.order('date ASC')
      @compromissos = @compromissos.group_by(&:date)
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_compromisso
      @compromisso = Compromisso.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def compromisso_params
      params.require(:compromisso).permit(:titulo, :descricao, :date)
    end
end
