test('文本', function() {
  var str = '1\n2\n1';
  equal(unique(str), '2\n1', 'unique');
  equal(repeated(str), '1', 'repeated');

  str = '2\n3\n1';
  equal(sort(str), '1\n2\n3', 'sort');
  equal(desc(str), '3\n2\n1', 'desc');
  equal(reverse(str), '1\n3\n2', 'reverse');

  str = '20\n3\n100\n3.5\n4';
  equal(sortNumber(str), '3\n3.5\n4\n20\n100', 'sort 数字');
  equal(descNumber(str), '100\n20\n4\n3.5\n3', 'desc 数字');
});
