import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WorldSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          width: MediaQuery.of(context).size.width,
          child: ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.24,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 3,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) => GestureDetector(
                    onTap: () {},
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: MediaQuery.of(context).size.width * 0.36,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage('assets/images/mts1.png'),
                          fit: BoxFit.cover,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Container(
                        height: double.infinity,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              Colors.black.withOpacity(0.9)
                            ],
                            begin: Alignment.topCenter,
                            stops: [0.5, 1],
                            end: Alignment.bottomCenter,
                          ),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Spacer(),
                            Text(
                              'title',
                              maxLines: 2,
                              overflow: TextOverflow.fade,
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "3 hours ago",
                              style: TextStyle(
                                color: Colors.white.withOpacity(0.5),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.only(left: 15),
                height: MediaQuery.of(context).size.height * 0.16,
                child: ListView.builder(
                  itemCount: 1,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (ctx, i) => Container(
                    margin: EdgeInsets.all(5),
                    width: MediaQuery.of(context).size.width * 0.9,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.cyan,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 90,
                          width: 120,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset(
                              'images/img1.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                              Text(
                                'Location',
                                maxLines: 2,
                                overflow: TextOverflow.fade,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                ),
                              ),
                              Text(
                                "3 hours ago",
                                style: TextStyle(
                                  color: Colors.white.withOpacity(0.7),
                                ),
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height * 0.34,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(10),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey.withOpacity(0.3),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 5,
                          child: Container(
                            height: MediaQuery.of(context).size.height * 0.34,
                            child: ClipRRect(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(20),
                                bottomLeft: Radius.circular(20),
                              ),
                              child: Image.asset(
                                "assets/images/ms.png",
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        Expanded(
                          flex: 5,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset(
                                "assets/images/layer.svg",
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text("Editor Choice"),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'title',
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Row(
                                children: [
                                  CircleAvatar(
                                    radius: 15,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: Image.asset(
                                        "assets/images/e4.jpg",
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  FittedBox(
                                    child: Text('name'),
                                  )
                                ],
                              )
                            ],
                          ),
                        )
                      ],
                    ),
                  )),
              Container(
                margin: EdgeInsets.all(5),
                width: double.infinity,
                height: MediaQuery.of(context).size.height * 0.15,
                decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.height * 0.15,
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset(
                          "assets/images/space.png",
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "NASA's green propellent\n infusion mission deploys",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        Text(
                            "NASA's green propellent mission (GPM0 has\nsucessfully launced from EDM"),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        )
      ],
    );
  }
}
