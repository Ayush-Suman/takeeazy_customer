import 'package:takeeazy_customer/model/takeeazyapis/base/URLRoutes.dart';
import 'package:takeeazy_customer/model/base/calltype.dart';
import 'package:takeeazy_customer/model/base/networkcall.dart';
import 'package:takeeazy_customer/model/takeeazyapis/containers/containersModel.dart';

class ContainerServices {
  static Future<TEResponse> getContainers() async {
    TEResponse<ContainerModel> containerModel = await request<ContainerModel>(
        URLRoutes.getShopContainers,
        call: CALLTYPE.GET);
    return containerModel;
  }
}
