import 'package:flutter/material.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class MovieHorizontal extends StatelessWidget {
  final List<Pelicula> peliculas;
  final Function siguientePagina;


  MovieHorizontal({@required this.peliculas, @required this.siguientePagina});
  
  
  final _pageController= new PageController(
    initialPage: 1,
    viewportFraction: 0.3,

  );


  @override
  Widget build(BuildContext context) {

    final _screenSize= MediaQuery.of(context).size;
    _pageController.addListener((){
      if (_pageController.position.pixels >= _pageController.position.maxScrollExtent-200) {
        siguientePagina();
      }
    });



    return Container(
      height: _screenSize.height*0.3,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        itemCount: peliculas.length,
        //children: _tarjetas(context), 
        itemBuilder: (BuildContext context, int index) {
          return _tarjeta(context, peliculas[index]);
        },
      ),
    );
  }

  Widget _tarjeta(BuildContext context, Pelicula pelicula){
            
      pelicula.uniqueId= '${pelicula.id}-poster';

     final tarjeta= Container(
        margin: EdgeInsets.only(right: 10.0),
        child: Column(
          children: <Widget>[
            Hero(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: FadeInImage(
                  image: NetworkImage(pelicula.getPosterImg()),
                  placeholder: AssetImage('assets/loader.gif'),
                  fit: BoxFit.cover,
                  height: 150.0,
                ),
              ), 
              tag: pelicula.uniqueId,
            ),
            SizedBox(height: 5.0,),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );


      return GestureDetector(
        child: tarjeta,
        onTap: (){
          print('ID de la pelicula ${pelicula.title}');
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
        },
      );
  }

  List<Widget> _tarjetas(BuildContext context) {


    return peliculas.map((pelicula){
      return Container(
        margin: EdgeInsets.only(right: 10.0),
        child: Column(
          children: <Widget>[
            ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: FadeInImage(
                image: NetworkImage(pelicula.getPosterImg()),
                placeholder: AssetImage('assets/loader.gif'),
                fit: BoxFit.cover,
                height: 150.0,
              ),
            ),
            SizedBox(height: 5.0,),
            Text(
              pelicula.title,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.caption,
            )
          ],
        ),
      );
    }).toList();
  }
}