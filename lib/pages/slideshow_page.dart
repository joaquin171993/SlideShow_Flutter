import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:slideshow_flutter/widgets/slideshow.dart';

class SlideShowPage extends StatelessWidget {
  const SlideShowPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SlideShow(
      colorPrimario: Color(0xffBA213A),
      slides: [
        SvgPicture.asset('assets/svgs/slide1.svg'),
        SvgPicture.asset('assets/svgs/slide2.svg'),
        SvgPicture.asset('assets/svgs/slide3.svg'),
        SvgPicture.asset('assets/svgs/slide4.svg'),
        SvgPicture.asset('assets/svgs/slide5.svg'),
      ],
    ));
  }
}
