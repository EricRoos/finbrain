class TagManagersController < ApplicationController
  def show
    @tags = Tag
      .select("tags.*, count(distinct tag_relations.id) as transaction_count")
      .all
      .joins("LEFT JOIN tag_relations on tag_relations.tag_id = tags.id")
      .group("tags.id")
      .order("transaction_count desc")
      .page(params.fetch(:page, 1))
  end

  def replace_with
    TagManager.replace_tag_with(
      Tag.find(params[:tag_id]).value, 
      params[:new_tag_value]
    )
    redirect_to tag_manager_path
  end
end
