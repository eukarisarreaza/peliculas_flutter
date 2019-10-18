import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas/src/models/pelicula_model.dart';


class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;

  CardSwiper({@required  this.peliculas});

  @override
  Widget build(BuildContext context) {
    final _screenSize= MediaQuery.of(context).size;


    return Container(
      padding: EdgeInsets.only(top: 10.0),
  
      child: Swiper(
          itemBuilder: (BuildContext context,int index){
            peliculas[index].uniqueId= '${peliculas[index].id}-tarjetas';

            return 
            Hero(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child: _cardPelicula(context, peliculas[index])
              ), 
              tag: peliculas[index].uniqueId,
            );
          },
          itemWidth: _screenSize.width * 0.7,
          itemHeight: _screenSize.height * 0.5,
          itemCount: peliculas.length,
          layout: SwiperLayout.STACK,
          //pagination: new SwiperPagination(),
          //control: new SwiperControl(),
      ),
    );
  }

  Widget _cardPelicula(BuildContext context, Pelicula pelicula){
    var tarjeta= FadeInImage(
      placeholder: AssetImage('assets/loader.gif'),
      image: NetworkImage( pelicula.getPosterImg()),
      fit: BoxFit.cover,
    );

    return GestureDetector(
        child: tarjeta,
        onTap: (){
          print('ID de la pelicula ${pelicula.title}');
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
        },
    );
  }
}