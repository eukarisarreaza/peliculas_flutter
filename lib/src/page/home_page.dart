import 'package:flutter/material.dart';
import 'package:peliculas/src/provider/peliculas_provider.dart';
import 'package:peliculas/src/widgets/card_swiper_widget.dart';
import 'package:peliculas/src/widgets/movie_horizontal.dart';

class HomePage extends StatelessWidget {
    final peliculaProvider= PeliculasProvider();

  @override
  Widget build(BuildContext context) {

    peliculaProvider.getPopulares();


    return Scaffold(
      appBar: AppBar(
        title: Text('Peliculas en cines'),
        backgroundColor: Colors.indigoAccent,
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search),
            onPressed: (){},
          )
        ],
        ),
      body: Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _swiperTarjetas(),
            _footer(context)
          ],),
      ),
    );
  }

  Widget _swiperTarjetas() {

    return FutureBuilder(
      future: peliculaProvider.getEnCines(),
      builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
        if (snapshot.hasData) {
          return CardSwiper(peliculas: snapshot.data);
        } else {
          return Container(
            height:400.0,
            child: Center(
              child: CircularProgressIndicator()
              ),
          );
        }        
      },
    );



    //peliculaProvider.getEnCines();
    //return CardSwiper(peliculas: [1, 2, 3, 4, 5],);
    //return Container();
  }

  Widget _footer(BuildContext context) {
    return Container(
      width: double.infinity,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment .start,

        children: <Widget>[
          Container(
            padding: EdgeInsets.only(left: 20.0),
            child: Text('Populares', style: Theme.of(context).textTheme.subhead)
            ),
          
          StreamBuilder(
            stream: peliculaProvider.popularesStream,
            builder: (BuildContext context, AsyncSnapshot<List<dynamic>> snapshot) {
              //snapshot.data?.forEach((p) => print(p.title));
              if (snapshot.hasData) {
                return MovieHorizontal(
                  peliculas:  snapshot.data, 
                  siguientePagina:  peliculaProvider.getPopulares
                );
              }else{
                return Center(child: CircularProgressIndicator());
              }
              
            },
          ),
        ],
      ),
    );
  }
}