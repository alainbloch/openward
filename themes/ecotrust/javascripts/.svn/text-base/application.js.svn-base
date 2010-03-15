// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

// Lets detect if the browser is the infamous & terrible ie6. 
// We'll yell at the user if they do use it.

function show_ie6_alert(){
	/*var isIE6 = navigator.userAgent.toLowerCase().indexOf('msie 6') != -1;
	if(isIE6 == true){
  	OpenLightbox('ie6_alert');
	};*/
		var browser=navigator.appName;
		var b_version=navigator.appVersion;
		var version=parseFloat(b_version);
		if ((browser=="Microsoft Internet Explorer") && (version>7)){
    	OpenLightbox('ie6_alert');
  	};
}

function quickRedReference() {
 window.open(
 "http://hobix.com/textile/quick.html",
 "redRef",
 "height=600,width=550,channelmode=0,dependent=0," +
 "directories=0,fullscreen=0,location=0,menubar=0," +
 "resizable=0,scrollbars=1,status=1,toolbar=0"
 );
 }

function toggleEditor(id) {
	var elm = document.getElementById(id);

	if (tinyMCE.getInstanceById(id) == null)
		tinyMCE.execCommand('mceAddControl', false, id);
	else
		tinyMCE.execCommand('mceRemoveControl', false, id);
}

function addEditor(id) {
	var elm = document.getElementById(id);
	var rem_tab = document.getElementById('html_view_tab');
	var add_tab = document.getElementById('wysiwig_view_tab');
  toggle_tab_styles(add_tab, rem_tab);
	tinyMCE.execCommand('mceAddControl', false, id);
}

function removeEditor(id) {
	var elm = document.getElementById(id);
	var rem_tab = document.getElementById('html_view_tab');
	var add_tab = document.getElementById('wysiwig_view_tab');
	toggle_tab_styles(rem_tab, add_tab);
	tinyMCE.execCommand('mceRemoveControl', false, id);
}

function toggle_tab_styles(selected_tab, unselected_tab) {
	selected_tab.style.background = "#F0F0EE";
	selected_tab.style.border = "1px solid #CCCCCC";
	selected_tab.style.borderBottomColor = "#F0F0EE";
	unselected_tab.style.background = "white";
	unselected_tab.style.border = "0px solid white";	
}

function toggle_media_fields(source_field,field_id) {
	var sf = $(source_field);
	var mf = $(field_id);
	$('media_url').disabled = true;
	$('media_embed').disabled = true;
	$('media_file').disabled = true;
	mf.disabled = false;
}

/* Used to toggle the selected option in a list */

function toggle_select(id) {
	var select = document.getElementById(id);
	if (select.value == "true"){
		$('select_' + id).removeClassName('selected');
		select.value = "false";
	}
  else {
		$('select_' + id).addClassName('selected');
		select.value = "true";
	}
}

/* Highlight Media associations */
function associated_media(media_id){	
	var associated_media_entries = $('associated_media_list_table').childElements();
  for (i = 0; i < associated_media_entries.length - 1; i++){
    if (associated_media_entries[i].id == "associated_media_entry_" + media_id){
      $('media_entry_' + media_id).style.backgroundColor = "#BBF48D";
      $('add_media_entry_' + media_id).style.display = 'none';
      $('remove_media_entry_' + media_id).style.display = '';
    };
  };


}

/* Simple Lightbox */

function OpenLightbox(id){
	new Effect.Appear(id + '_fader', {duration: 0.4, to: 0.6, queue: 'end'});
	new Effect.Appear(id + '_popup', {duration: 0.4, queue: 'end'}); 
}

function CloseLightbox(id){
	new Effect.Fade(id + '_popup', {duration: 0.4});
  new Effect.Fade(id + '_fader', {duration: 0.4});
}

