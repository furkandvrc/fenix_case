import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:the_moive_db/app/constants/app/env.dart';
import 'package:the_moive_db/app/model/general/error_model.dart';
import 'package:the_moive_db/app/model/header/session_header_model.dart';
import 'package:the_moive_db/app/model/response/base_http_model.dart';
import 'package:get/get_connect/http/src/status/http_status.dart';
import '../constants/app/http_url.dart';
import '../constants/enum/loading_status_enum.dart';
import '../model/response/search_response_model.dart';
import 'package:http/http.dart' as http;

class General extends SessionHeaderModel {
  General() : super();

  Future<BaseHttpModel<SearchResponseModel>> search(String searchSlug, int page) async {
    try {
      final response = await http.get(Uri.parse('${HttpUrl.baseUrl}/search/movie?api_key=$apiKey&query=$searchSlug&page=$page'));

      if (response.statusCode == HttpStatus.ok) {
        final responseModel = SearchResponseModel().fromJson(jsonDecode(response.body));
        return BaseHttpModel(status: BaseModelStatus.OK, data: responseModel);
      } else if (response.statusCode == HttpStatus.preconditionFailed) {
        return BaseHttpModel(status: BaseModelStatus.TIMEOUTE);
      } else {
        final errorModel = ErrorModel().fromJson(jsonDecode(response.body));
        return BaseHttpModel(status: BaseModelStatus.ERROR, message: errorModel.message);
      }
    } on HttpException catch (e) {
      return BaseHttpModel(status: BaseModelStatus.ERROR, message: e.toString());
    } on Exception catch (e) {
      log(e.toString(), name: 'Api Error {GET}: search');

      return BaseHttpModel(status: BaseModelStatus.ERROR);
    }
  }
}
