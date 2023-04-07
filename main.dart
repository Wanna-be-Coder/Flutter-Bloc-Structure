import 'dart:async';

class Cake {}

class Order {
  String type;
  Order(this.type);
}

void main() {
  final controller = new StreamController();
  final firstOrder = new Order('cake'); //Cutomers
  final secondOrder = new Order('tea');

  controller.sink.add(firstOrder); //Taking order
  controller.sink.add(secondOrder);

  final baker = StreamTransformer.fromHandlers(
      handleData: (cakeType, sink) => {
            if (cakeType == 'cake')
              {sink.add(new Cake())}
            else
              {sink.addError('Not asking for a cake')}
          }); //Baker function

  controller.stream
      .map((order) => order.type)
      . //Order processing
      transform(baker)
      .listen(
          //handing it to baker
          (cake) => print('Here is your $cake'), //Results
          onError: (err) => print('$err')); //Results
}
