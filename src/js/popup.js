$(document).ready(function(){
  i18n();
  initBind();
});
function i18n(){
  ['sort', 'desc', 'reverse', 'unique', 'repeated', 'trim', 'trim_row'].forEach(function(id){
    $('#'+id).text(chrome.i18n.getMessage(id));
  });
  ['g_sort', 'g_trim', 'g_unique'].forEach(function(id){
    $('#'+id).prepend(chrome.i18n.getMessage(id));
  });
}
// 初始化事件
var COMMAND = {
  'trim': $.trim,
  'unique': unique,
  'sort': sort,
  'desc': desc,
  'reverse': reverse,
  'repeated': repeated,
  'trim_row': trim_row
};
function initBind(){
  $('#input').keyup(countInput);
  $('#output').keyup(countOutput);
  for(var id in COMMAND){
    $('#'+id).click(clickHandle);
  }
}
// 单击处理
function clickHandle(e){
  var txt = $('#input').val();
  var id = e.srcElement.id;
  console.debug(id);
  $('#output').val(COMMAND[id](txt));
  countOutput();
}
// 输出统计
function countOutput(){
  var txt = $('#output').val();
  $('#o-count').text(txt.length);
  $('#o-row').text(txt.split('\n').length);
}
// 输入统计
function countInput(){
  var txt = $('#input').val();
  $('#i-count').text(txt.length);
  $('#i-row').text(txt.split('\n').length);
}
