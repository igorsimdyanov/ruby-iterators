# Итераторы в Ruby

В Ruby практически не используются циклы, вся современная экосистема языка и приложения выстроены при помощи итераторов блоков.

## 1. Циклы Ruby

В Ruby как и в любом языке программирования имеются операторы цикла, цель которых, выполнение повторяющихся участков кода.

Например, для перебора элементов массива `[1, 2, 3, 4, 5]` можно воспользоваться циклом `for`:

    for x in [1, 2, 3, 4, 5] do
      puts x
    end
    1
    2
    3
    4
    5

Цикл пробегает значения от начала массива до последнего элемента, помещая на каждой итерации текущее значение из массива в переменную `x`. Когда значения в цикле заканчиваются, цикл завершает работу.

Еще один оператор для выполнения циклов — это `while`. Например, следующий код выводит значения от 1 до 5:

    i = 1
    while i <= 5 do
      puts i
      i += 1
    end
    1
    2
    3
    4
    5

Цикл начинается с ключевого слова `while`, после которого размещено условие. Выражение с условием возвращает либо `true` (истина), либо `false` (ложь). Пока условие возвращает `true`, цикл выполняет выражения между ключевыми словами `do` и `end`. Как только условие возвращает `false`, а это происходит когда переменная i получает значение 6, он прекращает работу.

Кроме оператора `while` существует оператор `until`, который противоположен `while`, так как выполняет блок до тех пор, пока условие ложно:

    i = 1
    until i > 5 do
      puts i
      i += 1
    end
    1
    2
    3
    4
    5

## 2. Почему Ruby-исты не используют циклы?

Перечисленные выше операторы трудно обнаружить в Ruby-коде, по крайней мере в коде конечных приложений. Вместо них, рубисты часто прибегают к итераторам, специальным методам, которые позволяют обходить коллекции.

Рассмотрим типичный итератор `each`:

    [1, 2, 3, 4, 5].each do |i|
      puts i
    end
    1
    2
    3
    4
    5

Метод `each` является именно методом объекта `[1, 2, 3, 4, 5]`, а не специальной конструкцией языка, чуть позже мы попробуем писать свои собственные методы-итераторы.

Конструкция между `do` и `end` называется блоком, и в отличие от одноименных конструкций в циклах имеет собственную область видимости, не может быть сокращена за счет удаление `do` (как в случае циклов), однако, может быть преобразована в краткую форму за счет использования фигурных скобок:

    [1, 2, 3, 4, 5].each { |i| puts i }
    1
    2
    3
    4
    5

К фигурным скобках обычно прибегают, когда блок состоит из одного выражения, в случае нескольких выражений используют полную форму блока, с использованием ключевых слов `do` и `end`.

Итератор `each` применим, не только для массивов, но и для хэшей:

    {a: 'b', c: 'd'}.each { |key, value| puts "#{key}: #{value}" }
    a: b
    c: d

Здесь блок принимает вместо одного, два параметра, `key` под ключ (:a, :c), `value` — под значения ('b', 'd').

Итераторы необязательно обслуживают коллекции, например, итератор `times` применяется к числам позволяет выполнить цикл указанное количество раз:

    5.times { |i| puts i }
    0
    1
    2
    3
    4

