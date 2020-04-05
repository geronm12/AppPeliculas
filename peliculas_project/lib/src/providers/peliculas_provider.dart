
import 'dart:async';
import 'dart:convert';
import 'package:peliculas_project/src/models/actores_modelo.dart';
import 'package:peliculas_project/src/models/pelicula_model.dart';
import 'package:http/http.dart' as http;

class PeliculasProvider {

String _apikey = '8a44b844913192f7d94fc25a7c18a695';
String _url = 'api.themoviedb.org';
String _language = 'es-ES';

int _popularesPage = 0;

bool _cargando = false;

List<Pelicula> _populares = new List();

final _popularesStreamController = StreamController<List<Pelicula>>.broadcast();


Function(List<Pelicula>) get popularesSink => _popularesStreamController.sink.add; 


Stream<List<Pelicula>> get popularesStream => _popularesStreamController.stream;



void dispose(){
  
  _popularesStreamController?.close();

}


Future<List<Pelicula>> _procesarRespuesta (Uri url) async {

final resp = await http.get(url);
final decodedData = json.decode(resp.body);
final peliculas = new Peliculas.fromJsonList(decodedData['results']);

return peliculas.items;

}





     Future<List<Pelicula>> getEnCines() async {
    
     final url = Uri.https(_url, '3/movie/now_playing',
     {
      'api_key' : _apikey,  
       'language': _language
     });
    

      return await _procesarRespuesta(url);
     
     
}
     




     Future<List<Pelicula>> getPopulares() async {
     

      if(_cargando) return [];

      _cargando = true;

      _popularesPage ++;
    
      final url = Uri.http(_url, '/3/movie/popular',{
      
      'api_key' : _apikey,
      'language': _language,
      'page' : _popularesPage.toString()
      } );

        
      final respuesta = await _procesarRespuesta(url);
      
      _populares..addAll(respuesta);

      popularesSink(_populares);


      _cargando = false;
      
      return  respuesta;
     }




Future<List<Actor>> getCast(String peliId) async 
{
   final url = Uri.https(_url, '3/movie/$peliId/credits', 
   {
     'api_key': _apikey,
     'laguage': _language

   });


   final resp = await http.get(url);


   final decodedData = json.decode(resp.body);
    
   
   final actoresResp = new Actores.fromJsonList(decodedData['cast']);
   
   return actoresResp.actores;
 }



Future<List<Pelicula>> buscarPelicula(String query) async 
{
    final url = Uri.https(_url, '3/search/movie',
     {
      'api_key' : _apikey,  
      'language': _language,
      'query': query 
     });
    

      return await _procesarRespuesta(url);
     
}


}