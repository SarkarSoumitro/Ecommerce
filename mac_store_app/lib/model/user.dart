import 'dart:convert';

class User {
  final String id;
  final String fullName;
  final String email;
  final String state;
  final String city;
  final String locality;
  final String password;
  final String token;

  User({
    required this.id,
    required this.state,
    required this.city,
    required this.email,
    required this.fullName,
    required this.locality,
    required this.password,
    required this.token,
  });

  //Serialization: convert User object to a map
  //Map: Map is a collection of key-value pair
  //why: converting to a map is an intermediate step that makes easier to serialize
  //the object to formate like a json for storage or transmission

  Map<String, dynamic> tomap() {
    return <String, dynamic>{
      "id": id,
      "fullname": fullName,
      "email": email,
      "state": state,
      "city": city,
      "locality": locality,
      "password": password,
      "token": token,
    };
  }

  //serialization: convert map to json string
  //This method directly encode the data from map to a json string
  //The json encode function convert a dart (such as map or list)
  //into a json string representation , making it suitable for communication
  //between  different system
  String tojson() => json.encode(tomap());

  //Deserialization : Convert a map to a user object
  //purpose manipulation and user : once the data is converted a to a user object
  //it can be easily manipulated and use within the application. FOr example
  //we might want to display the user's faullname, eamial etc on the ui. or we might
  //want to save the data locally

  //the factory constructor takes a map (usually  obtained from a json object)
  //and converts it into a user object . if a field is anot present in the
  //it defaults to an empty String .

  //fromMap: this constructor take a map<string ,dyanmic> and convert it into a user object
  // it usefull when u already have the data in map format
  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['_id'] as String? ?? "",
      fullName: map['fullName'] as String? ?? "",
      email: map['email'] as String? ?? "",
      state: map['state'] as String? ?? "",
      city: map['city'] as String? ?? "",
      locality: map['locality'] as String? ?? "",
      password: map['password'] as String? ?? "",
      token: map['token'] as String? ?? "",
    );
  }
  //fromjson: this factory constructor take json string and decode into map<string ,dynamic>
  //and then use from map to convert that map into a user object
  factory User.fromJson(String source) =>
      User.fromMap(json.decode(source) as Map<String, dynamic>);
}
