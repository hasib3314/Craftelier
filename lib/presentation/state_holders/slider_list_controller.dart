import 'package:crafty_bay/data/models/network_response.dart';
import 'package:crafty_bay/data/models/slider_list_model.dart';
import 'package:crafty_bay/data/models/slider_model.dart';
import 'package:crafty_bay/data/services/network_caller.dart';
import 'package:crafty_bay/data/utils/urls.dart';
import 'package:get/get.dart';

class SliderListController extends GetxController {
  bool _inProgress = false;

  bool get inProgress => _inProgress;

  String? _errorMessage;

  List<SliderModel> _sliderList = [];

  List<SliderModel> get sliders => _sliderList;

  String? get errorMessage => _errorMessage;

  Future<bool> getSliderList() async {
    bool isSuccess = false;
    _inProgress = true;
    update();
    final NetworkResponse response =
        await Get.find<NetworkCaller>().getRequest(url: Urls.sliderListUrl);
    if (response.isSuccess) {
      _sliderList =
          SliderListModel.fromJson(response.responseData).sliderList ?? [];
      isSuccess = true;
      _errorMessage = null;
    } else {
      _errorMessage = response.errorMessage;
    }
    _inProgress = false;
    update();
    return isSuccess;
  }
}
