import 'package:base/core/network/network_status.dart';
import 'package:base/data/entity/token_entity.dart';
import 'package:base/data/datasource/api/base_api.dart';

import 'interface_api.dart';

class AuthenApiImpl extends AuthenApi with BaseApi {
  NetworkStatus networkStatus;
  AuthenApiImpl({this.networkStatus});

  @override
  Future<TokenEntity> login(String username, String password) async {
    var params = {'ten_truy_cap': username, 'mat_khau': password};
    var header = await buildHeader();
    final json = await ApiConnection(apiCofig, networkStatus: networkStatus)
        .execute(new ApiInput('/auth/signin', ApiMethod.post, header, params));
    return TokenEntity.fromJson(json);
  }
}
