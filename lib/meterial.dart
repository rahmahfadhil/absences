class meterial {
  String id_meterial;
  String  name;
  String  Theoretical_or_practical;
  meterial( Map map){
    this.id_meterial=map['id_meterial'];
    this.name=map['name'];
    this.Theoretical_or_practical=map['Theoretical_or_practical'];

  }
}