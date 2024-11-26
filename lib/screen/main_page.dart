import 'package:flutter/material.dart';
import 'package:htpts_app/main.dart';
import 'package:htpts_app/screen/htp_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _currentImageIndex = 0; // 현재 페이지를 추적할 변수

  final List<String> images = [
    'assets/images/htp.png',
    'assets/images/house.png',
    'assets/images/tree.png',
    'assets/images/person.png',
  ];

  // 이미지 변경 함수
  void _changeImage(bool isNext) {
    setState(() {
      if (isNext) {
        // "다음" 화살표 클릭 시
        if (_currentImageIndex < images.length - 1) {
          _currentImageIndex++; // 다음 이미지로 변경
        }
      } else {
        // "이전" 화살표 클릭 시
        if (_currentImageIndex > 0) {
          _currentImageIndex--; // 이전 이미지로 변경
        }
      }
    });
  }

  // 홈 버튼 클릭 시 StartPage로 이동
  void _goHome(BuildContext context) {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const HTPTSApp()),
    );
  }

  // 이미지 클릭 시 해당 페이지로 이동하는 함수
  void _goToPage(BuildContext context, int index) {
    // 예시로 각 이미지를 클릭했을 때 이동할 페이지 설정
    // 페이지가 하나씩 추가되도록 할 수 있습니다.
    // 여기에 페이지 이동 로직을 추가하세요.
    // 예: Navigator.push(...);
    switch (index) {
      case 0:
        // 첫 번째 이미지 클릭 시 페이지 이동 (예: Page1)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HTPPage()),
        );
        break;
      case 1:
        // 두 번째 이미지 클릭 시 페이지 이동 (예: Page2)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HTPPage()),
        );
        break;
      case 2:
        // 세 번째 이미지 클릭 시 페이지 이동 (예: Page3)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HTPPage()),
        );
        break;
      case 3:
        // 네 번째 이미지 클릭 시 페이지 이동 (예: Page4)
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HTPPage()),
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            // 상단 텍스트와 홈 버튼을 한 행에 배치
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceBetween, // 텍스트 왼쪽, 홈 버튼 오른쪽
              children: [
                const Padding(
                  padding:
                      EdgeInsets.only(left: 40.0, top: 80.0), // 왼쪽과 위쪽 공백 추가
                  child: Text(
                    'HTPTS TEST',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 60,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 70.0, left: 20),
                  child: IconButton(
                    icon: const Icon(Icons.home),
                    color: Colors.black,
                    iconSize: 30,
                    onPressed: () => _goHome(context), // 홈으로 이동
                  ),
                ),
              ],
            ),

            // "아래에서 검사방법을 선택해주세요." 텍스트 왼쪽에 딱 붙이기
            const SizedBox(height: 2),
            const Align(
              alignment: Alignment.centerLeft, // 텍스트를 왼쪽으로 정렬
              child: Padding(
                padding: EdgeInsets.only(left: 40.0),
                child: Text(
                  '아래에서 검사방법을 선택해주세요.',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),

            // 이미지 및 화살표 버튼 한 행에 배치
            const SizedBox(height: 100),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // 왼쪽 화살표
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                  color: Colors.black,
                  iconSize: 60, // 화살표 크기 크게
                  onPressed: () {
                    _changeImage(false); // 이전 이미지로 이동
                  },
                ),

                // 이미지 표시 (동그랗게)
                GestureDetector(
                  onTap: () =>
                      _goToPage(context, _currentImageIndex), // 이미지 클릭 시 페이지 이동
                  child: ClipOval(
                    child: Image.asset(
                      images[_currentImageIndex], // 현재 페이지의 이미지를 표시
                      width: 500, // 동그라미 크기 설정
                      height: 500,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),

                // 오른쪽 화살표
                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios_rounded),
                  color: Colors.black,
                  iconSize: 60, // 화살표 크기 크게
                  onPressed: () {
                    _changeImage(true); // 다음 이미지로 이동
                  },
                ),
              ],
            ),

            // 페이지 인디케이터 (하단 점)
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(images.length, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 10,
                  height: 10,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _currentImageIndex == index
                        ? Colors.black
                        : Colors.grey,
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  const Page2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page 2")),
      body: const Center(
        child: Text("This is Page 2"),
      ),
    );
  }
}

class Page3 extends StatelessWidget {
  const Page3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page 3")),
      body: const Center(
        child: Text("This is Page 3"),
      ),
    );
  }
}

class Page4 extends StatelessWidget {
  const Page4({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Page 4")),
      body: const Center(
        child: Text("This is Page 4"),
      ),
    );
  }
}
