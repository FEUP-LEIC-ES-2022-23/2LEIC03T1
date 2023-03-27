import 'package:flutter/material.dart';
import 'package:gameshare/services/api_requests.dart';
import 'package:gameshare/view/components/circular_progress.dart';
import 'package:gameshare/view/components/top_bar.dart';
import '../../model/genre.dart';
import '../../services/providers/scroll_provider.dart';
import '../components/nav_bar.dart';
import 'package:gameshare/view/components/scrollable_game_list.dart';
import '../components/section_title.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final Future<List<Genre>> allGenres;

  @override
  void initState() {
    super.initState();
    allGenres = fetchGenres();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: Padding(
        padding: const EdgeInsets.all(9.0),
        child: FutureBuilder(
          future: allGenres,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasData) {
                return ListView(
                  controller: ScrollProvider.scrollController,
                  children: [
                    for (Genre genre in snapshot.data!)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget> [
                          SectionTitle(title: genre.name),
                          SizedBox(
                              height: 300,
                              child: ScrollableGameList(scrollHorizontally: true, genres: [genre.slug])
                          ),
                        ],
                      ),
                  ],
                );
              }
              else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
            }
            return const Center(child: CircularProgressBar());
          }
        ),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
