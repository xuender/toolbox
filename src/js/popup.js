$(document).ready(function(){
  i18n();
  initCommand();
  initBind();
  breadcrumb();
  if(localStorage.one == 'checked'){
    $('#one').attr("checked", 'checked');
  }
  resetArea();
});
$(window).load(function(){
  $('#input').focus();
  chrome.i18n.getAcceptLanguages(function(list){
    list.forEach(function(l){
      _gaq.push(['_trackEvent', 'locale', l]);
    });
  });
});
// 多国语言
function i18n(){
  ['input_label', 'output_label', 'swap', 'repeat', 'clean', 'title' 
    ].forEach(function(id){
      $('#'+id).text(chrome.i18n.getMessage(id));
    });
  ['input', 'output',
    'repeat', 'clean', 'swap', 'new_tab'].forEach(function(id){
      $('#'+id).attr('title', chrome.i18n.getMessage(id+'_title'));
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
  'trim_row': trim_row,
  'md5': CryptoJS.MD5,
  'sha1': CryptoJS.SHA1,
  'js': js_beautify,
  'css': css_beautify,
  'html': style_html,
  'json': formatJson,
  'blank': removeBlankLine,
};
var GROUPS =  [
{'g': 'g_sort', 'c':['sort', 'desc', 'reverse']}, 
{'g': 'g_unique', 'c':['unique', 'repeated']},
{'g': 'g_trim', 'c':['trim', 'trim_row', 'blank']},
{'g': 'g_hash', 'c':['md5', 'sha1']},
{'g': 'g_beautify', 'c':['js', 'css', 'html', 'json']},
  ];
// 初始化命令
function initCommand(){
  GROUPS.forEach(function(group){
    var id = group['g'];
    var div = $('<div class="btn-group"><a class="btn dropdown-toggle" data-toggle="dropdown" href="#" id="' +
      id + '" title="' + chrome.i18n.getMessage(id+'_title')+
      '">'+chrome.i18n.getMessage(id) +
      ' <span class="caret"></span></a></div>');
    var ul = $('<ul class="dropdown-menu"></ul>');
    group['c'].forEach(function(c){
      $('<li><a href="#" title="' + chrome.i18n.getMessage(c + '_title')
        + '" id="' + c + '">'+
        chrome.i18n.getMessage(c) + '</li>').appendTo(ul);
    });
    ul.appendTo(div);
    div.appendTo($('#toolbar'));
  });
}
// 事件绑定
function initBind(){
  $('#input').keyup(countInput);
  $('#output').keyup(countOutput);
  $('#one').click(oneArea);
  $('#repeat').click(repeat);
  $('#clean').click(clean);
  $('#swap').click(swap);
  $('#new_tab').click(newTab);
  for(var id in COMMAND){
    $('#'+id).click(clickHandle);
  }
  $('.old>a').live('click', function() { 
    run($(this).attr('data-id'));
    $('#input').focus();
  });
}
// 新窗口
function newTab(){
  chrome.tabs.create({
    url: 'popup.html'
  });
  _gaq.push(['_trackEvent', 'option', 'new_tab']);
}
// 显示面包屑
function breadcrumb(){
  $('.old').remove();
  if(localStorage.history){
    $('.breadcrumb').show();
    var old = localStorage.history.split(',');
    old.forEach(function(id){
      $('<li class="old"><a href="#" class="btn btn-mini" data-id="'+
        id + '">' +
        chrome.i18n.getMessage(id) + '</a></li>').insertBefore('#split');
    });
  }else{
    $('.breadcrumb').hide();
  }
  resetArea();
}
// 重置窗口
function resetArea(){
  var height = 0;
  $('body').children().each(function(){
    if(!$(this).hasClass('row') && !$(this).is(":hidden")){
      height += $(this).height();
    }
  });
  $('#input').width(window.innerWidth - 230);
  $('#output').width(window.innerWidth - 230);
  if($('#one').attr("checked")){
    height += 166;
    $('#outdiv').hide();
    //$('#input').addClass('one');
    $('#input').height(window.innerHeight - height);
    $('#b_one').hide();
    _gaq.push(['_trackEvent', 'option', 'one']);
  }else{
    height += 226;
    $('#outdiv').show();
    //$('#input').removeClass('one');
    $('#input').height((window.innerHeight - height) / 2);
    $('#output').height($('#input').height());
    $('#b_one').show();
    _gaq.push(['_trackEvent', 'option', 'two']);
  }
}
// 单窗口模式
function oneArea(){ resetArea();
  if($('#one').attr("checked")){
    _gaq.push(['_trackEvent', 'option', 'one']);
  }else{
    _gaq.push(['_trackEvent', 'option', 'two']);
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
