import 'package:dismissible_page/dismissible_page.dart';
import 'package:flutter/material.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:simple_gradient_text/simple_gradient_text.dart';

class ImagePage extends StatefulWidget {
  final String url;
  final String destek;
  final String yorum;

  const ImagePage({Key? key, required this.url, required this.destek, required this.yorum})
      : super(key: key);

  @override
  State<ImagePage> createState() => _ImagePageState();
}

class _ImagePageState extends State<ImagePage> {
  RewardedAd? rewardedAd;
  final String rewardedAdUnitId = "ca-app-pub-1231155840549298/1049343236";

  @override
  void initState() {
    super.initState();
    _loadRewardedAd();
  }

  void _loadRewardedAd() {
    RewardedAd.load(
      adUnitId: rewardedAdUnitId,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdFailedToLoad: (LoadAdError error) {
          debugPrint("Reklam yüklenemedi, Error: $error");
        },
        onAdLoaded: (RewardedAd ad) {
          debugPrint("Reklam yüklendi, $ad");
          rewardedAd = ad;

          _setFullScreenContentCallback();
        },
      ),
    );
  }

  void _setFullScreenContentCallback() {
    if (rewardedAd == null) return;
    rewardedAd?.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          debugPrint("$ad onAdShowedFullScreenContent"),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        debugPrint("$ad onAdDismissedFullScreenContent");

        ad.dispose();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        debugPrint("$ad onAdFailedToShowFullScreenContent: $error");
        ad.dispose();
      },
      onAdImpression: (RewardedAd ad) => debugPrint("$ad Impression occured"),
    );
  }

  void _showRewardedAd() {
    rewardedAd?.show(
        onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) async {
          {
            String url = widget.url;
            await GallerySaver.saveImage(url, albumName: "WallpApp")
                .then((value) => Navigator.pop(context))
                .then((value) => showDialog(
              context: context,
              builder: (context) => AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0)),
                content: Text(
                  "Galerinize Kaydedildi !",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                    shadows: <Shadow>[
                      Shadow(
                        offset: const Offset(1.0, 1.0),
                        blurRadius: 7.0,
                        color: Colors.black.withOpacity(0.1),
                      ),
                      Shadow(
                        offset: const Offset(1.0, 1.0),
                        blurRadius: 7.0,
                        color: Colors.black.withOpacity(0.1),
                      ),
                    ],
                  ),
                ),
                actions: [
                  TextButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      child: const Text(
                        "Tamam",
                        style: TextStyle(color: Colors.blue),
                      ))
                ],
              ),
            ));
          }
        });
  }

  @override
  Widget build(BuildContext context) {
    final destek = widget.destek;
    final yorum = widget.yorum;


    return Material(
      child: Scaffold(
        body: DismissiblePage(
          onDismissed: () {
            Navigator.of(context).pop();
          },
          direction: DismissiblePageDismissDirection.multi,
          child: Hero(
            tag: widget.url,
            child: Stack(
              children: [
                Center(
                  child: Image.network(
                    widget.url,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: GradientText(
                    'WallpApp',
                    style: TextStyle(
                      fontSize: 70.0,
                      shadows: <Shadow>[
                        Shadow(
                          offset: const Offset(1.0, 1.0),
                          blurRadius: 7.0,
                          color: Colors.black.withOpacity(0.9),
                        ),
                        Shadow(
                          offset: const Offset(1.0, 1.0),
                          blurRadius: 7.0,
                          color: Colors.black.withOpacity(0.9),
                        ),
                      ],
                    ),
                    colors: const [
                      Colors.lightBlueAccent,
                      Colors.deepPurpleAccent,
                      Colors.purple,
                      Colors.blue,
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: GradientText(
                    'Katkıda Bulunan: @$destek ',
                    style: TextStyle(
                      fontSize: 20.0,
                      shadows: <Shadow>[
                        Shadow(
                          offset: const Offset(1.0, 1.0),
                          blurRadius: 7.0,
                          color: Colors.black.withOpacity(0.9),
                        ),
                        Shadow(
                          offset: const Offset(1.0, 1.0),
                          blurRadius: 7.0,
                          color: Colors.black.withOpacity(0.9),
                        ),
                      ],
                    ),
                    colors: const [
                      Colors.lightBlueAccent,
                      Colors.deepPurpleAccent,
                      Colors.purple,
                      Colors.blue,
                    ],
                  ),
                ),
                Align(
                  alignment: const Alignment(0.2,0.92),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                          elevation: MaterialStateProperty.all(0.0),
                          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.transparent;
                              }
                              return null;
                            },
                          ),
                        ),
                        child: Icon(
                          Icons.messenger_outline,
                          color: Colors.blue,
                          size: 30,
                          shadows: <Shadow>[
                            Shadow(
                              offset: const Offset(1.0, 1.0),
                              blurRadius: 7.0,
                              color: Colors.black.withOpacity(0.9),
                            ),
                            Shadow(
                              offset: const Offset(1.0, 1.0),
                              blurRadius: 7.0,
                              color: Colors.black.withOpacity(0.9),
                            ),
                          ],
                        ),
                        onPressed: (){
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.transparent,
                              content: Text("Katkıda bulunan mesajı: $yorum",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: const Offset(1.0, 1.0),
                                      blurRadius: 7.0,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    Shadow(
                                      offset: const Offset(1.0, 1.0),
                                      blurRadius: 7.0,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                          elevation: MaterialStateProperty.all(0.0),
                          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.transparent;
                              }
                              return null;
                            },
                          ),
                        ),
                        child: Icon(
                          Icons.download_rounded,
                          size: 36,
                          color: Colors.purple,
                          shadows: <Shadow>[
                            Shadow(
                              offset: const Offset(1.0, 1.0),
                              blurRadius: 7.0,
                              color: Colors.black.withOpacity(0.9),
                            ),
                            Shadow(
                              offset: const Offset(1.0, 1.0),
                              blurRadius: 7.0,
                              color: Colors.black.withOpacity(0.9),
                            ),
                          ],
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0)),
                              content: Text(
                                "İndirmek için: ",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: const Offset(1.0, 1.0),
                                      blurRadius: 7.0,
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                    Shadow(
                                      offset: const Offset(1.0, 1.0),
                                      blurRadius: 7.0,
                                      color: Colors.black.withOpacity(0.1),
                                    ),
                                  ],
                                ),
                              ),
                              actions: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                  children: [
                                    TextButton(
                                      onPressed: _showRewardedAd,
                                      child: Text(
                                        "Reklam izle",
                                        style: TextStyle(
                                          color: Colors.blue,
                                          shadows: <Shadow>[
                                            Shadow(
                                              offset: const Offset(1.0, 1.0),
                                              blurRadius: 7.0,
                                              color: Colors.black.withOpacity(0.1),
                                            ),
                                            Shadow(
                                              offset: const Offset(1.0, 1.0),
                                              blurRadius: 7.0,
                                              color: Colors.black.withOpacity(0.1),
                                            ),
                                          ],
                                        ),
                                      ), /*() async {
                                      String url = widget.url;
                                      await GallerySaver.saveImage(url,
                                              albumName: "WallpApp")
                                          .then((value) => Navigator.pop(context))
                                          .then((value) => showDialog(
                                                context: context,
                                                builder: (context) => AlertDialog(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20.0)),
                                                  content: const Text(
                                                    "Galerinize Kaydedildi !",
                                                    style: TextStyle(
                                                        fontWeight: FontWeight.bold,
                                                        color: Colors.purple),
                                                  ),
                                                  actions: [
                                                    TextButton(
                                                        onPressed: () {
                                                          Navigator.pop(context);
                                                        },
                                                        child: const Text(
                                                          "Tamam",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .lightBlueAccent),
                                                        ))
                                                  ],
                                                ),
                                              ));
                                    }*/
                                    ),
                                    TextButton(
                                      child: Text("Kapat",
                                          style: TextStyle(
                                            color: Colors.blue,
                                            shadows: <Shadow>[
                                              Shadow(
                                                offset: const Offset(1.0, 1.0),
                                                blurRadius: 7.0,
                                                color: Colors.black.withOpacity(0.1),
                                              ),
                                              Shadow(
                                                offset: const Offset(1.0, 1.0),
                                                blurRadius: 7.0,
                                                color: Colors.black.withOpacity(0.1),
                                              ),
                                            ],
                                          )),
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                    ),
                                  ],
                                ),

                                /* TextButton(
                                  child: Text("Destek Ol (19.99₺)",
                                      style: TextStyle(
                                        color: Colors.blue,
                                        shadows: <Shadow>[
                                          Shadow(
                                            offset: const Offset(1.0, 1.0),
                                            blurRadius: 7.0,
                                            color: Colors.black.withOpacity(0.2),
                                          ),
                                          Shadow(
                                            offset: const Offset(1.0, 1.0),
                                            blurRadius: 7.0,
                                            color: Colors.black.withOpacity(0.2),
                                          ),
                                        ],
                                      )),
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                ),*/

                              ],
                            ),
                          );
                        },
                      ),
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.transparent),
                          elevation: MaterialStateProperty.all(0.0),
                          overlayColor: MaterialStateProperty.resolveWith<Color?>(
                                (Set<MaterialState> states) {
                              if (states.contains(MaterialState.pressed)) {
                                return Colors.transparent;
                              }
                              return null;
                            },
                          ),
                        ),
                        child: Icon(
                          Icons.info,
                          color: Colors.blue,
                          size: 30,
                          shadows: <Shadow>[
                            Shadow(
                              offset: const Offset(1.0, 1.0),
                              blurRadius: 7.0,
                              color: Colors.black.withOpacity(0.9),
                            ),
                            Shadow(
                              offset: const Offset(1.0, 1.0),
                              blurRadius: 7.0,
                              color: Colors.black.withOpacity(0.9),
                            ),
                          ],
                        ),
                        onPressed: (){
                          showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              backgroundColor: Colors.transparent,
                              content: Text("Fotoğraflarınızı ve mesajlarınızı bize @wallpapp_ instagram sayfamızdan gönderin, katkıda bulunanlarda sizinde adınız olsun !",
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.purple,
                                  shadows: <Shadow>[
                                    Shadow(
                                      offset: const Offset(1.0, 1.0),
                                      blurRadius: 7.0,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                    Shadow(
                                      offset: const Offset(1.0, 1.0),
                                      blurRadius: 7.0,
                                      color: Colors.black.withOpacity(0.5),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
