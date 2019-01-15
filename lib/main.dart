import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shopping Cart',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(brightness: Brightness.light, fontFamily: 'Montserrat'),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{

  TabController _controller;

  @override
  void initState() {
    super.initState();
    _controller = new TabController(length: 4, vsync: this);
  }
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List _picked = [false, false];
  int _totalAmount = 0;

  void _pickToggle(int index){
    setState(() {
      _picked[index] = !_picked[index];
      _getTotalAmount();
    });
  }
  void _getTotalAmount(){
    var count = 0;
    for (int i = 0; i < _picked.length; i++) {
      if (_picked[i]) {
        count = count + 1;
      }
      if (i == _picked.length - 1) {
        setState(() {
          _totalAmount = 248 * count;
        });
      }
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        shrinkWrap: true,
        children: <Widget>[
          new Stack(
            children: <Widget>[
              // Header Màu Vàng ở trên
              new Container(
                height: 250,
                color: Color(0XFFFDD148),
                width: double.infinity,
                child: Stack(
                  children: <Widget>[
                    //Hình tròn bóng mờ theo vị trí
                    new Positioned(
                      bottom: 100,
                      right: 100,
                      child: Container(
                        height: 400,
                        width: 400,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                    ),
                    new Positioned(
                      bottom: 150,
                      left: 150,
                      child: Container(
                        height: 300,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: Colors.white.withOpacity(0.2),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              new Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  IconButton(icon: Icon(Icons.arrow_back, size: 40, ), onPressed: (){}),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Text('Shopping Cart', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold)),
                  ),

                  SizedBox(height: 50),
                  _itemListCart(
                    color: 'gray',
                    image: 'assets/anotherchair.jpg',
                    name: 'Ghế - Đệm',
                    price: '\$345',
                    count: 4,
                    available: true,
                    index: 0,
                  ),
                  SizedBox(height: 20),
                  _itemListCart(
                    color: 'orange',
                    image: 'assets/chair.jpg',
                    name: 'Ghế - Sofa',
                    price: '\$125',
                    count: 2,
                    available: true,
                    index: 1,
                  ),
                  SizedBox(height: 20),
                  _itemListCart(
                    color: 'red',
                    image: 'assets/otto5.jpg',
                    name: 'Sofa - Tròn',
                    price: '\$123',
                    count: 1,
                    available: false,
                    index: 2,
                  ),
                  SizedBox(height: 20),
                ],
              ),
              new Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height - 165),
                child: Container(
                  height: 50,
                  color: Colors.white,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Text('Total: \$' + _totalAmount.toString()),
                      SizedBox(width: 10.0),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: RaisedButton(
                          onPressed: () {},
                          elevation: 0.5,
                          color: Colors.red,
                          child: Center(
                            child: Text(
                              'Pay Now',
                            ),
                          ),
                          textColor: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],

          ),
        ],
      ),
      bottomNavigationBar: new Material(
        color: Colors.white,
        child: TabBar(
          indicatorColor: Colors.yellow,
          tabs: [
            Tab(icon: Icon(Icons.event_seat, color: Colors.yellow)),
            Tab(icon: Icon(Icons.timer, color: Colors.grey)),
            Tab(icon: Icon(Icons.shopping_cart, color: Colors.grey)),
            Tab(icon: Icon(Icons.person_outline, color: Colors.grey))
          ],
          controller: _controller,
        ),
      ),
    );
  }

  Widget _itemListCart({String color, String image, String name, String price, int count, bool available, int index}) {
    return InkWell(
      onTap: (){
        if(available)
          _pickToggle(index);
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Material(
          elevation: 5,
          borderRadius: BorderRadius.circular(10),
          child: Container(
            width: MediaQuery.of(context).size.width - 30.0,
            height: 150.0,
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: <Widget>[
                  Container(
                    height: 30,
                    width: 30,
                    decoration: BoxDecoration(
                      color: available ? Colors.grey.withOpacity(0.4) : Colors.red.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(15)
                    ),
                    child: Center(
                      child: available
                      ? Container(
                        height: 12,
                        width: 12,
                        decoration: BoxDecoration(
                          color: _picked[index]
                            ? Colors.yellow
                            : Colors.grey.withOpacity(0.4),
                          borderRadius: BorderRadius.circular(6)
                        ),
                      ) : Container(),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(image), fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          Text(name, style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),),
                          SizedBox(width: 20,),
                          available ? _picked[index] ? Text('x$count', style: TextStyle(fontSize: 20, color: Colors.grey)) : Container(): Container(),
                        ],
                      ),
                      SizedBox(height: 5),
                      Text('Color: $color', style: TextStyle(fontSize: 20, color: Colors.grey),),
                      SizedBox(height: 5),

                      available
                        ? Text(price, style: TextStyle(fontSize: 23, color: Colors.orange,fontWeight: FontWeight.bold))
                        : OutlineButton(
                          onPressed: () {},
                          borderSide: BorderSide(
                            width: 1,
                            style: BorderStyle.solid,
                            color: Colors.red,
                          ),
                          child: Center(
                            child: Text('Find Similar', style: TextStyle(fontSize: 12, color: Colors.red, fontWeight: FontWeight.bold)),
                          ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

}
