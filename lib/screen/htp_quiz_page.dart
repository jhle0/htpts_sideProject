import 'dart:math'; // 랜덤 선택을 위해 import
import 'package:flutter/material.dart';
import 'package:htpts_app/screen/htp_result_page.dart';
import 'package:image_picker/image_picker.dart';

class HTPQuizPage extends StatefulWidget {
  final List<String> detectedObjects;
  final XFile image;

  const HTPQuizPage({
    super.key,
    required this.detectedObjects,
    required this.image,
  });

  @override
  _HTPQuizPageState createState() => _HTPQuizPageState();
}

class _HTPQuizPageState extends State<HTPQuizPage> {
  final Map<String, String> selectedAnswers = {};
  final List<Map<String, dynamic>> allQuestions = [
    {
      "question": "집을 그리실 때 무엇이 가장 중요하다고 생각하셨나요?",
      "options": ["지붕", "창문", "문", "울타리"],
      "interpretations": {
        "지붕": "상상력과 이상을 중시하며 창의적인 성향을 가지고 있습니다.",
        "창문": "개방적이고 타인에게 관심이 많은 성향입니다.",
        "문": "현실적이며 안전과 실용성을 중시합니다.",
        "울타리": "자신을 보호하려는 심리가 강하며, 개인의 경계와 사생활을 중요시합니다.",
      },
    },
    {
      "question": "집에 창문은 몇 개나 그리셨나요?",
      "options": ["1개", "2~3개", "4개 이상", "창문을 그리지 않았다"],
      "interpretations": {
        "1개": "타인과의 소통은 필요하지만 제한적으로 느끼는 경향이 있습니다.",
        "2~3개": "외부와의 소통을 중시하며 사람들과 적절히 어울립니다.",
        "4개 이상": "개방적이며 타인의 의견에 쉽게 영향을 받을 수 있습니다.",
        "창문을 그리지 않았다": "내성적이며, 외부와의 관계를 차단하려는 경향이 있습니다.",
      },
    },
    {
      "question": "집의 위치는 어떤 환경에 있다고 상상하셨나요?",
      "options": ["도심", "산속", "바닷가", "들판"],
      "interpretations": {
        "도심": "바쁜 환경에서 활동적이고 외향적인 성격을 나타냅니다.",
        "산속": "평온함과 고립된 환경을 선호하며 내향적일 수 있습니다.",
        "바닷가": "감수성과 자유를 중시하며 개방적인 성격을 가지고 있습니다.",
        "들판": "자유로운 삶을 갈망하며 단순함과 자연을 중요하게 생각합니다."
      }
    },
    {
      "question": "문은 어떤 모양인가요? 열려 있나요, 닫혀 있나요?",
      "options": ["문이 열려 있다", "문이 닫혀 있다", "문이 없다"],
      "interpretations": {
        "문이 열려 있다": "타인과의 관계에서 개방적이고 환영하는 태도를 가지고 있습니다.",
        "문이 닫혀 있다": "자기 보호와 경계를 중요하게 생각하며 신중한 태도를 나타냅니다.",
        "문이 없다": "자신의 세계에 몰두하거나 타인과의 관계를 중요하게 여기지 않을 수 있습니다."
      }
    },
    {
      "question": "이 집에는 누가 살고 있나요?",
      "options": ["혼자", "가족", "친구", "모르겠다"],
      "interpretations": {
        "혼자": "독립적이고 자기 중심적인 성향을 나타냅니다.",
        "가족": "가족과의 유대와 안정감을 중요하게 생각합니다.",
        "친구": "사회적 관계를 중시하며 타인과의 연결을 원합니다.",
        "모르겠다": "자신의 소속감을 정의하기 어려운 상태일 수 있습니다."
      }
    },
    {
      "question": "이 집은 현실에서 본 적이 있는 집인가요, 아니면 상상한 집인가요?",
      "options": ["현실의 집", "상상의 집"],
      "interpretations": {
        "현실의 집": "과거 경험에 기반한 심리적 안정감을 중요시합니다.",
        "상상의 집": "창의적이고 이상적인 삶을 지향합니다."
      }
    },
    {
      "question": "집의 지붕 모양을 선택한 이유는 무엇인가요?",
      "options": ["뾰족한 지붕", "평평한 지붕", "둥근 지붕", "특이한 모양의 지붕"],
      "interpretations": {
        "뾰족한 지붕": "이상적인 목표를 추구하며 강한 에너지를 가지고 있습니다.",
        "평평한 지붕": "안정적이고 현실적인 사고방식을 가지고 있습니다.",
        "둥근 지붕": "온화하고 조화를 중시하는 성격을 나타냅니다.",
        "특이한 모양의 지붕": "독창적이며 고유의 방식으로 생각하는 성향을 가지고 있습니다."
      }
    },
    {
      "question": "집의 외관에서 가장 중요하다고 생각한 부분은 무엇인가요?",
      "options": ["지붕", "문", "창문", "벽"],
      "interpretations": {
        "지붕": "미래와 이상에 대한 생각이 많고, 창의적인 성향을 가집니다.",
        "문": "안전과 현실적인 요소를 중요시하며 실용적인 사고를 합니다.",
        "창문": "타인과의 소통과 개방적인 태도를 중시합니다.",
        "벽": "안정적이고 보호받는 환경을 추구합니다."
      }
    },
    {
      "question": "나무의 크기를 어떻게 그리셨나요?",
      "options": ["매우 크고 강한 나무", "중간 크기의 나무", "작고 앙상한 나무", "비정상적인 형태의 나무"],
      "interpretations": {
        "매우 크고 강한 나무": "자신감이 넘치며 목표를 향해 나아가는 추진력이 강합니다.",
        "중간 크기의 나무": "균형과 조화를 중요시하며, 현실적이고 안정적인 성향을 가지고 있습니다.",
        "작고 앙상한 나무": "내면적으로 불안감이 있거나, 에너지 부족 상태를 나타낼 수 있습니다.",
        "비정상적인 형태의 나무": "독특한 사고방식을 가지고 있으며, 타인의 시선을 크게 신경 쓰지 않습니다.",
      },
    },
    {
      "question": "나무에 잎사귀를 추가하셨나요?",
      "options": ["풍성하게 그렸다", "적당히 그렸다", "생략했다"],
      "interpretations": {
        "풍성하게 그렸다": "생명력과 에너지가 넘치며 긍정적인 성향을 나타냅니다.",
        "적당히 그렸다": "현실적이고 조화를 중시하는 성향을 나타냅니다.",
        "생략했다": "내성적이며 에너지 부족 상태를 나타낼 수 있습니다."
      }
    },
    {
      "question": "나무의 위치는 어디에 있다고 생각하셨나요?",
      "options": ["넓은 들판", "숲속", "집 가까이", "산 정상"],
      "interpretations": {
        "넓은 들판": "자유롭고 개방적인 환경을 선호하며 독립적인 성향을 가지고 있습니다.",
        "숲속": "안정적이고 보호받는 환경을 선호하며 내향적인 성격을 나타냅니다.",
        "집 가까이": "안정감과 가족 또는 소속감을 중요하게 여깁니다.",
        "산 정상": "성취와 목표를 중시하며 도전적인 성향을 가지고 있습니다."
      }
    },
    {
      "question": "나무를 그릴 때 가장 중요하게 생각한 요소는 무엇인가요?",
      "options": ["크기", "뿌리", "열매", "가지", "잎사귀"],
      "interpretations": {
        "크기": "자신감과 존재감을 나타내며, 외향적인 성격일 가능성이 높습니다.",
        "뿌리": "안정성과 기반을 중시하며, 과거와 연결되어 있음을 의미할 수 있습니다.",
        "열매": "성취와 결과물을 중시하며, 목표 지향적입니다.",
        "가지": "다양한 관계와 가능성을 탐색하는 것을 중요하게 여깁니다.",
        "잎사귀": "미적 감각과 생명력을 중요하게 생각합니다."
      }
    },
    {
      "question": "나무의 가지는 어떤 모습인가요?",
      "options": ["길고 풍성하다", "적당하다", "짧거나 없다"],
      "interpretations": {
        "길고 풍성하다": "타인과의 관계를 중시하며 확장을 중요하게 생각합니다.",
        "적당하다": "균형 잡힌 사고와 조화를 나타냅니다.",
        "짧거나 없다": "타인과의 관계에서 어려움을 느끼거나 내향적일 수 있습니다."
      }
    },
    {
      "question": "집 내부를 상상한다면 어떤 모습인가요?",
      "options": ["깔끔하고 정돈된 모습", "복잡하고 독특한 구조", "공간이 비어 있다", "구체적으로 떠오르지 않는다"],
      "interpretations": {
        "깔끔하고 정돈된 모습": "체계적이고 조직적인 성격을 가지고 있습니다.",
        "복잡하고 독특한 구조": "창의적이며 새로운 아이디어를 중요하게 여깁니다.",
        "공간이 비어 있다": "현재 감정적으로 공허하거나 지친 상태일 수 있습니다.",
        "구체적으로 떠오르지 않는다": "현실적인 것보다 추상적인 사고를 선호합니다."
      }
    },
    {
      "question": "나무가 건강해 보이나요?",
      "options": ["매우 건강해 보인다", "보통이다", "약해 보인다"],
      "interpretations": {
        "매우 건강해 보인다": "현재 상태에 자신감이 넘치고 긍정적입니다.",
        "보통이다": "균형 잡힌 상태를 나타내며 현실적입니다.",
        "약해 보인다": "에너지 부족이나 감정적인 불안을 나타낼 수 있습니다."
      }
    },
    {
      "question": "나무가 말을 한다면 첫 마디로 무엇을 말할 것 같나요?",
      "options": ["'어서 와!'", "'저리 가!'", "'날 도와줘'", "'아무 말도 하지 않는다'"],
      "interpretations": {
        "'어서 와!'": "사교적이고 환영하는 성격을 나타냅니다.",
        "'저리 가!'": "경계를 중요시하며, 타인과의 관계에서 신중합니다.",
        "'날 도와줘'": "현재 어려움을 겪고 있거나 의존적인 성향이 있을 수 있습니다.",
        "'아무 말도 하지 않는다'": "감정을 숨기고 내면에 집중하는 성향을 나타냅니다."
      }
    },
    {
      "question": "사람의 주변에 어떤 배경을 추가했나요?",
      "options": ["배경 없음", "친구", "동물", "자연 요소"],
      "interpretations": {
        "배경 없음": "개인적이고 독립적인 성향이 강하며, 타인의 영향을 덜 받습니다.",
        "친구": "사회적 관계를 중시하며, 타인과의 유대감을 중요하게 생각합니다.",
        "동물": "동물이나 자연을 사랑하며, 감수성과 연민이 강합니다.",
        "자연 요소": "평화롭고 조화를 이루는 삶을 갈망하며, 자연에 대한 애착이 있습니다."
      }
    },
    {
      "question": "사람의 표정은 어떤가요?",
      "options": ["웃는 표정", "무표정", "슬픈 표정"],
      "interpretations": {
        "웃는 표정": "긍정적이며 타인과의 관계를 중요하게 생각합니다.",
        "무표정": "현실적이며 감정 표현을 절제하려는 성향을 나타냅니다.",
        "슬픈 표정": "감정적으로 불안하거나 우울한 상태일 가능성이 있습니다."
      }
    },
    {
      "question": "이 사람은 무엇을 하고 있나요?",
      "options": ["서 있다", "걷고 있다", "앉아 있다", "모르겠다"],
      "interpretations": {
        "서 있다": "주도적이고 독립적인 성향을 나타냅니다.",
        "걷고 있다": "적응력이 높고 활동적인 성격을 나타냅니다.",
        "앉아 있다": "안정적이고 내향적인 성향을 나타냅니다.",
        "모르겠다": "자신의 행동과 목적에 대한 명확한 의식이 부족할 수 있습니다."
      }
    },
    {
      "question": "사람의 옷차림을 어떻게 표현했나요?",
      "options": ["깔끔하고 단정하다", "복잡하고 화려하다", "단순하고 평범하다", "옷을 생략했다"],
      "interpretations": {
        "깔끔하고 단정하다": "책임감이 강하고 타인에게 좋은 인상을 남기려 합니다.",
        "복잡하고 화려하다": "개성이 강하며 자신을 표현하는 데 적극적입니다.",
        "단순하고 평범하다": "실용적이고 현실적인 사고방식을 가지고 있습니다.",
        "옷을 생략했다": "자기 표현에 어려움을 느끼거나 무관심할 수 있습니다."
      }
    },
  ];

