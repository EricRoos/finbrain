class TagsController < ApplicationController
  before_action :set_taggable
  before_action :set_tag, only: %i[ show edit update destroy ]

  # GET /tags
  def index
    @tags = @taggable.tags
  end

  # GET /tags/1
  def show
  end

  # GET /tags/new
  def new
    @tag = Tag.new
    if params[:suggest].present?
      render :suggest
    else
      render :new
    end
  end

  # GET /tags/1/edit
  def edit
  end

  # POST /tags
  def create
    @tag = Tag.new(tag_params)
    if @taggable.tag_with(@tag.value)
      redirect_to taggable_tags_path(taggable_type: @taggable.class.to_s.underscore, taggable_id: @taggable.id), notice: "Tag was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      redirect_to @tag, notice: "Tag was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  def destroy
    if @taggable.present?
      TagRelation.where(tag: @tag, taggable: @taggable).destroy_all
      redirect_to taggable_tags_path(taggable_type: @taggable.class.to_s.underscore, taggable_id: @taggable.id), notice: "Tag was successfully removed."
    else
      Tag.find(params[:id]).destroy
      redirect_to request.referer, notice: 'Tag removed'
    end
  end

  private
    def set_taggable
      type_map = {
        bank_transactions: BankTransaction,
        bank_transaction: BankTransaction
      }
      klass = type_map[params[:taggable_type]&.to_sym]
      return unless klass.present?
      @taggable ||= klass.find(params[:taggable_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_params
      params.require(:tag).permit(:value)
    end
end
