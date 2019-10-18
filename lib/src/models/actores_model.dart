class Cast{

  List<Actor> items= List();

  Cast();

  Cast.fromJsonList(List<dynamic> jsonList){
    if (jsonList == null) return;
    
    /*for (var item in jsonList) {
      final actor= Actor.fromJsonMap(item);
      items.add(actor);
    }*/
    jsonList.forEach((item){
      final actor= Actor.fromJsonMap(item);
      items.add(actor);
    });
  }
}

class Actor {
  int castId;
  String character;
  String creditId;
  int gender;
  int id;
  String name;
  int order;
  String profilePath;

  Actor({
    this.castId,
    this.character,
    this.creditId,
    this.gender,
    this.id,
    this.name,
    this.order,
    this.profilePath,
  });


  Actor.fromJsonMap(Map<String, dynamic> json){
    castId     = json['cast_id'];
    character  = json['character'];
    creditId   = json['credit_id'];
    gender     = json['gender'];
    id         = json['id'];
    name       = json['name'];
    order      = json['order'];
    profilePath= json['profile_path'];

  }


  
  String getFoto(){
    if (profilePath == null) {
      return 'https://cdn11.bigcommerce.com/s-hcp6qon/stencil/ceeda4b0-2ef0-0137-a2f3-0242ac11000a/icons/icon-no-image.svg';
    }else
      return 'https://image.tmdb.org/t/p/w500$profilePath';
  }
}


