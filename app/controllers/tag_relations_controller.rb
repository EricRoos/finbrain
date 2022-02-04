class TagRelationsController < ApplicationController
  before_action :set_tag_relation, only: %i[ show edit update destroy ]
  before_action :set_tag

  # GET /tag_relations
  def index
    @tag_relations = TagRelation.all
  end

  # GET /tag_relations/1
  def show
  end

  # GET /tag_relations/new
  def new
    @tag_relation = TagRelation.new
  end

  # GET /tag_relations/1/edit
  def edit
  end

  # POST /tag_relations
  def create
    @tag_relation = TagRelation.new(tag_relation_params)

    if @tag_relation.save
      redirect_to @tag_relation, notice: "Tag relation was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tag_relations/1
  def update
    if @tag_relation.update(tag_relation_params)
      redirect_to @tag_relation, notice: "Tag relation was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tag_relations/1
  def destroy
    @tag_relation.destroy!
    redirect_to tag_relations_url, notice: "Tag relation was successfully destroyed."
  end

  private

    def set_tag
      @tag = Tag.find(params[:id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_tag_relation
      @tag_relation = TagRelation.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def tag_relation_params
      params.require(:tag_relation).permit(:tag_id, :taggable_id, :taggable_type)
    end
end
