
p Object.class.ancestors.last == BasicObject
# true

# p BasicObject.new.methods.sort
# undefined method `methods' for #<BasicObject:0x00007fffc3e21600> (NoMethodError)

p BasicObject.instance_methods(false).sort
# [:!, :!=, :==, :__id__, :__send__, :equal?, :instance_eval, :instance_exec]

require 'builder'
xml = Builder::XmlMarkup.new(target: STDOUT, indent: 2)
xml.instruct!
xml.friends do
  xml.friend(source: 'career') do
    xml.name('Jeo Leo')
    xml.address do
      xml.street('123 Main Street')
      xml.city('Anywhere, USA 00000')
    end
  end
end

class Lister < BasicObject
  attr_reader :list
  def initialize
    @list = ''
    @level = 0
  end
  
  def indent(string)
    ' ' * @level + string.to_s
  end
  
  def method_missing(m, &block)
    @list << indent(m) + ':'
    @list << '\n'
    @level += 2
    @list << indent(yield(self)) if block
    @level -= 2
    @list << "\n"
    return
  end
end

lister = Lister.new
lister.groceries do |item|
  item.name { 'Apples' }
  item.quantity { 10 }
  item.name { 'Sugar' }
  item.quantity { '1 lb' }
end

lister.freeze do |f|
  f.name { 'Ice cream' }
end

lister.inspect do |i|
  i.item { 'car' }
end

lister.sleep do |s|
  s.hours { 8 }
end

lister.print do |document|
  document.book { 'Chapter 13' }
  document.letter { 'to editor' }
end

puts lister.list
