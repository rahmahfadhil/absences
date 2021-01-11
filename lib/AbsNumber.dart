class AbsNumber{
  String id;
  String name;
  String day;

  AbsNumber(Map map){
    this.id=map['id'];
    this.name=map['name'];
    this.day=map['0'];
  }
}
