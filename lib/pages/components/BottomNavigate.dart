import 'package:flutter/material.dart';

class MyBottomNavigate extends StatelessWidget {
  const MyBottomNavigate({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      shape: CircularNotchedRectangle(),
      notchMargin: 5,
      child: Container(
        color: Colors.red,
        height: 60,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              width: MediaQuery.of(context).size.width / 2 - 20,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.person)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.home)),
                ],
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width / 2 - 20,
              height: 50,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(onPressed: (){}, icon: Icon(Icons.search)),
                  IconButton(onPressed: (){}, icon: Icon(Icons.shopping_basket)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
