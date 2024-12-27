import 'package:flutter/material.dart';
import 'widgets/job_list.dart';
import 'widgets/tag_list.dart';
import 'widgets/home_app_bar.dart';
import 'widgets/search_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
              HomeAppBar(),
              SearchCard(),
              TagList(),
              JobList(),
            ],
          )
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).colorScheme.secondary,
        elevation: 0,
        onPressed: () {},
        child: Icon(
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
          items: [
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
              label: 'Home',
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
