import 'package:car_parts_app/domain/entities/test/test_entities.dart';

class TestData {
  static List<TestEntities> getTestData() {
    return [
      TestEntities(
        name: 'Test Item 1',
        description: 'Description for Test Item 1',
        CategoryName: 'Category A',
      ),
      TestEntities(
        name: 'Test Item 2',
        description: 'Description for Test Item 2',
        CategoryName: 'Category B',
      ),
      TestEntities(
        name: 'Test Item 3',
        description: 'Description for Test Item 3',
        CategoryName: 'Category A',
      ),
      TestEntities(
        name: 'Test Item 4',
        description: 'Description for Test Item 4',
        CategoryName: 'Category C',
      ),
    ];
  }
}
