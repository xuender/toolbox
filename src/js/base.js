// analytics
var _gaq = _gaq || [];
_gaq.push(['_setAccount', 'UA-35761644-3']);
_gaq.push(['_trackPageview']);

(function() {
  var ga = document.createElement('script'); 
  ga.type = 'text/javascript'; 
  ga.async = true;
  ga.src = 'https://ssl.google-analytics.com/ga.js';
  var s = document.getElementsByTagName('script')[0]; 
  s.parentNode.insertBefore(ga, s);
})();
$(document).ready(function(){
  $('.store').click(gotoStore);
  ['store'].forEach(function(id){
    $('#'+id).text(chrome.i18n.getMessage(id));
  });
});
// 去往软件商店
function gotoStore(){
  _gaq.push(['_trackEvent', 'goto', 'store']);
}
