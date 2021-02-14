import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mock_network_calls/dio_adapter_mock.dart';
import 'package:flutter_mock_network_calls/main.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

void main() {
  DioAdapterMock dioAdapterMock;

  setUp(() {
    dioAdapterMock = DioAdapterMock();
  });
  testWidgets('Test-1', (WidgetTester tester) async {
    var data = {'message': 'This message has been fetched from mock API-1.'};

    final responsepayload = jsonEncode(data);

    final httpResponse = ResponseBody.fromString(
      responsepayload,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

    when(dioAdapterMock.fetch(any, any, any))
        .thenAnswer((_) async => httpResponse);

    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Test',
        home: MyHomePage(
          title: 'Flutter Test',
        ),
      ),
    );

    Finder button = find.ancestor(
      of: find.text('Click here to fetch data from API-1'),
      matching: find.byType(RaisedButton),
    );

    expect(find.text('This message has been fetched from mock API-1.'),
        findsNothing);

    await tester.tap(button);
    await tester.pumpAndSettle();

    expect(find.text('This message has been fetched from mock API-1.'),
        findsOneWidget);
  });

  testWidgets('Test-2', (WidgetTester tester) async {
    var data1 = {'message': 'Message from mock API-1'};

    final responsepayload1 = jsonEncode(data1);

    final httpResponse1 = ResponseBody.fromString(
      responsepayload1,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

    when(dioAdapterMock.fetch(
            argThat(
              isA<RequestOptions>().having(
                (options) => options.path,
                'path',
                equals('data1'),
              ),
            ),
            any,
            any))
        .thenAnswer((_) async => httpResponse1);

    var data2 = {'message': 'Message from mock API-2'};

    final responsepayload2 = jsonEncode(data2);

    final httpResponse2 = ResponseBody.fromString(
      responsepayload2,
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );

    when(dioAdapterMock.fetch(
            argThat(
              isA<RequestOptions>().having(
                (options) => options.path,
                'path',
                equals('data2'),
              ),
            ),
            any,
            any))
        .thenAnswer((_) async => httpResponse2);

    await tester.pumpWidget(
      MaterialApp(
        title: 'Flutter Test',
        home: MyHomePage(
          title: 'Flutter Test',
        ),
      ),
    );

    /// fetch data from API-1 by clicking on button1 and
    /// verify the text being rendered on UI after API call success
    Finder button1 = find.ancestor(
      of: find.text('Click here to fetch data from API-1'),
      matching: find.byType(RaisedButton),
    );

    expect(find.text('Message from mock API-1'), findsNothing);

    await tester.tap(button1);
    await tester.pumpAndSettle();

    expect(find.text('Message from mock API-1'), findsOneWidget);

    /// fetch data from API-2 by clicking on button2 and
    /// verify the text being rendered on UI after API call success
    Finder button2 = find.ancestor(
      of: find.text('Click here to fetch data from API-2'),
      matching: find.byType(RaisedButton),
    );

    expect(find.text('Message from mock API-2'), findsNothing);

    await tester.tap(button2);
    await tester.pumpAndSettle();

    expect(find.text('Message from mock API-2'), findsOneWidget);
  });
}
