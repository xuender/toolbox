test('文本', function() {
  var str = '1\n2\n1';
  equal(unique(str), '2\n1', 'unique');
  equal(repeated(str), '1', 'repeated');
  str = '2\n3\n1';
  equal(sort(str), '1\n2\n3', 'sort');
  equal(desc(str), '3\n2\n1', 'desc');
  equal(reverse(str), '1\n3\n2', 'reverse');
});
