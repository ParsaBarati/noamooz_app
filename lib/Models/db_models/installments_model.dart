
import 'package:noamooz_app/DataBase/Model.dart';

class InstallmentsModel extends BaseModel {
  @override
  Map<String, DbDataTypes> fields() {
    return {
      'content': DbDataTypes.Text,
    };
  }

  @override
  String primaryKey() {
    return 'id';
  }
}