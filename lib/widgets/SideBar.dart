import 'package:flutter/material.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 220.0,
      child: Drawer(
        backgroundColor: Theme.of(context).primaryColor,
        child: ListView(
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Center(
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            ListTile(
              iconColor: Colors.white,
              focusColor: Colors.grey,
              textColor: Colors.white,
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {},
            ),
            ListTile(
              iconColor: Colors.white,
              focusColor: Colors.grey,
              textColor: Colors.white,
              leading: const Icon(Icons.search),
              title: const Text('Search'),
              onTap: () {},
            ),
            ListTile(
              iconColor: Colors.white,
              focusColor: Colors.grey,
              textColor: Colors.white,
              leading: const Icon(Icons.library_music),
              title: const Text('Library'),
              onTap: () {},
            ),
          ],
        ),
      ),
    );
  }
}
