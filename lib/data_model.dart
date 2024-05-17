import 'package:api_example_239/quote_model.dart';

class DataModel {
  int? total;
  int? limit;
  int? skip;
  List<QuoteModel>? quotes;

  DataModel({
      required this.limit,
      required this.quotes,
      required this.skip,
      required this.total
      });


  factory DataModel.fromJson(Map<String, dynamic> json){

    List<QuoteModel> mQuotes = [];

    for(Map<String, dynamic> eachQuote in json['quotes']){
      QuoteModel model = QuoteModel.fromJson(eachQuote);
      mQuotes.add(model);
    }


    return DataModel(
        limit: json['limit'],
        quotes: mQuotes,
        skip: json['skip'],
        total: json['total']);
  }

}
