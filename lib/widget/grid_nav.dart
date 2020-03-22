import 'package:flutter/material.dart';
import 'package:trip/model/home_model_entity.dart';

class GirdNav extends StatelessWidget{
 final  HomeModelGridNav gridNav;

 GirdNav({Key key,@required this.gridNav}):super(key:key);

 @override
  Widget build(BuildContext context) {
    return Column(
      children:_gridNavItem(context),
    );
  }

  _gridNavItem(context){
   List<Widget>items=[];
   if(gridNav==null)return items;

   if(gridNav.hotel!=null){

   }
   if(gridNav.flight!=null){

   }
   if(gridNav.travel!=null){

   }
   return items;
  }

  _gradNavItem(context,HomeModelGridNavHotel hotel){

  }


}