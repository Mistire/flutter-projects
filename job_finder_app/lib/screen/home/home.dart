import 'package:flutter/material.dart';
import '../apply/apply.dart';
import '../chat/chat.dart';
import '../profile/profile_page.dart';
import '../search/search.dart';
import 'widgets/job_list.dart';
import 'widgets/tag_list.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/search_card.dart';

// Profile redirects to ProfilePage

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String selectedTag = 'All'; // Track selected tag

  // Callback to handle tag change
  void _onTagChange(String tag) {
    setState(() {
      selectedTag = tag; // Update the selected tag
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: Container(),
              ),
              Expanded(
                flex: 1,
                child: Container(color: Colors.grey.withOpacity(0.1)),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeAppBar(), // Your custom AppBar
              const SearchCard(), // Your custom SearchCard (search functionality separate)
              TagList(
                onTagChange: _onTagChange, // Pass the callback to filter jobs
              ),
              JobList(
                selectedTag:
                    selectedTag, // Pass selected tag to JobList for filtering
              ),
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        onPressed: () {
          // Navigate to ApplyPage when FAB is pressed
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const ApplyPage()),
          );
        },
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      bottomNavigationBar: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: Theme.of(context).primaryColor,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            switch (index) {
              case 0:
                // Navigate to Home (current page)
                break;
              case 1:
                // Navigate to SearchPage (Case redirect)
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const SearchPage()),
                );
                break;
              case 3:
                // Navigate to ChatPage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ChatPage()),
                );
                break;
              case 4:
                // Navigate to ProfilePage
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
                break;
              default:
                break;
            }
          },
          items: const [
            BottomNavigationBarItem(
              label: 'Home',
              icon: Icon(
                Icons.home,
                size: 20,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Case',
              icon: Icon(
                Icons.cases_outlined,
                size: 20,
              ),
            ),
            BottomNavigationBarItem(
              label: '',
              icon: Text(''),
            ),
            BottomNavigationBarItem(
              label: 'Chat',
              icon: Icon(
                Icons.chat_outlined,
                size: 20,
              ),
            ),
            BottomNavigationBarItem(
              label: 'Profile',
              icon: Icon(
                Icons.person_2_outlined,
                size: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
