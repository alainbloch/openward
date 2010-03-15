class Admin::DashboardController < Admin::AdminController

  def show
    @activities = Activity.paginate(:page => params[:page], :order => "created_at DESC", :per_page => 20)
    
    # monthly statistics
    @unique_visitors          = Visit.uniques_this_month
    
    @most_viewed_article      = Post.most_viewed
    @most_commented_article   = Post.most_commented
    @most_viewed_media        = Media.most_viewed
    
    @pending_articles         = Post.pending_articles[1..5]
    # alerts
    @new_comments = Comment.find_new
    @new_connections = Suggestion.find_new
    @new_subscriptions = Subscription.this_month

    #@most_trackbacked_article = Post.most_trackbacked
    #@new_pages    = Page.find(:all, :conditions => ["? <= created_at <= ?", Time.now - 30.days,Time.now], :order => "created_at DESC", :limit => 4)
    #@updated_articles = Post.find(:all, :conditions => ["? <= updated_at <= ?", Time.now - 30.days,Time.now], :order => "created_at DESC", :limit => 4)
    #@new_articles = Post.find(:all, :conditions => ["? <= created_at <= ?", Time.now - 30.days, Time.now], :order => "created_at DESC", :limit => 4)
    #@article_activities = Activity.find_all_by_action_type("Post", :conditions => ["? <= created_at <= ?", Time.now - 30.days, Time.now], :order => "created_at DESC", :limit => 4)
  end
  
end
