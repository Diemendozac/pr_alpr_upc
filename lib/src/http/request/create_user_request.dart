
class UserRequest {

  String _email;
  String _password;
  String _name;
  String? _phoneNumber = null;
  String? _photoUrl;
  List<String> confidenceCircle = [];


  UserRequest(this._email, this._password, this._name, this._photoUrl);
}