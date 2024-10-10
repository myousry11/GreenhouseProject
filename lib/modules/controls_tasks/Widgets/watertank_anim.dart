import 'package:flutter/material.dart';

import '../../../shared/components/constants.dart';



class WaterTankWidget extends StatefulWidget {
  final double waterLevel;

  WaterTankWidget({Key? key, required this.waterLevel}) : super(key: key);
  @override
  _WaterTankWidgetState createState() => _WaterTankWidgetState();
}

class _WaterTankWidgetState extends State<WaterTankWidget> with TickerProviderStateMixin {
  late AnimationController waveController;
  late Animation<double> waveAnimation;

  @override
  void initState() {
    super.initState();
    waveController = AnimationController(
      vsync: this,
      duration: Duration(seconds: 5),
    );

    waveAnimation = TweenSequence<double>([
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.0, end: 0.2),
        weight: 2,
      ),

      TweenSequenceItem<double>(
        tween: Tween<double>(begin: 0.2, end: -0.5),
        weight: 2,
      ),
      TweenSequenceItem<double>(
        tween: Tween<double>(begin: -0.2, end: 0.0),
        weight: 2,
      ),
    ]).animate(waveController)
      ..addListener(() {
        setState(() {});
      });

    waveController.repeat();
  }

  @override
  void dispose() {
    waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return  Container(
      padding: EdgeInsets.symmetric(horizontal: 60, vertical: 5),
      height: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              padding: EdgeInsets.all(5.0,),
              decoration: BoxDecoration(
                color: Colors.green,
                border: Border.all(
                  width: 10.0,
                  color: Colors.green,
                ),
                borderRadius: BorderRadius.circular(10.0,),
              ),
            ),
            Expanded(
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0,),
                  child: Stack(
                    children: [
                      Container(

                        decoration: BoxDecoration(
                          color: Color(0xff2B2C56),
                          border: Border.all(
                            width: 10.0,
                            color: Colors.green,
                          ),
                          borderRadius: BorderRadius.circular(20.0,),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: FittedBox(
                                child: Text(
                                  '${widget.waterLevel} cm',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w600,
                                    wordSpacing: 3,
                                    color: Colors.white.withOpacity(.7),
                                  ),
                                  textScaleFactor: 7.0,
                                ),
                              ),
                            ),
                            Positioned.fill(
                              child: CustomPaint(
                                size: kSize,
                                painter: MyPainter(
                                  waveAnimation.value,
                                  widget.waterLevel,
                                ),
                                child: SizedBox(
                                  height: size.height,
                                  width: size.width,
                                ),
                              ),
                            ),



                          ],
                        ),
                      ),
                      Positioned.fill(
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 10.0,
                              color: Colors.green,
                            ),
                            borderRadius: BorderRadius.circular(20.0,),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
      ),
    );
  }
}



class MyPainter extends CustomPainter {
  final double waveValue;
  final double waterLevel;

  MyPainter(
      this.waveValue,
      this.waterLevel,
      );

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = Color(0xff3B6ABA).withOpacity(.8)
      ..style = PaintingStyle.fill;

    var path = Path()
      ..moveTo(0, size.height * (1 - waterLevel / 7))
      ..cubicTo(
        size.width * .3,
        size.height * (1 - waterLevel / 7 + waveValue),
        size.width * .7,
        size.height * (0.9 - waterLevel / 7 ),
        size.width,
        size.height * (0.9 - waterLevel / 7),
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
