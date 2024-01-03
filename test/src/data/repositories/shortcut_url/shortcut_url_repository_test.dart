import 'package:demoafgr/demoafgr.dart';
import 'package:dio/dio.dart';
import 'package:exception_handler/exception_handler.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../../mocks.dart';

void main() {
  late ShortcutUrlRepository repository;
  late MockDioExceptionHandler mockDioExceptionHandler;
  late MockShortcutUrlRemoteDataSource mockShortcutUrlRemoteDataSource;
  const ShortcutUrlModel testModel = ShortcutUrlModel(
    alias: 'alias',
    links: LinksModel(self: 'self', short: 'short'),
  );

  setUp(() {
    registerFallbackValue(FakeApiHandler());

    mockDioExceptionHandler = MockDioExceptionHandler();
    mockShortcutUrlRemoteDataSource = MockShortcutUrlRemoteDataSource();

    repository = ShortcutUrlRepository(
      clientExceptionHandler: mockDioExceptionHandler,
      dataSource: mockShortcutUrlRemoteDataSource,
    );
  });

  test('Direct call to newShortcutUrl', () async {
    const testUrl = 'http://test.com';

    when(() => mockShortcutUrlRemoteDataSource.newShortcutUrl(any()))
        .thenAnswer(
      (_) async => Response(
        requestOptions: RequestOptions(path: 'path'),
        data: 'mock data',
      ),
    );
    when(
      () => mockDioExceptionHandler.callApi<Response, ShortcutUrlModel?>(any()),
    ).thenAnswer((_) async => const SuccessState(testModel));

    final result = await repository.postShortcutUrl(testUrl);

    await mockShortcutUrlRemoteDataSource.newShortcutUrl(testUrl);

    expect(result, isA<TaskResult<ShortcutUrlModel?>>());
    result.when(
      success: (data) {
        expect(data, equals(testModel));
      },
      failure: (e) {},
    );
    verify(() => mockShortcutUrlRemoteDataSource.newShortcutUrl(testUrl))
        .called(1);
  });
}
