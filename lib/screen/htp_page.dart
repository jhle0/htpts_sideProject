import 'package:flutter/material.dart';
import 'package:htpts_app/screen/htp_start_page.dart';

class HTPPage extends StatelessWidget {
  const HTPPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 돌아가기 버튼 (상단 왼쪽)
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 20),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle, // 원형 배경
                    color: Colors.white, // 배경색
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    color: Colors.black,
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(context); // 뒤로 가기
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
            // 이미지 표시
            ClipOval(
              child: Image.asset(
                'assets/images/htpts_icon2.png', // 이미지 경로
                width: 400, // 동그라미 크기 설정
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 30),
            // 제목 텍스트
            const Text(
              'HTP 검사',
              style: TextStyle(
                color: Colors.black,
                fontSize: 45,
                fontWeight: FontWeight.w900,
              ),
            ),
            const SizedBox(height: 20),
            // 설명 텍스트
            const Text(
              'HTP 검사는 1948년 심리학자 존 벅(John Buck)에 의해서 처음으로 제창되었으며\n 헤머(Hammer)가 크게 발전시킨 것으로 기존의 심리진단 검사를 보완해주는\n 대표적 투사적 검사이다.',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w800,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            // 추가 정보 보기 버튼
            TextButton(
              onPressed: () {
                // 추가 정보 페이지로 이동 (예시)
                showDialog(
                  context: context,
                  builder: (context) => const AlertDialog(
                    title: Text('자세한 설명'),
                    content: Text('HTP 검사는 그림을 통해 심리 상태를 분석하는 테스트로, 주로\n'
                        '개인의 감정이나 무의식적인 상태를 파악하는 데 사용됩니다.'),
                  ),
                );
              },
              child: const Text(
                '자세히 보기',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.underline, // 밑줄 추가
                ),
              ),
            ),
            const Spacer(), // 아래로 붙여주기 위해 스페이서 추가
            // 검사 시작 버튼
            Padding(
              padding: const EdgeInsets.only(bottom: 20.0),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: () {
                    // 검사 시작 페이지로 이동 (예시)
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            const HTPTSStartPage(), // 새 페이지로 이동
                      ),
                    );
                  },
                  child: const Text(
                    '검사 시작하기',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
