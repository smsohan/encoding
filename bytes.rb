x = "1"
x.bytes.count


y = x.encode('UTF-16')
y.bytes.count


z = x.encode('UTF-32')
z.bytes.count

x = String.new
x.encoding
x += 'Hello'
x.encoding
x += 'hello'.encode('UTF-16')

"Hello".encoding #change terminal settings