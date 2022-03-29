class BankTransactionsController < ApplicationController
  before_action :set_bank_transaction, only: %i[ show edit update destroy approval similar tag_similar approve_similar]

  def random_untagged
    @bank_transaction = BankTransaction.left_outer_joins(:tag_relations).where("tag_relations.id is null").last(50).shuffle.first
  end

  def random_unreviewed
    @bank_transaction = BankTransaction.not_reviewed.limit(30).shuffle.first
  end

  def similar
    @threshold = (params[:threshold] || "0.95").to_f
    @similar_transactions = @bank_transaction.similar_transactions(@threshold).includes(:tags)
  end

  def tag_similar
    @threshold = (params[:threshold] || "0.95").to_f
    @similar_transactions = @bank_transaction.similar_transactions(@threshold).includes(:tags)
    @similar_transactions.each do |transaction|
      transaction.tags.destroy_all
      @bank_transaction.tags.each do |tag|
        transaction.tag_with(tag.value)
      end
    end
    redirect_to similar_bank_transaction_path(@bank_transaction, threshold: @threshold)
  end

  def approve_similar
    @threshold = (params[:threshold] || "0.90").to_f
    @similar_transactions = @bank_transaction.similar_transactions(@threshold).includes(:tags)
    @similar_transactions.each do |transaction|
      transaction.reviewed = true
      transaction.save
    end
    redirect_to similar_bank_transaction_path(@bank_transaction, threshold: @threshold)

  end

  # GET /bank_transactions
  def index
    @bank_transactions = BankTransaction
      .includes(:tags)
      .distinct
    if (params[:tags] || []).any?
      @bank_transactions = @bank_transactions
        .where(id: TagRelation.where(tag_id: params[:tags]).where(taggable_type: 'BankTransaction').pluck(:taggable_id))
    end
    @total = Money.from_cents(@bank_transactions.sum(:total_cents))
    @bank_transactions = @bank_transactions.order(posted_at: :desc).page(params.fetch(:page,1))
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
      respond_to do |format|
        format.html do
          redirect_to request.referer, notice: "Bank transaction was successfully updated."
        end
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(@bank_transaction, partial: 'bank_transactions/bank_transaction', locals: { bank_transaction: @bank_transaction})
          ]
        end
      end
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
      params.require(:bank_transaction).permit(:posted_at, :amount, :description, :total, :reviewed)
    end
end
