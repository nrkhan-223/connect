import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          SizedBox(
              height: size.height,
              width: size.width,
              child: Image.asset(
                "assets/backgroundImage.png",
                fit: BoxFit.cover,
              )),
          Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: size.height * 0.35,
                    width: size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/profileImage.png")),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 125,
                      left: 15,
                      right: 15,
                    ),
                    child: Stack(
                      alignment: Alignment.topCenter,
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                          height: size.height * 0.35,
                          width: size.width,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: Colors.white),
                          child: Column(
                            children: [
                              const Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(top: 40),
                                    child: Text('Leslie Alexander',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold)),
                                  ),
                                  SizedBox(height: 8),
                                  Text('Flutter Developer',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      )),
                                ],
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/phone.svg",
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text('(+33)7 75 55 45 48',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Row(
                                  children: [
                                    SvgPicture.asset(
                                      "assets/email.svg",
                                      height: 12,
                                      width: 15,
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    const Text('sara.cruz@example.com',
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold)),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                height: 41,
                                width: 171,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(25),
                                    color: Colors.red),
                                child: const Center(
                                  child: Text('এডিট প্রোফাইল',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                        fontFamily: 'IrabotiMJ',
                                      )),
                                ),
                              )
                            ],
                          ),
                        ),
                        const Positioned(
                            top: -55,
                            child: CircleAvatar(
                              radius: 45,
                              backgroundColor: Colors.blue,
                              backgroundImage: AssetImage("assets/unnamed.png"),
                            )),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  // height: size.height*0.6,
                  // width: size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                  ),
                  child: Column(
                    children: [
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Text(
                            'The More Important the Work, the More Important the Rest',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            )),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextButton(
                              onPressed: () {},
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all(
                                    const Color(0xffF2F3F4)),
                              ),
                              child: const Text('বড় প্রকল্প সমূহ',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 12,
                                    fontFamily: 'IrabotiMJ',
                                  ))),
                          RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                                text: "Post: ",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                )),
                            TextSpan(
                                text: " ২ মিনিট আগে ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                  fontFamily: 'IrabotiMJ',
                                ))
                          ])),
                          const Text("by Mr. Sazzad",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 10,
                              )),
                          RichText(
                              text: const TextSpan(children: [
                            TextSpan(
                                text: "কানেক্ট আইডি :",
                                style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontFamily: 'IrabotiMJ',
                                )),
                            TextSpan(
                                text: "13 ",
                                style: TextStyle(
                                  color: Colors.grey,
                                  fontSize: 10,
                                ))
                          ]))
                        ],
                      ),
                      const Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                        child: Text(
                            'For athletes, high altitude produces two contradictory effects on performance. For explosive events (sprints up to 400 metres, long jump, triple jump) the reduction in atmospheric pressure means there is less resistance from the atmosphere and the athlete s performance will generally be better at high altitude.',
                            textAlign: TextAlign.start,
                            maxLines: 30,
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 16,
                            )),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Container(
                          height: size.height * 0.22,
                          width: size.width,
                          color: const Color(0xffD9D9D9),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              SvgPicture.asset(
                                "assets/postPin.svg",
                                height: 35,
                                width: 45,
                              ),
                              const Image(
                                image: AssetImage("assets/img.png"),
                                height: 145,
                                width: 145,
                              ),
                              const Image(
                                image: AssetImage("assets/img.png"),
                                height: 145,
                                width: 145,
                              )
                            ],
                          ),
                        ),
                      ),
                      const Divider(
                        indent: 10,
                        endIndent: 10,
                        thickness: 1.2,
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      IntrinsicHeight(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/bookImage.svg",
                                  height: 30,
                                  width: 25,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text('প্রস্তাবনা দিন',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'IrabotiMJ',
                                    ))
                              ],
                            ),
                            const VerticalDivider(
                              color: Colors.black,
                              thickness: 1.2,
                            ),
                            Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/postPin.svg",
                                  height: 30,
                                  width: 25,
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                const Text('সংযুক্তি (3)',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'IrabotiMJ',
                                    ))
                              ],
                            ),
                            const VerticalDivider(
                              color: Colors.black,
                              thickness: 1.2,
                            ),
                            const Row(
                              children: [
                                Icon(
                                  Icons.share_outlined,
                                  size: 31,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text('শেয়ার',
                                    textAlign: TextAlign.start,
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 12,
                                      fontFamily: 'IrabotiMJ',
                                    ))
                              ],
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8),
                              child: SvgPicture.asset(
                                "assets/menuImage.svg",
                                height: 22,
                                width: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
            ],
          )
        ],
      ),
    ));
  }
}
