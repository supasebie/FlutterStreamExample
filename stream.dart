import 'dart:async';

class Order {
  String type;
  
  Order(this.type);
}

class Cake {}

void main() {
  final controller = new StreamController();
  
  final order = new Order('banana');
  
  final baker = new StreamTransformer.fromHandlers(
  	handleData: (cakeType, sink) {
      if(cakeType == 'chocolate') {
        sink.add(new Cake());
      } else {
        sink.addError("I can't bake that type!");
      }
    }
  );
  
  controller.sink.add(order);
  
  controller.stream
    .map((order) => order.type)
    .transform(baker)
    .listen(
    	(cake) => print("Here is your $cake"),
    onError: (err) => print(err)
  );
}
