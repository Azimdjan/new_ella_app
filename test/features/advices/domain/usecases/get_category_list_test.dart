import 'package:dartz/dartz.dart';
import 'package:ella/features/advices/domain/entities/category_list_entity.dart';
import 'package:ella/features/advices/domain/repository/advices_repository.dart';
import 'package:ella/features/advices/domain/usecases/get_category_list.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'get_category_list_test.mocks.dart';

@GenerateMocks([AdvicesRepository])
void main() {
  late final AdvicesRepository advicesRepository;
  late final GetCategoryList getCategoryList;
  late final CategoryListEntity categoryListEntity;
  setUp(() {
    categoryListEntity = const CategoryListEntity(
      [
        Category(
          'hello',
          1,
          'uz',
          [
            Guid(
              'hello',
              1,
              'uz',
            ),
          ],
        ),
        Category(
          'hello',
          2,
          'uz',
          [
            Guid(
              'hello',
              2,
              'uz',
            ),
          ],
        ),
      ],
    );
    advicesRepository = MockAdvicesRepository();
    getCategoryList = GetCategoryList(advicesRepository);
  });

  test(
    'verify that it gets from advice repository',
    () async {
      when(advicesRepository.getCategoryList(false)).thenAnswer(
        (realInvocation) async => Right(
          categoryListEntity,
        ),
      );
      final result = await advicesRepository.getCategoryList(false);

      expect(result, Right(categoryListEntity));

      verify(advicesRepository.getCategoryList(false));

      verifyNoMoreInteractions(advicesRepository);
    },
  );
}
