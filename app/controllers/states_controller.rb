class StatesController < ApplicationController
  before_action :set_state, only: [:show, :edit, :update, :destroy]

  include ApplicationHelper

  # GET /states
  # GET /states.json
  def index
    @states = State.all
  end

  # GET /states/1
  # GET /states/1.json
  def show
  end

  # GET /states/new
  def new
    @state = State.new
    @states = State.all
  end

  # GET /states/1/edit
  def edit
  end

  # POST /states
  # POST /states.json
  def create
    @message = ""
    @state = State.new(state_params)

    @states = State.all

    correct = check_answer(@state.name)
    is_dup = check_for_dup(@state.name,@states)

    if correct == false
      @message = "That is not a state."
    elsif is_dup == true
      @message = "You already guessed that one!"
    end

    respond_to do |format|
      if @states.count <= 48 && correct == true && is_dup == false && @state.save
        format.html { redirect_to new_state_path, notice: 'State was successfully created.' }
        format.json { render action: 'show', status: :created, location: @state }
      elsif @states.count == 49 && correct == true && is_dup == false && @state.save
        format.html { redirect_to youwon_path, notice: 'State was successfully created.' }
        format.json { render action: 'show', status: :created, location: @state }
      else
        format.html { render action: 'new' }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /states/1
  # PATCH/PUT /states/1.json
  def update
    respond_to do |format|
      if @state.update(state_params)
        format.html { redirect_to @state, notice: 'State was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @state.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /states/1
  # DELETE /states/1.json
  def destroy
    @state.destroy
    respond_to do |format|
      format.html { redirect_to states_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_state
      @state = State.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def state_params
      params.require(:state).permit(:name)
    end
end