  int currentQuestionIndex = 0; // 현재 질문의 인덱스
  List<Map<String, dynamic>> selectedQuestions = [];

  @override
  void initState() {
    super.initState();
    selectedQuestions = _getRandomQuestions(6);
  }

  List<Map<String, dynamic>> _getRandomQuestions(int count) {
    final random = Random();
    final shuffled = List<Map<String, dynamic>>.from(allQuestions)
      ..shuffle(random);
    return shuffled.take(count).toList();
  }

  void _nextQuestion() {
    if (currentQuestionIndex < selectedQuestions.length - 1) {
      setState(() {
        currentQuestionIndex++;
      });
    } else {
      // 모든 질문에 답변을 마쳤을 때
      List<Map<String, String>> quizResults = [];
      for (var question in selectedQuestions) {
        var selected = selectedAnswers[question["question"]];
        if (selected != null) {
          quizResults.add({
            "question": question["question"],
            "answer": selected,
            "interpretation":
                question["interpretations"][selected] ?? "해석이 없습니다.",
          });
        }
      }
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HTPResultPage(
            image: widget.image,
            quizResults: quizResults,
            detectedObjects: widget.detectedObjects,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = selectedQuestions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / selectedQuestions.length;

    return Scaffold(
      appBar: AppBar(
        title: const Text("심리 테스트"),
        backgroundColor: const Color(0xFFAEC6CF),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 진행률 표시
            LinearProgressIndicator(
              value: progress,
              color: Colors.blue,
              backgroundColor: Colors.grey[300],
            ),
            const SizedBox(height: 80),

            // 현재 질문 표시
            Center(
              child: Text(
                currentQuestion["question"],
                style: const TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: 10),

            // 선택지 표시
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: currentQuestion["options"].map<Widget>((option) {
                  final isSelected =
                      selectedAnswers[currentQuestion["question"]] == option;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAnswers[currentQuestion["question"]] = option;
                      });
                    },
                    child: OptionButton(
                      option: option,
                      isSelected: isSelected,
                    ),
                  );
                }).toList(),
              ),
            ),

