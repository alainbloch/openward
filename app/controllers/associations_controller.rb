class AssociationsController < ApplicationController
  
  # METHODS RELATED TO ASSOCIATING MEDIA TO A POST
  
  # this is all found in the post forms
    def user_media
      @user  = User.find_by_id(params[:user_id])
      @medias = if params[:query].nil? or params[:query].blank?
        @user.medias.paginate(:page => params[:page])
      else
        @user.medias.search(:q => params[:query], :page => params[:page])
      end
      refresh_media_list
    end

    def all_media
      @medias = if params[:query].nil? or params[:query].blank?
      @type = params[:type]
        unless @type.blank?
          Media.paginate_by_media_type(@type, :page => params[:page])
        else
          Media.paginate(:page => params[:page])
        end
      else
        unless @type.blank?
          Media.find_by_media_type(@type).search(:q => params[:query], :page => params[:page], :order => "created_at DESC")
        else
          Media.search(:q => params[:query], :page => params[:page], :order => "created_at DESC")
        end
      end
      refresh_media_list
    end

    # I believe this can be replaced by pure javascript
    def add_media
      @media = Media.find_by_id(params[:media_id])
      add_media_update
    end

    # I believe this can be replaced by pure javascript
    def remove_media
      @media = Media.find_by_id(params[:media_id])
      remove_media_update
    end

private

  def refresh_media_list
    render :update do |page|
      page.replace_html "media_list",:partial => '/associations/media/media_list', 
                                      :locals  => {:medias => @medias, 
                                                   :action => params[:action], 
                                                   :user   => @user, 
                                                   :type   => @type }

      # Use this to make sure that the new actions 
      # are highlighted if they are associated
      for media in @medias do
        page << "associated_media('#{media.id}');"
      end
    end    
  end

  def add_media_update
    render :update do |page|
      # Highlights the associated media table
      page['associated_media_list_table'].visual_effect :highlight

      # Inserts the new associate media into the associated media table
      page.insert_html :before, 'associated_media_list_table_last', :partial => '/associations/media/associated_media', 
                                                                     :locals  => {:associated_media => @media }
      page << "associated_media('#{@media.id}');"
      end    
  end

  def remove_media_update
    render :update do |page|
      # Highlights the associated medias div area
      page['associated_media_list'].visual_effect :highlight          

      # Removes the associated media entry
      page.remove "associated_media_entry_#{@media.id}"      

      page << %(var me = document.getElementById('media_entry_#{@media.id}');
                if (me != null) 
                  { Element.replace(me,'#{escape_javascript(render(:partial => "/associations/media/media", 
                                                                   :locals  =>  { :media => @media }))}') };)

    end
  end  
  
end
