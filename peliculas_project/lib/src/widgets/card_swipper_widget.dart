import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:peliculas_project/src/models/pelicula_model.dart';
 
class CardSwiper extends StatelessWidget {

  final List<Pelicula> peliculas;
   
   
  CardSwiper({@required this.peliculas}); 


  @override
  Widget build(BuildContext context) {
  final _screenSize = MediaQuery.of(context).size;
  
  
  return new  Container(
  padding: EdgeInsets.only(top: 5.0),
  child: Swiper(
         itemBuilder:
         (BuildContext context, int index) {
            peliculas[index].uniqueId = '${peliculas[index].id}-tarjeta';

            return  Hero(
              tag: peliculas[index].uniqueId,
              child: ClipRRect(
              borderRadius: BorderRadius.circular(20.0),
              child: GestureDetector(
                child: FadeInImage(
                image: NetworkImage(peliculas[index].getPosterimg()),
                placeholder: AssetImage('recursos/no-image.jpg'),
                fit: BoxFit.cover,
                ),
                onTap: () => Navigator.pushNamed(context, 'detalle', 
                  arguments: peliculas[index]),
              )
              ),
            );},
         itemCount: peliculas.length,
         itemWidth: _screenSize.width * 0.6,
         itemHeight: _screenSize.height * 0.5,
         layout:  SwiperLayout.STACK,
          
          
     ),
   );


  

}

 


}