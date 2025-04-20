abstract class Validator {
  final Map<String, dynamic> data;

  Validator({required this.data});

  String? call<T>({required T value});
}
