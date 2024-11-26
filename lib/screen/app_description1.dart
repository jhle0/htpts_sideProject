import 'package:flutter/material.dart';
import 'package:htpts_app/screen/app_description2.dart';

class AppDescription1 extends StatelessWidget {
  const AppDescription1({super.key});

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
              // 뒤로 가기 버튼 (상단 왼쪽)
              Positioned(
                left: 20,
                top: 40,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back),
                  color: Colors.black,
                  iconSize: 30,
                  onPressed: () {
                    Navigator.pop(context); // 뒤로 가기
                  },
                ),
              ),
              // 'HTPTS' 텍스트 (상단 배치)
              const Positioned(
                left: 40,
                top: 110,
                child: Text(
                  'HTPTS',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 50,
                    fontFamily: 'Amaranth', // Amaranth 폰트 사용
                    fontWeight: FontWeight.w700,
                    height: 0,
                    decoration: TextDecoration.none, // 밑줄 제거
                  ),
                ),
              ),
              // 동그라미 3개 (1, 2, 3) 번호 표시
              Positioned(
                left: 60,
                top: 470,
                child: Row(
                  children: [
                    _buildCircle(1, true), // 1번: 검은 배경, 흰 글씨
                    const SizedBox(width: 16),
                    _buildCircle(2, false), // 2번: 투명 배경, 검은 테두리, 검은 글씨
                    const SizedBox(width: 16),
                    _buildCircle(3, false), // 3번: 투명 배경, 검은 테두리, 검은 글씨
                  ],
                ),
              ),
              // "그림 그리기" 텍스트
              const Positioned(
                left: 60,
                top: 520,
                child: Text(
                  '그림 그리기',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 32,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                    decoration: TextDecoration.none, // 밑줄 제거
                  ),
                ),
              ),
              // "집, 나무, 사람 그림을 간단히 그려주세요" 텍스트
              const Positioned(
                left: 60,
                top: 570,
                child: Text(
                  '집, 나무, 사람 그림을 간단히 그려주세요',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontFamily: 'Inter',
                    fontWeight: FontWeight.w600,
                    height: 0,
                    decoration: TextDecoration.none, // 밑줄 제거
                  ),
                ),
              ),
              // 이미지를 원형으로 표시 (assets에서 불러오기)
              Positioned(
                left: 248,
                top: 648,
                child: ClipOval(
                  child: Container(
                    width: 300,
                    height: 300,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/htpts_ex_image1.jpg'), // assets에서 이미지 불러오기
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ),
              ),
              // "다음" 버튼
              Positioned(
                right: 80,
                top: 1040,
                child: GestureDetector(
                  onTap: () {
                    // "다음" 버튼 클릭 시 페이지 이동
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AppDescription2()),
                    );
                  },
                  child: Container(
                    width: 200,
                    height: 66,
                    decoration: ShapeDecoration(
                      color: Colors.black,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40),
                      ),
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          '다음',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontFamily: 'Inter',
                            fontWeight: FontWeight.w500,
                            height: 0,
                            decoration: TextDecoration.none, // 밑줄 제거
                          ),
                        ),
                        SizedBox(width: 30), // "다음"과 화살표 사이 간격
                        Icon(
                          Icons.arrow_forward_ios, // 오른쪽 화살표 아이콘
                          color: Colors.white,
                          size: 24, // 화살표 크기
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

  // 원형 버튼을 만드는 위젯 (배경색과 글씨 색을 매개변수로 설정)
  Widget _buildCircle(int number, bool isBlackBackground) {
    return Container(
      width: 40, // 크기
      height: 40,
      decoration: BoxDecoration(
        color: isBlackBackground ? Colors.black : Colors.transparent, // 배경색 조정
        border: Border.all(color: Colors.black, width: 2), // 검은 테두리 추가
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Text(
          '$number',
          style: TextStyle(
            color: isBlackBackground ? Colors.white : Colors.black, // 글씨 색 조정
            fontSize: 16,
            fontFamily: 'Inter',
            fontWeight: FontWeight.w500,
            decoration: TextDecoration.none, // 밑줄 제거
          ),
        ),
      ),
    );
  }
}
