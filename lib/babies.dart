// ignore_for_file: public_member_api_docs, sort_constructors_first
class Babies {
  int age;

  Babies({
    required this.age,
  });

  Future<int> getBabies() async {
    await Future.delayed(const Duration(seconds: 2));
    if (age > 1 && age < 5) {
      return 4;
    } else {
      return 1;
    }
  }

  Stream<String> bark() async* {
    for (int i = 0; i < age; i++) {
      await Future.delayed(const Duration(seconds: 1));
      yield 'Bark $i times';
    }
  }
}
