class RickAndMortyApiAllResponseModel {
  RickAndMortyApiAllResponseInfo? info;
  List<RickAndMortyApiAllResponseResults>? results;

  RickAndMortyApiAllResponseModel({this.info, this.results});

  RickAndMortyApiAllResponseModel.fromJson(Map<String, dynamic> json) {
    info = json['info'] != null ? new RickAndMortyApiAllResponseInfo.fromJson(json['info']) : null;
    if (json['results'] != null) {
      results = <RickAndMortyApiAllResponseResults>[];
      json['results'].forEach((v) {
        results!.add(new RickAndMortyApiAllResponseResults.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.info != null) {
      data['info'] = this.info!.toJson();
    }
    if (this.results != null) {
      data['results'] = this.results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class RickAndMortyApiAllResponseInfo {
  var count;
  var pages;
  var next;
  var prev;

  RickAndMortyApiAllResponseInfo({this.count, this.pages, this.next, this.prev});

  RickAndMortyApiAllResponseInfo.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    pages = json['pages'];
    next = json['next'];
    prev = json['prev'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['count'] = this.count;
    data['pages'] = this.pages;
    data['next'] = this.next;
    data['prev'] = this.prev;
    return data;
  }
}

class RickAndMortyApiAllResponseResults {
  var id;
  var name;
  var status;
  var species;
  var type;
  var gender;
  RickAndMortyApiAllResponseOrigin? origin;
  RickAndMortyApiAllResponseLocation? location;
  var image;
  List<String>? episode;
  var url;
  var created;

  RickAndMortyApiAllResponseResults({
    this.id,
    this.name,
    this.status,
    this.species,
    this.type,
    this.gender,
    this.origin,
    this.location,
    this.image,
    this.episode,
    this.url,
    this.created,
  });

  RickAndMortyApiAllResponseResults.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    status = json['status'];
    species = json['species'];
    type = json['type'];
    gender = json['gender'];
    origin =
    json['origin'] != null ? new RickAndMortyApiAllResponseOrigin.fromJson(json['origin']) : null;
    location =
    json['location'] != null ? new RickAndMortyApiAllResponseLocation.fromJson(json['location']) : null;
    image = json['image'];
    episode = json['episode'].cast<String>();
    url = json['url'];
    created = json['created'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['status'] = this.status;
    data['species'] = this.species;
    data['type'] = this.type;
    data['gender'] = this.gender;
    if (this.origin != null) {
      data['origin'] = this.origin!.toJson();
    }
    if (this.location != null) {
      data['location'] = this.location!.toJson();
    }
    data['image'] = this.image;
    data['episode'] = this.episode;
    data['url'] = this.url;
    data['created'] = this.created;
    return data;
  }
}

class RickAndMortyApiAllResponseOrigin {
  var name;
  var url;

  RickAndMortyApiAllResponseOrigin({this.name, this.url});

  RickAndMortyApiAllResponseOrigin.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

class RickAndMortyApiAllResponseLocation {
  var name;
  var url;

  RickAndMortyApiAllResponseLocation({this.name, this.url});

  RickAndMortyApiAllResponseLocation.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['url'] = this.url;
    return data;
  }
}

