$(document).ready(function(){
  initBind();
});
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
