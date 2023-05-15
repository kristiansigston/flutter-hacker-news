import 'package:news/src/resources/news_api_provider.dart';
import 'dart:convert';
import 'package:test/test.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

void main() {
  test('fetchTopIds returns a list of ids', () async {
    final NewsApiProvider newsApi = NewsApiProvider();
    newsApi.client = MockClient((request) async {
      return Future.value(Response(json.encode([1, 2, 3, 4]), 200));
    });

    final List<int> topIds = await newsApi.fetchTopIds();
    expect(topIds, [1, 2, 3, 4]);
  });

  test('FetchItem returns an item model', () async {
    final newsApi = NewsApiProvider();

    newsApi.client = MockClient((request) {
      final jsonMap = {'id': 123};
      return Future.value(Response(json.encode(jsonMap), 200));
    });

    final item = await newsApi.fetchItem(999);
    expect(item.id, 123);
  });
}
