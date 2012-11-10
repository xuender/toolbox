// 按行修整
function trim_row(str){
  var ret = [];
  str.split('\n').forEach( function (t){
    ret.push($.trim(t));
  });
  return ret.join('\n');
}
function uniqueArray(array){
  var ret = [];
  var l = array.length;
  for ( var i=0; i<l; i++) {
    for ( var j=i+1; j<l; j++) {
      if (array[i] === array[j])
        j = ++i;
    }
    ret.push(array[i]);
  }
  return ret;
}
// 去重
function unique(str){
  return uniqueArray(str.split('\n')).join('\n');
}
// 重复的
function repeated(str){
  var all = str.split('\n');
  var uni = [];
  var ret = [];
  all.forEach( function (o){
    if (uni.indexOf(o) < 0){
      uni.push(o);
    }else{
      ret.push(o);
    }
  });
  return uniqueArray(ret).join('\n');
}
// 顺序
function sort(str){
  return str.split('\n').sort().join('\n')
}
// 倒序
function desc(str){
  return str.split('\n').sort().reverse().join('\n')
}
// 逆转
function reverse(str){
  return str.split('\n').reverse().join('\n')
}
