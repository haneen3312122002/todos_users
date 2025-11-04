import '../../domain/entities/user_entity.dart';

class AddressModel {
  final String city;
  final String country;

  const AddressModel({required this.city, required this.country});

  factory AddressModel.fromMap(Map<String, dynamic> m) {
    return AddressModel(city: m['city'] ?? '', country: m['country'] ?? '');
  }

  AddressEntity toEntity() {
    return AddressEntity(city: city, country: country);
  }
}

class HairModel {
  final String color;
  final String type;

  const HairModel({required this.color, required this.type});

  factory HairModel.fromMap(Map<String, dynamic> m) {
    return HairModel(color: m['color'] ?? '', type: m['type'] ?? '');
  }

  HairEntity toEntity() {
    return HairEntity(color: color, type: type);
  }
}

class BankModel {
  final String cardType;
  final String cardNumber;

  const BankModel({required this.cardType, required this.cardNumber});

  factory BankModel.fromMap(Map<String, dynamic> m) {
    return BankModel(
      cardType: m['cardType'] ?? '',
      cardNumber: m['cardNumber'] ?? '',
    );
  }

  BankEntity toEntity() {
    return BankEntity(cardType: cardType, cardNumber: cardNumber);
  }
}

class CompanyModel {
  final String name;
  final String title;

  const CompanyModel({required this.name, required this.title});

  factory CompanyModel.fromMap(Map<String, dynamic> m) {
    return CompanyModel(name: m['name'] ?? '', title: m['title'] ?? '');
  }

  CompanyEntity toEntity() {
    return CompanyEntity(name: name, title: title);
  }
}

class CryptoModel {
  final String coin;
  final String network;

  const CryptoModel({required this.coin, required this.network});

  factory CryptoModel.fromMap(Map<String, dynamic> m) {
    return CryptoModel(coin: m['coin'] ?? '', network: m['network'] ?? '');
  }

  CryptoEntity toEntity() {
    return CryptoEntity(coin: coin, network: network);
  }
}

class UserModel {
  final int id;
  final String role;
  final String firstName;
  final String lastName;
  final int age;
  final String gender;
  final String email;
  final String phone;
  final String image;
  final String university;
  final HairModel hair;
  final String eyeColor;
  final AddressModel address;
  final CompanyModel company;
  final BankModel bank;
  final CryptoModel crypto;

  const UserModel({
    required this.id,
    required this.role,
    required this.firstName,
    required this.lastName,
    required this.age,
    required this.gender,
    required this.email,
    required this.phone,
    required this.image,
    required this.university,
    required this.hair,
    required this.eyeColor,
    required this.address,
    required this.company,
    required this.bank,
    required this.crypto,
  });

  factory UserModel.fromMap(Map<String, dynamic> m) {
    return UserModel(
      id: (m['id'] as num?)?.toInt() ?? 0,
      role: m['role'] ?? '',
      firstName: m['firstName'] ?? '',
      lastName: m['lastName'] ?? '',
      age: (m['age'] as num?)?.toInt() ?? 0,
      gender: m['gender'] ?? '',
      email: m['email'] ?? '',
      phone: m['phone'] ?? '',
      image: m['image'] ?? '',
      university: m['university'] ?? '',
      hair: HairModel.fromMap(m['hair'] ?? {}),
      eyeColor: m['eyeColor'] ?? '',
      address: AddressModel.fromMap(m['address'] ?? {}),
      company: CompanyModel.fromMap(m['company'] ?? {}),
      bank: BankModel.fromMap(m['bank'] ?? {}),
      crypto: CryptoModel.fromMap(m['crypto'] ?? {}),
    );
  }

  UserEntity toEntity() {
    return UserEntity(
      id: id,
      role: role,
      firstName: firstName,
      lastName: lastName,
      age: age,
      gender: gender,
      email: email,
      phone: phone,
      image: image,
      university: university,
      hair: hair.toEntity(),
      eyeColor: eyeColor,
      address: address.toEntity(),
      company: company.toEntity(),
      bank: bank.toEntity(),
      crypto: crypto.toEntity(),
    );
  }
}
