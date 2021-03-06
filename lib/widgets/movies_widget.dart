import 'package:bwatch_front/constants.dart';
import 'package:bwatch_front/providers/data_provider.dart';
import 'package:bwatch_front/routes/single_movie_route.dart';
import 'package:provider/provider.dart';

import '../database.dart';
import 'package:flutter/material.dart';

class MoviesWidget extends StatelessWidget {
  final String listType;

  MoviesWidget(this.listType);

  @override
  Widget build(BuildContext context) {
    final globalData = Provider.of<DataProvider>(context, listen: false);
    return FutureBuilder(
        future: getMovies(this.listType),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.data == null) {
            return Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: snapshot.data.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  singleMovieRoute(context, snapshot, globalData, index);
                },
                child: Container(
                  margin: EdgeInsets.only(right: 20),
                  child: DecoratedBox(
                    decoration: BoxDecoration(
                      color: Color(kAccentColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.all(10),
                          width: 150,
                          height: 225,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            image: DecorationImage(
                                image: NetworkImage(
                                    'https://image.tmdb.org/t/p/w500' +
                                        snapshot.data[index].image),
                                fit: BoxFit.cover),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: EdgeInsets.only(left: 10),
                              child: Icon(
                                Icons.star,
                                color: Colors.yellow,
                              ),
                            ),
                            Text(
                              snapshot.data[index].rating,
                              style: TextStyle(color: Colors.white),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10),
                          constraints: BoxConstraints(maxWidth: 150),
                          child: Text(
                            snapshot.data[index].title,
                            style: TextStyle(color: Colors.white),
                            overflow: TextOverflow.fade,
                            softWrap: false,
                            maxLines: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        });
  }
}
