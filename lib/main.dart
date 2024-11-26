import 'package:flutter/material.dart';
import 'package:htpts_app/screen/app_description1.dart';

void main() {
  runApp(const HTPTSApp());
}

class HTPTSApp extends StatelessWidget {
  const HTPTSApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false, // 디버그 배너 숨기기
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFFAEC6CF), // 배경색 설정
      ),
      home: Scaffold(
        body: ListView(
          children: const [
            StartPage(),
          ],
        ),
      ),
    );
  }
}

class StartPage extends StatelessWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity, // 화면에 맞게 가로 크기 설정
          height: MediaQuery.of(context).size.height, // 화면 높이에 맞게 설정
          clipBehavior: Clip.antiAlias,
          decoration: const BoxDecoration(color: Color(0xFFAEC6CF)), // 배경색 설정
          child: Stack(
            children: [
              // 'HTPTS' 텍스트 (상단 배치)
              const Positioned(
                left: 90,
                top: 100,
                child: Text(
                  'HTPTS',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 100,
                    fontFamily: 'Amaranth', // Amaranth 폰트 사용
                    fontWeight: FontWeight.w700,
                    height: 0,
                  ),
                ),
              ),
              // "당신의 그림 속 숨겨진 심리를 탐험하세요." 텍스트 (HTPTS 아래에 배치)
              const Positioned(
                left: 94,
                top: 222,
                child: Text(
                  '당신의 그림 속 숨겨진 심리를 탐험하세요.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w800,
                    height: 0,
                  ),
                ),
              ),
              // 이미지 (assets 폴더의 이미지로 변경)
              Positioned(
                left: 20,
                top: 170,
                child: Container(
                  width: 800,
                  height: 800,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                          'assets/images/htpts_icon.png'), // 로컬 이미지 경로
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              // "다음" 버튼
              Positioned(
                left: 165,
                top: 990,
                child: GestureDetector(
                  onTap: () {
                    // "다음" 버튼 클릭 시 AppDescription1 페이지로 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AppDescription1()),
                    );
                  },
                  child: Container(
                    width: 526,
                    height: 66,
                    decoration: ShapeDecoration(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        '다음',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 20,
                          fontFamily: 'Inter',
                          fontWeight: FontWeight.w500,
                          height: 0,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              // 이용 약관 텍스트
              const Positioned(
                left: 180,
                top: 1075,
                child: SizedBox(
                  width: 435,
                  child: Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: '다음 버튼 클릭으로, HTPTS 이용약관에 동의합니다.\n',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w200,
                            height: 0,
                          ),
                        ),
                        TextSpan(
                          text: 'Terms of service',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w400,
                            height: 0,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
