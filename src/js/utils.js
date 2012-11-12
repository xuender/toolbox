// 按行修整
function trim_row(str){
  var ret = [];
  str.split('\n').forEach( function (t){
    ret.push($.trim(t));
  });
  return ret.join('\n');
}
// 删除空白行
function removeBlankLine(str){
  var ret = [];
  str.split('\n').forEach( function (t){
    if(t.length>0){
      ret.push($.trim(t));
    }
  });
  return ret.join('\n');
}
// 数组唯一
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
function repeatStr(s, count) {
  return new Array(count + 1).join(s);
}
// JSON格式化
function formatJson(json) {
  var i           = 0,
      il          = 0,
      tab         = "    ",
      newJson     = "",
      indentLevel = 0,
      inString    = false,
      currentChar = null;

  for (i = 0, il = json.length; i < il; i += 1) { 
    currentChar = json.charAt(i);

    switch (currentChar) {
      case '{': 
      case '[': 
        if (!inString) { 
          newJson += currentChar + "\n" + repeatStr(tab, indentLevel + 1);
          indentLevel += 1; 
        } else { 
          newJson += currentChar; 
        }
        break; 
      case '}': 
      case ']': 
        if (!inString) { 
          indentLevel -= 1; 
          newJson += "\n" + repeatStr(tab, indentLevel) + currentChar; 
        } else { 
          newJson += currentChar; 
        } 
        break; 
      case ',': 
        if (!inString) { 
          newJson += ",\n" + repeatStr(tab, indentLevel); 
        } else { 
          newJson += currentChar; 
        } 
        break; 
      case ':': 
        if (!inString) { 
          newJson += ": "; 
        } else { 
          newJson += currentChar; 
        } 
        break; 
      case ' ':
      case "\n":
      case "\t":
        if (inString) {
          newJson += currentChar;
        }
        break;
      case '"': 
        if (i > 0 && json.charAt(i - 1) !== '\\') {
          inString = !inString; 
        }
        newJson += currentChar; 
        break;
      default: 
        newJson += currentChar; 
        break;                    
    } 
  } 
  return newJson; 
}
