import 'package:superjet/super_jet_app/app_layout/domain/entities/update_user_date.dart';

class UpdateUserDataModel extends UpdateUserDateEntities{
  UpdateUserDataModel({required super.name, required super.phone, required super.profileImage, required super.coverImage});

  Map<String, dynamic> toJson() {
    return {
      'name':name,
      'phone':phone,
      'profileImage':profileImage,
      'coverImage':coverImage,
    };
  }
}