
import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:peliculas/src/models/actores_model.dart';
import 'package:peliculas/src/models/pelicula_model.dart';

class PeliculasProvider{
  String _apikey= '452f946721d6da4b6b5225a1355e5917';
  String _url= 'api.themoviedb.org';
  String _language = 'es-ES';

  int _popularesPage= 0;
  bool _cargando= false;

  List<Pelicula> _populares= List();
  final _popularesStreamController= StreamController<List<Pelicula>>.broadcast();


  Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add;

  Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;


  void disposeStream(){
    _popularesStreamController?.close();
  }


  Future<List<Pelicula>> getEnCines() async{

    final url= Uri.http(_url, '3/movie/now_playing', {
      'api_key': _apikey,
      'language': _language,
    });

    return await _procesarRespuesta(url);
  }


  Future<List<Pelicula>> getPopulares() async{
    if (_cargando) return [];

    _cargando= true;

    _popularesPage++;

    final url= Uri.http(_url, '3/movie/popular', {
      'api_key' : _apikey,
      'language': _language,
      'page'    : _popularesPage.toString()
    });

    final resp= await _procesarRespuesta(url);
    _populares.addAll(resp);

    popularesSink(_populares);
    _cargando= false;

    return resp;
    
  }


  Future<List<Pelicula>> _procesarRespuesta(Uri url) async{
    final resp= await http.get(url);
    final decodeData= json.decode(resp.body);
    final peliculas= Peliculas.fromJsonList(decodeData['results']);

    return peliculas.items;
  }

  Future<List<Actor>> getCast(String peliId) async{
    
    final url= Uri.http(_url, '3/movie/$peliId/credits',{
      'api_key' : _apikey,
      'language': _language,
    });

    final resp= await http.get(url);
    final decodeData= json.decode(resp.body);
    final cast= Cast.fromJsonList(decodeData['cast']);

    return cast.items;
  }

}