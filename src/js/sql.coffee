###
sql.coffee
Copyright (C) 2014 ender xu <xuender@gmail.com>

Distributed under terms of the MIT license.
###

split_sql = (str, tab)->
  str.replace(/\s{1,}/g," ")
    .replace(/\ AND\ /ig,"~::~"+tab+tab+"AND ")
    .replace(/\ BETWEEN\ /ig,"~::~"+tab+"BETWEEN ")
    .replace(/\ CASE\ /ig,"~::~"+tab+"CASE ")
    .replace(/\ ELSE\ /ig,"~::~"+tab+"ELSE ")
    .replace(/\ END\ /ig,"~::~"+tab+"END ")
    .replace(/\ FROM\ /ig,"~::~FROM ")
    .replace(/\ GROUP\s{1,}BY/ig,"~::~GROUP BY ")
    .replace(/\ HAVING\ /ig,"~::~HAVING ")
    #.replace(/ SET /ig," SET~::~")
    .replace(/\ IN\ /ig," IN ")
    .replace(/\ JOIN\ /ig,"~::~JOIN ")
    .replace(/\ CROSS~::~{1,}JOIN\ /ig,"~::~CROSS JOIN ")
    .replace(/\ INNER~::~{1,}JOIN\ /ig,"~::~INNER JOIN ")
    .replace(/\ LEFT~::~{1,}JOIN\ /ig,"~::~LEFT JOIN ")
    .replace(/\ RIGHT~::~{1,}JOIN\ /ig,"~::~RIGHT JOIN ")
    .replace(/\ ON /ig,"~::~"+tab+"ON ")
    .replace(/\ OR /ig,"~::~"+tab+tab+"OR ")
    .replace(/\ ORDER\s{1,}BY/ig,"~::~ORDER BY ")
    .replace(/\ OVER\ /ig,"~::~"+tab+"OVER ")
    .replace(/\(\s{0,}SELECT\ /ig,"~::~(SELECT ")
    .replace(/\)\s{0,}SELECT\ /ig,")~::~SELECT ")
    .replace(/\ THEN\ /ig," THEN~::~"+tab+"")
    .replace(/\ UNION\ /ig,"~::~UNION~::~")
    .replace(/\ USING\ /ig,"~::~USING ")
    .replace(/\ WHEN\ /ig,"~::~"+tab+"WHEN ")
    .replace(/\ WHERE\ /ig,"~::~WHERE ")
    .replace(/\ WITH\ /ig,"~::~WITH ")
    #.replace(/\,\s{0,}\(/ig,",~::~( ")
    #.replace(/\,/ig,",~::~"+tab+tab+"")
    .replace(/\ ALL\ /ig," ALL ")
    .replace(/\ AS\ /ig," AS ")
    .replace(/\ ASC\ /ig," ASC ")
    .replace(/\ DESC\ /ig," DESC ")
    .replace(/\ DISTINCT\ /ig," DISTINCT ")
    .replace(/\ EXISTS\ /ig," EXISTS ")
    .replace(/\ NOT\ /ig," NOT ")
    .replace(/\ NULL\ /ig," NULL ")
    .replace(/\ LIKE\ /ig," LIKE ")
    .replace(/\s{0,}SELECT\ /ig,"SELECT ")
    .replace(/\s{0,}UPDATE\ /ig,"UPDATE ")
    .replace(/\ SET\ /ig," SET ")
    .replace(/~::~{1,}/g,"~::~")
    .split('~::~')

isSubquery = (str, parenthesisLevel)->
  parenthesisLevel - (str.replace(/\(/g,'').length - str.replace(/\)/g,'').length )

createShiftArr = (step)->
  space = '    '
  if isNaN(parseInt(step))
    space = step
  else
    space = new Array(step + 1).join(' ')
  shift = ['\n']
  for ix in [0..99]
    shift.push(shift[ix]+space)
  shift

formatSql = (sql)->
  ar_by_quote = sql.replace(/\s{1,}/g," ")
    .replace(/\'/ig,"~::~\'").split('~::~')
  ar = []
  deep = 0
  tab = '    '
  parenthesisLevel = 0
  str = ''
  for i in [0..(ar_by_quote.length - 1)]
    if i%2
      ar = ar.concat(ar_by_quote[i])
    else
      ar = ar.concat(split_sql(ar_by_quote[i], tab) )
  shift = createShiftArr(tab)

  for i in [0..(ar.length - 1)]
    parenthesisLevel = isSubquery(ar[i], parenthesisLevel)

    if /\s{0,}\s{0,}SELECT\s{0,}/.exec(ar[i])
      ar[i] = ar[i].replace(/\,/g,",\n"+tab+tab+"")

    if /\s{0,}\s{0,}SET\s{0,}/.exec(ar[i])
      ar[i] = ar[i].replace(/\,/g,",\n"+tab+tab+"")

    if /\s{0,}\(\s{0,}SELECT\s{0,}/.exec(ar[i])
      deep++
      str += shift[deep]+ar[i]
    else if /\'/.exec(ar[i])
      if parenthesisLevel<1 && deep
              deep--
      str += ar[i]
    else
      str += shift[deep]+ar[i]
      if parenthesisLevel<1 && deep
        deep--
  str.replace(/^\n{1,}/,'').replace(/\n{1,}/g,"\n")

