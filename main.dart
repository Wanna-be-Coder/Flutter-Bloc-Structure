import 'dart:async';

class Cake {}

class Order {
  String type;
  Order(this.type);
}

void main() {
  final controller = new StreamController();
  final firstOrder = new Order('cake');
  final secondOrder = new Order('tea');

  controller.sink.add(firstOrder);
  controller.sink.add(secondOrder);

  final baker = StreamTransformer.fromHandlers(
      handleData: (cakeType, sink) => {
            if (cakeType == 'cake')
              {sink.add(new Cake())}
            else
              {sink.addError('Not asking for a cake')}
          });

  controller.stream.map((order) => order.type).transform(baker).listen(
      (cake) => print('Here is your $cake'),
      onError: (err) => print('$err'));
}
