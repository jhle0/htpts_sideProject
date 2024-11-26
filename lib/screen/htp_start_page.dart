import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:htpts_app/screen/htp_ai_result_page.dart';

class HTPTSStartPage extends StatefulWidget {
  const HTPTSStartPage({super.key});

  @override
  _HTPTSStartPageState createState() => _HTPTSStartPageState();
}

class _HTPTSStartPageState extends State<HTPTSStartPage> {
  XFile? _image;
  final ImagePicker picker = ImagePicker();

  // 원하는 name 리스트
  final List<String> desiredNames = [
    "집전체",
    "지붕",
    "문",
    "창문",
    "굴뚝",
    "연기",
    "울타리",
    "연못",
    "산",
    "나무",
    "꽃",
    "태양",
    "나무전체",
    "뿌리",
    "나뭇잎",
    "열매",
    "구름",
    "달",
    "별",
    // "사람전체"
    // "길",
    // "잔디",
  ];

  Future getImage(ImageSource imageSource) async {
    final XFile? pickedFile = await picker.pickImage(source: imageSource);
    if (pickedFile != null) {
      setState(() {
        _image = pickedFile;
      });
    }
  }

  // AI 분석 페이지로 이동
  void goToAIResultPage(BuildContext context) async {
    if (_image != null) {
      try {
        // Dio 패키지를 사용해 multipart로 이미지 전송
        var dio = Dio();
        var formData = FormData.fromMap({
          'file':
              await MultipartFile.fromFile(_image!.path, filename: 'photo.jpg'),
        });

        var url = 'http://35.223.240.171:8000/predict/';
        var response = await dio.post(url, data: formData);

        if (response.statusCode == 200) {
          // 전체 결과값 받아오기
          var responseData = response.data;

          // 원하는 name들 중에서 confidence가 0.9 이상인 값만 필터링
          List<dynamic> filteredResult = responseData.where((item) {
            return desiredNames.contains(item['name']) &&
                item['confidence'] >= 0.9;
          }).toList();

          // 필터링된 결과를 AIResultPage로 전달
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AIResultPage(
                image: _image!,
                result: filteredResult,
              ),
            ),
          );
        } else {
          print('Error: ${response.statusCode}');
        }
      } catch (e) {
        print('Error: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFAEC6CF),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 20),
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white,
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back_ios_new),
                    color: Colors.black,
                    iconSize: 30,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
              ),
            ),
            const SizedBox(height: 150),
            Container(
              alignment: Alignment.center,
              child: _image != null
                  ? Image.file(
                      File(_image!.path),
                      width: 500,
                      height: 500,
                      fit: BoxFit.cover,
                    )
                  : const Text(
                      "이미지를 촬영해주세요.",
                      style: TextStyle(fontSize: 16, color: Colors.black54),
                    ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                getImage(ImageSource.camera);
              },
              style: ElevatedButton.styleFrom(
                fixedSize: const Size(200, 60),
                // minimumSize: const Size(50, 60),
                backgroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
              ),
              // child: const Text(
              //   '사진 찍기',
              //   style: TextStyle(
              //     color: Colors.black,
              //     fontSize: 20,
              //     fontWeight: FontWeight.bold,
              //   ),
              // ),
              child: const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.photo_camera,
                    color: Color.fromARGB(255, 0, 0, 0),
                    size: 24, // 화살표 크기
                  ),
                  SizedBox(width: 15),
                  Text(
                    '사진 찍기',
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
            // const SizedBox(height: 580),
            Padding(
              padding: const EdgeInsets.only(top: 250.0),
              child: ElevatedButton(
                onPressed: () {
                  goToAIResultPage(context); // 서버로 전송 후 결과 페이지로 이동
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(500, 60),
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: const Text(
                  'AI 분석 시작하기',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
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
