$(document).ready(function(){
  i18n();
  initBind();
  breadcrumb();
  if(localStorage.one == 'checked'){
    $('#one').attr("checked", 'checked');
    oneArea();
  }
});
$(window).load(function(){
  $('#input').focus();
  chrome.i18n.getAcceptLanguages(function(list){
    list.split(',').forEach(function(l){
      _gaq.push(['_trackEvent', 'locale', l]);
    });
  });
});
// 多国语言
function i18n(){
  ['sort', 'desc', 'reverse', 'unique', 'repeated', 'trim', 'trim_row',
    'input_label', 'output_label', 'swap', 'repeat', 'clean', 'title' 
      ].forEach(function(id){
        $('#'+id).text(chrome.i18n.getMessage(id));
      });
  ['g_sort', 'sort', 'desc', 'reverse', 'g_unique', 'unique', 
    'repeated', 'g_trim', 'trim', 'trim_row', 'input', 'output',
    'repeat', 'clean', 'swap'].forEach(function(id){
      $('#'+id).attr('title', chrome.i18n.getMessage(id+'_title'));
    });
  ['g_sort', 'g_trim', 'g_unique'].forEach(function(id){
    $('#'+id).prepend(chrome.i18n.getMessage(id));
  });
  ['one_label', 'name'].forEach(function(id){
    $('#'+id).append(chrome.i18n.getMessage(id));
  });
  ['t_row', 't_byte'].forEach(function(id){
    $('.'+id).text(chrome.i18n.getMessage(id));
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
// 事件绑定
function initBind(){
  $('#input').keyup(countInput);
  $('#output').keyup(countOutput);
  $('#one').click(oneArea);
  $('#repeat').click(repeat);
  $('#clean').click(clean);
  $('#swap').click(swap);
  for(var id in COMMAND){
    $('#'+id).click(clickHandle);
  }
  $('.old>a').live('click', function() { 
    run($(this).attr('data-id'));
  });
}
// 显示面包屑
function breadcrumb(){
  $('.old').remove();
  if(localStorage.history){
    $('.breadcrumb').show();
    var old = localStorage.history.split(',');
    console.debug(old);
    old.forEach(function(id){
      console.debug(id);
      $('<li class="old"><a href="#" class="btn" data-id="'+
        id + '">' +
        chrome.i18n.getMessage(id) + '</a></li>').insertBefore('#split');
    });
  }else{
    $('.breadcrumb').hide();
  }
}
// 单窗口模式
function oneArea(){
  if($('#one').attr("checked")){
    $('#outdiv').hide();
    $('#input').addClass('one');
    $('#b_one').hide();
    _gaq.push(['_trackEvent', 'one', 'true']);
  }else{
    $('#outdiv').show();
    $('#input').removeClass('one');
    $('#b_one').show();
    _gaq.push(['_trackEvent', 'one', 'false']);
  }
  $('#input').focus();
  localStorage.one = $('#one').attr("checked");
}
// 重复命令
function repeat(){
  if(localStorage.history){
    localStorage.history.split(',').forEach(function(id){
      run(id);
    });
  }
  $('#input').focus();
  _gaq.push(['_trackEvent', 'command', 'repeat']);
}
// 运行命令
function run(id){
  if(id=='swap'){
    var tmp = $('#input').val();
    $('#input').val($('#output').val());
    countInput();
    $('#output').val(tmp);
  }else{
    var txt = $('#input').val();
    if($('#one').attr("checked")){
      $('#input').val(COMMAND[id](txt));
    }else{
      $('#output').val(COMMAND[id](txt));
    }
    countOutput();
  }
  _gaq.push(['_trackEvent', 'command', id]);
}
// IO swap
function swap(){
  run('swap');
  countOutput();
  pushCommand('swap');
  $('#input').focus();
}
// 单击处理
function clickHandle(e){
  var id = e.srcElement.id;
  run(id);
  pushCommand(id);
  $('#input').focus();
}
function pushCommand(id){
  if(localStorage.history){
    var hs = localStorage.history.split(',');
    hs.push(id);
    if(hs.length > 5){
      localStorage.history = hs.slice(1).join(',');
    }else{
      localStorage.history = hs.join(',');
    }
  }else{
    localStorage.history = id;
  }
  breadcrumb();
}
// 清除
function clean(){
  localStorage.removeItem('history');
  breadcrumb();
  $('#input').focus();
  _gaq.push(['_trackEvent', 'command', 'clean']);
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
