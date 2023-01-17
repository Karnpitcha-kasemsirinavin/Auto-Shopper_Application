
class Item{
  String id;
  String imgbox_address;
  String img_address;
  int price;

  void type(){
    String id_type = id[0];

    if(id_type == "v"){
      imgbox_address = "assets/itemtype_bg/vegetables_bg.jpg";
    }
    else if(id_type == "b"){
      imgbox_address = "assets/itemtype_bg/bakery_bg.jpg";
    }
    else if(id_type == "m"){
      imgbox_address = "assets/itemtype_bg/meats_bg.jpg";
    }
    else if(id_type == "d"){
      imgbox_address = "assets/itemtype_bg/dairy_bg.jpg";
    }
    else if(id_type == "f"){
      imgbox_address = "assets/itemtype_bg/freeze_bg.jpg";
    }
    else if(id_type == "t"){
      imgbox_address = "assets/itemtype_bg/thing_bg.jpg";
    }
  }

  String get box_path {
    this.type();
    return imgbox_address;
  }

  void image_and_price(){

    if(this.id == "v1"){
      img_address = "";
    }
    else if(this.id == "v1"){
      img_address = "";
    }
    else if(this.id == "v1"){
      img_address = "";
    }
    else if(this.id == "v1"){
      img_address = "";
    }
    else if(this.id == "v1"){
      img_address = "";
    }

  }

  Item({
    required this.id,
    this.imgbox_address = "",
    this.img_address = "",
    this.price = 0
  });

}