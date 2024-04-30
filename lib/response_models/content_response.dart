class ContentResponse {
  List<Course>? course;

  ContentResponse({this.course});

  ContentResponse.fromJson(Map<String, dynamic> json) {
    if (json['course'] != null) {
      course = <Course>[];
      json['course'].forEach((v) {
        course!.add(new Course.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.course != null) {
      data['course'] = this.course!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Course {
  int? courseId;
  String? courseName;
  List<Subject>? subject;

  Course({this.courseId, this.courseName, this.subject});

  Course.fromJson(Map<String, dynamic> json) {
    courseId = json['courseId'];
    courseName = json['courseName'];
    if (json['subject'] != null) {
      subject = <Subject>[];
      json['subject'].forEach((v) {
        subject!.add(new Subject.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['courseId'] = this.courseId;
    data['courseName'] = this.courseName;
    if (this.subject != null) {
      data['subject'] = this.subject!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Subject {
  int? subjectId;
  String? subjectName;
  List<Chapter>? chapter;

  Subject({this.subjectId, this.subjectName, this.chapter});

  Subject.fromJson(Map<String, dynamic> json) {
    subjectId = json['subjectId'];
    subjectName = json['subjectName'];
    if (json['chapter'] != null) {
      chapter = <Chapter>[];
      json['chapter'].forEach((v) {
        chapter!.add(new Chapter.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['subjectId'] = this.subjectId;
    data['subjectName'] = this.subjectName;
    if (this.chapter != null) {
      data['chapter'] = this.chapter!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Chapter {
  int? chapterId;
  String? chapterName;
  List<Content>? content;

  Chapter({this.chapterId, this.chapterName, this.content});

  Chapter.fromJson(Map<String, dynamic> json) {
    chapterId = json['chapterId'];
    chapterName = json['chapterName'];
    if (json['content'] != null) {
      content = <Content>[];
      json['content'].forEach((v) {
        content!.add(new Content.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['chapterId'] = this.chapterId;
    data['chapterName'] = this.chapterName;
    if (this.content != null) {
      data['content'] = this.content!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Content {
  int? contentId;
  String? nameOfContent;
  String? fromDate;
  String? toDate;
  String? contentType;
  String? contentLink;
  bool? isLive;
  String? contentuploadDate;
  bool? isDeleted;
  String? liveStartTime;
  String? liveEndTime;

  Content(
      {this.contentId,
      this.nameOfContent,
      this.fromDate,
      this.toDate,
      this.contentType,
      this.contentLink,
      this.isLive,
      this.contentuploadDate,
      this.isDeleted,
      this.liveStartTime,
      this.liveEndTime});

  Content.fromJson(Map<String, dynamic> json) {
    contentId = json['content_id'];
    nameOfContent = json['nameOfContent'];
    fromDate = json['fromDate'];
    toDate = json['toDate'];
    contentType = json['contentType'];
    contentLink = json['contentLink'];
    isLive = json['isLive'];
    contentuploadDate = json['contentuploadDate'];
    isDeleted = json['isDeleted'];
    liveStartTime = json['live_start_time'];
    liveEndTime = json['live_end_time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['content_id'] = this.contentId;
    data['nameOfContent'] = this.nameOfContent;
    data['fromDate'] = this.fromDate;
    data['toDate'] = this.toDate;
    data['contentType'] = this.contentType;
    data['contentLink'] = this.contentLink;
    data['isLive'] = this.isLive;
    data['contentuploadDate'] = this.contentuploadDate;
    data['isDeleted'] = this.isDeleted;
    data['live_start_time'] = this.liveStartTime;
    data['live_end_time'] = this.liveEndTime;
    return data;
  }
}