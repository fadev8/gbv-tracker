/// data : [{"case":{"victim_sex":"MALE","violence_type":"PSYCHOLOGICAL","channel":"USSD","violence_description":"0","victim_sector":282,"victim_phone_nid":"6676543754678564/250788861991","ussd_user_id":5569,"abuser_age_range":"25-34","names":"Eric  Kayumba","received_date":"2020-08-20","victim_marital_status":"MARRIED","abuser_sex":"FEMALE","id":2699,"district_id":20,"age":16,"status":"PENDING"}},{"case":{"victim_sex":"MALE","violence_type":"PSYCHOLOGICAL","channel":"USSD","violence_description":"0","victim_sector":282,"victim_phone_nid":"6676543754678564/250788861991","ussd_user_id":5569,"abuser_age_range":"25-34","names":"Eric  Kayumba","received_date":"2020-08-20","victim_marital_status":"MARRIED","abuser_sex":"FEMALE","id":2699,"district_id":20,"age":16,"status":"PENDING"}},null]
/*
class Case {
  List<Data> _data;

  List<Data> get data => _data;

  Case({
      List<Data> data}){
    _data = data;
}

  Case.fromJson(dynamic json) {
    if (json["data"] != null) {
      _data = [];
      json["data"].forEach((v) {
        _data.add(Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_data != null) {
      map["data"] = _data.map((v) => v.toJson()).toList();
    }
    return map;
  }

}
*/
/// case : {"victim_sex":"MALE","violence_type":"PSYCHOLOGICAL","channel":"USSD","violence_description":"0","victim_sector":282,"victim_phone_nid":"6676543754678564/250788861991","ussd_user_id":5569,"abuser_age_range":"25-34","names":"Eric  Kayumba","received_date":"2020-08-20","victim_marital_status":"MARRIED","abuser_sex":"FEMALE","id":2699,"district_id":20,"age":16,"status":"PENDING"}
/*
class Data {
  Case _case;

  Case get case => _case;

  Data({
      Case case}){
    _case = case;
}

  Data.fromJson(dynamic json) {
    _case = json["case"] != null ? Case.fromJson(json["case"]) : null;
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    if (_case != null) {
      map["case"] = _case.toJson();
    }
    return map;
  }

}
*/
/// victim_sex : "MALE"
/// violence_type : "PSYCHOLOGICAL"
/// channel : "USSD"
/// violence_description : "0"
/// victim_sector : 282
/// victim_phone_nid : "6676543754678564/250788861991"
/// ussd_user_id : 5569
/// abuser_age_range : "25-34"
/// names : "Eric  Kayumba"
/// received_date : "2020-08-20"
/// victim_marital_status : "MARRIED"
/// abuser_sex : "FEMALE"
/// id : 2699
/// district_id : 20
/// age : 16
/// status : "PENDING"

class Case {
  String _victimSex;
  String _violenceType;
  String _channel;
  String _violenceDescription;
  int _victimSector;
  String _victimPhoneNid;
  int _ussdUserId;
  String _abuserAgeRange;
  String _names;
  String _receivedDate;
  String _victimMaritalStatus;
  String _abuserSex;
  int _id;
  int _districtId;
  int _age;
  String _status;

  String get victimSex => _victimSex;
  String get violenceType => _violenceType;
  String get channel => _channel;
  String get violenceDescription => _violenceDescription;
  int get victimSector => _victimSector;
  String get victimPhoneNid => _victimPhoneNid;
  int get ussdUserId => _ussdUserId;
  String get abuserAgeRange => _abuserAgeRange;
  String get names => _names;
  String get receivedDate => _receivedDate;
  String get victimMaritalStatus => _victimMaritalStatus;
  String get abuserSex => _abuserSex;
  int get id => _id;
  int get districtId => _districtId;
  int get age => _age;
  String get status => _status;

  Case({
      String victimSex, 
      String violenceType, 
      String channel, 
      String violenceDescription, 
      int victimSector, 
      String victimPhoneNid, 
      int ussdUserId, 
      String abuserAgeRange, 
      String names, 
      String receivedDate, 
      String victimMaritalStatus, 
      String abuserSex, 
      int id, 
      int districtId, 
      int age, 
      String status}){
    _victimSex = victimSex;
    _violenceType = violenceType;
    _channel = channel;
    _violenceDescription = violenceDescription;
    _victimSector = victimSector;
    _victimPhoneNid = victimPhoneNid;
    _ussdUserId = ussdUserId;
    _abuserAgeRange = abuserAgeRange;
    _names = names;
    _receivedDate = receivedDate;
    _victimMaritalStatus = victimMaritalStatus;
    _abuserSex = abuserSex;
    _id = id;
    _districtId = districtId;
    _age = age;
    _status = status;
}

  Case.fromJson(dynamic json) {
    _victimSex = json["victimSex"];
    _violenceType = json["violenceType"];
    _channel = json["channel"];
    _violenceDescription = json["violenceDescription"];
    _victimSector = json["victimSector"];
    _victimPhoneNid = json["victimPhoneNid"];
    _ussdUserId = json["ussdUserId"];
    _abuserAgeRange = json["abuserAgeRange"];
    _names = json["names"];
    _receivedDate = json["receivedDate"];
    _victimMaritalStatus = json["victimMaritalStatus"];
    _abuserSex = json["abuserSex"];
    _id = json["id"];
    _districtId = json["districtId"];
    _age = json["age"];
    _status = json["status"];
  }

  Map<String, dynamic> toJson() {
    var map = <String, dynamic>{};
    map["victimSex"] = _victimSex;
    map["violenceType"] = _violenceType;
    map["channel"] = _channel;
    map["violenceDescription"] = _violenceDescription;
    map["victimSector"] = _victimSector;
    map["victimPhoneNid"] = _victimPhoneNid;
    map["ussdUserId"] = _ussdUserId;
    map["abuserAgeRange"] = _abuserAgeRange;
    map["names"] = _names;
    map["receivedDate"] = _receivedDate;
    map["victimMaritalStatus"] = _victimMaritalStatus;
    map["abuserSex"] = _abuserSex;
    map["id"] = _id;
    map["districtId"] = _districtId;
    map["age"] = _age;
    map["status"] = _status;
    return map;
  }

}