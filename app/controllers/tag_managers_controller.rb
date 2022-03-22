class TagManagersController < ApplicationController
  def show
    @tags = Tag.all.order(value: :asc)
  end

  def replace_with
    TagManager.replace_tag_with(
      Tag.find(params[:tag_id]).value, 
      params[:new_tag_value]
    )
    redirect_to tag_manager_path
  end
end
