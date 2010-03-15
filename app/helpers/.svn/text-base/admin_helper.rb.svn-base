module AdminHelper
  
  def render_sub_menu
    return render(:partial => "submenu_admin" )  if current_user.has_role?("admin")
    return render(:partial => "submenu_editor")  if current_user.has_role?("contributor")
  end
  
end
