import 'dart:io';
import 'package:flutter/material.dart';
import 'package:htpts_app/screen/htp_quiz_page.dart';
import 'package:image_picker/image_picker.dart';

class AIResultPage extends StatelessWidget {
  final XFile image;
  final List<dynamic> result;

  AIResultPage({
    super.key,
    required this.image,
    required this.result,
  });

  // 아이콘 경로 매핑 (name에 따라 아이콘 이미지 경로 지정)
  final Map<String, String> iconMap = {
    "집전체": "assets/icons/house.png",
    "지붕": "assets/icons/roof.png",
    "문": "assets/icons/door.png",
    "창문": "assets/icons/window.png",
    "굴뚝": "assets/icons/gul.png",
    "연기": "assets/icons/smoke.png",
    "울타리": "assets/icons/fence.png",
    "연못": "assets/icons/pond.png",
    "산": "assets/icons/mountain.png",
    "나무": "assets/icons/tree.png",
    "꽃": "assets/icons/flower.png",
    "태양": "assets/icons/sun.png",
    "나무전체": "assets/icons/forest.png",
    "뿌리": "assets/icons/root.png",
    "나뭇잎": "assets/icons/leaf.png",
    "열매": "assets/icons/fruit.png",
    "구름": "assets/icons/cloud.png",
    "달": "assets/icons/moon.png",
    "별": "assets/icons/stars.png",
    // "사람전체": "assets/icons/person.png"
    // "길": "assets/icons/road.png",
    // "잔디": "assets/icons/gress.png",
  };

  @override
  Widget build(BuildContext context) {
    const double imageDisplayWidth = 500;
    const double imageDisplayHeight = 500;

    // 스케일링된 박스 정보
    final scaledBoxes =
        scaleBoundingBoxes(result, imageDisplayWidth, imageDisplayHeight);

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFAEC6CF),
        elevation: 0,
        title: const Text(
          "사용자 그림 AI 분석 결과",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
      ),
      backgroundColor: const Color(0xFFAEC6CF),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                // 분석된 이미지 출력과 바운딩 박스 오버레이
                Stack(
                  children: [
                    Container(
                      width: imageDisplayWidth,
                      height: imageDisplayHeight,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.black12),
                      ),
                      child: Image.file(
                        File(image.path),
                        width: imageDisplayWidth,
                        height: imageDisplayHeight,
                        fit: BoxFit.cover,
                      ),
                    ),
                    CustomPaint(
                      size: const Size(imageDisplayWidth, imageDisplayHeight),
                      painter: BoundingBoxPainter(scaledBoxes),
                    ),
                  ],
                ),
                const SizedBox(height: 40),

                // 객체들을 정렬하여 보여주기
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 16, // 가로 간격
                  runSpacing: 16, // 세로 간격
                  children: result.map((box) {
                    final name = box['name'] as String;
                    return Rectangle41(
                      name: name,
                      iconPath: iconMap[name] ?? "assets/icons/default.png",
                    );
                  }).toList(),
                ),
                const SizedBox(height: 30),

                // "다음" 버튼
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HTPQuizPage(
                          image: image,
                          detectedObjects: result
                              .map((box) => box['name'] as String)
                              .toList(),
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(200, 60),
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                  child: const Text(
                    '다음',
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 이미지 크기를 3000x3850 기준에서 500x500 크기로 변환
  List<Map<String, dynamic>> scaleBoundingBoxes(
      List<dynamic> boxes, double imageWidth, double imageHeight) {
    return boxes.map((box) {
      final scaleX = imageWidth / 3000.0;
      final scaleY = imageHeight / 3850.0;

      return {
        'name': box['name'],
        'xmin': box['xmin'] * scaleX,
        'ymin': box['ymin'] * scaleY,
        'xmax': box['xmax'] * scaleX,
        'ymax': box['ymax'] * scaleY,
      };
    }).toList();
  }
}

class BoundingBoxPainter extends CustomPainter {
  final List<Map<String, dynamic>> boxes;

  BoundingBoxPainter(this.boxes);

  // 다양한 색상 리스트
  final List<Color> colors = [
    Colors.red,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.purple,
    Colors.cyan,
    Colors.yellow,
  ];

  @override
  void paint(Canvas canvas, Size size) {
    const textStyle = TextStyle(
      color: Colors.black,
      fontSize: 12,
      backgroundColor: Colors.white,
    );

    for (int i = 0; i < boxes.length; i++) {
      final box = boxes[i];
      final paint = Paint()
        ..color = colors[i % colors.length] // 색상 순환
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;

      final rect = Rect.fromLTRB(
        box['xmin'],
        box['ymin'],
        box['xmax'],
        box['ymax'],
      );

      canvas.drawRect(rect, paint);

      // Draw name label
      final textSpan = TextSpan(
        text: box['name'],
        style: textStyle,
      );
      final textPainter = TextPainter(
        text: textSpan,
        textDirection: TextDirection.ltr,
      );
      textPainter.layout();
      textPainter.paint(canvas, Offset(box['xmin'], box['ymin'] - 14));
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}

class Rectangle41 extends StatelessWidget {
  final String name;
  final String iconPath;

  const Rectangle41({
    super.key,
    required this.name,
    required this.iconPath,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 151,
          height: 151,
          decoration: ShapeDecoration(
            color: const Color(0xFFF0FBFF),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(13),
            ),
          ),
          child: Center(
            child: Image.asset(
              iconPath,
              width: 85,
              height: 86,
              fit: BoxFit.contain,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          name,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 15,
            fontWeight: FontWeight.w700,
          ),
        ),
      ],
    );
  }
}
