class FlashCard {
  final String question;
  final String answer;

  FlashCard({
    required this.question,
    required this.answer,
  });
}

List<FlashCard> qaList = [
  FlashCard(question: "플러터를 구성하는 블럭들의 이름은?", answer: "위젯"),
  FlashCard(question: "플러터에서 State란?", answer: "변경될 때마다 화면에 리렌더링 되는 데이터"),
  FlashCard(question: "위젯 인스펙터의 존재 목적?", answer: "디버깅"),
];
