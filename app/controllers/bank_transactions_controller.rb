class BankTransactionsController < ApplicationController
  before_action :set_bank_transaction, only: %i[ show edit update destroy ]

  def random_untagged
    @bank_transaction = BankTransaction.left_outer_joins(:tag_relations).where("tag_relations.id is null").last(50).shuffle.first
  end

  # GET /bank_transactions
  def index
    @bank_transactions = BankTransaction
      .includes(:tags)
    if (params[:tags] || []).any?
      @bank_transactions = @bank_transactions
        .where(id: TagRelation.where(tag_id: params[:tags]).where(taggable_type: 'BankTransaction').pluck(:taggable_id))
    end
  end

  # GET /bank_transactions/1
  def show
  end

  # GET /bank_transactions/new
  def new
    @bank_transaction = BankTransaction.new
  end

  # GET /bank_transactions/1/edit
  def edit
  end

  # POST /bank_transactions
  def create
    @bank_transaction = BankTransaction.new(bank_transaction_params)

    if @bank_transaction.save
      redirect_to @bank_transaction, notice: "Bank transaction was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /bank_transactions/1
  def update
    if @bank_transaction.update(bank_transaction_params)
      redirect_to @bank_transaction, notice: "Bank transaction was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /bank_transactions/1
  def destroy
    @bank_transaction.destroy!
    redirect_to bank_transactions_url, notice: "Bank transaction was successfully destroyed."
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_bank_transaction
      @bank_transaction = BankTransaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def bank_transaction_params
      params.require(:bank_transaction).permit(:posted_at, :amount, :description, :md5, :total)
    end
end
