import 'package:equatable/equatable.dart';

class TestEntities extends Equatable {
  final String name;
  final String description;
  final String CategoryName;

  TestEntities({
    required this.name,
    required this.description,
    required this.CategoryName,
  });

  @override
  // TODO: implement props
  List<Object?> get props => [name, description, CategoryName];
}
