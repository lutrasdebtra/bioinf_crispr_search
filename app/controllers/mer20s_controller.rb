class Mer20sController < ApplicationController
  before_action :set_mer20, only: [:show, :edit, :update, :destroy]

  # POST /mer20s
  # POST /mer20s.json
  def index
  	@mers = []
    # Checkboxes, determines which genomes are searched: 0 = all
    genome = 0
    if params[:search_DSM]
      genome = 1
    end
    if params[:search_LZ]
      genome = 2
    end
    if params[:search_DSM] and params[:search_LZ]
      genome = 0
    end 

    # case for different search types.
    if params[:search]
      case 
        # Start search.
        when (params[:search] =~ /\A\d+\z/ ? true : false) 
          @mers = Mer20.start_search(params[:search], genome)
          if @mers.length == 0
            @mers = Mer14.start_search(params[:search], genome)
          end
        # Range search.
        when (params[:search] =~ /\A\d+\s\-\s\d+\z/ ? true : false)
          queries = params[:search].strip.split(/\s+/)
          @mers = Mer14.range_search(queries[0].to_i, queries[2].to_i, genome)
        # Sequence search.
        when (params[:search] =~ /\A[ATCGatcg\W]+\z/ ? true : false)
          params[:search] = params[:search].gsub(/\W/, "").upcase
          @mers = Mer14.sequence_search(params[:search], genome)
        # Failure, error out. 
        else
        flash.now[:alert] = 'Incorrect search parameters - Seek help'
      end
    end
  end

  # GET /mer20s/1
  # GET /mer20s/1.json
  def show
  end

  # GET /mer20s/new
  def new
    @mer20 = Mer20.new
  end

  # GET /mer20s/1/edit
  def edit
  end

  # THIS HAS BE REDIRECTED - SEE ROUTES.RB
  # POST /mer20s
  # POST /mer20s.json
  def create
    @mer20 = Mer20.new(mer20_params)

    respond_to do |format|
      if @mer20.save
        format.html { redirect_to @mer20, notice: 'Mer20 was successfully created.' }
        format.json { render action: 'show', status: :created, location: @mer20 }
      else
        format.html { render action: 'new' }
        format.json { render json: @mer20.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /mer20s/1
  # PATCH/PUT /mer20s/1.json
  def update
    respond_to do |format|
      if @mer20.update(mer20_params)
        format.html { redirect_to @mer20, notice: 'Mer20 was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @mer20.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mer20s/1
  # DELETE /mer20s/1.json
  def destroy
    @mer20.destroy
    respond_to do |format|
      format.html { redirect_to mer20s_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mer20
      @mer20 = Mer20.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mer20_params
      params.require(:mer20).permit(:sequence, :leading, :lagging, :genome_id, mer14_files_attributes: [:id, :mer20_id, :sequence, :leading, :lagging, :_destroy])
    end
end
