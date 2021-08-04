class Diary {
  // 변수 선언
  final String? id;
  final String title;
  final String text;

  // initialize
  Diary({
    required this.id,
    required this.title,
    required this.text,
  });

  // map형식 반환 메소드 정의
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'text': text,
    };
  }

  // log에서 확인 쉽게 하기 위해서 만들어 놓은 메소드
  @override
  String toString() {
    return 'Diary{id: $id, title: $title, text: $text }';
  }
}