            // "다음" 버튼
            Center(
              child: ElevatedButton(
                onPressed:
                    selectedAnswers.containsKey(currentQuestion["question"])
                        ? _nextQuestion
                        : null, // 답변이 선택되지 않으면 버튼 비활성화
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 60),
                  backgroundColor:
                      selectedAnswers.containsKey(currentQuestion["question"])
                          ? Colors.black
                          : Colors.grey, // 활성화 상태에 따른 색상 변경
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  currentQuestionIndex == selectedQuestions.length - 1
                      ? "결과 보기"
                      : "다음",
                  style: const TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OptionButton extends StatelessWidget {
  final String option;
  final bool isSelected;

  const OptionButton({
    super.key,
    required this.option,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Container(
        // width: double.infinity,
        width: 400,
        height: 73,
        decoration: ShapeDecoration(
          color: isSelected ? const Color(0x1C226FE3) : const Color(0x1CE9E9E9),
          shape: RoundedRectangleBorder(
            side: BorderSide(
              width: 1,
              color: isSelected
                  ? const Color(0xFF226FE3)
                  : const Color(0xFFE9E9E9),
            ),
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        child: Stack(
          children: [
            Center(
              child: Text(
                option,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            if (isSelected)
              Positioned(
                right: 20,
                top: 20,
                child: Container(
                  width: 33,
                  height: 33,
                  decoration: const ShapeDecoration(
                    color: Color(0xFF226FE3),
                    shape: OvalBorder(),
                  ),
                  child: const Icon(Icons.check, color: Colors.white, size: 20),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
