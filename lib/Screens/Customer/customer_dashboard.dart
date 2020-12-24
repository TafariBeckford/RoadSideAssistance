import 'package:RoadSideAssistance/Screens/Login/login_screen.dart';
import 'package:RoadSideAssistance/Screens/ServiceProvider/ListPages/SPlist.dart';
import 'package:RoadSideAssistance/Screens/ServiceProvider/ListPages/TowTruckList.dart';
import 'package:RoadSideAssistance/constants.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:RoadSideAssistance/components/ReusableCard.dart';
import 'package:foldable_sidebar/foldable_sidebar.dart';

FirebaseAuth auth = FirebaseAuth.instance;

class CustomerDashboard extends StatefulWidget {
  @override
  _CustomerDashboardState createState() => _CustomerDashboardState();
}

class _CustomerDashboardState extends State<CustomerDashboard> {
  FSBStatus status;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('DASHBOARD'),
            leading: IconButton(
              icon: Icon(
                Icons.list,
                color: Colors.white,
              ),
              onPressed: () {
                setState(() {
                  status = status == FSBStatus.FSB_OPEN
                      ? FSBStatus.FSB_CLOSE
                      : FSBStatus.FSB_OPEN;
                });
              },
            ),
          ),
          body: FoldableSidebarBuilder(
              drawerBackgroundColor: Color(0xFF0A0E21),
              status: status,
              drawer: CustomDrawer(
                closeDrawer: () {
                  setState(() {
                    status = FSBStatus.FSB_CLOSE;
                  });
                },
              ),
              screenContents: OptionGrid())),
    );
  }
}

class OptionGrid extends StatefulWidget {
  @override
  _OptionGridState createState() => _OptionGridState();
}

class _OptionGridState extends State<OptionGrid> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {
                    Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => ListPage()));
                  },
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Tab(
                      icon: Image.asset("assets/icons/flat-tire.png"),
                      text: 'Flat Tyre',
                    ),
                  ),
                ),
              ),
              SizedBox(),
              Expanded(
                child: InkWell(
                  // borderRadius: ,
                  onTap: () {
                     Navigator.pushReplacement(context,
                        MaterialPageRoute(builder: (context) => TowTruckListPage()));
                  },
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Tab(
                      icon: Image.asset("assets/icons/tow-truck.png"),
                      text: 'Towing',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {
                    print('it was tapped');
                  },
                  child: ReusableCard(
                    cardChild: Tab(
                      icon: Image.asset("assets/icons/car-battery.png"),
                      text: 'Dead Battery',
                    ),
                    colour: kActiveCardColour,
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    print('it was tapped');
                  },
                  child: ReusableCard(
                    cardChild: Tab(
                      icon: Image.asset("assets/icons/engine-oil.png"),
                      text: 'Engine Oil',
                    ),
                    colour: kActiveCardColour,
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Row(
            children: <Widget>[
              Expanded(
                child: InkWell(
                  onTap: () {
                    print('it was tapped');
                  },
                  child: ReusableCard(
                    cardChild: Tab(
                      icon: Image.asset("assets/icons/gas-pump.png"),
                      text: 'Low Fuel',
                    ),
                    colour: kActiveCardColour,
                  ),
                ),
              ),
              Expanded(
                child: InkWell(
                  onTap: () {
                    print('it was tapped');
                  },
                  child: ReusableCard(
                    colour: kActiveCardColour,
                    cardChild: Tab(
                      icon: Image.asset("assets/icons/car-service.png"),
                      text: 'Breakdown',
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class CustomDrawer extends StatelessWidget {
  final Function closeDrawer;

  const CustomDrawer({Key key, this.closeDrawer}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);
    return Container(
      color: kInActiveColour,
      width: mediaQuery.size.width * 0.60,
      height: mediaQuery.size.height,
      child: Column(
        children: <Widget>[
          Container(
            width: double.infinity,
            height: 200,
            color: kInActiveColour,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset(
                  "drive-steering-wheel.jpg",
                  fit: BoxFit.cover,
                  //width: 100,
                  //height: 100,
                ),
                SizedBox(
                  height: 10,
                ),
                Text("RetroPortal Studio")
              ],
            ),
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Profile");
            },
            leading: Icon(Icons.person),
            title: Text(
              "Your Profile",
            ),
          ),
          Divider(
            height: 1,
            color: Colors.white,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped settings");
            },
            leading: Icon(Icons.settings),
            title: Text("Settings"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Payments");
            },
            leading: Icon(Icons.payment),
            title: Text("Payments"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              debugPrint("Tapped Notifications");
            },
            leading: Icon(Icons.notifications),
            title: Text("Notifications"),
          ),
          Divider(
            height: 1,
            color: Colors.grey,
          ),
          ListTile(
            onTap: () {
              _signOut();
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) {
                    return LoginScreen();
                  },
                ),
              );
            },
            leading: Icon(Icons.exit_to_app),
            title: Text("Log Out"),
          ),
        ],
      ),
    );
  }

  _signOut() async {
    await auth.signOut();
  }
}
