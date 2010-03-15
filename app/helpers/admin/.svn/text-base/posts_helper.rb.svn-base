module Admin::PostsHelper
  
  def link_to_posts_path(string = "", column = "created_at", order = "ASC")
    order = "DESC" if @column == column and @order == order
    return link_to( string, admin_posts_path(:column => column, :order => order, :page => params[:page], :query => params[:query]))
  end
  
end