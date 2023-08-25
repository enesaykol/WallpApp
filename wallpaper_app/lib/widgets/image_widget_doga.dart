import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:wallpaper_app/pages/image_page.dart';



class ImageWidgetDoga extends StatefulWidget {



  const ImageWidgetDoga({Key? key}) : super(key: key);

  @override
  State<ImageWidgetDoga> createState() => _ImageWidgetDogaState();
}

class _ImageWidgetDogaState extends State<ImageWidgetDoga> {

  //final _firestore = FirebaseFirestore.instance;
  final _firestore_filter = FirebaseFirestore.instance.collection("wallpaper").where("tag",arrayContains: "d");

  QuerySnapshot? imagesList;

  @override
  void initState()  {


    super.initState();
    getData();
  }

  Future<void> getData() async {
    Query<Map<String, dynamic>> images = _firestore_filter;

    imagesList = await images.get();
    setState(() {

    });

  }



  @override
  Widget build(BuildContext context) {



    if(imagesList == null || imagesList!.size <= 0){

      return const Center(child: CircularProgressIndicator(),);
    }else {
      return Padding(
        padding: const EdgeInsets.all(5),
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,
              mainAxisSpacing: 10,
              crossAxisSpacing: 10,
              childAspectRatio: 0.8,),
            itemCount: imagesList!.size,
            itemBuilder: (BuildContext  context, int index){
              return buildGestureDetector(context, index, data: imagesList!.docs[index]);
            }),
      );
    }
  }




  GestureDetector buildGestureDetector(BuildContext context, int i, {required QueryDocumentSnapshot data}) {
    return GestureDetector(
      onTap: (){
        context.pushTransparentRoute( ImagePage(url: data['url'],destek: data['destek'],yorum: data['yorum'],));
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Hero(
            tag: "${data['url']}",
            child: Image.network(data['url'], fit: BoxFit.cover,
                loadingBuilder: (context, child, loadingProgress){
                  if(loadingProgress == null) return child;

                  return  Center(child: Image.asset("assets/allpApp.gif"));
                }
            ),
          ),
        ),
      ),
    );
  }
}
