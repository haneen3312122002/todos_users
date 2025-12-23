class Coordinates {
  final double lat;
  final double lng;
  const Coordinates({required this.lat, required this.lng});
}

class AddressEntity {
  final String city;
  final String country;

  const AddressEntity({required this.city, required this.country});
}

class HairEntity {
  final String color;
  final String type;
  const HairEntity({required this.color, required this.type});
}

class BankEntity {
  final String cardType;
  final String cardNumber;
  const BankEntity({required this.cardType, required this.cardNumber});
}

class CompanyEntity {
  final String name;
  final String title;
  const CompanyEntity({required this.name, required this.title});
}

class CryptoEntity {
  final String coin;
  final String network;
  const CryptoEntity({required this.coin, required this.network});
}

class UserEntity {
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
  final HairEntity hair;
  final String eyeColor;
  final AddressEntity address;
  final CompanyEntity company;
  final BankEntity bank;
  final CryptoEntity crypto;

  const UserEntity({
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
}