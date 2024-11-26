import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class HTPResultPage extends StatelessWidget {
  final List<Map<String, String>> quizResults; // 퀴즈 결과
  final List<String>? detectedObjects; // 감지된 객체
  final XFile image; // 전달받은 이미지

  const HTPResultPage({
    super.key,
    required this.quizResults,
    this.detectedObjects,
    required this.image,
  });

  @override
  Widget build(BuildContext context) {
    // 객체 이름에 따른 추가 심리 결과 및 아이콘 경로 매핑
    final Map<String, Map<String, String>> objectDetails = {
      "지붕": {
        "icon": "assets/icons/roof.png",
        "interpretation": "상상력과 이상을 중시하며, 창의적인 성향을 나타냅니다.",
      },
      "굴뚝": {
        "icon": "assets/icons/gul.png",
        "interpretation": "가정 내의 따뜻함과 인간관계를 상징하며, 타인과의 소통을 중요하게 생각합니다.",
      },
      "연기": {
        "icon": "assets/icons/smoke.png",
        "interpretation": "가정 내의 정서 상태를 나타내며, 안정감과 편안함을 상징합니다.",
      },
      "울타리": {
        "icon": "assets/icons/fence.png",
        "interpretation": "개인의 경계와 사생활을 중시하는 성향이 강합니다.",
      },
      "연못": {
        "icon": "assets/icons/pond.png",
        "interpretation": "긍정적인 사고를 가지고 있으며, 감정적으로 안정된 상태입니다.",
      },
      "산": {
        "icon": "assets/icons/mountain.png",
        "interpretation": "높은 목표와 도전 정신을 상징하며, 성취에 대한 열망이 강합니다.",
      },
      "꽃": {
        "icon": "assets/icons/flower.png",
        "interpretation": "아름다움과 애정을 중시하며, 미적 감각과 사랑에 대한 관심을 나타냅니다.",
      },
      "태양": {
        "icon": "assets/icons/sun.png",
        "interpretation": "에너지가 넘치고 활발한 성격을 가진 사람입니다.",
      },
    };

    // 감지된 객체 해석 결과 생성
    final List<Widget> objectResults = [];
    if (detectedObjects != null && detectedObjects!.isNotEmpty) {
      for (var obj in detectedObjects!) {
        if (objectDetails.containsKey(obj)) {
          objectResults.add(ObjectResultCard(
            iconPath: objectDetails[obj]!["icon"]!,
            question: "그림에 $obj을 그리셨군요?",
            interpretation: objectDetails[obj]!["interpretation"]!,
          ));
        }
      }
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFAEC6CF),
        title: const Text(
          "심리 테스트 결과",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Column(
            children: [
              // 배경 박스와 콘텐츠
              Rectangle3(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      // 이미지 표시
                      Container(
                        width: 300,
                        height: 300,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: FileImage(File(image.path)),
                            fit: BoxFit.cover,
                          ),
                          border: Border.all(
                            // 테두리 추가
                            color: const Color(0x0ff6fcff), // 테두리 색상
                            width: 4.0, // 테두리 두께
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),

                      // 질문 결과 표시
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "질문을 통한 답변 결과",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 15),
                      ...quizResults.map((result) {
                        return Rectangle4(
                          iconPath: 'assets/icons/survey.png', // 예시 이미지
                          question: result["question"]!,
                          answer: result["answer"]!,
                          interpretation: result["interpretation"]!,
                        );
                      }),

                      const SizedBox(height: 20),

                      // 객체 인식 결과
                      const Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "그림에서 인식된 객체 기반 해석",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                      // const SizedBox(height: 10),
                      if (objectResults.isNotEmpty)
                        ...objectResults
                      else
                        const Text(
                          "그림에서 추가 해석할 객체가 없습니다.",
                          style: TextStyle(fontSize: 16, color: Colors.grey),
                        ),
                      const SizedBox(height: 30),

                      // 테스트 종료 버튼
                      ElevatedButton(
                        onPressed: () {
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(200, 50),
                          backgroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        child: const Text(
                          "테스트 종료",
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Rectangle3: 배경 박스
class Rectangle3 extends StatelessWidget {
  final Widget child;

  const Rectangle3({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: ShapeDecoration(
            color: const Color.fromARGB(255, 211, 227, 233),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
          child: child,
        ),
        Positioned(
          top: 16, // 위쪽 여백
          right: 16, // 오른쪽 여백
          child: IconButton(
            onPressed: () {
              // 공유 버튼 클릭 시 동작 정의
              print("Share Icon Pressed");
            },
            icon: const Icon(
              Icons.share,
              color: Colors.black,
              size: 24,
            ),
          ),
        ),
      ],
    );
  }
}

// Rectangle4: 질문 기반 결과 카드
class Rectangle4 extends StatelessWidget {
  final String iconPath;
  final String question;
  final String answer;
  final String interpretation;

  const Rectangle4({
    super.key,
    required this.iconPath,
    required this.question,
    required this.answer,
    required this.interpretation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF0FBFF),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            children: [
              // 아이콘
              Container(
                width: 55,
                height: 55,
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(iconPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 16),
              // 질문/답변/해석
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      interpretation,
                      style: const TextStyle(
                          fontSize: 19,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    Text(
                      "질문: $question",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 161, 157, 157),
                      ),
                    ),
                    Text(
                      "답변: $answer",
                      style: const TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 161, 157, 157),
                      ),
                    ),
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

// ObjectResultCard: 객체 결과 카드
class ObjectResultCard extends StatelessWidget {
  final String iconPath;
  final String question;
  final String interpretation;

  const ObjectResultCard({
    super.key,
    required this.iconPath,
    required this.question,
    required this.interpretation,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF0FBFF),
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              spreadRadius: 1,
              blurRadius: 3,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Row(
            children: [
              // 아이콘
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  // shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(iconPath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(width: 26),

              // 텍스트
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      interpretation,
                      style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.black),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      question,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 161, 157, 157),
                      ),
                    ),
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
