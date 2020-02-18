class MainData {
  String lastUpdateTime;
  ChinaTotal chinaTotal;
  ChinaTotal chinaAdd;
  bool isShowAdd;
  List<ChinaDayList> chinaDayList;
  List<ChinaDayAddList> chinaDayAddList;
  List<DailyNewAddHistory> dailyNewAddHistory;
  List<DailyDeadRateHistory> dailyDeadRateHistory;
  //List<DailyHealRateHistory> dailyHealRateHistory;
  List<Children> areaTree;
  List<ArticleList> articleList;

  MainData(
      {this.lastUpdateTime,
        this.chinaTotal,
        this.chinaAdd,
        this.isShowAdd,
        this.chinaDayList,
        this.chinaDayAddList,
        this.dailyNewAddHistory,
        this.dailyDeadRateHistory,
        /*this.dailyHealRateHistory,*/
        this.areaTree,
        this.articleList});

  MainData.fromJson(Map<String, dynamic> json) {
    lastUpdateTime = json['lastUpdateTime'];
    chinaTotal = json['chinaTotal'] != null
        ? new ChinaTotal.fromJson(json['chinaTotal'])
        : null;
    chinaAdd = json['chinaAdd'] != null
        ? new ChinaTotal.fromJson(json['chinaAdd'])
        : null;
    isShowAdd = json['isShowAdd'];
    if (json['chinaDayList'] != null) {
      chinaDayList = new List<ChinaDayList>();
      json['chinaDayList'].forEach((v) {
        chinaDayList.add(new ChinaDayList.fromJson(v));
      });
    }
    if (json['chinaDayAddList'] != null) {
      chinaDayAddList = new List<ChinaDayAddList>();
      json['chinaDayAddList'].forEach((v) {
        chinaDayAddList.add(new ChinaDayAddList.fromJson(v));
      });
    }
    if (json['dailyNewAddHistory'] != null) {
      dailyNewAddHistory = new List<DailyNewAddHistory>();
      json['dailyNewAddHistory'].forEach((v) {
        dailyNewAddHistory.add(new DailyNewAddHistory.fromJson(v));
      });
    }
    if (json['dailyDeadRateHistory'] != null) {
      dailyDeadRateHistory = new List<DailyDeadRateHistory>();
      json['dailyDeadRateHistory'].forEach((v) {
        dailyDeadRateHistory.add(new DailyDeadRateHistory.fromJson(v));
      });
    }
    /*if (json['dailyHealRateHistory'] != null) {
      dailyHealRateHistory = new List<DailyHealRateHistory>();
      json['dailyHealRateHistory'].forEach((v) {
        dailyHealRateHistory.add(new DailyHealRateHistory.fromJson(v));
      });
    }*/
    if (json['areaTree'] != null) {
      areaTree = new List<Children>();
      json['areaTree'].forEach((v) {
        areaTree.add(new Children.fromJson(v));
      });
    }
    if (json['articleList'] != null) {
      articleList = new List<ArticleList>();
      json['articleList'].forEach((v) {
        articleList.add(new ArticleList.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['lastUpdateTime'] = this.lastUpdateTime;
    if (this.chinaTotal != null) {
      data['chinaTotal'] = this.chinaTotal.toJson();
    }
    if (this.chinaAdd != null) {
      data['chinaAdd'] = this.chinaAdd.toJson();
    }
    data['isShowAdd'] = this.isShowAdd;
    if (this.chinaDayList != null) {
      data['chinaDayList'] = this.chinaDayList.map((v) => v.toJson()).toList();
    }
    if (this.chinaDayAddList != null) {
      data['chinaDayAddList'] =
          this.chinaDayAddList.map((v) => v.toJson()).toList();
    }
    if (this.dailyNewAddHistory != null) {
      data['dailyNewAddHistory'] =
          this.dailyNewAddHistory.map((v) => v.toJson()).toList();
    }
    if (this.dailyDeadRateHistory != null) {
      data['dailyDeadRateHistory'] =
          this.dailyDeadRateHistory.map((v) => v.toJson()).toList();
    }
    /*if (this.dailyHealRateHistory != null) {
      data['dailyHealRateHistory'] =
          this.dailyHealRateHistory.map((v) => v.toJson()).toList();
    }*/
    if (this.areaTree != null) {
      data['areaTree'] = this.areaTree.map((v) => v.toJson()).toList();
    }
    if (this.articleList != null) {
      data['articleList'] = this.articleList.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class ChinaTotal {
  int confirm;
  int suspect;
  int dead;
  int heal;
  int nowConfirm;
  int nowSevere;

  ChinaTotal(
      {this.confirm,
        this.suspect,
        this.dead,
        this.heal,
        this.nowConfirm,
        this.nowSevere});

  ChinaTotal.fromJson(Map<String, dynamic> json) {
    confirm = json['confirm'];
    suspect = json['suspect'];
    dead = json['dead'];
    heal = json['heal'];
    nowConfirm = json['nowConfirm'];
    nowSevere = json['nowSevere'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirm'] = this.confirm;
    data['suspect'] = this.suspect;
    data['dead'] = this.dead;
    data['heal'] = this.heal;
    data['nowConfirm'] = this.nowConfirm;
    data['nowSevere'] = this.nowSevere;
    return data;
  }
}

class ChinaDayList {
  int confirm;
  int suspect;
  int dead;
  int heal;
  int nowConfirm;
  int nowSevere;
  String deadRate;
  String healRate;
  String date;

  ChinaDayList(
      {this.confirm,
        this.suspect,
        this.dead,
        this.heal,
        this.nowConfirm,
        this.nowSevere,
        this.deadRate,
        this.healRate,
        this.date});

  ChinaDayList.fromJson(Map<String, dynamic> json) {
    confirm = json['confirm'];
    suspect = json['suspect'];
    dead = json['dead'];
    heal = json['heal'];
    nowConfirm = json['nowConfirm'];
    nowSevere = json['nowSevere'];
    deadRate = json['deadRate'];
    healRate = json['healRate'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirm'] = this.confirm;
    data['suspect'] = this.suspect;
    data['dead'] = this.dead;
    data['heal'] = this.heal;
    data['nowConfirm'] = this.nowConfirm;
    data['nowSevere'] = this.nowSevere;
    data['deadRate'] = this.deadRate;
    data['healRate'] = this.healRate;
    data['date'] = this.date;
    return data;
  }
}

class ChinaDayAddList {
  int confirm;
  int suspect;
  int dead;
  int heal;
  String deadRate;
  String healRate;
  String date;

  ChinaDayAddList(
      {this.confirm,
        this.suspect,
        this.dead,
        this.heal,
        this.deadRate,
        this.healRate,
        this.date});

  ChinaDayAddList.fromJson(Map<String, dynamic> json) {
    confirm = json['confirm'];
    suspect = json['suspect'];
    dead = json['dead'];
    heal = json['heal'];
    deadRate = json['deadRate'];
    healRate = json['healRate'];
    date = json['date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirm'] = this.confirm;
    data['suspect'] = this.suspect;
    data['dead'] = this.dead;
    data['heal'] = this.heal;
    data['deadRate'] = this.deadRate;
    data['healRate'] = this.healRate;
    data['date'] = this.date;
    return data;
  }
}

class DailyNewAddHistory {
  String date;
  int hubei;
  int country;
  int notHubei;

  DailyNewAddHistory({this.date, this.hubei, this.country, this.notHubei});

  DailyNewAddHistory.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    hubei = json['hubei'];
    country = json['country'];
    notHubei = json['notHubei'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['hubei'] = this.hubei;
    data['country'] = this.country;
    data['notHubei'] = this.notHubei;
    return data;
  }
}

class DailyDeadRateHistory {
  String date;
  String hubeiRate;
  String notHubeiRate;
  String countryRate;

  DailyDeadRateHistory(
      {this.date, this.hubeiRate, this.notHubeiRate, this.countryRate});

  DailyDeadRateHistory.fromJson(Map<String, dynamic> json) {
    date = json['date'];
    hubeiRate = json['hubeiRate'];
    notHubeiRate = json['notHubeiRate'];
    countryRate = json['countryRate'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['date'] = this.date;
    data['hubeiRate'] = this.hubeiRate;
    data['notHubeiRate'] = this.notHubeiRate;
    data['countryRate'] = this.countryRate;
    return data;
  }
}

class Children {
  String name;
  Today today;
  Total total;
  List<Children> children;

  Children({this.name, this.today, this.total, this.children});

  Children.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    today = json['today'] != null ? new Today.fromJson(json['today']) : null;
    total = json['total'] != null ? new Total.fromJson(json['total']) : null;
    if (json['children'] != null) {
      children = new List<Children>();
      json['children'].forEach((v) {
        children.add(new Children.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    if (this.today != null) {
      data['today'] = this.today.toJson();
    }
    if (this.total != null) {
      data['total'] = this.total.toJson();
    }
    if (this.children != null) {
      data['children'] = this.children.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Today {
  int confirm;
  bool isUpdated;

  Today({this.confirm, this.isUpdated});

  Today.fromJson(Map<String, dynamic> json) {
    confirm = json['confirm'];
    isUpdated = json['isUpdated'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirm'] = this.confirm;
    data['isUpdated'] = this.isUpdated;
    return data;
  }
}

class Total {
  int confirm;
  int suspect;
  int dead;
  String deadRate;
  bool showRate;
  int heal;
  String healRate;
  bool showHeal;

  Total(
      {this.confirm,
        this.suspect,
        this.dead,
        this.deadRate,
        this.showRate,
        this.heal,
        this.healRate,
        this.showHeal});

  Total.fromJson(Map<String, dynamic> json) {
    confirm = json['confirm'];
    suspect = json['suspect'];
    dead = json['dead'];
    deadRate = json['deadRate'];
    showRate = json['showRate'];
    heal = json['heal'];
    healRate = json['healRate'];
    showHeal = json['showHeal'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['confirm'] = this.confirm;
    data['suspect'] = this.suspect;
    data['dead'] = this.dead;
    data['deadRate'] = this.deadRate;
    data['showRate'] = this.showRate;
    data['heal'] = this.heal;
    data['healRate'] = this.healRate;
    data['showHeal'] = this.showHeal;
    return data;
  }
}

class ArticleList {
  String cmsId;
  String source;
  String media;
  String publishTime;
  int canUse;
  String desc;
  String url;
  String title;

  ArticleList(
      {this.cmsId,
        this.source,
        this.media,
        this.publishTime,
        this.canUse,
        this.desc,
        this.url,
        this.title});

  ArticleList.fromJson(Map<String, dynamic> json) {
    cmsId = json['cmsId'];
    source = json['source'];
    media = json['media'];
    publishTime = json['publish_time'];
    canUse = json['can_use'];
    desc = json['desc'];
    url = json['url'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['cmsId'] = this.cmsId;
    data['source'] = this.source;
    data['media'] = this.media;
    data['publish_time'] = this.publishTime;
    data['can_use'] = this.canUse;
    data['desc'] = this.desc;
    data['url'] = this.url;
    data['title'] = this.title;
    return data;
  }
}
