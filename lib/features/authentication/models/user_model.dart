import 'package:hive/hive.dart';

@HiveType(typeId: 0)
class UserModel extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String phone;

  @HiveField(2)
  String email;

  @HiveField(3)
  String password;

  UserModel({
    required this.name,
    required this.phone,
    required this.email,
    required this.password,
  });
}

class UserModelAdapter extends TypeAdapter<UserModel> {
  @override
  final int typeId = 0;

  @override
  UserModel read(BinaryReader reader) {
    return UserModel(
      name: reader.readString(),
      phone: reader.readString(),
      email: reader.readString(),
      password: reader.readString(),
    );
  }

  @override
  void write(BinaryWriter writer, UserModel obj) {
    writer.writeString(obj.name);
    writer.writeString(obj.phone);
    writer.writeString(obj.email);
    writer.writeString(obj.password);
  }
}
