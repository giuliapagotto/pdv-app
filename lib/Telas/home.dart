import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

//Classe da home
class Home extends StatefulWidget {
  @override
  _HomeState createState() => new _HomeState();
}

class _HomeState extends State<Home> {
  Material myItens(IconData icon, String heading, int color) {
    return Material(
      color: Colors.white,
      elevation: 14.0,
      shadowColor: Color(0XB02196F3),
      borderRadius: BorderRadius.circular(24.0),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      heading,
                      style: TextStyle(color: new Color(color), fontSize: 20.0),
                    ),
                  ),
                  Material(
                    color: new Color(color),
                    borderRadius: BorderRadius.circular(24.0),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Icon(
                        icon,
                        color: Colors.white,
                        size: 30.0,
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Vendas"),
        ),
        body: ListView(
          children: <Widget>[
            StaggeredGridView.count(
              shrinkWrap: true,
              physics: ScrollPhysics(),
              crossAxisCount: 2,
              crossAxisSpacing: 12.0,
              mainAxisSpacing: 12.0,
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              children: <Widget>[
                myItens(Icons.graphic_eq, "TotalViews", 0XFFED622B),
                myItens(Icons.bookmark, "Bookmark", 0XFF26CB3C),
                myItens(Icons.notifications, "Notifications", 0XFFFF3266),
                myItens(Icons.attach_money, "Balance", 0XFF3399FE),
                myItens(Icons.settings, "Settings", 0XFFF438CF),
                myItens(Icons.group_work, "Group Work", 0XFF622F74),
                myItens(Icons.message, "Messages", 0XFF7297FF),
              ],
              staggeredTiles: [
                StaggeredTile.extent(2, 130.0),
                StaggeredTile.extent(1, 150.0),
                StaggeredTile.extent(1, 150.0),
                StaggeredTile.extent(1, 150.0),
                StaggeredTile.extent(1, 150.0),
                StaggeredTile.extent(2, 240.0),
                StaggeredTile.extent(2, 120.0)
              ],
            ),
          ],
        ));
  }
}
