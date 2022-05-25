import 'package:carousel_slider/carousel_slider.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inovola/model/course.dart';
import 'package:inovola/model/types.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _current = 0;
  final CarouselController _controller = CarouselController();
  List<String> imgList = [
    'assets/images/img-1.jpeg',
    'assets/images/img-2.jpeg',
    'assets/images/img-3.webp',
    'assets/images/img-4.jpeg',
  ];
  Course? course;
  bool loading = false;
  @override
  void initState() {
    getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return loading
        ? Center(
            child: _buildLoading(),
          )
        : SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                _buildSlider(),
                _buildInterest(),
                _buildTitle(),
                _buildDate(),
                SizedBox(height: 6.h),
                _buildAddress(),
                Divider(
                  color: Color(0xFFb9bed1),
                ),
                _buildTrainer(),
                Divider(
                  color: Color(0xFFb9bed1),
                ),
                _buildCourseInfo(),
                Divider(
                  color: Color(0xFFb9bed1),
                ),
                _buildPrice(),
                SizedBox(height: 20.h),
                _buildButton(),
              ],
            ),
          );
  }

  Widget _buildInterest() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Text(
        "#${course!.interest}",
        style: GoogleFonts.cairo(
          color: Color(0xFFb9bed1),
          fontSize: 13.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Stack _buildSlider() {
    return Stack(
      children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height > 800 ? 300.h : 200.h,
          child: CarouselSlider.builder(
            carouselController: _controller,
            itemCount: imgList.length,
            options: CarouselOptions(
                viewportFraction: 1,
                initialPage: 0,
                height: 1.sh,
                enlargeCenterPage: false,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                }),
            itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) => Container(
              child: Image.asset(
                imgList[itemIndex],
                fit: BoxFit.cover,
                width: 1.sw,
              ),
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 6.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Row(
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.star,
                    size: MediaQuery.of(context).size.height > 800 ? 18.h : 12.h,
                    color: Colors.white,
                  ),
                  SizedBox(
                    width: 10.w,
                  ),
                  FaIcon(
                    FontAwesomeIcons.shareNodes,
                    size: MediaQuery.of(context).size.height > 800 ? 18.h : 12.h,
                    color: Colors.white,
                  ),
                ],
              ),
              FaIcon(
                FontAwesomeIcons.angleLeft,
                size: MediaQuery.of(context).size.height > 800 ? 18.h : 12.h,
                color: Colors.white,
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: imgList.asMap().entries.map((entry) {
              return GestureDetector(
                onTap: () => _controller.animateToPage(entry.key),
                child: Container(
                  width: MediaQuery.of(context).size.height > 800 ? 7.w : 10.w,
                  height: MediaQuery.of(context).size.height > 800 ? 7.w : 10.w,
                  margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                  decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.white.withOpacity(_current == entry.key ? 0.9 : 0.4)),
                ),
              );
            }).toList(),
          ),
        )
      ],
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Text(
        "${course!.title}",
        style: GoogleFonts.cairo(
          color: Color(0xFF9ea3b8),
          fontSize: 13.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  _buildDate() {
    DateFormat format = DateFormat.yMMMMEEEEd('ar');
    DateFormat formatTime = DateFormat.jm('ar');

    initializeDateFormatting("ar_SA", null).then((_) {
      format;
    });
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        children: [
          Image(
            width: 15.w,
            height: 15.w,
            image: AssetImage(
              'assets/images/date-icon.png',
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Text(
            " ${format.format(course!.date!)} ، ${formatTime.format(course!.date!)}",
            style: GoogleFonts.cairo(
              color: Color(0xFFb9bed1),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddress() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Row(
        children: <Widget>[
          Image(
            width: 15.w,
            height: 15.w,
            image: AssetImage(
              'assets/images/address-icon.png',
            ),
          ),
          SizedBox(
            width: 6,
          ),
          Text(course!.address!,
              style: GoogleFonts.cairo(
                color: Color(0xFFb9bed1),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }

  Widget _buildTrainer() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              CircleAvatar(
                backgroundImage: AssetImage('assets/images/photo-trainer.png'),
                radius: 15.w,
              ),
              SizedBox(
                width: 6,
              ),
              Text(course!.trainerName!,
                  style: GoogleFonts.cairo(
                    color: Color(0xFF9ea3b8),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.bold,
                  )),
            ],
          ),
          Text(course!.trainerInfo!,
              style: GoogleFonts.cairo(
                color: Color(0xFFb9bed1),
                fontSize: 13.sp,
                fontWeight: FontWeight.w500,
              )),
        ],
      ),
    );
  }

  Widget _buildCourseInfo() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("عن الدورة",
              style: GoogleFonts.cairo(
                color: Color(0xFF9ea3b8),
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              )),
          Text(
            course!.occasionDetail!,
            style: GoogleFonts.cairo(
              color: Color(0xFFb9bed1),
              fontSize: 13.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPrice() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 15.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text("تكلفه الدورة",
              style: GoogleFonts.cairo(
                color: Color(0xFF9ea3b8),
                fontSize: 13.sp,
                fontWeight: FontWeight.bold,
              )),
          Column(
            children: course!.reservTypes!
                .map(
                  (Types e) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(e.name!,
                          style: GoogleFonts.cairo(
                            color: Color(0xFFb9bed1),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          )),
                      Text(" SAR ${e.price.toInt().toString()}",
                          style: GoogleFonts.cairo(
                            color: Color(0xFFb9bed1),
                            fontSize: 13.sp,
                            fontWeight: FontWeight.w500,
                          )),
                    ],
                  ),
                )
                .toList(),
          )
        ],
      ),
    );
  }

  Widget _buildButton() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 15.h),
      width: 1.sw,
      color: Color(0xFF8d3ca3),
      child: Center(
        child: Text("قم بالحجز الآن",
            style: GoogleFonts.cairo(
              fontSize: 14.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            )),
      ),
    );
  }

  Widget _buildLoading() {
    SpinKitThreeBounce spinkit = SpinKitThreeBounce(
      color: Color(0xFF8d3ca3),
      size: 25.w,
    );
    return spinkit;
  }

  Future getData() async {
    loading = true;

    try {
      Response response = await Dio().get('https://run.mocky.io/v3/3a1ec9ff-6a95-43cf-8be7-f5daa2122a34');
      if (response.statusCode == 200) {
        course = Course.fromJson(response.data);
      }
      setState(() {
        loading = false;
      });
    } catch (e) {
      print(e);
    }
  }
}
