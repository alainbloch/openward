module MediaLibraryHelper
  
  def render_media_for(media = nil, options = {})
     return if media.nil?
     case media.media_type
     when "Video" then
       render_video(media, options)
     when "Audio" then
       render_audio(media, options)
     when "Image" then
       render_image(media, options)
     when "Text" then
       render_text(media, options)
     when "Caricature" then
       render_image(media, options)
     end
   end

   def render_video(media = nil, options = {})
     case media.media_class
     when "file" then
       render_media_player(media)
     when "link" then
       render_media_link(media, "Video", options)
     when "embed" then
       # currently this is unsafe
       return media.embed
     end
   end

   def render_audio(media = nil, options = {})
     case media.media_class
     when "file" then
       return render_media_player(media)
     when "link" then
       render_media_link(media, "Audio", options)
     when "embed" then
       # currently this is unsafe
       return media.embed
     end
   end

   def render_image(media = nil, options = {})
     case media.media_class
     when "file" then
       @file_column_media = media
       return image_tag(url_for_file_column('file_column_media', 'file'), :class => "media-image", :style => "width:#{options[:width] || Media::STANDARD_WIDTH}px;max-width: 100%;") rescue nil
     when "link" then
       # currently this is unsafe
       render_media_link(media, "Image", options)
     when "embed" then
       # images should not be embedded - maybe
       # currently this is unsafe
       return media.embed
     end
   end

   def render_text(media = nil, options = {})
     case media.media_class
     when "file" then
       @file_column_media = media
       return link_to("Download Text: #{truncate @file_column_media.filename}", url_for_file_column('file_column_media', 'file'))
     when "link" then
       render_media_link(media, "Text", options)
     when "embed" then
       # text should not be embedded - maybe
       return media.embed
     end
   end
   
   def render_media_link(media, name = nil, options = {})
     %(#{link_to "Link to #{name}", media.clean_url, options.merge({:title => media.clean_url, :class => "media_link"})}
       #{link_to image_tag("external_link.jpg",:class => "media_link_image"), media.clean_url, options.merge({:title => media.clean_url})})
   end

   def render_media_player(media = nil, options = {})
     return if media.nil? or media.file.nil?
     @file_column_media = media
     case media.extension
     when ".mov"
       return mov_object(options)
     when ".flv"
       return flash_object(options)
     when ".wmv"
       return windows_object(options)
     when ".avi"
       return mov_object(options)
     when ".mp3"
       return audio_player_object(options)
     when ".wav"
       return audio_player_object(options)
     when ".m4a"
       return audio_player_object(options)
     when ".wma"
       return wma_object(options)   
     else
       return link_to("Download Media: #{media.file}",  url_for_file_column('file_column_media', 'file'), options)
     end
   end
   
   def audio_player_object(options = {})
     %(<object id="MP3player" height="25"  width="#{options[:width] || Media::STANDARD_WIDTH}" align="" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=6,0,0,0" classid="clsid:D27CDB6E-AE6D-11cf-96B8-444553540000">
       <param value="/swf/MP3PlayerMini.swf?src=#{escape_javascript url_for_file_column('file_column_media', 'file')}&autoStart=1" name="movie"/>
       <embed height="25" width="450" align="" pluginspage="http://www.macromedia.com/go/getflashplayer" type="application/x-shockwave-flash" name="MP3player" bgcolor="#AAAAAA" quality="high" src="/swf/MP3PlayerMini.swf?src=#{escape_javascript url_for_file_column('file_column_media', 'file')}&autoStart=1"/>
       <param value="high" name="quality"/>
       <param value="#AAAAAA" name="bgcolor"/>
       </object>)     
   end
   
   def wma_object(options = {})
     %(<object CLASSID="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B" CODEBASE="http://www.apple.com/qtactivex/qtplugin.cab" width="#{options[:width] || Media::STANDARD_WIDTH}"  controller="true">
       <param name="src" value="#{escape_javascript url_for_file_column('file_column_media', 'file')}">
       <param name="controller" value="true">
       <param name="autoplay" value="true">
       <param name="type" value="video/quicktime"  width="#{options[:width] || Media::STANDARD_WIDTH}" >
       <embed src="#{escape_javascript url_for_file_column('file_column_media', 'file')}" width="#{options[:width] || Media::STANDARD_WIDTH}" autoplay="true" type="video/quicktime" pluginspage="http://www.apple.com/quicktime/download/">
       </object>)
    end
   
   def flash_object(options = {})
      %(<object classid="clsid:d27cdb6e-ae6d-11cf-96b8-444553540000" codebase="http://download.macromedia.com/pub/shockwave/cabs/flash/swflash.cab#version=9,0,0,0"  width="#{options[:width] || Media::STANDARD_WIDTH}" height="#{options[:height] || Media::STANDARD_HEIGHT}" id="jcplayer" align="TL">
        <param name="allowScriptAccess" value="sameDomain" />
        <param name="FlashVars" value="videoURL=#{escape_javascript url_for_file_column('file_column_media', 'file')}&autoPlay=false&margins=10&marginsFullScreen=200&offsetY=35&offsetYFullScreen=85&&highlightColor=0xFFCC00&autoHide=true&backgroundColor1=0x333333&backgroundColor2=0x222222">
        <param name="allowFullScreen" value="true" />
        <param name="salign" value="TL" />
        <param name="scale" value="noScale" />
        <param name="movie" value="/swf/jcplayer.swf" />
        <param name="quality" value="high" />
        <param name="bgcolor" value="#ffffff" />	
        <embed src="/swf/jcplayer.swf" FlashVars="videoURL=#{escape_javascript url_for_file_column('file_column_media', 'file')}&autoPlay=false&margins=10&marginsFullScreen=200&offsetY=35&offsetYFullScreen=85&&highlightColor=0xFFCC00&autoHide=true&backgroundColor1=0x333333&backgroundColor2=0x222222" quality="high" bgcolor="#ffffff" width="#{Media::STANDARD_WIDTH}" height="#{Media::STANDARD_HEIGHT}" name="jcplayer" align="middle" salign="TL" scale="noScale" allowScriptAccess="sameDomain" allowFullScreen="true" type="application/x-shockwave-flash" pluginspage="http://www.macromedia.com/go/getflashplayer" />
        </object>)
   end
   
   def mov_object(options = {})
     %(<object CLASSID="clsid:02BF25D5-8C17-4B23-BC80-D3488ABDDC6B" CODEBASE="http://www.apple.com/qtactivex/qtplugin.cab" width="#{options[:width] || Media::STANDARD_WIDTH}"px height="#{options[:height] || Media::STANDARD_HEIGHT}px" controller="true">
       <param name="src" value="#{escape_javascript url_for_file_column('file_column_media', 'file')}">
       <param name="controller" value="true">
       <param name="autoplay" value="true">
       <param name="type" value="video/quicktime"  width="#{options[:width] || Media::STANDARD_WIDTH}" height="#{options[:height] || Media::STANDARD_HEIGHT}" >
       <embed src="#{escape_javascript url_for_file_column('file_column_media', 'file')}" width="#{options[:width] || Media::STANDARD_WIDTH}" height="#{options[:height] || Media::STANDARD_HEIGHT}" autoplay="true" type="video/quicktime" pluginspage="http://www.apple.com/quicktime/download/">
       </object>)
   end
   
   def windows_object(options = {})
     %(<object id="MediaPlayer1" CLASSID="CLSID:22d6f312-b0f6-11d0-94ab-0080c74c7e95" codebase="http://activex.microsoft.com/activex/controls/mplayer/en/nsmp2inf.cab#Version=5,1,52,701" standby="Loading Microsoft Windows® Media Player components..." type="application/x-oleobject"  width="#{options[:width] || Media::STANDARD_WIDTH}" height="#{options[:height] || Media::STANDARD_HEIGHT}">
       <param name="fileName" value="#{escape_javascript url_for_file_column('file_column_media', 'file')}">
       <param name="animationatStart" value="true">
       <param name="transparentatStart" value="true">
       <param name="autoStart" value="true">
       <param name="showControls" value="true">
       <param name="Volume" value="-450">
       <embed type="application/x-mplayer2" pluginspage="http://www.microsoft.com/Windows/MediaPlayer/" src="#{escape_javascript url_for_file_column('file_column_media', 'file')}" name="MediaPlayer1" width="#{options[:width] || Media::STANDARD_WIDTH}" height="#{options[:height] || Media::STANDARD_HEIGHT}" autostart=1 showcontrols=1 volume=-450>
       </object>)
   end

end
