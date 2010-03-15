module Admin::PagesHelper
  
  # Following methods help in creating the parent page.
  
  def parent_page(parent_page = nil)
    return '' if parent_page.nil?
    str = ''
    while page != nil
      page = page.parent_page
      str << '-'
    end
    return str << parent_page.title  
  end
  
  def parent_pages(page)
    @page = page
    pages = Page.parents
    @list = "<option value=""></option>"
    iterate_pages(pages, '')
    return @list
  end
  
  def parent_page_select
    pages = Page.parents
    return pages.collect {|p| [ p.title, p.id ] }
  end
  
  def iterate_pages(pages, spacer = '-')
    original_spacer = spacer.dup
    pages.each do |page|
      next if @page == page
      @list << "<option value='#{page.id }' #{'selected="selected"' if @page.parent_page == page}>#{spacer + page.title}</option>"
      iterate_pages(page.child_pages, spacer << "-") if page.child_pages
      spacer = original_spacer
    end
  end
  
end
