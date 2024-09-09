import 'package:flutter/material.dart';
import '../../../Model/User.dart'; // Import your User model
import 'googlelogin.dart'; // Replace with your Firebase services import

class HomeScreen extends StatefulWidget {
  final User? currentUser; // Optional: If you want to pass the current user
  const HomeScreen({Key? key, this.currentUser}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<User> userList = []; // List to store users
  FirebaseServices firebaseServices = FirebaseServices();

  @override
  void initState() {
    super.initState();
    _fetchUsers();
  }

  Future<void> _fetchUsers() async {
    try {
      List<User> users = await firebaseServices.getAllUsers(); // Fetch users from Firebase
      setState(() {
        userList = users; // Update state with fetched users
      });
    } catch (e) {
      print('Error fetching users: $e');
      // Handle error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.notifications),
            onPressed: () {
              // Handle notification icon press
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Welcome!',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    widget.currentUser?.name ?? 'User Name', // Display current user's name
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // Handle Home drawer item tap
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // Handle Settings drawer item tap
              },
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                // Handle Profile drawer item tap
              },
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                _signOut(context); // Call _signOut method
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
        itemCount: userList.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(userList[index].logoUrl),
            ),
            title: Text(userList[index].name),
            onTap: () {
              // Handle tapping on a user item
            },
          );
        },
      ),
    );
  }

  Future<void> _signOut(BuildContext context) async {
    // Implement sign-out logic here
  }
}
