import 'package:flutter/material.dart';
import 'package:wallpaper_app/widgets/image_widget.dart';
import 'package:wallpaper_app/widgets/image_widget_cafe.dart';
import 'package:wallpaper_app/widgets/image_widget_doga.dart';
import 'package:wallpaper_app/widgets/image_widget_hayvan.dart';
import 'package:wallpaper_app/widgets/image_widget_kulturel.dart';
import 'package:wallpaper_app/widgets/image_widget_manzara.dart';
import 'package:wallpaper_app/widgets/image_widget_siyah_beyaz.dart';
import 'package:wallpaper_app/widgets/image_widget_yiyecek_icecek.dart';

class WallScreen extends StatefulWidget {
  const WallScreen({Key? key}) : super(key: key);

  @override
  State<WallScreen> createState() => _WallScreenState();
}

class _WallScreenState extends State<WallScreen> {
  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;

    return DefaultTabController(
      length: 8,
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              Image.asset("assets/wallpappgiris.gif",height: screen.height * 0.15,width: screen.width * 0.9,fit: BoxFit.fitWidth,),
              TabBar(
                isScrollable: true,
                unselectedLabelColor: Colors.blueAccent,
                indicatorSize: TabBarIndicatorSize.tab,
                indicator: BoxDecoration(
                    gradient: const LinearGradient(
                        colors: [Colors.lightBlueAccent,
                          Colors.blueAccent,
                          Colors.deepPurpleAccent,
                          Colors.purple,
                        ]
                    ),
                    borderRadius: BorderRadius.circular(50),
                    color: Colors.deepPurple
                ),
                tabs: const [
                  Tab(child: Align(alignment: Alignment.center,child: Text("Tümü"),),),
                  Tab(child: Align(alignment: Alignment.center,child: Text("Hayvan"),),),
                  Tab(child: Align(alignment: Alignment.center,child: Text("Manzara"),),),
                  Tab(child: Align(alignment: Alignment.center,child: Text("Siyah&Beyaz"),),),
                  Tab(child: Align(alignment: Alignment.center,child: Text("Yiyecek&İçecek"),),),
                  Tab(child: Align(alignment: Alignment.center,child: Text("Cafe"),),),
                  Tab(child: Align(alignment: Alignment.center,child: Text("Kültürel"),),),
                  Tab(child: Align(alignment: Alignment.center,child: Text("Doğa"),),),
                ],
              ),
               const Flexible(
                flex: 1,
                child: TabBarView(
                  children: [
                    ImageWidget(),
                    ImageWidgetHayvan(),
                    ImageWidgetManzara(),
                    ImageWidgetSiyahBeyaz(),
                    ImageWidgetYiyecekIcecek(),
                    ImageWidgetCafe(),
                    ImageWidgetKulturel(),
                    ImageWidgetDoga(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