Причем для вещественного числа метод `times` уже не сработает:

    (5.0).times { |i| puts i }
    NoMethodError: undefined method `times' for 5.0:Float

Для итерирования от одного числа к другому можно воспользоваться методом `upto`:

    5.upto(10) { |i| puts i }
    5
    6
    7
    8
    9
    10

Метод `downto` позволяет наоборот пробегать числа с шагом минус один:

    10.downto(5) { |i| puts i }
    10
    9
    8
    7
    6
    5

Главное знать, какой итератор можно применять с текущим объектом.

## 3. Как определить какой из итераторов можно использовать?

Как видно из предыдущего раздела итераторы можно применять не ко всем объектам. При поиске подходящего итератора в документации следует помнить, что Ruby является полностью объектно-ориентированным языком. Это упрощает работу с документацией. Так как любая практически любая конструкция языка, за исключением небольшого количества ключевых слов (тех операторов цикла `for`, `while`, `until`), является либо объектом, либо методом объекта.

Например даже обычное сложение

    5 + 2
    7

следует рассматривать как объектно-ориентированную операцию, заключающуюся в вызове метода с именем + в отношении объекта 5, с передачей методу аргумента 2

    5.+(2)
    7

Разумеется на практике отдается предпочтение более привычной арифметической форме записи 5 + 2, хотя в случае Ruby вторая форма записи более каноническая и более точно отражает, что стоит за реальным вызовом.

Почти каждый объект, с которым приходится иметь дело в Ruby, имеет метод `methods`, который возвращает список методов объекта. Например:

    5.methods
    [:%, :&, :*, :+, :-, :/, :<, :>, :^, :|, :~, :-@, :**, :<=>, :<<, :>>, :<=, :>=, :==, :===, :[], :inspect, :size, :succ, :to_s, :to_f, :div, :divmod, :fdiv, :modulo, :abs, :magnitude, :zero?, :odd?, :even?, :bit_length, :to_int, :to_i, :next, :upto, :chr, :ord, :integer?, :floor, :ceil, :round, :truncate, :downto, :times, :pred, :to_r, :numerator, :denominator, :rationalize, :gcd, :lcm, :gcdlcm, :+@, :eql?, :singleton_method_added, :coerce, :i, :remainder, :real?, :nonzero?, :step, :positive?, :negative?, :quo, :arg, :rectangular, :rect, :polar, :real, :imaginary, :imag, :abs2, :angle, :phase, :conjugate, :conj, :to_c, :between?, :iterator, :instance_of?, :public_send, :instance_variable_get, :instance_variable_set, :instance_variable_defined?, :remove_instance_variable, :private_methods, :kind_of?, :instance_variables, :tap, :is_a?, :extend, :define_singleton_method, :to_enum, :enum_for, :=~, :!~, :respond_to?, :freeze, :display, :send, :object_id, :method, :public_method, :singleton_method, :nil?, :hash, :class, :singleton_class, :clone, :dup, :itself, :taint, :tainted?, :untaint, :untrust, :trust, :untrusted?, :methods, :protected_methods, :frozen?, :public_methods, :singleton_methods, :!, :!=, :__send__, :equal?, :instance_eval, :instance_exec, :__id__]

Полученный массив можно сортировать

    5.methods.sort
    [:!, :!=, :!~, :%, :&, :*, :**, :+, :+@, :-, :-@, :/, :<, :<<, :<=, :<=>, :==, :===, :=~, :>, :>=, :>>, :[], :^, :__id__, :__send__, :abs, :abs2, :angle, :arg, :between?, :bit_length, :ceil, :chr, :class, :clone, :coerce, :conj, :conjugate, :define_singleton_method, :denominator, :display, :div, :divmod, :downto, :dup, :enum_for, :eql?, :equal?, :even?, :extend, :fdiv, :floor, :freeze, :frozen?, :gcd, :gcdlcm, :hash, :i, :imag, :imaginary, :inspect, :instance_eval, :instance_exec, :instance_of?, :instance_variable_defined?, :instance_variable_get, :instance_variable_set, :instance_variables, :integer?, :is_a?, :iterator, :itself, :kind_of?, :lcm, :magnitude, :method, :methods, :modulo, :negative?, :next, :nil?, :nonzero?, :numerator, :object_id, :odd?, :ord, :phase, :polar, :positive?, :pred, :private_methods, :protected_methods, :public_method, :public_methods, :public_send, :quo, :rationalize, :real, :real?, :rect, :rectangular, :remainder, :remove_instance_variable, :respond_to?, :round, :send, :singleton_class, :singleton_method, :singleton_method_added, :singleton_methods, :size, :step, :succ, :taint, :tainted?, :tap, :times, :to_c, :to_enum, :to_f, :to_i, :to_int, :to_r, :to_s, :truncate, :trust, :untaint, :untrust, :untrusted?, :upto, :zero?, :|, :~]

Или отфильтровать при помощи метода `grep`

    5.methods.grep :downto
    [:downto]

Метод `grep` допускает использование регулярных выражений, например, следующий вызов вернет список методов, начинающихся с символа d

    5.methods.grep /^d.*/
    [:div, :divmod, :downto, :denominator, :define_singleton_method, :display, :dup]

Кроме того, всегда можно запросить у текущего объекта его класс при помощи одноименного метода `class`:

    5.class
    Fixnum

Получив имя класса, в [документации](https://ruby-doc.org/core-2.3.0/) всегда можно уточнить список его методов.