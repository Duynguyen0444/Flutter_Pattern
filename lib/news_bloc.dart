import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc_pattern/news_info.dart';
import 'package:http/http.dart' as http;

enum NewsAction { Delete, Fetch }

class NewsBloc {
  // 1. State StreamController
  final _stateStreamController = StreamController<List<Article>>();
  StreamSink<List<Article>> get _newsSink => _stateStreamController.sink;
  Stream<List<Article>> get newsStream => _stateStreamController.stream;

  // 2. Event StreamController
  final _eventStreamController = StreamController<NewsAction>();
  StreamSink<NewsAction> get eventSink => _eventStreamController.sink;
  Stream<NewsAction> get _eventStream => _eventStreamController.stream;

  NewsBloc() {
    _eventStream.listen((event) async {
      if (event == NewsAction.Fetch) {
        try {
          var news = await getNews();
          if (news != null) {
            _newsSink.add(news.articles);
          } else {
            _newsSink.addError('Something went wrong');
          }
        } on Exception catch (e) {
          _newsSink.addError('Something went wrong');
        }
      }
    });
  }

  Future<NewsModel> getNews() async {
    var client = http.Client();
    var newsModel;

    try {
      var response = await client.get(Uri.parse(
          'http://newsapi.org/v2/everything?domains=wsj.com&apiKey=YOUR_API_KEY'));
      if (response.statusCode == 200) {
        var jsonString = response.body;
        var jsonMap = json.decode(jsonString);

        newsModel = NewsModel.fromJson(jsonMap);
      }
    } catch (Exception) {
      return newsModel;
    }

    return newsModel;
  }
}
