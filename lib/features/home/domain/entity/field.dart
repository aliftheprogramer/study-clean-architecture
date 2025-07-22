class Field {
  final int id;
  final String name;
  final int land_area;
  final String? picture_url;
  final Address address;
  final String soil_type;
  final ActiveCrop active_crop;

  Field({
    required this.id,
    required this.name,
    required this.land_area,
    this.picture_url,
    required this.address,
    required this.soil_type,
    required this.active_crop,
  });
}

class Address {
  final String sub_village;
  final String village;
  final String district;

  Address({
    required this.sub_village,
    required this.village,
    required this.district,
  });
}

class ActiveCrop {
  final int id;
  final String seed_name;

  ActiveCrop({required this.id, required this.seed_name});
}

final List<Field> dummyFields = [
  Field(
    id: 1,
    name: "Field 1",
    land_area: 1000,
    picture_url: 'rawr.png',
    address: Address(
      sub_village: "Sub Village 1",
      village: "Village 1",
      district: "District 1",
    ),
    soil_type: "Loamy",
    active_crop: ActiveCrop(id: 1, seed_name: "Corn"),
  ),
  Field(
    id: 2,
    name: "Field 2",
    land_area: 2000,
    picture_url: "rawr.png",
    address: Address(
      sub_village: "Sub Village 2",
      village: "Village 2",
      district: "District 2",
    ),
    soil_type: "Clay",
    active_crop: ActiveCrop(id: 2, seed_name: "Wheat"),
  ),
  Field(
    id: 3,
    name: "Field 3",
    land_area: 1500,
    picture_url: "rawr.png",
    address: Address(
      sub_village: "Sub Village 3",
      village: "Village 3",
      district: "District 3",
    ),
    soil_type: "Sandy",
    active_crop: ActiveCrop(id: 3, seed_name: "Rice"),
  ),
];
