import 'package:flutter/material.dart';
import 'package:peliculas_project/src/models/actores_modelo.dart';
import 'package:peliculas_project/src/models/pelicula_model.dart';
import 'package:peliculas_project/src/providers/peliculas_provider.dart';


class PeliculaDetalle extends StatelessWidget {
  
  
  @override
  Widget build(BuildContext context) {
    
    final Pelicula pelicula = ModalRoute.of(context)
    .settings.arguments;
    
    
    return Scaffold(
    body: CustomScrollView(
    slivers: <Widget>[
    _crearAppbar( pelicula ),
    SliverList(
    
    delegate: SliverChildListDelegate(
    [
     SizedBox(height: 10.0),
    _posterTitulo(pelicula, context),
    _descripcion(pelicula),
    _crearCasting(pelicula)
  
    ]
    )
    )
    
    
 
    ],
    ),
    );
  }

  Widget _crearAppbar(Pelicula pelicula)
  {
    return SliverAppBar(
    elevation: 2.0,
    backgroundColor: Colors.indigoAccent,
    expandedHeight: 200.0,
    floating: false,
    pinned: true,
    flexibleSpace: FlexibleSpaceBar(
    centerTitle: true,
    background: FadeInImage(placeholder: AssetImage('recursos/loading.gif'), image: NetworkImage(pelicula.getBackgroundImg()),
    fadeInDuration: Duration(milliseconds: 150),
    fit: BoxFit.cover,
    )
    )

    );
  }


  Widget _posterTitulo(Pelicula pelicula, BuildContext context)
  {
    return Container(
    
    padding: EdgeInsets.symmetric(horizontal: 20.0),
    child: Row(
    
    children: <Widget>[
    
    Hero(
        tag: pelicula.uniqueId,
        child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: Image(image: NetworkImage(pelicula.getPosterimg()),
        height: 150.0,
        )
       ),
    ),
     SizedBox(width: 30.0),
     Flexible(
     child: Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     children: <Widget>[
     Text(pelicula.title,  style:  Theme.of(context).textTheme.title, overflow: TextOverflow.ellipsis),
     SizedBox(width:  20.0),
     Text(pelicula.originalTitle, style: Theme.of(context).textTheme.subhead, overflow: TextOverflow.ellipsis),
     Row(
      children: <Widget>[
      Icon(Icons.star, color: Colors.yellow),
      Text(pelicula.voteAverage.toString(),style: Theme.of(context).textTheme.subhead)
      ],
     )


     ]

      )
     )
   ],
         )
           );

  }


  Widget _descripcion( Pelicula pelicula)
  {
     return Container(
     padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
     child: Text(
     
     pelicula.overview,
     textAlign: TextAlign.justify,
     )


     );
   


  }

   
   Widget _crearCasting(Pelicula pelicula)
   {
      final peliProvider = new PeliculasProvider();

      return FutureBuilder(
      future: peliProvider.getCast(pelicula.id.toString()),
      builder: (BuildContext context, AsyncSnapshot<List> snapshot)
      {  
        if(snapshot.hasData)
        {
          return _crearActoresPageView(snapshot.data);
        }else
        {
          return Center(child: CircularProgressIndicator());
        }
         
      }
      );
  


   }


   Widget _crearActoresPageView(List<Actor> actores)
   {
     
     return SizedBox(
    height: 200.0,
    child: PageView.builder(
    pageSnapping: false,
    itemBuilder: (context, i) => _actorTarjeta(actores[i]),
    itemCount: actores.length,
    controller: PageController(
    viewportFraction: 0.3,
    initialPage: 1  
    )) 
     );
     


   }


   Widget _actorTarjeta(Actor actor)
   {
     return Container( 
     child: Column(
     children: <Widget>[
     
     ClipRRect(

      borderRadius: BorderRadius.circular(20.0),
      child: FadeInImage(image: NetworkImage(actor.getFoto()),
      placeholder: AssetImage('recursos/no-image.jpg'),
      height: 150.0,
      fit: BoxFit.cover 
      ),
     ),

     Text(
     actor.name, 
     overflow: TextOverflow.ellipsis,
     )
       
     ],


     )
     );
   }



}