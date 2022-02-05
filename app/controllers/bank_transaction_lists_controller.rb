class BankTransactionListsController < ApplicationController
  before_action :set_bank_transaction_list, only: %i[ show edit update destroy ]

  # GET /bank_transaction_lists
  def index
    @bank_transaction_lists = BankTransactionList.all
  end

  # GET /bank_transaction_lists/1
  def show
  end

  # GET /bank_transaction_lists/new
  def new
    @bank_transaction_list = BankTransactionList.new
  end

  # GET /bank_transaction_lists/1/edit
  def edit
  end

  # POST /bank_transaction_lists
  def create
    @bank_transaction_list = BankTransactionList.new(bank_transaction_list_params)

    if @bank_transaction_list.save
      redirect_to @bank_transaction_list, notice: "Bank transaction list was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bank_transaction_lists/1
  def update
    if @bank_transaction_list.update(bank_transaction_list_params)
      redirect_to @bank_transaction_list, notice: "Bank transaction list was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /bank_transaction_lists/1
  def destroy
    @bank_transaction_list.destroy!
    redirect_to bank_transaction_lists_url, notice: "Bank transaction list was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_transaction_list
      @bank_transaction_list = BankTransactionList.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bank_transaction_list_params
      params.require(:bank_transaction_list).permit(:source_file)
    end
end
