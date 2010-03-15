module Admin::MediasHelper

  def link_to_medias_path(string = "", column = "created_at", order = "ASC")
    order = "DESC" if @column == column and @order == order
    return link_to(string, admin_medias_path(:column => column, :order => order, :page => params[:page], :query => params[:query]))
  end

end
