import 'package:flutter/material.dart';
import 'package:gameshare/model/game.dart';
import 'package:gameshare/services/api_requests.dart';
import 'package:gameshare/view/components/bars/top_bar.dart';
import 'package:gameshare/view/components/circular_progress.dart';
import 'package:gameshare/view/components/scrollable_game_list.dart';
import 'package:http/io_client.dart';

import '../../model/genre.dart';
import '../../services/providers/scroll_provider.dart';
import '../components/bars/nav_bar.dart';
import '../components/game_card.dart';
import '../components/text_utils/api_error_message.dart';
import '../components/text_utils/section_title.dart';

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
    allGenres = fetchGenres(IOClient());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: const Key('Home'),
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
                          children: <Widget>[
                            SectionTitle(title: genre.name),
                            SizedBox(
                                height: 300,
                                child: ScrollableGameList(
                                    scrollHorizontally: true,
                                    genres: [genre.slug])),
                          ],
                        ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  // Only use it to run tests when the api is down
                  //return GameCard(game: Game(13, "", ['Xbox'], 'Tales of toninhos'),key: Key("action1"),);
                   return APIErrorMessage(errMessage: snapshot.error.toString());
                }
              }
              return const Center(child: CircularProgressBar());
            }),
      ),
      bottomNavigationBar: const NavBar(),
    );
  }
}
