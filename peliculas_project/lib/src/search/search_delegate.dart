import 'package:flutter/material.dart';
import 'package:peliculas_project/src/models/pelicula_model.dart';
import 'package:peliculas_project/src/providers/peliculas_provider.dart';



class DataSearch extends SearchDelegate 
{

  final peliculasProvider = new PeliculasProvider();


  final peliculas = [
  'Iron Man',
  'Dragon Ball'
  

  ];

  final peliculasRecientes = [
    'Spiderman',
    'Capitan América'
  ];


  @override
  List<Widget> buildActions(BuildContext context) {
    // Las acciones de nuestro AppBar
      return [
      IconButton(icon: Icon(Icons.clear),
      onPressed: () {

      query = '';

      }),
      ];
 

  }

  @override
  Widget buildLeading(BuildContext context) {
    //El icono del inicio (izquierda) del appbar
    return IconButton(
    icon: AnimatedIcon(
    icon: AnimatedIcons.menu_arrow,
    progress: transitionAnimation),
    onPressed: (){

    close(context, null);

    });
  }


  @override
  Widget buildResults(BuildContext context) {
    //Crea los resultados que vamos a mostrar
    return Center(

    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    
   if(query.isEmpty) return Container();

   return FutureBuilder(
   
   future: peliculasProvider.buscarPelicula(query),
   builder: (context, AsyncSnapshot<List<Pelicula>> snapshot)
   {
      if(snapshot.hasData)
      { 
        final peliculas = snapshot.data;

        return ListView(
        children: peliculas.map((pelicula)
        {
          return ListTile(
          leading: FadeInImage(image: NetworkImage(pelicula.getPosterimg()),
          placeholder: AssetImage('recursos/no-image.jpg'),
          width:  50.0,
          fit: BoxFit.contain),
          title: Text(pelicula.title),
          subtitle: Text(pelicula.originalTitle),
          onTap: () {
          close(context, null);
          pelicula.uniqueId = '';
          Navigator.pushNamed(context, 'detalle', arguments: pelicula);
           
          },        
          );
        }).toList()
        ); 

      }else{
       return Center(child: CircularProgressIndicator());
      }
   }
   
   
   );
  





  }
  
   




}


//Sugerencias que aparecen cuando la persona escribe
    
    
    //final listaSugerida = (query.isEmpty) 
    //? peliculasRecientes
    //: peliculas.where(
    //  (p) => p.toLowerCase().startsWith(query)).toList(); 
    //
    //return ListView.builder(
    //itemCount: peliculasRecientes.length,
    //itemBuilder: (context, i)
    //{
    //  return ListTile(
    // leading: Icon(Icons.movie),
    //  title: Text(peliculasRecientes[i]),
    //  onTap: ()
    //  {
    //    showResults(context);
    //  },
   //
    //  );
    //},
    //
    //);