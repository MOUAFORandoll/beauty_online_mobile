import 'package:beauty/common/widgets/filter_buttons.dart';
import 'package:beauty/common/widgets/horizontal_service_list.dart';
import 'package:beauty/common/widgets/location_selector.dart';
import 'package:beauty/common/widgets/post_list.dart';
import 'package:beauty/common/widgets/salon_card_list.dart';
import 'package:beauty/common/widgets/search_bar.dart';
import 'package:beauty/common/widgets/section_title.dart';
import 'package:flutter/material.dart' hide SearchBar;

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum:
          EdgeInsets.symmetric(horizontal: 16).copyWith(top: kToolbarHeight),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
 // Map similaire a celle de snap mettant en avant plusieurs pour ou sont repertories des ,
 // prestataires de services ,
 // et en clicquant dessus on accede leur profil ,
 // s' inspirer de signyale,
 // chercher a faire une map hyper interactive avec posibilite de rechercher un professionnel sur la map,
 // avec un boutton permettant d'auto rechercher et proposer les professionnel les plus proches de ,
 // l'utilisateur unpeu comme sur yango 


        ],
      ),
    );
  }
}
